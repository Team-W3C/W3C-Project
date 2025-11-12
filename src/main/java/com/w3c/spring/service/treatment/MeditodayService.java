package com.w3c.spring.service.treatment;

import com.w3c.spring.model.vo.PatientReservationVO;

import java.util.List;

public interface MeditodayService {
    List<PatientReservationVO> getTodayPatients(String searchToday);
}
