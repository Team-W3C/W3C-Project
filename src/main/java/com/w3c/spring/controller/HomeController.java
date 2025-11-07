package com.w3c.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

    @RequestMapping("/")
    public String home(){
        return "index";
    }

    @GetMapping("/detail")
    public String homePageDetail() {
        System.out.println("detail");
        return "homePage/Detail/detail";
    }
}

