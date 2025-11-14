package com.w3c.spring.model.vo.inquiry;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Answer {
    private int answerNo;
    private int boardId;
    private int staffNo;
    private String answerContent;
    private String answerDate;   // 필요 시 Date/LocalDateTime으로 변경
}