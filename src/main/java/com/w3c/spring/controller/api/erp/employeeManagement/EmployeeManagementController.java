package com.w3c.spring.controller.api.erp.employeeManagement;

import com.w3c.spring.model.dto.EmployeeCount;
import com.w3c.spring.model.vo.Member;
import com.w3c.spring.service.member.erp.employeeManagement.EmployeeManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.async.DeferredResult;

import java.util.concurrent.ConcurrentLinkedQueue;

@Controller
@RequestMapping("/api/employeeManagement") // 클래스 레벨 공통 경로
public class EmployeeManagementController {

    private final EmployeeManagementService employeeManagementService;

    // (멤버 변수로 대기 큐 선언 - DTO 타입으로 변경)
    private final ConcurrentLinkedQueue<DeferredResult<EmployeeCount>> waitingClients = new ConcurrentLinkedQueue<>();

    // (생성자 주입)
    @Autowired
    public EmployeeManagementController(EmployeeManagementService employeeManagementService) {
        this.employeeManagementService = employeeManagementService;
    }

    /**
     * [리팩토링]
     * 4개의 카운트 값을 서비스에서 조회하여 DTO로 묶어 반환하는 헬퍼 메서드
     * 이 컨트롤러 내부에서 중복을 제거하기 위해 사용합니다.
     */
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

    // --- 2. 롱 폴링 API ---

    /**
     * 롱 폴링 Ajax 요청 처리 엔드포인트
     */
    @GetMapping("/longPolling")
    @ResponseBody // @RestController가 아니므로 @ResponseBody 필요
    public DeferredResult<EmployeeCount> pollForStats() {

        // 5분 설정 (300,000 밀리초)
        final DeferredResult<EmployeeCount> deferredResult = new DeferredResult<>(30000L);

        // 타임아웃 시 (데이터 변경이 없을 때)
        deferredResult.onTimeout(() -> {
            try {
                // 헬퍼 메서드를 호출하여 DTO를 가져와 응답으로 설정
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
     * [가장 중요]
     * 데이터 변경(예: 직원 추가/삭제)이 발생했을 때 이 메소드를 호출해야 합니다.
     * 이 메소드는 이 컨트롤러 내부의 @PostMapping 등에서 호출됩니다.
     */
    public void notifyStatsChange() {
        // 1. 헬퍼 메서드를 호출하여 최신 통계 DTO를 가져옵니다.
        EmployeeCount newStats = this.getCurrentStats();

        // 2. 대기 중인 모든 클라이언트(DeferredResult)에게 응답 전송
        while (!waitingClients.isEmpty()) {
            DeferredResult<EmployeeCount> result = waitingClients.poll(); // 큐에서 꺼냄
            if (result != null && !result.isSetOrExpired()) {
                result.setResult(newStats); // 응답 전송!
            }
        }
    }

    // --- 3. 데이터 변경 API (예: 직원 추가) ---

    @PostMapping("/addEmployee")
    public String addEmployee(Member staff) {

        // 1. [구현] 직원 추가 서비스 로직 호출

        // 2. [연동] 롱 폴링 대기자들에게 "데이터 변했음"을 알림
        this.notifyStatsChange(); // 같은 클래스 내의 메서드 호출

        // 3. [수정] 페이지 리다이렉트 (페이지 로드 URL인 /employeeCount로 이동)
        // (contextPath를 포함한 전체 경로로 리다이렉트하는 것이 안전합니다)
        return "redirect:/erp/employee/manage";
    }
}