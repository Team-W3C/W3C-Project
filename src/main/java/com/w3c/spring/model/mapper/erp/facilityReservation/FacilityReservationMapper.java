package com.w3c.spring.model.mapper.erp.facilityReservation;

import com.w3c.spring.model.vo.erp.facilityReservation.FacilityReservation;
import com.w3c.spring.model.vo.erp.facilityReservation.Facility;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface FacilityReservationMapper {
    List<FacilityReservation> selectAllReservations();

    List<FacilityReservation> selectReservationsByDate(@Param("date") String date);

    List<FacilityReservation> selectReservationsByDateAndFacility(
            @Param("date") String date,
            @Param("facilityNo") int facilityNo
    );

    int selectUniquePatientCountByDate(
            @Param("date") String date,
            @Param("facilityNo") int facilityNo
    );

    int insertReservation(FacilityReservation reservation);

    int deleteReservationsByDateAndFacility(
            @Param("date") String date,
            @Param("facilityNo") int facilityNo
    );
    
    int selectReservationCountByDate(
            @Param("date") String date,
            @Param("facilityNo") int facilityNo
    );
    
    // ✅ 시설 목록 조회
    List<Facility> selectAllFacilities();
}