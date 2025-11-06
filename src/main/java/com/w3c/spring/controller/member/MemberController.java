package com.w3c.spring.controller.member;

import com.w3c.spring.model.vo.Member;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/member") // URL이 /member 로 시작하는 요청을 처리
public class MemberController {

    @GetMapping("/loginPage.me")
    public String homePageLogin() {
        System.out.println("homePageLogin");
        return "common/homePageMember/login";
    }

    @GetMapping("/signUpPage.me")
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

    @PostMapping("/signUp.me")
    public String signUp(Member member) {
        System.out.println(member);
        return "common/homePageMember/login";
    }

    /**
     * 회원 정보 페이지
     * URL: /member/info
     */
    @GetMapping("/info.me")
    public String showUserInfo() {
        // /WEB-INF/views/homePage/member/userInfo.jsp 를 반환
        return "homePage/member/userInfo";
    }

    /**
     * 나의 차트 페이지
     * URL: /member/mychart
     */
    @GetMapping("/mychart.me")
    public String showMyChart() {
        // /WEB-INF/views/homePage/member/MyChart.jsp 를 반환
        return "homePage/member/MyChart";   
    }

}