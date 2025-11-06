package com.w3c.spring.controller.erpNotice;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/erpNotice")
public class ErpNoticeController {
    @GetMapping("/notice.erp")
    public String erpNotice() {
        return "ERP/notice/erp-notice";
    }
    @GetMapping("/inquiry.erp")
    public String erpInquiry() {
        return "ERP/notice/erp-inquiry";
    }
}


