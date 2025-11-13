package com.w3c.spring.model.vo; // (VO 패키지 경로)

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class DepartmentVO {

    /**
     * 진료과 번호 (PK)
     * (DB: DEPARTMENT_NO)
     */
    private int departmentNo;

    /**
     * 진료과 이름
     * (DB: DEPARTMENT_NAME)
     */
    private String departmentName;

    /**
     * 진료과 위치
     * (DB: DEPARTMENT_LOCATION)
     */
    private String departmentLocation;

    /**
     * [추가]
     * 서비스 레이어에서 아이콘 URL을 설정하기 위한 필드
     */
    private String iconUrl;
}