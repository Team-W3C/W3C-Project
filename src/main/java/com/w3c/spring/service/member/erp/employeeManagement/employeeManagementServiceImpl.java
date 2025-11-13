package com.w3c.spring.service.member.erp.employeeManagement;

import com.w3c.spring.model.mapper.EmployeeManagementMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class employeeManagementServiceImpl implements EmployeeManagementService {
    private EmployeeManagementMapper employeeManagementMapper;

    @Autowired
    public void setEmployeeManagementMapper(EmployeeManagementMapper employeeManagementMapper) {
        this.employeeManagementMapper = employeeManagementMapper;
    }

    @Override
    public int getCountEmployeeAll() {
        return employeeManagementMapper.getCountEmployeeAll();
    }

    @Override
    public int getCountEmployeeWork() {
        return employeeManagementMapper.getCountEmployeeWork();
    }

    @Override
    public int getCountEmployeeVacation() {
        return employeeManagementMapper.getCountEmployeeVacation();
    }

    @Override
    public int getCountEmployeeResign() {
        return employeeManagementMapper.getCountEmployeeResign();
    }
}
