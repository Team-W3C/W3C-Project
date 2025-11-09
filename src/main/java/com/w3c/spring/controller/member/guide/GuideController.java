package com.w3c.spring.controller.member.guide;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member")
public class GuideController {

    @GetMapping("/procedure")
    public String procedure() {
        return "homePage/homePageGuide/procedure";
    }

    @GetMapping("/guide")
    public String guide() {
        return "homePage/homePageGuide/guide";
    }
}