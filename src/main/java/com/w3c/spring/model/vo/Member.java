package com.w3c.spring.model.vo;

import lombok.*;
import java.util.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Member {

    private int memberNo;
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

    private Integer staffNo;

    // [추가] 근태 신청서 모달에 필요한 추가 정보
    private String departmentName;
    private String positionName;
}