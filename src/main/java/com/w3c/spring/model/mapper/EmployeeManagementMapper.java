package com.w3c.spring.model.mapper;

import com.w3c.spring.model.vo.Member;
import com.w3c.spring.model.vo.employeeManagement.StaffDetail;
import com.w3c.spring.model.vo.employeeManagement.ViewStaffList;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface EmployeeManagementMapper {
    int getCountEmployeeAll();
    int getCountEmployeeWork();
    int getCountEmployeeVacation();
    int getCountEmployeeResign();
    
    //직원 리스트
    List<Member> selectStaffList(RowBounds rowBounds);

    // 검색 관련
    int getSearchCount(@Param("condition") String condition, @Param("keyword") String keyword);
    List<ViewStaffList> searchStaffList(@Param("condition") String condition,
                                        @Param("keyword") String keyword,
                                        RowBounds rowBounds);
    StaffDetail getEmployeeById(@Param("staffNo") int staffNo);
}
