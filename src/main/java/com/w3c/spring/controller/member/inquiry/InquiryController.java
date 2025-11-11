package com.w3c.spring.controller.member.inquiry;

import com.w3c.spring.service.inquiry.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
@RequestMapping("/member")
public class InquiryController {

    private final BoardService boardService;

    @Autowired
    public InquiryController(BoardService boardService) {
        this.boardService = boardService;
    }


    @GetMapping("/inquiry-board")
    public String SelecthomePageinquiryBoard(@RequestParam(value = "cpage", defaultValue = "1") int cuurentPage, Model model) {
        Map<String, Object> result = boardService.getBoardList(cuurentPage);

        model.addAttribute("list", result.get("list"));
        model.addAttribute("pi",  result.get("pi"));


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
