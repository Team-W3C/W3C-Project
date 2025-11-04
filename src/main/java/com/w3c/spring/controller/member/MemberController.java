package com.w3c.spring.controller.member;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member") // URL이 /member 로 시작하는 요청을 처리
public class MemberController {

    /**
     * 회원 정보 페이지
     * URL: /member/info
     */
    @GetMapping("/info")
    public String showUserInfo() {
        // /WEB-INF/views/common/member/userInfo.jsp 를 반환
        return "common/member/userInfo";
    }

    /**
     * 나의 차트 페이지
     * URL: /member/mychart
     */
    @GetMapping("/mychart")
    public String showMyChart() {
        // /WEB-INF/views/common/member/MyChart.jsp 를 반환
        return "common/member/MyChart";
    }
}