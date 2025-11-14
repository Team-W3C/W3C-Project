package com.w3c.spring.service.dashBoard;

import com.w3c.spring.model.mapper.DashBoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
