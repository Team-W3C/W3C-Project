package com.w3c.spring.service.attendance;

import com.w3c.spring.model.mapper.AttendanceMapper;
import com.w3c.spring.model.vo.AttendanceVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.format.TextStyle;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@Service
public class AttendanceServiceImpl implements AttendanceService {

    @Autowired
    private AttendanceMapper attendanceMapper;

    // 출근 기준 시간 스케줄 없을 시 기본값으로 사용
    private static final LocalTime NINE_AM = LocalTime.of(9, 0);
    // 퇴근 기준 시간 (정상/조퇴)
    private static final LocalTime SIX_PM = LocalTime.of(18, 0);

    // JSP에서 사용할 시간 포맷
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm");
    // DB 스케줄 파싱용 포맷
    private static final DateTimeFormatter SCHEDULE_TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm");


    @Override
    public Map<String, Object> getAttendanceMainPageData(long staffNo, boolean isAdmin) {
        Map<String, Object> pageData = new HashMap<>();

        // 오늘 출근 기록을 조회 (workHours 계산을 위해)
        AttendanceVO todayRecord = attendanceMapper.findTodayRecordByStaffNo(staffNo);
        if (todayRecord != null) {
            // 근무 시간 및 시간 포매팅
            formatAttendanceTimes(todayRecord); // 시간 포매팅
            if (todayRecord.getAbsenceEnd() != null) {
                calculateWorkHours(todayRecord); // 근무 시간 계산
            }
        }
        pageData.put("todayRecord", todayRecord);


        List<AttendanceVO> historyList = attendanceMapper.findHistoryByStaffNo(staffNo);
        //  근무 시간 및 시간 포매팅
        historyList.forEach(vo -> {
            formatAttendanceTimes(vo); // 시간 포매팅
            calculateWorkHours(vo); // 근무 시간 계산 (기존 로직)
        });
        pageData.put("historyList", historyList);

        pageData.put("applicationList", attendanceMapper.findApplicationsByStaffNo(staffNo));

        if (isAdmin) {
            List<AttendanceVO> pendingList = attendanceMapper.findAllPendingApplications();
            pageData.put("pendingList", pendingList);
            pageData.put("pendingCount", pendingList.size());
            pageData.put("completedList", attendanceMapper.findAllCompletedApplications());
        }

        return pageData;
    }

    /**
     *  출근 처리 로직
     */
    @Override
    @Transactional
    public void clockIn(long staffNo) throws Exception {
        // 1. 이미 출근했는지 확인
        AttendanceVO todayRecord = attendanceMapper.findTodayRecordByStaffNo(staffNo);
        if (todayRecord != null && todayRecord.getAbsenceStart() != null) {
            throw new Exception("이미 출근 처리되었습니다.");
        }

        LocalDateTime now = LocalDateTime.now();

        // 2. 새 출근 기록 생성
        AttendanceVO newRecord = new AttendanceVO();
        newRecord.setStaffNo(staffNo);
        newRecord.setAbsenceDate(now.toLocalDate());
        newRecord.setAbsenceStart(now);

        // ---  지각 여부 판단 로직 ---

        // 3.a. 오늘 요일 구하기 (예: "월", "화")
        String dayOfWeek = now.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREAN);

        // 3.b. DB에서 오늘 스케줄의 출근 시간 조회
        Map<String, Object> params = new HashMap<>();
        params.put("staffNo", staffNo);
        params.put("dayOfWeek", dayOfWeek);
        String scheduledStartTimeStr = attendanceMapper.findScheduleStartTimeByStaffNoAndDay(params);

        LocalTime scheduledStartTime = NINE_AM; // 기본 출근 시간(9시)으로 초기화

        if (scheduledStartTimeStr != null && !scheduledStartTimeStr.isEmpty()) {
            try {
                // DB에서 가져온 "09:00" 같은 문자열을 LocalTime으로 파싱
                scheduledStartTime = LocalTime.parse(scheduledStartTimeStr, SCHEDULE_TIME_FORMATTER);
            } catch (DateTimeParseException e) {
                e.printStackTrace(); // 파싱 실패 시 기본값(NINE_AM) 사용
            }
        }

        // 3.c. 지각 여부 판단 (스케줄 시간 VS 현재 시간)
        if (now.toLocalTime().isAfter(scheduledStartTime)) {
            newRecord.setAbsenceStatus(2); // 2: 지각
        } else {
            newRecord.setAbsenceStatus(1); // 1: 정상
        }

        // 4. DB 삽입
        attendanceMapper.insertClockIn(newRecord);
    }

    /**
     * 퇴근 처리 로직
     */
    @Override
    @Transactional
    public void clockOut(long absenceNo, long staffNo) throws Exception {
        // 1. 오늘 출근 기록이 있는지, 본인 맞는지, 이미 퇴근했는지 확인
        AttendanceVO todayRecord = attendanceMapper.findTodayRecordByStaffNo(staffNo);

        if (todayRecord == null || todayRecord.getAbsenceNo() != absenceNo) {
            throw new Exception("유효하지 않은 출근 기록입니다.");
        }

        if (todayRecord.getAbsenceEnd() != null) {
            throw new Exception("이미 퇴근 처리되었습니다.");
        }

        // 2. 퇴근 시간 및 상태 업데이트
        todayRecord.setAbsenceEnd(LocalDateTime.now());

        // 3. 조퇴 여부 판단 (6시 기준)
        if (todayRecord.getAbsenceStatus() == 1 && LocalDateTime.now().toLocalTime().isBefore(SIX_PM)) {
            todayRecord.setAbsenceStatus(3); // 3: 조퇴
        }
        // (else) 지각(2)이었으면 상태를 그대로 둠.

        // 4. DB 업데이트
        attendanceMapper.updateClockOut(todayRecord); // absenceNo, absenceEnd, absenceStatus 전달
    }

    @Override
    public List<AttendanceVO> getDashboardData(String searchTerm) {
        return attendanceMapper.findAllEmployeeStatus(searchTerm);
    }

    @Override
    @Transactional
    public int submitApplication(AttendanceVO attendance) {
        return attendanceMapper.insertApplication(attendance);
    }

    @Override
    @Transactional
    public int approveOrRejectApplication(long addNo, String isApproved) {
        Map<String, Object> params = new HashMap<>();
        params.put("addNo", addNo);
        params.put("isApproved", isApproved);
        return attendanceMapper.updateApplicationStatus(params);
    }

    private void calculateWorkHours(AttendanceVO vo) {
        if (vo == null || vo.getAbsenceStart() == null || vo.getAbsenceEnd() == null) {
            return;
        }

        LocalDateTime start = vo.getAbsenceStart();
        LocalDateTime end = vo.getAbsenceEnd();

        Duration duration = Duration.between(start, end);
        long totalMinutes = duration.toMinutes();

        double hours = totalMinutes / 60.0;
        String formattedHours = String.format("%.1f", hours);

        vo.setWorkHours(formattedHours);
    }

    /**
     * JSP에서 EL/JSTL <fmt:formatDate>가 java.time 객체를
     * 처리하지 못하는 문제를 해결하기 위해, Service단에서 문자열로 변환
     */
    private void formatAttendanceTimes(AttendanceVO vo) {
        if (vo == null) {
            return;
        }
        if (vo.getAbsenceStart() != null) {
            vo.setAbsenceStartTime(vo.getAbsenceStart().format(TIME_FORMATTER));
        }
        if (vo.getAbsenceEnd() != null) {
            vo.setAbsenceEndTime(vo.getAbsenceEnd().format(TIME_FORMATTER));
        }
    }
}