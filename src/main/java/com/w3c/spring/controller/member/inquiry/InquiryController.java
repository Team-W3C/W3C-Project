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
            @RequestParam(value = "status", defaultValue = "") String status,
            Model model) {

        if ("undefined".equals(keyword)) {
            keyword = "";
        }
        if ("undefined".equals(category)) {
            category = "";
        }
        if ("undefined".equals(status)) {
            status = "";
        }

        Map<String, Object> result = boardService.getBoardList(cuurentPage, keyword, category, status);

        model.addAttribute("list", result.get("list"));
        model.addAttribute("pi",  result.get("pi"));
        model.addAttribute("keyword", keyword);
        model.addAttribute("category", category);

        System.out.println("inquiry-board");
        return "homePage/homePageinquiry/inquiry-board";
    }

    @GetMapping("/inquiry-detail")
    public String homePageinquiryDetail(@RequestParam("bno") int boardId, Model model, HttpSession session) {
        System.out.println("inquiry-detail 진입 요청 번호: " + boardId);

        // 1. 게시글 정보 가져오기
        Board boardDetail = boardService.getBoardById(boardId);

        // 2. 로그인 사용자 정보 가져오기 (로그인 안 했으면 null)
        Member loginMember = (Member) session.getAttribute("loginMember");

        // 3. '비밀글'인 경우에만 권한 체크 (공개글은 누구나 통과)
        // boardDetail.getBoardSecretTypeName() 값이 "비밀" 인지 확인
        if ("비밀".equals(boardDetail.getBoardSecretTypeName())) {

            // 3-1. 로그인을 안 한 경우 -> 차단
            if (loginMember == null) {
                model.addAttribute("alertMessage", "비밀글은 로그인이 필요합니다.");
                model.addAttribute("redirectUrl", "/member/inquiry-board");
                return "common/alert";
            }

            // 3-2. 로그인 했지만, 작성자도 아니고 직원도 아닌 경우 -> 차단
            // (getStaffNo()가 null이면 직원이 아님)
            if (loginMember.getMemberNo() != boardDetail.getMemberNo() && loginMember.getStaffNo() == null) {
                model.addAttribute("alertMessage", "비밀글 열람 권한이 없습니다.");
                model.addAttribute("redirectUrl", "/member/inquiry-board");
                return "common/alert";
            }
        }

        // 4. 권한 체크를 통과했거나 '공개글'인 경우 페이지 보여줌
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