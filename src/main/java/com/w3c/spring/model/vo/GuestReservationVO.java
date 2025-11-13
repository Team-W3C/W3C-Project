package com.w3c.spring.model.vo;

import lombok.*;
import java.time.LocalDateTime;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class GuestReservationVO {
    private Long reservationId;
    private String name;
    private String ssn;
    private String phone;
    private String address;
    private String email;
    private String notes;

    // 예약 관련 필수 정보
    private String departmentName;      // 진료과 이름 (Mapper에서 departmentNo를 찾아야 함)
    private Long departmentNo;          // DB에 저장할 실제 번호 (Service/Mapper에서 설정될 예정)
    private String treatmentDateString; // 최종 조합된 날짜와 시간 (YYYY-MM-DD HH:MI)
    private Long reservationNo;

    private LocalDateTime reservedAt;
}