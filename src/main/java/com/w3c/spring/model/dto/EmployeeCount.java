package com.w3c.spring.model.dto;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor

//직원관리에 필요한 count 값을 저장하는 객체
public class EmployeeCount {
    private int totalCount;
    private int workCount;
    private int vacationCount;
    private int resignCount;
}
