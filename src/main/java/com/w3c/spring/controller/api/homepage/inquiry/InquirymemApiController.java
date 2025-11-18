package com.w3c.spring.controller.api.homepage.inquiry;

import com.w3c.spring.model.vo.Member;
import com.w3c.spring.model.vo.inquiry.BoardInsert;
import com.w3c.spring.service.inquiry.BoardService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/api/member")
public class InquirymemApiController {

    private final BoardService boardService;

    public InquirymemApiController(BoardService boardService) {
        this.boardService = boardService;
    }

    @PostMapping("/inquiry/insert")
    public String inquiryinsert(BoardInsert boardInsert, HttpSession session, Model model) {
        Member member = (Member) session.getAttribute("loginMember");
        boardInsert.setMemberNo(member.getMemberNo());

        int result = boardService.insertBoard(boardInsert);

        if (result >0) {
            session.setAttribute("alertMsg", "문의사항이 등록 되었습니다.");
            return "redirect:/member/inquiry-board";
        }else {
            model.addAttribute("errorMsg","게시글 등록에 실패하였습니다.");
            return "redirect:/member/inquiry-insert";
        }

    }

}
