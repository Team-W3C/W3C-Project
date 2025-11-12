package com.w3c.spring.model.vo;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class PatientReservationVO {
    private int reservationNo;
    private String reservationTime;
    private String patientName;
    private String patientCode;
    private String departmentName;
    private String reservationPurpose;
    private String reservationStatus;
    private String patientNote;
    private String chronicDisease;
    private String allergy;
    private String gradeStatus;
    private String treatmentWaiting;
    private String treatmentOngoing;
    private String treatmentComplete;
}
