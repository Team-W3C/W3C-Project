package com.w3c.spring.model.vo;

import lombok.*;
import java.util.Date;

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

    //추가 : 회원 생년월일을 받아오기 위한 메서드
    public String getBirthDateForHtml() {
        if (memberRrn == null || memberRrn.length() < 6) {
            return "";
        }

        // RRN 앞 6자리 추출 (예: 900101)
        String rrnFront = memberRrn.substring(0, 6);

        // 성별/세기 식별자 추출 (뒷자리 첫 번째 숫자)
        // 하이픈(-)이 있는 경우 index 7, 없는 경우 index 6
        char genderDigit = memberRrn.contains("-") ? memberRrn.charAt(7) : memberRrn.charAt(6);

        String yearPrefix;
        if (genderDigit == '1' || genderDigit == '2' || genderDigit == '5' || genderDigit == '6') {
            yearPrefix = "19"; // 1900년대
        } else {
            yearPrefix = "20"; // 2000년대
        }

        String year = yearPrefix + rrnFront.substring(0, 2);
        String month = rrnFront.substring(2, 4);
        String day = rrnFront.substring(4, 6);

        return year + "-" + month + "-" + day; // YYYY-MM-DD 반환
    }
}