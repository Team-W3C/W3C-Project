package com.w3c.spring.service.reservation;

import com.w3c.spring.model.vo.DepartmentVO;
import java.util.List;

public interface DepartmentService {
    List<DepartmentVO> getAllDepartments();
}