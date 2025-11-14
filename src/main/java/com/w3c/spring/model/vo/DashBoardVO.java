package com.w3c.spring.model.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class DashBoardVO {
    private int reservationCount;

    private int standbyPatient ;

    private double equipmentUtilizationRate;

    private double reservationIncreaseRate;

    private double standbyPatientIncreaseRate;

    private double equipmentUtilizationIncreaseRate;
}
