package com.w3c.spring.controller.erp.erpEmployee;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping; // RequestMapping 임포트 추가

@Controller // 이 클래스가 컨트롤러임을 명시
@RequestMapping("/erp/employee") // 이 컨트롤러의 모든 메서드에 대해 기본 경로를 "/manage"로 설정
public class empManageController {

    @GetMapping("/manage") // GET 요청이 /manage/employee 경로로 오면 이 메서드가 처리
    public String showEmployeeMange(){

        return "erp/employee/employeeManagement";
    }
}