package com.w3c.spring.model.vo;

import lombok.*;
import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Member {

    private int memberNo; // DB NUMBER에 대응, Java int 사용
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
    private String memberStatus;

    // staff_no는 DB에서 NUMBER이므로 Java에서는 Integer(NULL 허용) 또는 int(NULL 불허)
    // DDL에서 NULL 허용이므로 Integer가 적절합니다.
    private Integer staffNo;

    // [추가] 근태 신청서 모달에 필요한 추가 정보
    private String departmentName;
    private String positionName;
}