package com.w3c.spring.service.dashBoard;

import com.w3c.spring.model.vo.dashBoardChart.GradeChart;
import com.w3c.spring.model.vo.dashBoardChart.TOP5Reservaion;

import java.util.List;
import java.util.Map;

public interface DashBoardService {
    int getTodayReservationCount();

    int getStandbyPatient();

    double getEquipmentUtilizationRate();

    double getReservationIncreaseRate();

    double getStandbyPatientIncreaseRate();

    double getEquipmentUtilizationIncreaseRate();

    List<Integer> getWeeklyReservationCounts();

    List<GradeChart> getGradeRatio();

    Map<String, Object> getFacilityReservationChart();
    List<TOP5Reservaion> getRecentReservations();
}
