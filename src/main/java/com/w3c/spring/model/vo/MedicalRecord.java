package com.w3c.spring.model.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor

public class MedicalRecord {
    private String patientCode;
    private String recordDate;
    private String departmentName;
    private String diagnosisContent;
    private String prescription;
}
