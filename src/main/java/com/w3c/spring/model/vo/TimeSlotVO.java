package com.w3c.spring.model.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class TimeSlotVO {

    // 1. 시간 (예: "09:00")
    private String time;

    // 2. 의사 이름 (예: "이준호 교수")
    private String doctorName;

    // 3. 위치 (예: "본관 2층")
    private String location;

    // 4. 예약 가능 여부 (true: 예약 가능, false: 예약 마감)
    private boolean available;
}