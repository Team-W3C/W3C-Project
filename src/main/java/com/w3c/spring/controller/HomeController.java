package com.w3c.spring.controller;

import com.w3c.spring.service.inquiry.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@Controller
@RequiredArgsConstructor
public class HomeController {

    private final BoardService boardService;
    @RequestMapping("/")

    public String home(Model model) {
        Map<String, Object> result = boardService.getBoardListTop3();

        model.addAttribute("list", result.get("list"));
        return "index";
    }

    @GetMapping("/detail")
    public String homePageDetail() {
        System.out.println("detail");
        return "homePage/Detail/detail";
    }
}

