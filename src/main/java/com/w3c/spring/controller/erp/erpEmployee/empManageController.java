package com.w3c.spring.controller.erp.erpEmployee;

import com.w3c.spring.model.dto.EmployeeCount;
import com.w3c.spring.service.member.erp.employeeManagement.EmployeeManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping; // RequestMapping 임포트 추가

@Controller // 이 클래스가 컨트롤러임을 명시
@RequestMapping("/erp/employee") // 이 컨트롤러의 모든 메서드에 대해 기본 경로를 "/manage"로 설정
public class empManageController {

    private final EmployeeManagementService employeeManagementService;

    // (생성자 주입)
    @Autowired
    public empManageController(EmployeeManagementService employeeManagementService) {
        this.employeeManagementService = employeeManagementService;
    }

    private EmployeeCount getCurrentStats() {
        // 1. DTO 객체 생성
        EmployeeCount stats = new EmployeeCount();

        // 2. 서비스의 각 메서드를 호출하여 DTO에 값 설정
        stats.setTotalCount(employeeManagementService.getCountEmployeeAll());
        stats.setWorkCount(employeeManagementService.getCountEmployeeWork());
        stats.setVacationCount(employeeManagementService.getCountEmployeeVacation());
        stats.setResignCount(employeeManagementService.getCountEmployeeResign());

        // 3. 값이 채워진 DTO 반환
        return stats;
    }

    // --- 1. JSP 페이지 최초 로드 (EL 값 전달) ---
    // GET 요청이 /manage/employee 경로로 오면 이 메서드가 처리
    @GetMapping("/manage")
    public String showEmployeeManagePage(Model model) {

        // 헬퍼 메서드를 호출하여 최신 통계 DTO를 가져옵니다.
        EmployeeCount stats = this.getCurrentStats();

        // Model에 각 값을 추가합니다. (JSP의 EL에서 사용)
        model.addAttribute("totalCount", stats.getTotalCount());
        model.addAttribute("workCount", stats.getWorkCount());
        model.addAttribute("vacationCount", stats.getVacationCount());
        model.addAttribute("resignCount", stats.getResignCount());

        return "/erp/employee/employeeManagement"; // "직원관리.jsp" 뷰 이름
    }
}