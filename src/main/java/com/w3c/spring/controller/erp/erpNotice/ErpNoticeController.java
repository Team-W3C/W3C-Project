package com.w3c.spring.controller.erp.erpNotice;

import com.w3c.spring.model.vo.inquiry.Board;
import com.w3c.spring.service.inquiry.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/erp/erpNotice")
public class ErpNoticeController {
    private final BoardService boardService;
    @GetMapping("/notice")
    public String erpNotice(@RequestParam(value = "cpage", defaultValue = "1") int curentPage, Model model) {
        Map<String,Object> result = boardService.selectNotificationList(curentPage);
        Map<String, Object> stats = boardService.getInquiryStats();

        model.addAttribute("result", result.get("list"));
        model.addAttribute("pi", result.get("pi"));
        model.addAttribute("stats", stats);

        return "erp/notice/erp-notice";
    }
    @GetMapping("/inquiry")
    public String erpInquiry(@RequestParam(value = "cpage", defaultValue = "1") int cuurentPage,
                             @RequestParam(value = "keyword", defaultValue = "") String keyword,
                             @RequestParam(value = "category", defaultValue = "") String category,
                             Model model) {

        if ("undefined".equals(keyword)) {
            keyword = "";
        }
        if ("undefined".equals(category)) {
            category = "";
        }
        Map<String, Object> stats = boardService.getInquiryStats();
        Map<String, Object> result = boardService.getBoardList(cuurentPage, keyword, category);

        model.addAttribute("list", result.get("list"));
        model.addAttribute("pi",  result.get("pi"));
        model.addAttribute("keyword", keyword);
        model.addAttribute("category", category);
        model.addAttribute("stats", stats);

        System.out.println(result.get("list"));

        return "erp/notice/erp-inquiry";
    }
}


