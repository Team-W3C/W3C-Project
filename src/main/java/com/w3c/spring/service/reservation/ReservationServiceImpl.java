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

    // ▼▼▼ [수정된 부분] ▼▼▼
    // 제공해주신 DB 스크립트(더미 데이터)의 진료과 목록에 맞게 수정했습니다.
    private static final Map<String, String> ICON_MAP;
    static {
        Map<String, String> iconMap = new HashMap<>();

        // (DB DML에 포함된 진료과)
        iconMap.put("정형외과", "/img/icons/orthopedics.png");
        iconMap.put("내과", "/img/icons/medicine.png");
        iconMap.put("피부과", "/img/icons/dermatology.jpg");
        iconMap.put("응급실", "/img/icons/emergency.png");
        iconMap.put("안경원과", "/img/icons/ophthalmology.png"); // (안과 아이콘)
        iconMap.put("응급의학과", "/img/icons/emergency.png"); // (응급실 아이콘)

        // (DB DML에 없는 항목은 지도에서 제외함 - 예: 소아과, 외과, 치과 등)

        // (기본값)
        // (정보시스템팀, 원무팀 등은 이 아이콘이 표시됨)
        iconMap.put("DEFAULT", "/img/icons/default.png");

        ICON_MAP = Collections.unmodifiableMap(iconMap);
    }
    // ▲▲▲ [수정 완료] ▲▲▲

    @Autowired
    public ReservationServiceImpl(ReservationMapper reservationMapper) {
        this.reservationMapper = reservationMapper;
    }

    // 병원 기본 운영 시간 (원본 유지)
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

            if (workingDoctors.isEmpty()) {
                break;
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
     * (이 로직은 원본 그대로이며, 수정된 ICON_MAP을 사용합니다)
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

    public Map<String, List<ReservationDetailVO>> selectReservationDetailByDate(String selectedDate){
        List<ReservationDetailVO> Reservations = reservationMapper.selectReservationDetailByDate(selectedDate);
        System.out.println(Reservations);
        Map<String, List<ReservationDetailVO>> result = new HashMap<>();
        result.put("waiting", new ArrayList<>());
        result.put("inProgress", new ArrayList<>());
        result.put("completed", new ArrayList<>());
        result.put("canceled", new ArrayList<>());

        for (ReservationDetailVO reservation : Reservations){
            String status = reservation.getStatus();
            if("대기".equals(status)){
                result.get("waiting").add(reservation);
            }else if("진행중".equals(status)){
                result.get("inProgress").add(reservation);
            }else if("완료".equals(status)){
                result.get("completed").add(reservation);
            }else if("취소".equals(status)){
                result.get("canceled").add(reservation);
            };
        }

        return result;
    }

    @Transactional
    public int updateRvtnStatus(String status, int reservationNo ){
        Map<String, Object> reservations = new HashMap<>();
        reservations.put("status", status);
        reservations.put("reservationNo", reservationNo);
        return reservationMapper.updateRvtnStatus(reservations);
    }

    public ReservationDetailVO selectRvtnDetail(int reservationNo){
        ReservationDetailVO result = reservationMapper.selectRvtnDetail(reservationNo);
        return result;
    }

    public List<ReservationDetailVO> selectDoctorByDepartmentName(String departmentName) {
        return reservationMapper.selectDoctorByDepartmentName(departmentName);
    }

    public int insertErpReservation(Map<String, Object> params) {
        String patientName = (String) params.get("patientName");
        String departmentName = (String) params.get("department");

        int memberNo = reservationMapper.findMemberNo(patientName);
        int departmentNo = reservationMapper.findDepartmentNo(departmentName);

        Map<String, Object> reservations = new HashMap<>();
        reservations.put("memberNo", memberNo);
        reservations.put("departmentNo", departmentNo);
        reservations.put("time", params.get("time"));
        reservations.put("date", params.get("date"));
        reservations.put("symptoms", params.get("symptom"));
        reservations.put("memo", params.get("doctor"));

        return reservationMapper.insertErpReservation(reservations);
    }
}