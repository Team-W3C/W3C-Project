package com.w3c.spring.controller.erp.meditoday;

import com.w3c.spring.model.vo.PatientReservationVO;
import com.w3c.spring.service.treatment.MeditodayService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@RequestMapping("/erp/medi")
public class MeditodayController {
    private final MeditodayService meditodayService;

    public MeditodayController(MeditodayService meditodayService) {
        this.meditodayService = meditodayService;
    }

    @GetMapping("/meditoday")
    public String getTodayPatients(Model model) {
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        List<PatientReservationVO> patients = meditodayService.getTodayPatients(today);
        model.addAttribute("patients", patients);
        System.out.println(patients.size());
        return "erp/meditoday/medical-today";
    }
}