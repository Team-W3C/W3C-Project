package com.w3c.spring.service.dashBoard;

import com.w3c.spring.model.mapper.DashBoardMapper;
import com.w3c.spring.model.vo.dashBoardChart.GradeChart;
import com.w3c.spring.model.vo.dashBoardChart.ReservaionWeekly;
import com.w3c.spring.model.vo.dashBoardChart.TOP5Reservaion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.*;

@Service
public class DashBoardServiceImpl implements DashBoardService {

    @Autowired
    private DashBoardMapper dashBoardMapper;

    @Override
    public int getTodayReservationCount() {
        return dashBoardMapper.getTodayReservationCount();
    }

    @Override
    public int getStandbyPatient() {
        return dashBoardMapper.getStandbyPatient();
    }

    @Override
    public double getEquipmentUtilizationRate() {
        return dashBoardMapper.getEquipmentUtilizationRate();
    }

    @Override
    public double getReservationIncreaseRate(){
        return dashBoardMapper.getReservationIncreaseRate();
    }

    @Override
    public double getStandbyPatientIncreaseRate(){
        return dashBoardMapper.getStandbyPatientIncreaseRate();
    }

    @Override
    public double getEquipmentUtilizationIncreaseRate(){
        return dashBoardMapper.getEquipmentUtilizationIncreaseRate();
    }

    // 대시보드 왼쪽 상단 차트 일주일 치 예약 현황 카운트 ㄴ
    @Override
    public List<Integer> getWeeklyReservationCounts() {
        LocalDate today = LocalDate.now(); //오늘
        LocalDate monday = today.with(DayOfWeek.MONDAY); //월요일 (월요일부터 오늘까지 가져오기 위함임다)
        
        List<ReservaionWeekly> rawList =
                dashBoardMapper.selectWeeklyReservationCount(monday, today);

        // 날짜별 count 저장
        Map<LocalDate, Integer> countMap = new HashMap<>();
        for (ReservaionWeekly r : rawList) {
            countMap.put(r.getRdate(), r.getCnt());
        }

        // 월요일 부터 일요일 까지 이번주 예약 현황 카운트 리스트
        List<Integer> result = new ArrayList<>();
        LocalDate cur = monday;

        while (!cur.isAfter(today)) { // 월요일 부터 오늘까지 while 문 카운트가 없으면 0집어 넣는 로직
            if (countMap.containsKey(cur)) {
                result.add(countMap.get(cur));
            } else {
                result.add(0);
            }
            cur = cur.plusDays(1);
        }
        System.out.println("result :" +result);

        return result;
    }

    public List<GradeChart> getGradeRatio() {

        List<Map<String, Object>> list = dashBoardMapper.selectGradeCount();

        int total = 0;
        for (Map<String, Object> m : list) {
            total += ((Number) m.get("CNT")).intValue();
        }

        List<GradeChart> result = new ArrayList<>();

        for (Map<String, Object> row : list) {
            String grade = (String) row.get("GRADE");
            int count = ((Number) row.get("CNT")).intValue();

            // 비율 계산
            int ratio = (int) Math.floor((count * 100.0) / total);

            result.add(new GradeChart(grade, ratio));
        }

        return result;
    }

    //시설예약 차트 그리는 로직
    @Override
    public Map<String, Object> getFacilityReservationChart() {

        LocalDate today = LocalDate.now();
        LocalDate firstDay = today.withDayOfMonth(1);


        List<Map<String, Object>> raw =
                dashBoardMapper.selectFacilityReservationCount(firstDay, today);


        LinkedHashMap<String, Integer> map = new LinkedHashMap<>();
        map.put("MRI", 0);
        map.put("초음파", 0);
        map.put("CT", 0);
        map.put("X-RAY", 0);
        map.put("내시경", 0);

        //list안에 map자료형 꺼내기
        for (Map<String, Object> row : raw) {
            String category = (String) row.get("CATEGORY");
            int cnt = ((Number) row.get("CNT")).intValue();
            map.put(category, cnt);
        }


        Map<String, Object> result = new HashMap<>();
        result.put("labels", new ArrayList<>(map.keySet()));
        result.put("data", new ArrayList<>(map.values()));

        return result;
    }
    @Override
    public List<TOP5Reservaion> getRecentReservations() {

        LocalDate today = LocalDate.now();
        LocalDate firstDay = today.withDayOfMonth(1);
        return dashBoardMapper.selectRecentReservations(firstDay,today);
    }


}
