package com.w3c.spring.model.mapper;

import com.w3c.spring.model.vo.MedicalRecord;
import com.w3c.spring.model.vo.PatientReservation;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PatientReservationMapper {
    List<PatientReservation> selectTodayPatients(String searchToday);
    List<MedicalRecord> selectTreatmentDetails(String today);
}
