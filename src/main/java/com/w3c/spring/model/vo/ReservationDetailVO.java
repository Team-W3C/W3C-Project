package com.w3c.spring.model.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ReservationDetailVO {

    // JSP에서 ${reservation.reservationNo}로 사용하기 위해
    // mapper.xml의 AS "reservationNo"와 이름(대소문자)이 일치해야 합니다.
    private int reservationNo;

    // JSP에서 사용하는 필드명을 그대로 선언
    private String status;           // 예약 상태 (CONFIRMED, PENDING 등)
    private String type;             // 예약 타입 (진료, 검사 등)
    private String departmentName;   // 진료과 이름
    private String date;             // 진료 날짜 (YYYY-MM-DD)
    private String doctorName;       // 담당의사 이름
    private String time;             // 진료 시간 (HH24:MI)
    private String location;         // 진료실 위치

}