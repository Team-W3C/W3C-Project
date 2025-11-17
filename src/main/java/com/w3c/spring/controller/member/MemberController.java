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
                                 @RequestParam("memberPwd") String newPassword) {
        System.out.println(memberId + " 회원의 비밀번호가 " + newPassword + " (으)로 변경되었습니다.");
        return "redirect:/loginPage";
    }


    @PostMapping("/signUp.me")
    public String signUp(Member member) {
        System.out.println(member);
        return "common/homePageMember/login";
    }

    /**
     * [404 오류 해결]
     * GET /member/appointmentPage 요청을 받아서
     * /WEB-INF/views/homePage/member/appointment.jsp 파일을 보여줍니다.
     */
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

    /**
     * 예약 취소 처리 (AJAX)
     * URL: /member/reservation/cancel
     */
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

    @GetMapping("/logout.me")
    public String logout(HttpSession session) {
        // 세션에 저장된 loginMember 정보만 삭제하는 대신,
        // 세션 전체를 무효화(invalidate)하는 것이 가장 안전하고 확실한 로그아웃입니다.
        session.invalidate();

        // 메인 페이지로 리다이렉트
        return "redirect:/member/loginPage";
    }

    // --- 8. 마이페이지 (회원 탈퇴) ---
    @GetMapping("/deleteMember")
    public String showCancelMemberPage(HttpSession session) {
        if (session.getAttribute("loginMember") == null) {
            return "redirect:/member/loginPage";
        }
        return "homePage/member/mychart/deleteMember";
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