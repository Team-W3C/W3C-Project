package com.w3c.spring.service.treatment;

import com.w3c.spring.model.mapper.PatientReservationMapper;
import com.w3c.spring.model.vo.PatientReservation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MeditodayServiceImpl implements MeditodayService {
    private final PatientReservationMapper patientReservationMapper;

    @Autowired
    public MeditodayServiceImpl(PatientReservationMapper patientReservationMapper) {
        this.patientReservationMapper = patientReservationMapper;
    }

    @Override
    public List<PatientReservation> getTodayPatients(String searchToday){
        return patientReservationMapper.selectTodayPatients(searchToday);
    }
}
