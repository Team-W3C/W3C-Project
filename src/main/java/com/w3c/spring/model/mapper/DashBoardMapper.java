package com.w3c.spring.model.mapper;

import com.w3c.spring.model.vo.dashBoardChart.ReservaionWeekly;
import com.w3c.spring.model.vo.dashBoardChart.TOP5Reservaion;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Mapper
public interface DashBoardMapper {
    int getTodayReservationCount();

    int getStandbyPatient();

    double getEquipmentUtilizationRate();

    double getReservationIncreaseRate();

    double getStandbyPatientIncreaseRate();

    double getEquipmentUtilizationIncreaseRate();

    List<ReservaionWeekly> selectWeeklyReservationCount(LocalDate monday, LocalDate today);
    List<Map<String, Object>> selectGradeCount();

    List<Map<String, Object>> selectFacilityReservationCount(
            @Param("startDate") LocalDate startDate,
            @Param("endDate") LocalDate endDate
    );

    List<TOP5Reservaion> selectRecentReservations();

    List<TOP5Reservaion> selectRecentReservations(  @Param("startDate") LocalDate startDate,
                                                    @Param("endDate") LocalDate endDate);
}
