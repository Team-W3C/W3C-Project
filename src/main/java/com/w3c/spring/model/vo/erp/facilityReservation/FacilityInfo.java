package com.w3c.spring.model.vo.erp.facilityReservation;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class FacilityInfo {
    private int facilityNo;
    private String facilityName;
    private String facilityCode;
    private String facilityLocation;
    private String facilityType;
    private String facilityStatus;
    private String facilityPhone;
    private String facilityRepresentative;
    private Integer reservationUnit;
    private String fixDate;
}

