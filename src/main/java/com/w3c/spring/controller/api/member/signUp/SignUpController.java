package com.w3c.spring.controller.api.member.signUp;

import com.w3c.spring.model.vo.Member;
import com.w3c.spring.service.member.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/api/member")
public class SignUpController {
    private final MemberService memberService;

    @Autowired
    public SignUpController(MemberService memberService) {
        this.memberService = memberService;
    }

    @PostMapping("/signUp")
    public String signUp(@RequestParam("memberSsnFront") String rrnFront,
                         @RequestParam("memberSsnBack") String rrnBack,
                         Member member, HttpSession session, Model model) {
        System.out.println(member);

        //주민번호 병합
        member.setMemberRrn(rrnFront + "-" + rrnBack);

        //주민번호 뒷자리 중 첫 숫자를 추출 후 성별 구별
        String memberGender = rrnBack.substring(0, 1);
        System.out.println("memberGender: " + memberGender);

        if (memberGender.equals("1") || memberGender.equals("3")) {
            member.setMemberGender("M");
        } else if (memberGender.equals("2") || memberGender.equals("4")) {
            member.setMemberGender("F");
        }

//        비밀번호 암호화 기능
//        String pwd = bCryptPasswordEncoder.encode(member.getMemberPwd());
//        member.setMemberPwd(pwd);

        int result = memberService.signUpMember(member);

        if(result > 0){
            session.setAttribute("alertMsg", "회원가입에 성공하였습니다.");
            return "redirect:/";
        } else {
            model.addAttribute("errorMsg", "회원가입에 실패하였습니다.");
            return "common/error";
        }
    }

    @GetMapping("/idDuplicateCheck")
    @ResponseBody
    public String idDuplicateCheck(@RequestParam String checkId) {

        System.out.println("checkId: " + checkId);

        int count = memberService.getMemberCountById(checkId);

        return count == 1 ? "F" : "T";
    }
}
