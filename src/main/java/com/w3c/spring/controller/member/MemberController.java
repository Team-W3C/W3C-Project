package com.w3c.spring.controller.member;

import com.w3c.spring.model.vo.Member;
import com.w3c.spring.model.vo.ReservationDetailVO;
import com.w3c.spring.service.member.MemberService;
import com.w3c.spring.service.mychart.MyChartService;
import com.w3c.spring.service.reservation.ReservationService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/member") // URL이 /member 로 시작하는 요청을 처리
public class MemberController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private ReservationService reservationService;

    // --- 1. 로그인/회원가입 페이지 이동 ---

    @GetMapping("/loginPage")
    public String homePageLogin() {
        System.out.println("homePageLogin");
        return "common/homePageMember/login";
    }

    @GetMapping("/signUpPage")
    public String homePageSignUp() {
        System.out.println("homePageSignUp");
        return "common/homePageMember/signUp";
    }

    // --- 2. 로그인/로그아웃 처리 ---

    /**
     * 로그인 처리
     */
    @PostMapping("/login.me")
    public String loginMember(
            @RequestParam("memberId") String memberId,
            @RequestParam("memberPwd") String memberPwd,
            HttpSession session,
            RedirectAttributes ra) {

        // [수정] 서비스의 login 메서드 호출 (서비스 레이어에서 비밀번호 비교)
        Member loginMember = memberService.login(memberId, memberPwd);

        if (loginMember != null) {
            // 로그인 성공 시 세션에 저장 (loginMember 객체는 비밀번호가 null로 제거된 상태)
            session.setAttribute("loginMember", loginMember);
            return "redirect:/";
        } else {
            ra.addFlashAttribute("alertMsg", "아이디 또는 비밀번호가 일치하지 않습니다.");
            return "redirect:/member/loginPage";
        }
    }

    /**
     * 로그아웃 처리
     */
    @GetMapping("/logout.me")
    public String logoutMember(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }


    // --- 3. 회원가입 처리 ---

    @PostMapping("/signUp.me")
    public String signUp(Member member, RedirectAttributes ra) {
        System.out.println("회원가입 시도: " + member);

        try {
            int result = memberService.signUpMember(member);
            if (result > 0) {
                ra.addFlashAttribute("alertMsg", "회원가입이 완료되었습니다. 로그인해주세요.");
                return "redirect:/member/loginPage";
            } else {
                ra.addFlashAttribute("alertMsg", "회원가입에 실패했습니다. 다시 시도해주세요.");
                return "redirect:/member/signUpPage";
            }
        } catch (Exception e) {
            e.printStackTrace();
            ra.addFlashAttribute("alertMsg", "처리 중 오류가 발생했습니다.");
            return "redirect:/member/signUpPage";
        }
    }

    // --- 4. 아이디/비밀번호 찾기 ---

    @GetMapping("/findId")
    public String showFindIdPage() {
        return "homePage/Find/findId";
    }

    @GetMapping("/findPwd")
    public String showFindPwdPage() {
        return "homePage/Find/findPwd";
    }

    @PostMapping("/findPwd-update.me")
    public String updatePassword(@RequestParam("memberId") String memberId,
                                 @RequestParam("memberPwd") String newPassword,
                                 RedirectAttributes ra) {

        try {
            int result = memberService.updatePassword(memberId, newPassword);

            if (result > 0) {
                ra.addFlashAttribute("alertMsg", "비밀번호가 성공적으로 변경되었습니다. 로그인해주세요.");
                return "redirect:/member/loginPage";
            } else {
                ra.addFlashAttribute("alertMsg", "존재하지 않는 회원이거나 변경에 실패했습니다.");
                return "redirect:/member/findPwd";
            }
        } catch (Exception e) {
            e.printStackTrace();
            ra.addFlashAttribute("alertMsg", "처리 중 오류가 발생했습니다.");
            return "redirect:/member/findPwd";
        }
    }


    // --- 5. 마이페이지 (예약 확인) ---

    @GetMapping("/appointmentPage")
    public String showAppointmentPage(HttpSession session) {
        if (session.getAttribute("loginMember") == null) {
            return "redirect:/member/loginPage";
        }
        return "member/reservation/main";
    }

    @GetMapping("/mychart")
    public String myChartPage(HttpSession session, Model model) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/loginPage";
        }

        int memberNo = loginMember.getMemberNo();
        List<ReservationDetailVO> reservationList = reservationService.getReservationsByMemberNo(memberNo);
        model.addAttribute("reservationList", reservationList);

        return "homePage/member/MyChart";
    }

    @PostMapping("/reservation/cancel")
    @ResponseBody
    public ResponseEntity<String> cancelReservation(@RequestBody Map<String, Integer> payload, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        Integer reservationNo = payload.get("reservationNo");
        if (reservationNo == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("예약 번호가 누락되었습니다.");
        }

        try {
            boolean success = reservationService.cancelReservation(reservationNo, loginMember.getMemberNo());

            if (success) {
                return ResponseEntity.ok("success");
            } else {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body("예약을 취소할 권한이 없거나 이미 완료/취소된 예약입니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류로 인해 취소에 실패했습니다.");
        }
    }


    // --- 6. 마이페이지 (회원정보 수정) ---

    @GetMapping("/info")
    public String showUserInfo(HttpSession session) {
        if (session.getAttribute("loginMember") == null) {
            return "redirect:/member/loginPage";
        }
        return "homePage/member/userInfo";
    }

    /**
     * (AJAX) 현재 비밀번호 확인 (정보 수정 페이지 접근 전)
     */
    @PostMapping("/verify-password")
    @ResponseBody
    public Map<String, Object> verifyPassword(@RequestBody Map<String, String> payload, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return response;
        }

        String memberId = loginMember.getMemberId();
        String passwordToVerify = payload.get("password");

        if (passwordToVerify == null) {
            response.put("success", false);
            response.put("message", "비밀번호가 전송되지 않았습니다.");
            return response;
        }

        boolean isPasswordCorrect = memberService.checkPassword(memberId, passwordToVerify);

        if (isPasswordCorrect) {
            response.put("success", true);
        } else {
            response.put("success", false);
            response.put("message", "비밀번호가 일치하지 않습니다.");
        }

        return response;
    }


    @PostMapping("/updateInfo")
    @ResponseBody
    public Map<String, Object> updateMemberInfo(@RequestBody Member member, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            response.put("success", false);
            response.put("message", "세션이 만료되었거나 로그인이 필요합니다.");
            return response;
        }

        member.setMemberNo(loginMember.getMemberNo());

        try {
            int result = memberService.updateMemberInfo(member);

            if (result > 0) {
                Member updatedMember = memberService.getMemberByNo((long) member.getMemberNo());
                session.setAttribute("loginMember", updatedMember);
                response.put("success", true);
            } else {
                response.put("success", false);
                response.put("message", "회원정보 수정에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "서버 오류가 발생했습니다.");
        }

        return response;
    }

    // --- 7. 마이페이지 (비밀번호 변경) ---

    @GetMapping("/changePassword")
    public String showChangePasswordPage(HttpSession session) {
        if (session.getAttribute("loginMember") == null) {
            return "redirect:/member/loginPage";
        }
        return "homePage/member/mychart/changePassword";
    }

    @PostMapping("/updatePassword")
    @ResponseBody
    public Map<String, Object> updatePassword(@RequestBody Map<String, String> payload, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return response;
        }

        String memberId = loginMember.getMemberId();
        String currentPassword = payload.get("currentPassword");
        String newPassword = payload.get("newPassword");

        boolean isPasswordCorrect = memberService.checkPassword(memberId, currentPassword);

        if (!isPasswordCorrect) {
            response.put("success", false);
            response.put("message", "현재 비밀번호가 일치하지 않습니다.");
            response.put("field", "current");
            return response;
        }

        try {
            int result = memberService.updatePassword(memberId, newPassword);
            if (result > 0) {
                response.put("success", true);
            } else {
                response.put("success", false);
                response.put("message", "비밀번호 변경에 실패했습니다. (DB 오류)");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "서버 오류가 발생했습니다.");
        }

        return response;
    }

    // --- 8. 마이페이지 (회원 탈퇴) ---

    /**
     * 회원 탈퇴 페이지(cancelMember.jsp)를 보여줍니다.
     * (이전 턴에서 작업한 withdrawal.jsp와 동일한 페이지입니다)
     */
    @GetMapping("/cancelMember")
    public String showCancelMemberPage(HttpSession session) {
        if (session.getAttribute("loginMember") == null) {
            return "redirect:/member/loginPage";
        }
        // JSP 실제 경로: /WEB-INF/views/homePage/member/mychart/cancelMember.jsp
        return "homePage/member/mychart/cancelMember";
    }

    /**
     * (AJAX) 회원 탈퇴 처리
     * (이전 턴에서 작업한 withdrawal.jsp의 AJAX 요청을 처리합니다)
     */
    @PostMapping("/deleteAccount")
    @ResponseBody
    public Map<String, Object> deleteAccount(@RequestBody Map<String, String> payload, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return response;
        }

        String memberId = loginMember.getMemberId();
        String password = payload.get("password");

        // 1. 비밀번호가 맞는지 확인
        boolean isPasswordCorrect = memberService.checkPassword(memberId, password);

        if (!isPasswordCorrect) {
            response.put("success", false);
            response.put("message", "비밀번호가 일치하지 않습니다.");
            return response;
        }

        // 2. 비밀번호가 맞으면, 회원 비활성화(탈퇴) 처리
        try {
            int result = memberService.deactivateMember(memberId);
            if (result > 0) {
                // 3. 탈퇴 성공 시 세션(로그인) 무효화
                session.invalidate();
                response.put("success", true);
            } else {
                response.put("success", false);
                response.put("message", "회원 탈퇴 처리에 실패했습니다. (DB 오류)");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "서버 오류가 발생했습니다.");
        }

        return response;
    }

    @Autowired
    private MyChartService myChartService;

    @GetMapping("/history")
    public String medicalHistory(Model model, HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/loginPage";
        }
        int memberNo = loginMember.getMemberNo();

        // [변경] DTO 리스트가 아닌 Map 리스트를 받습니다.
        List<Map<String, Object>> historyList = myChartService.getMedicalHistoryList(memberNo);

        model.addAttribute("historyList", historyList);
        return "homePage/member/mychart/history";
    }

    @GetMapping("/results")
    public String diagnosisResults(Model model, HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/loginPage";
        }
        int memberNo = loginMember.getMemberNo();

        // [변경] Map 리스트로 받음
        List<Map<String, Object>> diagnosisList = myChartService.getDiagnosisRecords(memberNo);
        List<Map<String, Object>> testList = myChartService.getTestResults(memberNo);

        model.addAttribute("diagnosisList", diagnosisList);
        model.addAttribute("testList", testList);

        return "homePage/member/mychart/results";
    }
}