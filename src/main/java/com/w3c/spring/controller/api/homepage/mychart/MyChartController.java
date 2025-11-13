package com.w3c.spring.controller.api.homepage.mychart;

import com.w3c.spring.service.mychart.MyChartService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;
import com.w3c.spring.model.vo.Member;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/mychart")
public class MyChartController {

    @Autowired
    private MyChartService myChartService;

    @GetMapping("/history")
    public String medicalHistory(Model model, HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/loginPage";
        }
        int memberNo = loginMember.getMemberNo();

        // [변경] DTO 리스트가 아닌 Map 리스트를 받습니다.
        List<Map<String, Object>> historyList = myChartService.getMedicalHistoryList(memberNo);

        model.addAttribute("historyList", historyList);
        return "homePage/member/mychart/history";
    }

    @GetMapping("/results")
    public String diagnosisResults(Model model, HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/loginPage";
        }
        int memberNo = loginMember.getMemberNo();

        // [변경] Map 리스트로 받음
        List<Map<String, Object>> diagnosisList = myChartService.getDiagnosisRecords(memberNo);
        List<Map<String, Object>> testList = myChartService.getTestResults(memberNo);

        model.addAttribute("diagnosisList", diagnosisList);
        model.addAttribute("testList", testList);

        return "homePage/member/mychart/results";
    }
}