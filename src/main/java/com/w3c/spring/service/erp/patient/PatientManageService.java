package com.w3c.spring.service.erp.patient;

import com.w3c.spring.model.vo.Member;

import java.util.Map;

public interface PatientManageService {
    public Map<String, Object> getPatientList(int currentPage, String keyword, String grade); //환자 조회 메서드(페이징 포함)
    Map<String, Object> getPatientStatistics(); //통계 조회용 메서드

    int registerPatient(Member member); //신규 환자 등록


}
