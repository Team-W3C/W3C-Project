package com.w3c.spring.model.vo.notification;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class NotificationInsert {
    private int notificationType;     // 공지 유형 (1: 시스템, 2: 운영, 3: 진료)
    private int departmentNo;         // 부서 번호
    private String notificationTitle; // 공지 제목
    private String notificationContent; // 공지 내용
    private int notifiedType;         // 대상 타입 (1: 환자, 2: 직원, 3: 전체)
    private int staffNo; // 직원넘버
}