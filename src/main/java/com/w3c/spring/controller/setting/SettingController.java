package com.w3c.spring.controller.setting;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SettingController {
    @GetMapping("/setting.me")
    public String setting() {
        return "ERP/setting";
    }
}
