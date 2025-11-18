package com.w3c.spring.model.vo.inquiry;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class BoardMemberSelect {

    private int memberNo; //멤버 번호
    private String memberName; //멤버 이름
    private String memberEmail; //멤버 이메일
    private String memberPhone; //멤버 전화번호
}
