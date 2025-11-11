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
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/api/member")
public class LoginController {

    private final MemberService memberService;

    @Autowired
    public LoginController(MemberService memberService) {
        this.memberService = memberService;
    }

    @PostMapping("/login")
    public ModelAndView login(@RequestParam("memberId") String memberId,
                        ModelAndView mv, HttpSession session) {

        Member loginMember = memberService.getMemberById(memberId);
        System.out.println(loginMember);

        if(loginMember == null) { //ID가 잘못된 상태
            mv.addObject("errorMsg", "아이디를 찾을 수 없습니다.");
            mv.setViewName("/WEB-INF/views/homePage/errorModal.jsp");
            //} else if(!loginMember.getMemberPwd().equals(memberPwd)){ //비밀번호 오류
//        } else if(!bCryptPasswordEncoder.matches(memberPwd, loginMember.getMemberPwd())){
//            mv.addObject("errorMsg", "비밀번호를 확인해 주세요.");
//            mv.setViewName("common/error");
        } else {//로그인 성공
            session.setAttribute("loginMember", loginMember);
            mv.setViewName("redirect:/");
        }
        return mv;
    }

    @GetMapping("logOut")
    public String logoutMember(HttpSession httpSession) {
        httpSession.removeAttribute("loginMember");

        return "redirect:/";
    }
}
