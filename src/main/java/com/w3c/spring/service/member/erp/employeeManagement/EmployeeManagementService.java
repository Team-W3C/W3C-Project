package com.w3c.spring.service.member.erp.employeeManagement;

import com.w3c.spring.model.dto.EmployeeCount;
import com.w3c.spring.model.vo.employeeManagement.StaffDetail;

import java.util.Map;

public interface EmployeeManagementService {
    Map<String, Object> getStaffList(int currentPage);
    Map<String, Object> searchEmployeeList(int currentPage, String condition, String keyword);
    EmployeeCount getCurrentStats();
    StaffDetail getEmployeeById(int staffNo);

}
