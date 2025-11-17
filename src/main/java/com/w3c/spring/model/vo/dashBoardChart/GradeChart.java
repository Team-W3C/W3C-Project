package com.w3c.spring.model.vo.dashBoardChart;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class GradeChart {
    private String label; // 일반, VIP, 우선예약
    private int value;    // 비율 %
}
