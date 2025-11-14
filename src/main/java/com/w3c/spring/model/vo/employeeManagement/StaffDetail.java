package com.w3c.spring.model.vo.employeeManagement;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class StaffDetail {
    private int staffNo;
    private String staffName;
    private String staffEmail;
    private String staffPhone;
    private Date joinDate;
    private String status;
    private String position;
    private String department;
    private String scheduleDetail;
    private int attendanceDayCount;
    private int lateCount;
    private int absentCount;
    private int vacationDayCount;
    private int totalAnnualLeave;
    private int usedAnnualLeave;
    private int remainingAnnualLeave;
    private String licenses;
    private String specialties;
    private int working;
}
