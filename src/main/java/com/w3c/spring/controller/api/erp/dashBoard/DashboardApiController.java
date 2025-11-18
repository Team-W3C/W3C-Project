package com.w3c.spring.controller.api.erp.dashBoard;

import com.w3c.spring.model.vo.dashBoardChart.GradeChart;
import com.w3c.spring.service.dashBoard.DashBoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/api/erp")
public class DashboardApiController {

    private final DashBoardService dashBoardService;
    @GetMapping("/chart/reservation")
    @ResponseBody
    public List<Integer> reservation() {

        List<Integer> list= dashBoardService.getWeeklyReservationCounts();
        if(list.isEmpty()){
            System.out.println("리스트를 불러오지 못함");
            List<Integer> emptyCount = Arrays.asList(0,0,0,0,0,0,0);
            return emptyCount;
        }else{
            return list;
        }
    }

    @GetMapping("/chart/grade")
    @ResponseBody
    public List<GradeChart> gradeRatio() {
        return dashBoardService.getGradeRatio();
    }

    @GetMapping("/chart/facility")
    @ResponseBody
    public Map<String,Object> facility() {
        return dashBoardService.getFacilityReservationChart();
    }

}
