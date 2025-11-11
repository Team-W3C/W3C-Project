package com.w3c.spring.model.vo;

import java.util.Date;
import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ScheduleVO {

    private Date scheduleStartTime; // schedule_start_time
    private Date scheduleEndTime;   // schedule_end_time (추가)
    private String status;
}