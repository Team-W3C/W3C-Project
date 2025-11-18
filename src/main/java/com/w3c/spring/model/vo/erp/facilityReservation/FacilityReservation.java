package com.w3c.spring.model.vo.erp.facilityReservation;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class FacilityReservation {
    private int facilityReservationNo;
    private String reservationStatus;
    private String reservationNotes;
    private String treatmentDate;
    private String facilityReservationMemo;
    private int staffNo;
    private int memberNo;
    private int facilityNo;

    private int reservationCount; // 조회용
}
