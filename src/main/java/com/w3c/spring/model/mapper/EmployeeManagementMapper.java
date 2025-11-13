package com.w3c.spring.model.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EmployeeManagementMapper {
    int getCountEmployeeAll();
    int getCountEmployeeWork();
    int getCountEmployeeVacation();
    int getCountEmployeeResign();
}
