package com.w3c.spring.controller.api.hompage.reservation;

import com.w3c.spring.model.vo.DepartmentVO;
import com.w3c.spring.service.reservation.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@Controller
@RequestMapping("/api/departments")
public class DepartmentController {

    private final DepartmentService departmentService;

    @Autowired
    public DepartmentController(DepartmentService departmentService) {
        this.departmentService = departmentService;
    }

    @GetMapping
    public ResponseEntity<List<DepartmentVO>> getDepartments() {
        List<DepartmentVO> departments = departmentService.getAllDepartments();
        return ResponseEntity.ok(departments);
    }
}