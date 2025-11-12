package com.w3c.spring.model.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ReservationRequestVO {

    // (기존 필드) 예약 폼에서 넘어오는 데이터
    private int departmentNo;
    private String treatmentDate; // (예: "2025-11-20 10:00")
    private String doctorName;
    private String reservationNotes;

    // ▼▼▼ [오류 수정] 예약 '수정' 시 필요한 필드 추가 ▼▼▼

    /**
     * (Service에서 주입 또는 JS에서 전달)
     * 수정 대상이 되는 예약 번호 (PK)
     */
    private int reservationNo;

    /**
     * (Service에서 주입)
     * 예약을 요청한 회원 번호 (PK)
     */
    private int memberNo;

    // ▲▲▲ [오류 수정] ▲▲▲
}