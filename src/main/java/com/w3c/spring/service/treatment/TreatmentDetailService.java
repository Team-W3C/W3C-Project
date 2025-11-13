package com.w3c.spring.service.treatment;

import com.w3c.spring.model.vo.MedicalRecord;

import java.util.List;

public interface TreatmentDetailService {
    List<MedicalRecord> selectTreatmentDetails(String today);
}
