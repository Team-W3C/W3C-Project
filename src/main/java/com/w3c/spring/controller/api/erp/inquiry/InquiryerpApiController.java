package com.w3c.spring.controller.api.erp.inquiry;

import com.w3c.spring.model.vo.inquiry.Board;
import com.w3c.spring.service.inquiry.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@RequiredArgsConstructor
@Controller
@RequestMapping("/api/erp")
public class InquiryerpApiController {

    private final BoardService boardService;

    /**
     * AJAX 요청 @ResponseBody 로 JSON 반환
     */
    @GetMapping("/inquiry/{boardNo}")
    @ResponseBody
    public Board getInquiryDetail(@PathVariable("boardNo") int boardNo) {

        Board inquiryDetail = boardService.selectInquiryDetail(boardNo);
        System.out.println("inquiryDetail = " + inquiryDetail);
        return inquiryDetail;
    }

}
