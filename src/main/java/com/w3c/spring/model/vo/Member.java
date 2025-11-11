package com.w3c.spring.model.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Member {
    private String memberNo;
    private String memberId;
    private String memberPwd;
    private String memberName;
    private String memberGender;
    private String memberRrn;
    private String memberPhone;
    private String memberEmail;
    private String memberAddress;
    private Date memberJoinDate;
    private String memberBloodType;
    private String memberChronicDisease;
    private String memberAllergy;
    
    //참조를 위한 직원 번호
    private String staff_no;
}
