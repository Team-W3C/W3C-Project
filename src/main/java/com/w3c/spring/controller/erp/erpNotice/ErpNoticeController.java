package com.w3c.spring.controller.erp.erpNotice;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/erp/erpNotice")
public class ErpNoticeController {
    @GetMapping("/notice")
    public String erpNotice() {
        return "erp/notice/erp-notice";
    }
    @GetMapping("/inquiry")
    public String erpInquiry() {
        return "erp/notice/erp-inquiry";
    }
}


