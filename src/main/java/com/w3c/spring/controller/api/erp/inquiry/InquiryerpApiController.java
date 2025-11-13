package com.w3c.spring.controller.api.erp.inquiry;

import com.w3c.spring.model.vo.Member;
import com.w3c.spring.model.vo.inquiry.Board;
import com.w3c.spring.model.vo.inquiry.BoardMemberSelect;
import com.w3c.spring.service.inquiry.BoardService;
import com.w3c.spring.service.member.MemberService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/api/erp")
public class InquiryerpApiController {

    private final BoardService boardService;

    private final MemberService memberService;
    /**
     * AJAX 요청 @ResponseBody 로 JSON 반환
     */
    @GetMapping("/inquiry/{boardNo}")
    @ResponseBody
    public Board getInquiryDetail(@PathVariable("boardNo") int boardNo) {

        Board inquiryDetail = boardService.selectInquiryDetail(boardNo);
        BoardMemberSelect selectMemberById = memberService.selectMemberByBoardId(boardNo);
        inquiryDetail.setMemberEmail(selectMemberById.getMemberEmail());
        inquiryDetail.setMemberPhone(selectMemberById.getMemberPhone());
        System.out.println("inquiryDetail = " + inquiryDetail);
        return inquiryDetail;
    }


    //문의 답변 등록

    @PostMapping("/inquiry/{boardNo}/reply")
    @ResponseBody
    public Map<String, Object> insertInquiryReply(@PathVariable("boardNo") int boardNo,
                                                  @RequestBody AnswerRequest request,
                                                  HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null || loginMember.getStaffNo() == null) {
            response.put("success", false);
            response.put("message", "직원 계정으로 로그인 후 이용하세요.");
            return response;
        }

        if (request == null || request.getAnswerContent() == null || request.getAnswerContent().trim().isEmpty()) {
            response.put("success", false);
            response.put("message", "답변 내용을 입력하세요.");
            return response;
        }

        int result = boardService.registerAnswer(boardNo,
                loginMember.getStaffNo(),
                request.getAnswerContent().trim());

        if (result > 0) {
            response.put("success", true);
            response.put("message", "답변이 등록되었습니다.");
        } else {
            response.put("success", false);
            response.put("message", "답변 등록 중 문제가 발생했습니다.");
        }

        return response;
    }

    //요청 바디
    private static class AnswerRequest {
        private String answerContent;

        public String getAnswerContent() {
            return answerContent;
        }

        public void setAnswerContent(String answerContent) {
            this.answerContent = answerContent;
        }
    }

}
