package com.w3c.spring.model.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class GuestReservationRequest {
    private String name;
    private String birthDate; // 생년월일 6자리
    private String birthSuffix; // 주민번호 뒷자리
    private String phone;
    private String address;
    private String email;
    private String notes;

    // ★★★ 예약 정보 필드 수정 ★★★
    private String departmentName;  // 진료과 이름 (새로 추가)
    private String treatmentDate;   // 선택된 날짜 (YYYY-MM-DD)
    private String treatmentTime;   // 선택된 시간 (HH:MI)
}