package com.w3c.spring.service.attendance;

import com.w3c.spring.model.vo.AttendanceVO;

import java.util.List;
import java.util.Map;

public interface AttendanceService {
    Map<String, Object> getAttendanceMainPageData(long staffNo, boolean isAdmin);
    List<AttendanceVO> getDashboardData(String searchTerm);
    int submitApplication(AttendanceVO attendance);
    int approveOrRejectApplication(long addNo, String isApproved);
}