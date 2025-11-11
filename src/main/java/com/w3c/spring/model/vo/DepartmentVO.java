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
    private String iconUrl;
}