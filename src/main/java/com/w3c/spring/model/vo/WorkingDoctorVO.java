package com.w3c.spring.model.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class WorkingDoctorVO {

    // SQL (staffNo)
    private int staffNo;

    // SQL (memberName)
    private String memberName;

    // SQL (departmentLocation)
    private String departmentLocation;
}