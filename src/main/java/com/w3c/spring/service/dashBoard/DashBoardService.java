package com.w3c.spring.service.dashBoard;

public interface DashBoardService {
    int getTodayReservationCount();

    int getStandbyPatient();

    double getEquipmentUtilizationRate();
}
