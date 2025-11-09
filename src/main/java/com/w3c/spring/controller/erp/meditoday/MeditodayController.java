package com.w3c.spring.controller.erp.meditoday;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/erp/medi")
public class MeditodayController {

    @GetMapping("/meditoday")
    public String meditoday() {
        return "erp/meditoday/medical-today";
    }
}
