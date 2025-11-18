package com.w3c.spring.controller.erp.setting;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller("erpSettingViewController")
public class SettingController {
    @GetMapping("/erp/setting")
    public String setting() {
        return "erp/setting";
    }
}
