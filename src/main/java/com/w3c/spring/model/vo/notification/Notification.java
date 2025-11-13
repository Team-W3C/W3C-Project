package com.w3c.spring.model.vo.notification;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Notification {
    private int notificationNo; //아이디
    private int notificationType;     // 공지 유형 (시스템, 시설, 진료 등)
    private String departmentName;    // 부서명
    private String notificationTitle; // 공지 제목
    private String notificationDate;  // 공지 날짜 (YYYY-MM-DD)
    private String notificationContent; //공지 내용
    private int notifiedType; // 환자 직원 공지


    private String notifiedTypeName; // 타입 이름  1-> 시스템 등등
    private String notificationTypeName;
}