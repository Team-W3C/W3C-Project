package com.w3c.spring.service.attendance;

import com.w3c.spring.model.mapper.AttendanceMapper;
import com.w3c.spring.model.vo.AttendanceVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AttendanceServiceImpl implements AttendanceService {

    @Autowired
    private AttendanceMapper attendanceMapper;

    @Override
    public Map<String, Object> getAttendanceMainPageData(long staffNo, boolean isAdmin) {
        Map<String, Object> pageData = new HashMap<>();

        AttendanceVO todayRecord = attendanceMapper.findTodayRecordByStaffNo(staffNo);
        calculateWorkHours(todayRecord);
        pageData.put("todayRecord", todayRecord);

        List<AttendanceVO> historyList = attendanceMapper.findHistoryByStaffNo(staffNo);
        historyList.forEach(this::calculateWorkHours);
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
}