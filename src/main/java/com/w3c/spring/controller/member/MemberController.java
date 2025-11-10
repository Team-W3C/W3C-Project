package com.w3c.spring.controller.member;

import com.w3c.spring.model.vo.Member;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/member") // URL이 /member 로 시작하는 요청을 처리
public class MemberController {


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

    @PostMapping("/login.me")
    public String login(@RequestParam("memberId") String memberId, @RequestParam("memberPwd") String memberPwd) {
        System.out.println(memberId);
        System.out.println(memberPwd);

        return "index";
    }

    @GetMapping("/findId")
    public String showFindIdPage() {
        return "homePage/Find/findId";
    }

    // 1. 비밀번호 찾기 1단계 페이지 보여주기 (GET)
// (login.jsp 등에서 <a href="${contextPath}/findPwd.me">로 링크)
    @GetMapping("/findPwd")
    public String showFindPwdPage() {
        // 1단계 JSP 파일 반환
        return "homePage/Find/findPwd";
    }

    // 2. 1단계 폼(아이디) 제출 시 (POST)
//    @PostMapping("/findPwd-checkId.me")
//    public String checkMemberId(@RequestParam("memberId") String memberId,
//                                Model model,
//                                RedirectAttributes rttr) {
//
//        // --- TODO: DB에서 memberId가 실제로 존재하는지 확인하는 로직 ---
//        // (예시) Member foundMember = memberService.findMemberById(memberId);
//
//        // (임시) 아이디가 'admin'이면 존재한다고 가정
//        boolean memberExists = memberId.equals("admin"); // <-- 이 부분을 DB 조회 결과로 바꾸세요.
//
//        if (memberExists) {
//            // 2-1. 아이디가 존재하면:
//            // 2단계 페이지(resetPwd.jsp)로 아이디 정보를 가지고 이동
//            model.addAttribute("memberId", memberId);
//            return "homePage/Find/resetPwd"; // -> /WEB-INF/views/homePage/Find/resetPwd.jsp
//
//        } else {
//            // 2-2. 아이디가 존재하지 않으면:
//            // 다시 1단계 페이지로 돌려보내고 에러 메시지 표시
//            // RedirectAttributes: 리다이렉트할 때 메시지를 1회성으로 전달
//            rttr.addFlashAttribute("errorMessage", "존재하지 않는 아이디입니다.");
//            return "redirect:/findPwd.me";
//        }
//    }

    // 3. 2단계 폼(새 비밀번호) 제출 시 (POST)
    @PostMapping("/findPwd-update.me")
    public String updatePassword(@RequestParam("memberId") String memberId,
                                 @RequestParam("memberPwd") String newPassword) {

        // --- TODO: DB에서 memberId 회원의 비밀번호를 newPassword로 업데이트하는 로직 ---
        // (예시) memberService.updatePassword(memberId, newPassword);
        // (비밀번호는 암호화해서 저장해야 합니다!)

        System.out.println(memberId + " 회원의 비밀번호가 " + newPassword + " (으)로 변경되었습니다.");

        // 비밀번호 변경 완료 후 로그인 페이지로 리다이렉트
        return "redirect:/loginPage"; // 또는 homePageLogin.me 등
    }


    @PostMapping("/signUp.me")
    public String signUp(Member member) {
        System.out.println(member);
        return "common/homePageMember/login";
    }

    /**
     * 회원 정보 페이지
     * URL: /member/info
     */
    @GetMapping("/info")
    public String showUserInfo() {
        // /WEB-INF/views/homePage/member/userInfo.jsp 를 반환
        return "homePage/member/userInfo";
    }

    /**
     * 나의 차트 페이지
     * URL: /member/mychart
     */
    @GetMapping("/mychart")
    public String showMyChart() {
        // /WEB-INF/views/homePage/member/MyChart.jsp 를 반환
        return "homePage/member/MyChart";   
    }

//    /*====================문의사항======================*/
//
//    @GetMapping("/inquiry-board")
//    public String homePageinquiryBoard() {
//        System.out.println("inquiry-board");
//        return "homePage/homePageinquiry/inquiry-board";
//    }
//    @GetMapping("/inquiry-detail")
//    public String homePageinquiryDetail() {
//        System.out.println("inquiry-detail");
//        return "homePage/homePageinquiry/inquiry-detail";
//    }
//    @GetMapping("/inquiry-insert")
//    public String homePageinquiryInsert() {
//        System.out.println("inquiry-insert");
//        return "homePage/homePageinquiry/inquiry-insert";
//    }
//
//    /*====================공지사항======================*/
//    @GetMapping("/notice")
//    public String notice() {
//        return "homePage/homePageNotice/notice-member";
//    }
//    @GetMapping("/notice-detail.bo")
//    public String noticeDetail() {
//        return "homePage/homePageNotice/notice-detail";
//    }


}