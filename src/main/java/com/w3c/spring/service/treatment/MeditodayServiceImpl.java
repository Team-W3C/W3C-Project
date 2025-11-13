package com.w3c.spring.service.treatment;

import com.w3c.spring.model.mapper.TreatmentMapper;
import com.w3c.spring.model.vo.PatientReservation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MeditodayServiceImpl implements MeditodayService {
    private final TreatmentMapper treatmentMapper;

    @Autowired
    public MeditodayServiceImpl(TreatmentMapper treatmentMapper) {
        this.treatmentMapper = treatmentMapper;
    }

    @Override
    public List<PatientReservation> getTodayPatients(String searchToday){
        return treatmentMapper.selectTodayPatients(searchToday);
    }
}
