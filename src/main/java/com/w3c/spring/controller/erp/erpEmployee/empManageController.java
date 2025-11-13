package com.w3c.spring.controller.erp.erpEmployee;

import com.w3c.spring.model.dto.EmployeeCount;
import com.w3c.spring.service.member.erp.employeeManagement.EmployeeManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping; // RequestMapping 임포트 추가
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller // 이 클래스가 컨트롤러임을 명시
@RequestMapping("/erp/employee") // 이 컨트롤러의 모든 메서드에 대해 기본 경로를 "/manage"로 설정
public class empManageController {

    private final EmployeeManagementService employeeManagementService;

    // (생성자 주입)
    @Autowired
    public empManageController(EmployeeManagementService employeeManagementService) {
        this.employeeManagementService = employeeManagementService;
    }

    // --- 1. JSP 페이지 최초 로드 (EL 값 전달) -
    // GET 요청이 /manage/employee 경로로 오면 이 메서드가 처리
    @GetMapping("/manage")
    public String showEmployeeManagePage(Model model, @RequestParam(value = "empPage", defaultValue = "1") int currentPage) {

        // 통계 정보 조회
        EmployeeCount stats = employeeManagementService.getCurrentStats();

        // 직원 목록 조회
        Map<String, Object> result = employeeManagementService.getStaffList(currentPage);

        // ✅ 리스트 추출
        List<?> list = (List<?>) result.get("list");

        System.out.println("조회된 리스트: " + list);
        System.out.println("리스트 크기: " + list.size());

        // Model에 각 값을 추가
        model.addAttribute("totalCount", stats.getTotalCount());
        model.addAttribute("workCount", stats.getWorkCount());
        model.addAttribute("vacationCount", stats.getVacationCount());
        model.addAttribute("resignCount", stats.getResignCount());

        model.addAttribute("list", list);
        model.addAttribute("pi", result.get("pi"));

        // ✅ currentListSize 추가
        model.addAttribute("currentListSize", list.size());

        return "/erp/employee/employeeManagement";
    }
}