package com.w3c.spring.controller.erp.erpDashBoard;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/dashBoard")
public class DashBoardController {

    @GetMapping("/enterErp.erp")
    public String enterErp() {
        System.out.println("dashboard");
        return "erp/dashBoard/erpDashBoard";
    }
}
