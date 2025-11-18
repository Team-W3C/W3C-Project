package com.w3c.spring.model.vo.dashBoardChart;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class TOP5Reservaion {
    private String memberName;        // 환자 이름
    private String departmentName;    // 부서명
    private String treatmentDate;     // 진료 날짜 (YYYY-MM-DD 형식, 시간 제외)
    private String reservationStatus; // 예약 상태 (확정, 대기, 완료, 취소)
    private int reservationNo;        // 예약 번호
}
