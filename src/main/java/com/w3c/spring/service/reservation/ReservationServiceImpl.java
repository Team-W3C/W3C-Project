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
            WorkingDoctorVO assignedDoctor = workingDoctors.get(doctorIndex % totalCapacity);
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

    @Override
    public List<DepartmentVO> getDepartments() {
        return reservationMapper.findDepartmentsWithDoctors();
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

    // ▼▼▼▼▼ [수정] Map을 사용하여 Mapper 호출 ▼▼▼▼▼
    @Override
    public ReservationUpdateVO getReservationForUpdate(int reservationNo, int memberNo) {
        // XML 쿼리가 Map 타입을 기대하므로, Map으로 변환하여 전달합니다.
        Map<String, Integer> params = new HashMap<>();
        params.put("reservationNo", reservationNo);
        params.put("memberNo", memberNo);

        // Map을 받는 selectReservationForUpdate 메소드 호출 (Mapper.xml과 일치)
        return reservationMapper.selectReservationForUpdate(params);
    }
    // ▲▲▲▲▲ [수정] ▲▲▲▲▲

    @Override
    @Transactional
    public boolean updateReservation(ReservationRequestVO reservationData, int reservationNo, int memberNo) {
        reservationData.setReservationNo(reservationNo);
        reservationData.setMemberNo(memberNo);

        int result = reservationMapper.updateReservation(reservationData);
        return result == 1;
    }
}