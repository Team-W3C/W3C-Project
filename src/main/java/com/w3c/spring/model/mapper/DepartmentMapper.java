package com.w3c.spring.model.mapper;

import com.w3c.spring.model.vo.DepartmentVO; // ★★★ DepartmentVO가 필요합니다. ★★★
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface DepartmentMapper {

    // 1. 진료과 이름으로 번호 조회 (기존 로직 지원)
    Long selectDepartmentNoByName(@Param("departmentName") String departmentName);

    // 2. ★★★ 추가: 모든 진료과 목록 조회 ★★★
    List<DepartmentVO> selectAllDepartments();
}