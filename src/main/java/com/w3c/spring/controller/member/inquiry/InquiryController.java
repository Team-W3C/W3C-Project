package com.w3c.spring.controller.member.inquiry;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member")
public class InquiryController {


    @GetMapping("/inquiry-board.bo")
    public String homePageinquiryBoard() {
        System.out.println("inquiry-board");
        return "homePageinquiry/inquiry-board";
    }
    @GetMapping("/inquiry-detail.bo")
    public String homePageinquiryDetail() {
        System.out.println("inquiry-detail");
        return "homePageinquiry/inquiry-detail";
    }
    @GetMapping("/inquiry-insert.bo")
    public String homePageinquiryInsert() {
        System.out.println("inquiry-insert");
        return "homePageinquiry/inquiry-insert";
    }

}
