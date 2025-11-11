package com.w3c.spring.model.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class FullCalendarEventVO {

    // ServiceImpl의 getReservationSchedule 메소드가 사용합니다.
    // (JSP의 FullCalendar 'events' 옵션이 이 객체 리스트를 받습니다)
    private String title;
    private String display;
    private String start;
    private String end;
    private String className;
}