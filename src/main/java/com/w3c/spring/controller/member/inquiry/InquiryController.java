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
    public String SelecthomePageinquiryBoard(
            @RequestParam(value = "cpage", defaultValue = "1") int cuurentPage,
            @RequestParam(value = "keyword", defaultValue = "") String keyword,
            @RequestParam(value = "category", defaultValue = "") String category,
            Model model) {

        if ("undefined".equals(keyword)) {
            keyword = "";
        }
        if ("undefined".equals(category)) {
            category = "";
        }

        Map<String, Object> result = boardService.getBoardList(cuurentPage, keyword, category);

        model.addAttribute("list", result.get("list"));
        model.addAttribute("pi",  result.get("pi"));
        model.addAttribute("keyword", keyword);
        model.addAttribute("category", category);

        System.out.println("inquiry-board");
        return "homePage/homePageinquiry/inquiry-board";
    }
    @GetMapping("/inquiry-detail")
    public String homePageinquiryDetail(@RequestParam("bno") int boardId, Model model, HttpSession session) {
        System.out.println("inquiry-detail");

        Board boardDetail= boardService.getBoardById(boardId);

        Member loginMember = (Member) session.getAttribute("loginMember");
        System.out.println("스테프넘버 :" + loginMember.getStaffNo());
        // 로그인하지 않은 경우
        if (loginMember == null) {
            model.addAttribute("alertMessage", "비밀글 열람 권한이 없습니다.");
            model.addAttribute("redirectUrl", "/member/inquiry-board");
            return "common/alert";
        }

        // 작성자 본인이 아니고, 직원도 아닌 경우
        if (loginMember.getMemberNo() != boardDetail.getMemberNo() &&
                loginMember.getStaffNo() == null) {

            model.addAttribute("alertMessage", "비밀글 열람 권한이 없습니다.");
            model.addAttribute("redirectUrl", "/member/inquiry-board");
            return "common/alert";
        }

        model.addAttribute("board", boardDetail);
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
