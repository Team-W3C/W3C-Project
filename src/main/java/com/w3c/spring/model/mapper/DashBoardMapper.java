package com.w3c.spring.model.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DashBoardMapper {
    int getTodayReservationCount();

    int getStandbyPatient();

    double getEquipmentUtilizationRate();

    double getReservationIncreaseRate();

    double getStandbyPatientIncreaseRate();

    double getEquipmentUtilizationIncreaseRate();
}
