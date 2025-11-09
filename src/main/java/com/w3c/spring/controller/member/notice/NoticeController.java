package com.w3c.spring.controller.member.notice;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/member")
public class NoticeController {

    @GetMapping("/notice")
    public String notice() {
        return "homePage/homePageNotice/notice-member";
    }
    @GetMapping("/notice-detail")
    public String noticeDetail() {
        return "homePage/homePageNotice/notice-detail";
    }
}
