package com.w3c.spring.model.vo;

import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class AttendanceVO {
    private long absenceNo;
    private LocalDate absenceDate;
    private LocalDateTime absenceStart;
    private LocalDateTime absenceEnd;
    private int absenceStatus;
    private int annualLeave;
    private String workHours;
    private long addNo;
    private String detailedReason;
    private String isApproved;
    private LocalDate absenceStartDate;
    private LocalDate absenceEndDate;
    private int absenceType;
    private long staffNo;
    private String employeeName;
    private String departmentName;
    private String position;
    private String workSchedule;
    private String email;
    private String phone;

    private String absenceStartTime;
    private String absenceEndTime;

    private LocalDate absenceApplicationDate;
}