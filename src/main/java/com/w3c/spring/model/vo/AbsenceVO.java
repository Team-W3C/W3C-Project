package com.w3c.spring.model.vo;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class AbsenceVO {

    // reservation-mapper.xml의 findApprovedAbsences 쿼리가 사용합니다.
    private Date absenceStartDate;
    private Date absenceEndDate;
}