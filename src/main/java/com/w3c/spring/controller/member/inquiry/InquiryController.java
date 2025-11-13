package com.w3c.spring.controller.member.inquiry;

import com.w3c.spring.model.vo.Member;
import com.w3c.spring.model.vo.inquiry.Board;
import com.w3c.spring.service.inquiry.BoardService;
import jakarta.servlet.http.HttpSession;
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
    public String homePageinquiryDetail(@RequestParam("bno") int boardId, Model model) {
        System.out.println("inquiry-detail");
        Map<String,Object> boardDetail= boardService.getBoardById(boardId);
        model.addAttribute("board", boardDetail.get("boardDetail"));

        return "homePage/homePageinquiry/inquiry-detail";
    }
    @GetMapping("/inquiry-insert")
    public String homePageinquiryInsert(HttpSession session, Model model) {
        if(session.getAttribute("loginMember") != null) {
            Member member = (Member) session.getAttribute("loginMember");
            model.addAttribute("memberName", member.getMemberName());
        }
        System.out.println("inquiry-insert");
        return "homePage/homePageinquiry/inquiry-insert";
    }

}
