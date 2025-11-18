package com.w3c.spring.model.vo.erp.facilityReservation;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Facility {
    private int facilityNo;              // FACILITY_NO
    private String facilityName;        // FACILITY_NAME
    private String facilityCode;        // FACILITY_CODE
    private String facilityLocation;    // FACILITY_LOCATION
    private String facilityType;        // FACILITY_TYPE
    private String facilityStatus;      // FACILITY_STATUS
    private String facilityPhone;       // FACILITY_PHONE
    private String facilityRepresentative; // FACILITY_REPRESENTATIVE
    private String reservationUnit;     // RESERVATION_UNIT
    private String fixDate;             // FIX_DATE
}