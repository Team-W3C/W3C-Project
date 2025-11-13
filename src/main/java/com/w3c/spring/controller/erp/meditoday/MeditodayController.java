package com.w3c.spring.controller.erp.meditoday;

import com.w3c.spring.model.vo.MedicalRecord;
import com.w3c.spring.model.vo.PatientReservation;
import com.w3c.spring.service.treatment.MeditodayService;
import com.w3c.spring.service.treatment.TreatmentDetailService;
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
    private final TreatmentDetailService treatmentDetailService;

    public MeditodayController(MeditodayService meditodayService, TreatmentDetailService treatmentDetailService) {
        this.meditodayService = meditodayService;
        this.treatmentDetailService = treatmentDetailService;
    }

    @GetMapping("/meditoday")
    public String getTodayPatients(Model model) {
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        List<PatientReservation> patients = meditodayService.getTodayPatients(today);
        model.addAttribute("patients", patients);
        System.out.println("patients: " + patients);

        List<MedicalRecord> treatments = treatmentDetailService.selectTreatmentDetails(today);
        model.addAttribute("treatments", treatments);
        System.out.println("treatments: " + treatments);

        return "erp/meditoday/medical-today";
    }
}