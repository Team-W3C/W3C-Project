package com.w3c.spring.model.vo.inquiry;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Board {

    private int boardId;           // 게시글 번호
    private int boardType;         // 게시글 유형
    private String boardTitle;     // 제목
    private String boardSecretType; // 비밀여부
    private String questionContent; // 질문 내용
    private String questionDate;   // 질문 날짜
    private String patientName;    // 환자 이름
    private String boardStatus;    // 게시글 상태
    private String departmentName; // 진료과 이름
    private Integer answerNo;      // 답변 번호 (nullable)
    private String answerContent;  // 답변 내용
    private String staffName;      // 답변자 이름
    private String answerDate;    // 답변 날짜


    private String boardTypeName;     // 게시글 유형명
    private String boardSecretTypeName; // 비밀 여부명

    private String memberEmail; //멤버 이메일 가져올때
    private String memberPhone;// 멤버 전화번호 가져올때

}