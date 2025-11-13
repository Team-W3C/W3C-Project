package com.w3c.spring.service.treatment;

import com.w3c.spring.model.mapper.PatientReservationMapper;
import com.w3c.spring.model.vo.MedicalRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TreatmentDetailServiceImpl implements TreatmentDetailService {
    private final PatientReservationMapper patientReservationMapper;

    @Autowired
    public TreatmentDetailServiceImpl(PatientReservationMapper patientReservationMapper) {
        this.patientReservationMapper = patientReservationMapper;
    }

    public List<MedicalRecord> selectTreatmentDetails(String today) {
        System.out.println("Service - today 파라미터: " + today);
        List<MedicalRecord> result = patientReservationMapper.selectTreatmentDetails(today);
        System.out.println("Service - 결과 개수: " + result.size());
        if (!result.isEmpty()) {
            System.out.println("Service - 첫 번째 데이터: " + result.get(0));
        }
        return result;
    }



}
