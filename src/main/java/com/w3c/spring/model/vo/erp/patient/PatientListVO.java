package com.w3c.spring.model.vo.erp.patient;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor

public class PatientListVO {
    private int memberNo;
    private String memberName;
    private String memberGender;
    private String memberPhone;

    // 별칭(Alias)과 1:1 대응
    private Date lastVisitDate;
    private int visitCount;
    private int age;
    private String grade;
}
