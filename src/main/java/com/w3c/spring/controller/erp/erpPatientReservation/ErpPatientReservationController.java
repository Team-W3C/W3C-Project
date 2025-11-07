package com.w3c.spring.controller.erp.erpPatientReservation;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/erpReservation")
public class ErpPatientReservationController {

    @GetMapping("/reservation.pr")
    public String enterErp() {
        System.out.println("patientReservation");
        return "erp/patientReservation/reservation";
    }
}
