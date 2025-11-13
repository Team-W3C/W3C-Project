package com.w3c.spring.controller.api.erp.patient;

import com.w3c.spring.service.erp.patient.PatientManageService;
import com.w3c.spring.service.member.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
@RequestMapping("/api/erp")
public class PatientManageController {

    private final PatientManageService patientManageService;

    @Autowired
    public PatientManageController(PatientManageService patientManageService) {
        this.patientManageService = patientManageService;
    }

    @GetMapping("/patientList") //환자 목록 조회
    public String selectPatientList(
            @RequestParam(value = "cpage", defaultValue = "1") int cuurentPage,
            @RequestParam(value = "keyword", defaultValue = "") String keyword,
            @RequestParam(value = "grade", defaultValue = "") String grade,
            Model model) {

        if ("undefined".equals(keyword)) {
            keyword = "";
        }
        if ("undefined".equals(grade)) {
            grade = "";
        }

        Map<String, Object> result = patientManageService.getPatientList(cuurentPage, keyword, grade);

        //환자 목록 조회 데이터
        model.addAttribute("list", result.get("list"));
        model.addAttribute("pi", result.get("pi"));

        //환자 통계 데이터 가져오기
        Map<String, Object> stats = patientManageService.getPatientStatistics();
        model.addAttribute("stats", stats); // 모델에 "stats"라는 이름으로 통째로 추가

        //검색어를 jsp로 보내기
        model.addAttribute("keyword", keyword);
        model.addAttribute("grade", grade);
        return "erp/patient/patientManagement";
    }


}
