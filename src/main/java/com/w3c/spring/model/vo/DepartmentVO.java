package com.w3c.spring.model.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class DepartmentVO {
    private int departmentNo;
    private String departmentName;
    // (참고) 아이콘 URL을 DB에서 관리하려면 여기에 private String iconUrl; 추가
}