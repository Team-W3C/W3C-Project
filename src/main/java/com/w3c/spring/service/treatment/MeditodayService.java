package com.w3c.spring.service.treatment;

import com.w3c.spring.model.vo.PatientReservation;

import java.util.List;

public interface MeditodayService {
    List<PatientReservation> getTodayPatients(String searchToday);
}
