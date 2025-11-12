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
import java.time.format.DateTimeParseException;
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

            @RequestParam(value = "outingReason", required = false) String outingReason,
            @RequestParam(value = "leaveReason", required = false) String leaveReason,
            @RequestParam(value = "overnightReason", required = false) String overnightReason,

            @RequestParam(value = "outingStartTime", required = false) String outingStartTime,
            @RequestParam(value = "outingEndTime", required = false) String outingEndTime,
            @RequestParam(value = "leaveStartDate", required = false) String leaveStartDate,
            @RequestParam(value = "leaveEndDate", required = false) String leaveEndDate,
            @RequestParam(value = "overnightStartDate", required = false) String overnightStartDate,
            @RequestParam(value = "overnightEndDate", required = false) String overnightEndDate,

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
            String selectedReason = "";

            if ("outing".equals(applicationType)) {
                if (outingStartTime == null || outingStartTime.isEmpty() || outingEndTime == null || outingEndTime.isEmpty()) {
                    rttr.addFlashAttribute("errorMessage", "외출 시간을 올바르게 입력해주세요.");
                    return "redirect:/erp/attendance/main?tab=list";
                }

                selectedReason = outingReason;

                application.setAbsenceType(1);
                application.setAbsenceStartDate(LocalDate.now());
                application.setAbsenceEndDate(LocalDate.now());

                // "시간|사유" 형식으로 저장
                reasonToSave = String.format("%s ~ %s|%s", outingStartTime, outingEndTime, selectedReason);
                application.setDetailedReason(reasonToSave);

            } else if ("leave".equals(applicationType)) {
                // [!!] 휴가 유효성 검사
                if (leaveStartDate == null || leaveStartDate.isEmpty() || leaveEndDate == null || leaveEndDate.isEmpty()) {
                    rttr.addFlashAttribute("errorMessage", "휴가 기간을 올바르게 입력해주세요.");
                    return "redirect:/erp/attendance/main?tab=list";
                }

                selectedReason = leaveReason;

                application.setAbsenceType(2);
                application.setAbsenceStartDate(LocalDate.parse(leaveStartDate));
                application.setAbsenceEndDate(LocalDate.parse(leaveEndDate));

                reasonToSave = selectedReason;
                application.setDetailedReason(reasonToSave);

            } else if ("overnight".equals(applicationType)) {
                // [!!] 외박 유효성 검사
                if (overnightStartDate == null || overnightStartDate.isEmpty() || overnightEndDate == null || overnightEndDate.isEmpty()) {
                    rttr.addFlashAttribute("errorMessage", "외박 기간을 올바르게 입력해주세요.");
                    return "redirect:/erp/attendance/main?tab=list";
                }

                selectedReason = overnightReason;

                application.setAbsenceType(3);
                application.setAbsenceStartDate(LocalDate.parse(overnightStartDate));
                application.setAbsenceEndDate(LocalDate.parse(overnightEndDate));

                reasonToSave = selectedReason;
                application.setDetailedReason(reasonToSave);
            }

            if (selectedReason == null || selectedReason.trim().isEmpty()) {
                rttr.addFlashAttribute("errorMessage", "사유를 입력해주세요.");
                return "redirect:/erp/attendance/main?tab=list";
            }

            // 3. 서비스 호출
            attendanceService.submitApplication(application);
            rttr.addFlashAttribute("message", "신청서가 성공적으로 제출되었습니다.");

        } catch (DateTimeParseException e) {
            e.printStackTrace(); // 날짜 변환 실패
            rttr.addFlashAttribute("errorMessage", "날짜 형식이 올바르지 않습니다.");
        } catch (Exception e) {
            e.printStackTrace(); // 콘솔에 에러 로그 출력
            rttr.addFlashAttribute("errorMessage", "신청서 제출에 실패했습니다. (서버 오류)");
        }

        // '나의 신청 내역' 탭으로 리다이렉트
        return "redirect:/erp/attendance/main?tab=list";
    }

    /**
     * 관리자 승인/반려 처리
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