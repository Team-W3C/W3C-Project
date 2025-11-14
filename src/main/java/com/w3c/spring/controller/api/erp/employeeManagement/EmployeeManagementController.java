package com.w3c.spring.controller.api.erp.employeeManagement;

import com.w3c.spring.model.dto.EmployeeCount;
import com.w3c.spring.model.vo.Member;
import com.w3c.spring.model.vo.employeeManagement.StaffDetail;
import com.w3c.spring.service.member.erp.employeeManagement.EmployeeManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.async.DeferredResult;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentLinkedQueue;

@Controller
@RequestMapping("/api/employeeManagement")
public class EmployeeManagementController {

    private final EmployeeManagementService employeeManagementService;
    private final ConcurrentLinkedQueue<DeferredResult<EmployeeCount>> waitingClients = new ConcurrentLinkedQueue<>();

    @Autowired
    public EmployeeManagementController(EmployeeManagementService employeeManagementService) {
        this.employeeManagementService = employeeManagementService;
    }

    @GetMapping("/listEmployee")
    public String listEmployee(
            @RequestParam(value = "page", defaultValue = "1") int currentPage,
            @RequestParam(value = "condition", required = false) String condition,
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model
    ) {
        Map<String, Object> map;

        if (condition != null && keyword != null && !keyword.trim().isEmpty()) {
            map = employeeManagementService.searchEmployeeList(currentPage, condition, keyword);
            model.addAttribute("condition", condition);
            model.addAttribute("keyword", keyword);
        } else {
            map = employeeManagementService.getStaffList(currentPage);
        }

        EmployeeCount stats = employeeManagementService.getCurrentStats();

        List<?> list = (List<?>) map.get("list");

        model.addAttribute("list", list);
        model.addAttribute("pi", map.get("pi"));
        model.addAttribute("currentListSize", list.size());
        model.addAttribute("totalCount", stats.getTotalCount());
        model.addAttribute("workCount", stats.getWorkCount());
        model.addAttribute("vacationCount", stats.getVacationCount());
        model.addAttribute("resignCount", stats.getResignCount());

        return "erp/employee/employeeManagement";
    }

    @GetMapping("/detailEmployee")
    @ResponseBody
    public StaffDetail detailEmployee(@RequestParam(value = "staffNo") int staffNo) {
        System.out.println("staffNo: " + staffNo);
        System.out.println(employeeManagementService.getEmployeeById(staffNo));
        return employeeManagementService.getEmployeeById(staffNo);
    }

    /**
     * 롱 폴링 API - 실시간 통계 업데이트
     */
    @GetMapping("/longPolling")
    @ResponseBody
    public DeferredResult<EmployeeCount> pollForStats() {
        final DeferredResult<EmployeeCount> deferredResult = new DeferredResult<>(300000L);

        deferredResult.onTimeout(() -> {
            try {
                deferredResult.setResult(this.getCurrentStats());
            } catch (Exception e) {
                deferredResult.setErrorResult("Timeout Error");
            }
            waitingClients.remove(deferredResult);
        });

        deferredResult.onCompletion(() -> waitingClients.remove(deferredResult));
        waitingClients.add(deferredResult);

        return deferredResult;
    }

    /**
     * 직원 추가
     */
    @PostMapping("/addEmployee")
    public String addEmployee(Member staff) {
        // TODO: 직원 추가 서비스 로직 구현 필요
        // employeeManagementService.addEmployee(staff);

        this.notifyStatsChange();

        return "redirect:/api/employeeManagement/listEmployee";
    }

    /**
     * 현재 통계 정보 조회 (헬퍼 메서드)
     */
    private EmployeeCount getCurrentStats() {
        return employeeManagementService.getCurrentStats();
    }

    /**
     * 통계 변경 알림 (롱 폴링 클라이언트들에게 알림)
     */
    public void notifyStatsChange() {
        EmployeeCount newStats = this.getCurrentStats();

        while (!waitingClients.isEmpty()) {
            DeferredResult<EmployeeCount> result = waitingClients.poll();
            if (result != null && !result.isSetOrExpired()) {
                result.setResult(newStats);
            }
        }
    }
}