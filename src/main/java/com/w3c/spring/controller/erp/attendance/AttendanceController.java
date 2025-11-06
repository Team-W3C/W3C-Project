package com.w3c.spring.controller.erp.attendance;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/attendance") // "/attendance"로 시작하는 URL 요청을 이 컨트롤러가 담당
public class AttendanceController {

    /**
     * 근태 관리 메인 페이지 (나의 근태 현황 / 나의 신청 내역 탭이 있는 페이지)
     * URL: /attendance/main.at
     * * @return "attendance/attendance"
     * (ViewResolver가 /WEB-INF/views/attendance/attendance.jsp 경로로 변환)
     */
    @GetMapping("/main.at")
    public String showAttendancePage() {
        // 기능 구현 없이 JSP 페이지만 반환합니다.
        // JSP 파일 내의 JSTL 탭 로직(${param.tab})은 이 설정과 관계없이
        // URL 파라미터(?tab=status 또는 ?tab=list)에 따라 자동으로 동작합니다.
        return "attendance/attendance";
    }

    @GetMapping("/dashboard.at")
    public String showAttendanceDashboardPage() {
        return "attendance/attendance-dashboard";
    }
}