package com.w3c.spring.controller.erp.attendance;

import com.w3c.spring.model.vo.AttendanceVO;
import com.w3c.spring.model.vo.Member;
import com.w3c.spring.service.attendance.AttendanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/erp/attendance")
public class AttendanceController {

    @Autowired
    private AttendanceService attendanceService;

    /**
     * 근태 관리 메인 페이지 (나의 근태 현황 / 나의 신청 내역 / 승인 관리 탭)
     */
    @GetMapping("/main")
    public String showAttendancePage(Model model,
                                     @SessionAttribute(value = "loginMember", required = false) Member loginMember) {

        // --- 1.  로그인 세션 확인 ---
        if (loginMember == null) {
            // 세션이 없으면 로그인 페이지로 리다이렉트
            return "redirect:/member/loginPage";
        }
        // ---------------------------------

        // --- 2. 세션 정보에서 staffNo 및 관리자 여부 추출 ---
        long staffNo = (loginMember.getStaffNo() != null) ? loginMember.getStaffNo().longValue() : 0L;

        boolean isAdmin = "admin".equals(loginMember.getMemberId());

        // --- 3. 'else' 블록 (하드코딩 부분) 제거 ---

        // 4. Service를 호출하여 페이지에 필요한 모든 데이터를 Map으로 받음
        Map<String, Object> pageData = attendanceService.getAttendanceMainPageData(staffNo, isAdmin);

        // 5. Model에 Map의 모든 데이터를 한 번에 추가
        model.addAllAttributes(pageData);

        // 6. [수정] JSP에서 사용할 수 있도록 loginUser와 isAdmin 플래그를 모델에 추가
        model.addAttribute("loginUser", loginMember); // 모달용
        model.addAttribute("isAdmin", isAdmin);      // JSP 탭 제어용

        return "erp/attendance/attendance";
    }

    /**
     * 전체 근태 현황 대시보드 페이지
     */
    @GetMapping("/dashboard")
    public String showAttendanceDashboardPage(Model model,
                                              @RequestParam(required = false) String searchTerm) {

        // 1. Service를 호출하여 대시보드 데이터 조회
        List<AttendanceVO> employeeList = attendanceService.getDashboardData(searchTerm);

        // 2. Model에 데이터 추가
        model.addAttribute("employeeList", employeeList);

        return "erp/attendance/attendance-dashboard";
    }

    /**
     * 신청서 작성 (모달 폼 제출)
     */
    @PostMapping("/apply")
    public String submitApplication(
            @RequestParam("applicationType") String applicationType,
            @RequestParam("reason") String reason,
            @RequestParam(value = "outingStartTime", required = false) String outingStartTime,
            @RequestParam(value = "outingEndTime", required = false) String outingEndTime,
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "leave-type", required = false) String leaveType,
            @RequestParam(value = "overnight-type", required = false) String overnightType,
            @SessionAttribute(value = "loginMember", required = false) Member loginMember,
            RedirectAttributes rttr) {

        // --- 로그인 정보 가져오기 ---
        if (loginMember == null) {
            // (보안) 폼 제출 시에도 세션이 없으면 로그인 페이지로
            return "redirect:/member/loginPage";
        }
        long staffNo = (loginMember.getStaffNo() != null) ? loginMember.getStaffNo().longValue() : 0L;
        // -----------------------------------------------------------

        try {
            // 1. DB에 저장할 VO 객체 생성
            AttendanceVO application = new AttendanceVO();
            application.setStaffNo(staffNo);

            // 2. 어떤 탭의 신청서인지(applicationType)에 따라 VO 데이터 조립
            String reasonToSave;

            if ("outing".equals(applicationType)) {
                // "외출" 탭: 날짜는 오늘 날짜로, 사유는 "외출: [사유]"
                application.setAbsenceStartDate(LocalDate.now());
                application.setAbsenceEndDate(LocalDate.now());
                reasonToSave = String.format("외출 (%s ~ %s): %s", outingStartTime, outingEndTime, reason);
                application.setDetailedReason(reasonToSave);

            } else if ("leave".equals(applicationType)) {
                // "휴가" 탭: 선택한 날짜, 사유는 "[휴가종류]: [사유]"
                application.setAbsenceStartDate(LocalDate.parse(startDate));
                application.setAbsenceEndDate(LocalDate.parse(endDate));
                // (예) "annual: [사유]"
                reasonToSave = String.format("%s: %s", leaveType, reason);
                application.setDetailedReason(reasonToSave);

            } else if ("overnight".equals(applicationType)) {
                // "외박" 탭: 선택한 날짜, 사유는 "[외박종류]: [사유]"
                application.setAbsenceStartDate(LocalDate.parse(startDate));
                application.setAbsenceEndDate(LocalDate.parse(endDate));
                // (예) "regular: [사유]"
                reasonToSave = String.format("%s: %s", overnightType, reason);
                application.setDetailedReason(reasonToSave);
            }

            // 3. 서비스 호출
            attendanceService.submitApplication(application);
            rttr.addFlashAttribute("message", "신청서가 성공적으로 제출되었습니다.");

        } catch (Exception e) {
            e.printStackTrace(); // 콘솔에 에러 로그 출력
            rttr.addFlashAttribute("errorMessage", "신청서 제출에 실패했습니다. (입력값 확인)");
        }

        // '나의 신청 내역' 탭으로 리다이렉트
        return "redirect:/erp/attendance/main?tab=list";
    }


    /**
     *  관리자 승인/반려 처리
     */
    @PostMapping("/admin/updateStatus")
    public String updateApplicationStatus(@RequestParam long addNo,
                                          @RequestParam String status, // "T" (승인) 또는 "R" (반려)
                                          RedirectAttributes rttr) {

        try {
            attendanceService.approveOrRejectApplication(addNo, status);
            rttr.addFlashAttribute("message", "처리가 완료되었습니다.");
        } catch (Exception e) {
            rttr.addFlashAttribute("errorMessage", "처리 중 오류가 발생했습니다.");
        }

        // '승인 관리' 탭으로 리다이렉트
        return "redirect:/erp/attendance/main?tab=admin";
    }
}