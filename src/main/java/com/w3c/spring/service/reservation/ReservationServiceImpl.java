package com.w3c.spring.service.reservation;

import com.w3c.spring.model.mapper.ReservationMapper;
import com.w3c.spring.model.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class ReservationServiceImpl implements ReservationService {

    private final ReservationMapper reservationMapper;

    // 아이콘 매핑을 위한 상수 맵 정의 (하드코딩된 URL 대신 사용)
    private static final Map<String, String> ICON_MAP = Map.of(
            "내과", "/img/icons/medicine.png",
            "외과", "/img/icons/surgery.png", // 추가된 항목
            "정형외과", "/img/icons/orthopedics.png",
            "소아과", "/img/icons/pediatrics.jpg", // 추가된 항목
            "피부과", "/img/icons/dermatology.jpg", // 추가된 항목
            "안과", "/img/icons/ophthalmology.png", // 추가된 항목
            "치과", "/img/icons/dentistry.png", // 추가된 항목
            "심장내과", "/img/icons/Cardiology.png", // 추가된 항목
            "DEFAULT", "/img/icons/default.png" // 기본값
    );

    @Autowired
    public ReservationServiceImpl(ReservationMapper reservationMapper) {
        this.reservationMapper = reservationMapper;
    }

    // 병원 기본 운영 시간
    private static final List<String> WORK_HOURS = List.of(
            "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00"
    );

    @Override
    public List<FullCalendarEventVO> getReservationSchedule() {
        List<AbsenceVO> absenceList = reservationMapper.findApprovedAbsences();
        List<FullCalendarEventVO> eventList = new ArrayList<>();
        SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");

        for (AbsenceVO absence : absenceList) {
            String startDate = sdfDate.format(absence.getAbsenceStartDate());
            Date endDate = absence.getAbsenceEndDate();
            Calendar c = Calendar.getInstance();
            c.setTime(endDate);
            c.add(Calendar.DATE, 1);
            String exclusiveEndDate = sdfDate.format(c.getTime());

            eventList.add(new FullCalendarEventVO(
                    "휴무",
                    "background",
                    startDate,
                    exclusiveEndDate,
                    "unavailable-date"
            ));
        }
        return eventList;
    }

    @Override
    public List<TimeSlotVO> getAvailableTimes(String date, int departmentId) {

        Map<String, Object> params = new HashMap<>();
        params.put("date", date);
        params.put("departmentId", departmentId);

        List<WorkingDoctorVO> workingDoctors = reservationMapper.findWorkingDoctorsByDeptOnDate(params);
        int totalCapacity = workingDoctors.size();

        if (totalCapacity == 0) {
            return Collections.emptyList();
        }

        List<Map<String, Object>> bookedCountsList = reservationMapper.findBookedTimeCountsByDeptOnDate(params);
        Map<String, Long> bookedCountsMap = bookedCountsList.stream()
                .collect(Collectors.toMap(
                        map -> (String) map.get("HOUR"),
                        map -> ((Number) map.get("COUNT")).longValue()
                ));

        List<TimeSlotVO> finalTimeSlots = new ArrayList<>();
        int doctorIndex = 0;

        for (String hour : WORK_HOURS) {
            long currentBooked = bookedCountsMap.getOrDefault(hour, 0L);
            boolean isAvailable = (currentBooked < totalCapacity);

            // totalCapacity가 0이 아님을 이미 위에서 검사했지만, 안전을 위해 List.size() 검사 추가
            if (workingDoctors.isEmpty()) {
                break; // 혹시 모를 에러 방지
            }

            WorkingDoctorVO assignedDoctor = workingDoctors.get(doctorIndex % workingDoctors.size());
            doctorIndex++;

            finalTimeSlots.add(new TimeSlotVO(
                    hour,
                    assignedDoctor.getMemberName(),
                    assignedDoctor.getDepartmentLocation(),
                    isAvailable
            ));
        }

        return finalTimeSlots;
    }

    /**
     * 의사가 배정된 진료과 목록을 조회하고, 각 진료과에 아이콘 URL을 매핑하여 반환합니다.
     */
    @Override
    public List<DepartmentVO> getDepartments() {
        // 1. DB에서 진료과 데이터 조회 (SQL에서는 departmentName, departmentNo만 가져옴)
        List<DepartmentVO> departmentList = reservationMapper.findDepartmentsWithDoctors();

        // 2. Service에서 아이콘 URL 매칭 로직 처리
        for (DepartmentVO dept : departmentList) {
            String iconPath = ICON_MAP.getOrDefault(
                    dept.getDepartmentName(),
                    ICON_MAP.get("DEFAULT")
            );
            // DepartmentVO의 iconUrl 필드에 설정
            dept.setIconUrl(iconPath);
        }

        return departmentList;
    }

    @Override
    @Transactional
    public boolean submitReservation(ReservationRequestVO reservationData, int memberNo) {
        reservationData.setMemberNo(memberNo);
        int result = reservationMapper.insertReservation(reservationData);
        return result == 1;
    }

    @Override
    public List<ReservationDetailVO> getReservationsByMemberNo(int memberNo) {
        return reservationMapper.selectReservationsByMemberNo(memberNo);
    }

    @Override
    @Transactional
    public boolean cancelReservation(int reservationNo, int memberNo) {
        int result = reservationMapper.updateReservationStatus(reservationNo, memberNo, "취소");
        return result == 1;
    }

    @Override
    public ReservationUpdateVO getReservationForUpdate(int reservationNo, int memberNo) {
        // XML 쿼리가 Map 타입을 기대하므로, Map으로 변환하여 전달합니다.
        Map<String, Integer> params = new HashMap<>();
        params.put("reservationNo", reservationNo);
        params.put("memberNo", memberNo);

        // Map을 받는 selectReservationForUpdate 메소드 호출
        return reservationMapper.selectReservationForUpdate(params);
    }

    @Override
    @Transactional
    public boolean updateReservation(ReservationRequestVO reservationData, int reservationNo, int memberNo) {
        reservationData.setReservationNo(reservationNo);
        reservationData.setMemberNo(memberNo);

        int result = reservationMapper.updateReservation(reservationData);
        return result == 1;
    }
}