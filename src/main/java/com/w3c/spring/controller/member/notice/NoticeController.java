package com.w3c.spring.controller.member.notice;

import com.w3c.spring.model.vo.notification.Notification;
import com.w3c.spring.service.inquiry.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
public class NoticeController {

    private final BoardService boardService;
    @GetMapping("/notice")
    public String notice(@RequestParam(value = "cpage", defaultValue = "1") int curentPage, Model model) {
        Map<String,Object> result = boardService.selectPatientNoticeList(curentPage);
        model.addAttribute("list", result.get("list"));
        model.addAttribute("pi",  result.get("pi"));


        return "homePage/homePageNotice/notice-member";

    }
    @GetMapping("/notice-detail")
    public String noticeDetail(@RequestParam("nNo") int nNo, Model model) {
        Notification notifi = boardService.selectPatientNoticeById(nNo);

        model.addAttribute("notifi", notifi);

        return "homePage/homePageNotice/notice-detail";
    }
}
