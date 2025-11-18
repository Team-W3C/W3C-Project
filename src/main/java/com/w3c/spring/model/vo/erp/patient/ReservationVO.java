package com.w3c.spring.model.vo.erp.patient;

import java.util.Date;
import lombok.Data;

@Data
public class ReservationVO {
    private Date reservationDate;  // 예약 날짜/시간
    private String departmentName; // 진료과
    private String doctorName;     // 담당의
    private String reservationType; // 예약 구분 (예: 정기검진, 초진)
}
