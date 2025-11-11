package com.w3c.spring.model.vo;

import lombok.*;
import java.util.Date; // [수정] java.sql.Date -> java.util.Date

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Member {

    private int memberNo; // [수정] String -> int (DB의 NUMBER 타입과 일치)
    private String memberId;
    private String memberPwd;
    private String memberName;
    private String memberGender;
    private String memberRrn;
    private String memberPhone;
    private String memberEmail;
    private String memberAddress;
    private Date memberJoinDate; // [수정] java.sql.Date -> java.util.Date
    private String memberBloodType;
    private String memberChronicDisease;
    private String memberAllergy;
    private String memberStatus;

    // [수정] DB 스키마에 맞게 staff_no -> staffNo, String -> Integer
    private Integer staffNo;
}