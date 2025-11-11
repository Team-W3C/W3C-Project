package com.w3c.spring.controller.member;

import com.w3c.spring.model.vo.Member;
import com.w3c.spring.model.vo.ReservationDetailVO;
import com.w3c.spring.service.member.MemberService;
import com.w3c.spring.service.reservation.ReservationService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

    @GetMapping("/info")
    public String showUserInfo() {
        return "homePage/member/userInfo";
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
    @ResponseBody // 이 메소드는 뷰가 아닌 JSON/텍스트 데이터를 반환합니다.
    public ResponseEntity<String> cancelReservation(@RequestBody Map<String, Integer> payload, HttpSession session) {

        // 1. 세션에서 로그인 회원 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        // 2. 전달된 예약 번호(reservationNo) 확인
        Integer reservationNo = payload.get("reservationNo");
        if (reservationNo == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("예약 번호가 누락되었습니다.");
        }

        try {
            // 3. 서비스 호출 (본인 확인을 위해 memberNo도 함께 넘김)
            boolean success = reservationService.cancelReservation(reservationNo, loginMember.getMemberNo());

            if (success) {
                return ResponseEntity.ok("success"); // 성공 시 "success" 텍스트 반환
            } else {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body("예약을 취소할 권한이 없거나 이미 완료/취소된 예약입니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류로 인해 취소에 실패했습니다.");
        }
    }
}