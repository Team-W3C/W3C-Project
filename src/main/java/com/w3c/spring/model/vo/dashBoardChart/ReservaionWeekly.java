package com.w3c.spring.model.vo.dashBoardChart;


import lombok.*;

import java.time.LocalDate;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ReservaionWeekly {
    private LocalDate rdate;
    private int cnt;
}
