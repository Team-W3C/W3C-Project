package com.w3c.spring.model.vo;

import lombok.*;

// '변경' 시 예약 폼에 데이터를 채우기 위한 VO
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ReservationUpdateVO {

    private int reservationNo;      // 예약 PK
    private int departmentNo;       // 진료과 PK (select box 선택용)
    private String departmentName;    // 진료과 이름 (화면 표시용)

    // YYYY-MM-DD HH24:MI 형식의 문자열
    private String treatmentDate;   // 예약 날짜/시간

    private String reservationNotes;  // 증상 (textarea)
    private String doctorName;        // 담당의 (input)

    // (필요에 따라 다른 필드 추가)
}