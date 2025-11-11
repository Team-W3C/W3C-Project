package com.w3c.spring.model.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class FullCalendarEventVO {

    private String title;
    private String start;
    private String end;
    private String display;
    private String className;
}