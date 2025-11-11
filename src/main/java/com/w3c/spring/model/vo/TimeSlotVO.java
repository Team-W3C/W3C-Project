package com.w3c.spring.model.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class TimeSlotVO {
    private String time; // 예: "09:00~10:00"
    private String doctorName;
    private String location;
    // private String status; // (필요시: 예약가능/예약마감)
}