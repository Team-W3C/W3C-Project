package com.w3c.spring.controller.member;

import com.w3c.spring.model.vo.Member;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MemberController {

//    private final MemberService memberService;
//
//    @Autowired
//    public MemberController(MemberService memberService) {
//        this.memberService = memberService;
//    }

    @GetMapping("/member/loginPage.me")
    public String homePageLogin() {
        System.out.println("homePageLogin");
        return "common/homePageMember/login";
    }

    @GetMapping("/member/signUpPage.me")
    public String homePageSignUp() {
        System.out.println("homePageSignUp");
        return "common/homePageMember/signUp";
    }

    @PostMapping("/member/login.me")
    public String login(@RequestParam("memberId") String memberId, @RequestParam("memberPwd") String memberPwd) {
        System.out.println(memberId);
        System.out.println(memberPwd);

        return "index";
    }

    @PostMapping("/member/signUp.me")
    public String signUp(Member member) {
        System.out.println(member);
        return "common/homePageMember/login";
    }
}
