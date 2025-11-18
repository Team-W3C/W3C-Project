package com.w3c.spring.service.erp.facilityReservation;

import com.w3c.spring.model.vo.erp.facilityReservation.FacilityReservation;
import com.w3c.spring.model.vo.erp.facilityReservation.Facility;

import java.util.List;

public interface FacilityReservationService {
    List<FacilityReservation> getAllReservations();

    List<FacilityReservation> getReservationsByDate(String date);

    List<FacilityReservation> getReservationsByDateAndFacility(String date, int facilityNo);

//    int getUniquePatientCountByDate(String date, int facilityNo);
//
//    int getReservationCountByDate(String date, int facilityNo);

    int insertReservation(FacilityReservation reservation);

    int deleteReservationsByDateAndFacility(String date, int facilityNo);
    
    // ✅ 시설 목록 조회
    List<Facility> getAllFacilities();
}