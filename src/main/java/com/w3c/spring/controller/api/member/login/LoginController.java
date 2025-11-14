package com.w3c.spring.controller.api.member.login;

import com.w3c.spring.model.vo.Member;
import com.w3c.spring.service.member.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes; //

@Controller
@RequestMapping("/api/member")
public class LoginController {

    private final MemberService memberService;

    @Autowired
    public LoginController(MemberService memberService) {
        this.memberService = memberService;
    }

    @PostMapping("/login")
    public String login(@RequestParam("memberId") String memberId, //
                        @RequestParam("memberPwd") String memberPwd,
                        HttpSession session,
                        RedirectAttributes ra) { //

        Member loginMember = memberService.login(memberId, memberPwd);
        System.out.println(loginMember);

        if(loginMember == null) { // ID가 존재하지 않거나 비밀번호가 틀린 상태
            //
            ra.addFlashAttribute("errorMsg", "아이디 또는 비밀번호를 확인해 주세요.");

            //
            //
            //
            return "redirect:/member/loginPage";
        }

        //로그인 성공
        session.setAttribute("loginMember", loginMember);
        return "redirect:/"; //
    }

    @GetMapping("logOut")
    public String logoutMember(HttpSession httpSession) {
        httpSession.removeAttribute("loginMember");
        return "redirect:/";
    }
}