package com.w3c.spring.model.mapper.erp.facilityReservation;

import com.w3c.spring.model.vo.erp.facilityReservation.FacilityReservation;
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
    
    // ✅ 총 예약 개수 조회 (서로 다른 환자 수가 아닌 전체 예약 개수)
    // XML의 id와 일치하도록 selectReservationCountByDate로 변경
    int selectReservationCountByDate(
            @Param("date") String date,
            @Param("facilityNo") int facilityNo
    );
}
