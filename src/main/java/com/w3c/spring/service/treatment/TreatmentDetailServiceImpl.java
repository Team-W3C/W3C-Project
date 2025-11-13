package com.w3c.spring.service.treatment;

import com.w3c.spring.model.mapper.TreatmentMapper;
import com.w3c.spring.model.vo.MedicalRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TreatmentDetailServiceImpl implements TreatmentDetailService {
    private final TreatmentMapper treatmentMapper;

    @Autowired
    public TreatmentDetailServiceImpl(TreatmentMapper treatmentMapper) {
        this.treatmentMapper = treatmentMapper;
    }

    public List<MedicalRecord> selectTreatmentDetails(String today) {
        return treatmentMapper.selectTreatmentDetails(today);
    }

}
