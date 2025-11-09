package com.w3c.spring.controller.erp.erpPatient;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/erp/patient")
public class ptManageController {

    @GetMapping("/manage")
    public String ShowPatientManage(){
        return "erp/patient/patientManagement";
    }
}
