package com.w3c.spring.service.reservation;

import com.w3c.spring.model.mapper.ReservationMapper;
import com.w3c.spring.model.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class ReservationServiceImpl implements ReservationService {

    private final ReservationMapper reservationMapper;

    private static final Map<String, String> ICON_MAP;

    static {
        Map<String, String> iconMap = new HashMap<>();
        iconMap.put("정형외과", "/img/icons/orthopedics.png");
        iconMap.put("내과", "/img/icons/medicine.png");
        iconMap.put("피부과", "/img/icons/dermatology.jpg");
        iconMap.put("응급실", "/img/icons/emergency.png");
        iconMap.put("안경원과", "/img/icons/ophthalmology.png");
        iconMap.put("응급의학과", "/img/icons/emergency.png");
        iconMap.put("DEFAULT", "/img/icons/default.png");
        ICON_MAP = Collections.unmodifiableMap(iconMap);
    }

    private static final List<String> WORK_HOURS = List.of(
            "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00"
    );

    @Autowired
    public ReservationServiceImpl(ReservationMapper reservationMapper) {
        this.reservationMapper = reservationMapper;
    }

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
//            eventList.add(new FullCalendarEventVO("휴무", "background", startDate, exclusiveEndDate, "unavailable-date"));
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
        if (totalCapacity == 0) return Collections.emptyList();

        List<Map<String, Object>> bookedCountsList = reservationMapper.findBookedTimeCountsByDeptOnDate(params);
        Map<String, Long> bookedCountsMap = bookedCountsList.stream()
                .collect(Collectors.toMap(m -> (String) m.get("HOUR"), m -> ((Number) m.get("COUNT")).longValue()));

        List<TimeSlotVO> finalTimeSlots = new ArrayList<>();
        int doctorIndex = 0;
        LocalDate targetDate = LocalDate.parse(date);
        boolean isToday = targetDate.isEqual(LocalDate.now());
        int currentHour = LocalTime.now().getHour();

        for (String hour : WORK_HOURS) {
            long currentBooked = bookedCountsMap.getOrDefault(hour, 0L);
            boolean isAvailable = (currentBooked < totalCapacity);
            if (isToday && isAvailable) {
                int slotHour = Integer.parseInt(hour.split(":")[0]);
                if (slotHour <= currentHour) isAvailable = false;
            }
            if (workingDoctors.isEmpty()) break;
            WorkingDoctorVO assignedDoctor = workingDoctors.get(doctorIndex % workingDoctors.size());
            doctorIndex++;
            finalTimeSlots.add(new TimeSlotVO(hour, assignedDoctor.getMemberName(), assignedDoctor.getDepartmentLocation(), isAvailable));
        }
        return finalTimeSlots;
    }

    @Override
    public List<DepartmentVO> getDepartments() {
        List<DepartmentVO> departmentList = reservationMapper.findDepartmentsWithDoctors();
        for (DepartmentVO dept : departmentList) {
            dept.setIconUrl(ICON_MAP.getOrDefault(dept.getDepartmentName(), ICON_MAP.get("DEFAULT")));
        }
        return departmentList;
    }

    @Override
    @Transactional
    public boolean submitReservation(ReservationRequestVO reservationData, int memberNo) {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            LocalDateTime rvtnTime = LocalDateTime.parse(reservationData.getTreatmentDate(), formatter);

            if (rvtnTime.isBefore(LocalDateTime.now())) {
                throw new IllegalArgumentException("현재 시간보다 이전 시간으로 예약할 수 없습니다.");
            }
        } catch (IllegalArgumentException e) {
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
        }

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
        Map<String, Integer> params = new HashMap<>();
        params.put("reservationNo", reservationNo);
        params.put("memberNo", memberNo);
        return reservationMapper.selectReservationForUpdate(params);
    }

    @Override
    @Transactional
    public boolean updateReservation(ReservationRequestVO reservationData, int reservationNo, int memberNo) {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            LocalDateTime rvtnTime = LocalDateTime.parse(reservationData.getTreatmentDate(), formatter);

            if (rvtnTime.isBefore(LocalDateTime.now())) {
                // 예외를 던짐 (Controller에서 catch하여 메시지 반환)
                throw new IllegalArgumentException("현재 시간보다 이전 시간으로 예약할 수 없습니다.");
            }
        } catch (IllegalArgumentException e) {
            throw e; // 중요한 예외이므로 상위로 전달
        } catch (Exception e) {
            e.printStackTrace();
        }

        reservationData.setReservationNo(reservationNo);
        reservationData.setMemberNo(memberNo);

        int result = reservationMapper.updateReservation(reservationData);
        return result == 1;
    }

    public Map<String, List<ReservationDetailVO>> selectReservationDetailByDate(String selectedDate) {
        List<ReservationDetailVO> Reservations = reservationMapper.selectReservationDetailByDate(selectedDate);
        Map<String, List<ReservationDetailVO>> result = new HashMap<>();
        result.put("waiting", new ArrayList<>());
        result.put("inProgress", new ArrayList<>());
        result.put("completed", new ArrayList<>());
        result.put("canceled", new ArrayList<>());
        for (ReservationDetailVO reservation : Reservations) {
            String status = reservation.getStatus();
            if ("대기".equals(status)) result.get("waiting").add(reservation);
            else if ("진행중".equals(status)) result.get("inProgress").add(reservation);
            else if ("완료".equals(status)) result.get("completed").add(reservation);
            else if ("취소".equals(status)) result.get("canceled").add(reservation);
        }
        return result;
    }

    @Transactional
    public int updateRvtnStatus(String status, int reservationNo) {
        Map<String, Object> reservations = new HashMap<>();
        reservations.put("status", status);
        reservations.put("reservationNo", reservationNo);
        return reservationMapper.updateRvtnStatus(reservations);
    }

    public ReservationDetailVO selectRvtnDetail(int reservationNo) {
        return reservationMapper.selectRvtnDetail(reservationNo);
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

//    public boolean submitReservation(ReservationRequestVO reservationData, int memberNo) {
//        try {
//            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
//            LocalDateTime rvtnTime = LocalDateTime.parse(reservationData.getTreatmentDate(), formatter);
//
//            if (rvtnTime.isBefore(LocalDateTime.now())) {
//                throw new IllegalArgumentException("현재 시간보다 이전 시간으로 예약할 수 없습니다.");
//            }
//        } catch (IllegalArgumentException e) {
//            throw e;
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        reservationData.setMemberNo(memberNo);
//        int result = reservationMapper.insertReservation(reservationData);
//        return result == 1;
//    }
}