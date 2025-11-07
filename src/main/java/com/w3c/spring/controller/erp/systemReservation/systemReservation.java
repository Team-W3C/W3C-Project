package com.w3c.spring.controller.erp.systemReservation;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/erp/reservation")
public class systemReservation {
    @GetMapping("/systemReservationEmployee.re")
    public String ShowSystemReservation(){ return "systemReservation/systemReservationEmployee";
    }
}
