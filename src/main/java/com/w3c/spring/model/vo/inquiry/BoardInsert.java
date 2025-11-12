package com.w3c.spring.model.vo.inquiry;


import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class BoardInsert {

    private int boardType;          // 문의 타입 (1: 수납, 2: 예약, 3: 질문 등)
    private String boardTitle;      // 제목
    private String boardContent;    // 내용
    private String boardSecretType; // 비밀 여부 (T/F)
    private int memberNo;           // 세션에서 가져올 회원번호
//    private String patientName;     // 작성자 이름
}
