package com.w3c.spring.service.reservation;

import com.w3c.spring.model.mapper.DepartmentMapper;
import com.w3c.spring.model.vo.DepartmentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class DepartmentServiceImpl implements DepartmentService {

    private final DepartmentMapper departmentMapper;

    @Autowired
    public DepartmentServiceImpl(DepartmentMapper departmentMapper) {
        this.departmentMapper = departmentMapper;
    }

    @Override
    public List<DepartmentVO> getAllDepartments() {
        return departmentMapper.selectAllDepartments();
    }
}