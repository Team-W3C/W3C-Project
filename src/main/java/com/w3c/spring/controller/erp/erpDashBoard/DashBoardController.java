package com.w3c.spring.controller.erp.erpDashBoard;

import com.w3c.spring.service.dashBoard.DashBoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/erp/dashBoard")
public class DashBoardController {

    @Autowired
    private DashBoardService dashBoardService;

    @GetMapping("/enterErp")
    public String enterErp(Model model) {
        System.out.println("dashboard");

        int getTodayReservationCount = dashBoardService.getTodayReservationCount();
        model.addAttribute("getTodayReservationCount", getTodayReservationCount);

        int getStandbyPatient = dashBoardService.getStandbyPatient();
        model.addAttribute("getStandbyPatient", getStandbyPatient);

        double getEquipmentUtilizationRate = dashBoardService.getEquipmentUtilizationRate();
        model.addAttribute("getEquipmentUtilizationRate", getEquipmentUtilizationRate);

        double getReservationIncreaseRate = dashBoardService.getReservationIncreaseRate();
        model.addAttribute("getReservationIncreaseRate", getReservationIncreaseRate);

        double getStandbyPatientIncreaseRate=dashBoardService.getStandbyPatientIncreaseRate();
        model.addAttribute("getStandbyPatientIncreaseRate", getStandbyPatientIncreaseRate);

        double getEquipmentUtilizationIncreaseRate=dashBoardService.getEquipmentUtilizationIncreaseRate();
        model.addAttribute("getEquipmentUtilizationIncreaseRate", getEquipmentUtilizationIncreaseRate);

        return "erp/dashBoard/erpDashBoard";
    }
}
