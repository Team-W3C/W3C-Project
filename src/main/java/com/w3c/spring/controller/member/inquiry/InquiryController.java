package com.w3c.spring.controller.member.inquiry;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member")
public class InquiryController {


    @GetMapping("/inquiry-board")
    public String homePageinquiryBoard() {
        System.out.println("inquiry-board");
        return "homePage/homePageinquiry/inquiry-board";
    }
    @GetMapping("/inquiry-detail")
    public String homePageinquiryDetail() {
        System.out.println("inquiry-detail");
        return "homePage/homePageinquiry/inquiry-detail";
    }
    @GetMapping("/inquiry-insert")
    public String homePageinquiryInsert() {
        System.out.println("inquiry-insert");
        return "homePage/homePageinquiry/inquiry-insert";
    }

}
