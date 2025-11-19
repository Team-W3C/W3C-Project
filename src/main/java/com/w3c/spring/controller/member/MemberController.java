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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private MyChartService myChartService;


    // --- 로그인 & 회원가입 ---
    @GetMapping("/loginPage")
    public String homePageLogin() {
        return "common/homePageMember/login";
    }

    @GetMapping("/signUpPage")
    public String homePageSignUp() {
        return "common/homePageMember/signUp";
    }

    @PostMapping("/signUp.me")
    public String signUp(Member member) {
        System.out.println("회원가입: " + member);
        // memberService.signUpMember(member); // 필요 시 주석 해제
        return "common/homePageMember/login";
    }


    // --- 아이디 찾기 ---
    @GetMapping("/findId")
    public String showFindIdPage() {
        return "homePage/Find/findId";
    }

    @PostMapping("/findId.me")
    public String findIdAction(@RequestParam("memberName") String memberName,
                               @RequestParam("memberPhone") String memberPhone,
                               Model model) {
        String foundId = memberService.findMemberIdByNameAndPhone(memberName, memberPhone);

        if (foundId != null) {
            model.addAttribute("message", "회원님의 아이디는 [ " + foundId + " ] 입니다.");
            return "homePage/Find/findId";
        } else {
            model.addAttribute("error", "일치하는 회원 정보가 없습니다.");
            return "homePage/Find/findId";
        }
    }


    // --- 비밀번호 찾기 (1단계: 아이디 확인) ---
    @GetMapping("/findPwd")
    public String showFindPwdPage() {
        return "homePage/Find/findPwd";
    }

    @PostMapping("/findPwd-checkId.me")
    public String checkIdForFindPwd(@RequestParam("memberId") String memberId, Model model) {
        int count = memberService.getMemberCountById(memberId);

        if (count > 0) {
            model.addAttribute("memberId", memberId);
            return "homePage/Find/findPwdReset";
        } else {
            model.addAttribute("errorMessage", "존재하지 않는 아이디입니다.");
            return "homePage/Find/findPwd";
        }
    }

    // --- 비밀번호 찾기 (2단계: 변경 실행) ---
    @PostMapping("/findPwd-update.me")
    public String updatePasswordAction(@RequestParam("memberId") String memberId,
                                       @RequestParam("memberPwd") String newPassword,
                                       Model model) {

        // 1. 현재 회원 정보 가져오기 (비밀번호 비교를 위해)
        Member member = memberService.getMemberByIdOnly(memberId);

        // 2. 현재 비밀번호와 새 비밀번호가 같은지 확인
        if(member != null && member.getMemberPwd().equals(newPassword)) {
            // 같다면 에러 메시지와 함께 다시 재설정 페이지로 보냄
            model.addAttribute("memberId", memberId); // ID값 유지
            model.addAttribute("errorMessage", "새 비밀번호는 현재 비밀번호와 다르게 설정해야 합니다.");
            return "homePage/Find/findPwdReset";
        }

        // 3. 다르다면 업데이트 진행
        int result = memberService.updatePassword(memberId, newPassword);

        if(result > 0) {
            System.out.println(memberId + " 비밀번호 변경 완료");
            return "redirect:/member/loginPage";
        } else {
            return "common/errorPage";
        }
    }


    // --- 예약 관련 ---
    @GetMapping("/appointmentPage")
    public String showAppointmentPage(HttpSession session) {
        if (session.getAttribute("loginMember") == null) return "redirect:/member/loginPage";
        return "member/reservation/main";
    }

    @PostMapping("/reservation/cancel")
    @ResponseBody
    public ResponseEntity<String> cancelReservation(@RequestBody Map<String, Integer> payload, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인 필요");

        Integer reservationNo = payload.get("reservationNo");
        if (reservationNo == null) return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("예약 번호 없음");

        try {
            boolean success = reservationService.cancelReservation(reservationNo, loginMember.getMemberNo());
            return success ? ResponseEntity.ok("success") : ResponseEntity.status(HttpStatus.FORBIDDEN).body("취소 권한 없음");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("오류 발생");
        }
    }


    // --- 마이페이지 (정보수정, 비번변경, 탈퇴) ---
    @GetMapping("/mychart")
    public String myChartPage(HttpSession session, Model model) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) return "redirect:/member/loginPage";

        int memberNo = loginMember.getMemberNo();
        List<ReservationDetailVO> reservationList = reservationService.getReservationsByMemberNo(memberNo);
        model.addAttribute("reservationList", reservationList);
        return "homePage/member/MyChart";
    }

    @GetMapping("/info")
    public String showUserInfo(HttpSession session) {
        if (session.getAttribute("loginMember") == null) return "redirect:/member/loginPage";
        return "homePage/member/userInfo";
    }

    @PostMapping("/verify-password")
    @ResponseBody
    public Map<String, Object> verifyPassword(@RequestBody Map<String, String> payload, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            response.put("success", false);
            return response;
        }
        boolean isCorrect = memberService.checkPassword(loginMember.getMemberId(), payload.get("password"));
        response.put("success", isCorrect);
        if(!isCorrect) response.put("message", "비밀번호 불일치");
        return response;
    }

    @PostMapping("/updateInfo")
    @ResponseBody
    public Map<String, Object> updateMemberInfo(@RequestBody Member member, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            response.put("success", false);
            return response;
        }

        member.setMemberNo(loginMember.getMemberNo());
        int result = memberService.updateMemberInfo(member);

        if (result > 0) {
            session.setAttribute("loginMember", memberService.getMemberByNo((long)member.getMemberNo()));
            response.put("success", true);
        } else {
            response.put("success", false);
        }
        return response;
    }

    @GetMapping("/changePassword")
    public String showChangePasswordPage(HttpSession session) {
        if (session.getAttribute("loginMember") == null) return "redirect:/member/loginPage";
        return "homePage/member/mychart/changePassword";
    }

    @PostMapping("/updatePassword")
    @ResponseBody
    public Map<String, Object> updatePassword(@RequestBody Map<String, String> payload, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            response.put("success", false);
            return response;
        }

        String currentPwd = payload.get("currentPassword");
        String newPwd = payload.get("newPassword");

        // 현재 비밀번호 확인
        if (!memberService.checkPassword(loginMember.getMemberId(), currentPwd)) {
            response.put("success", false);
            response.put("message", "현재 비밀번호가 일치하지 않습니다.");
            return response;
        }

        if (currentPwd.equals(newPwd)) {
            response.put("success", false);
            response.put("message", "새 비밀번호는 현재 비밀번호와 다르게 설정해야 합니다.");
            return response;
        }

        int result = memberService.updatePassword(loginMember.getMemberId(), newPwd);
        response.put("success", result > 0);
        return response;
    }

    @GetMapping("/deleteMember")
    public String showCancelMemberPage(HttpSession session) {
        if (session.getAttribute("loginMember") == null) return "redirect:/member/loginPage";
        return "homePage/member/mychart/deleteMember";
    }

    @PostMapping("/deleteAccount")
    @ResponseBody
    public Map<String, Object> deleteAccount(@RequestBody Map<String, String> payload, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            response.put("success", false);
            return response;
        }

        if (!memberService.checkPassword(loginMember.getMemberId(), payload.get("password"))) {
            response.put("success", false);
            response.put("message", "비밀번호 불일치");
            return response;
        }

        int result = memberService.deactivateMember(loginMember.getMemberId());
        if (result > 0) {
            session.invalidate();
            response.put("success", true);
        } else {
            response.put("success", false);
        }
        return response;
    }

    @GetMapping("/logout.me")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/member/loginPage";
    }

    // --- 진료 기록 ---
    @GetMapping("/history")
    public String medicalHistory(Model model, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if(loginMember == null) return "redirect:/member/loginPage";

        model.addAttribute("historyList", myChartService.getMedicalHistoryList(loginMember.getMemberNo()));
        return "homePage/member/mychart/history";
    }

    @GetMapping("/results")
    public String diagnosisResults(Model model, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if(loginMember == null) return "redirect:/member/loginPage";

        int memberNo = loginMember.getMemberNo();
        model.addAttribute("diagnosisList", myChartService.getDiagnosisRecords(memberNo));
        model.addAttribute("testList", myChartService.getTestResults(memberNo));
        return "homePage/member/mychart/results";
    }
}