package com.w3c.spring.model.vo.employeeManagement;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ViewStaffList {
    private int staffNo;
    private String staffName;
    private String staffPosition;
    private String department;
    private String staffEmail;
    private String staffPhone;
    private String scheduleDay;
    private String staffStatus;
}
