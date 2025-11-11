package com.w3c.spring.controller.api.member.login;

import com.w3c.spring.service.member.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/api/member")
public class LoginController {

    private final MemberService memberService;

    @Autowired
    public LoginController(MemberService memberService) {
        this.memberService = memberService;
    }

    @PostMapping("/login")
    public String login(@RequestParam("memberId") String memberId, @RequestParam("memberPwd") String memberPwd) {
        System.out.println(memberId);
        System.out.println(memberPwd);

        int count = memberService.loginMember(memberId);
        System.out.println(count);

        if (count > 0) {
            return "redirect:/";
        }  else {
            return "common/homePageMember/login";
        }
    }

}
