package com.w3c.spring.service.member.erp.employeeManagement;

import com.w3c.spring.model.dto.EmployeeCount;
import com.w3c.spring.model.mapper.EmployeeManagementMapper;
import com.w3c.spring.model.vo.Member;
import com.w3c.spring.model.vo.employeeManagement.StaffDetail;
import com.w3c.spring.model.vo.employeeManagement.ViewStaffList;
import com.w3c.spring.model.vo.inquiry.Board;
import com.w3c.spring.model.vo.inquiry.PageInfo;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class employeeManagementServiceImpl implements EmployeeManagementService {
    private EmployeeManagementMapper employeeManagementMapper;

    @Autowired
    public void setEmployeeManagementMapper(EmployeeManagementMapper employeeManagementMapper) {
        this.employeeManagementMapper = employeeManagementMapper;
    }

    @Override
    public Map<String, Object> getStaffList(int currentPage) {
        int listCount = employeeManagementMapper.getCountEmployeeAll();

        PageInfo pi = new PageInfo(currentPage, listCount, 5, 5);

        int offset = (currentPage - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

        ArrayList<Member> list = (ArrayList)employeeManagementMapper.selectStaffList(rowBounds);

        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("pi", pi);

        return map;
    }

    @Override
    public Map<String, Object> searchEmployeeList(int currentPage, String condition, String keyword) {
        // 1. 검색 결과 총 개수 조회
        int listCount = employeeManagementMapper.getSearchCount(condition, keyword);

        // 2. 페이징 정보 생성
        PageInfo pi = new PageInfo(currentPage, listCount, 5, 5);

        // 3. RowBounds로 페이징 처리
        int offset = (currentPage - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

        // 4. 검색 결과 조회
        List<ViewStaffList> list = employeeManagementMapper.searchStaffList(condition, keyword, rowBounds);

        // 5. Map에 담아서 반환
        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("pi", pi);

        return map;
    }

    public EmployeeCount getCurrentStats() {
        // 1. DTO 객체 생성
        EmployeeCount stats = new EmployeeCount();

        // 2. 서비스의 각 메서드를 호출하여 DTO에 값 설정
        stats.setTotalCount(employeeManagementMapper.getCountEmployeeAll());
        stats.setWorkCount(employeeManagementMapper.getCountEmployeeWork());
        stats.setVacationCount(employeeManagementMapper.getCountEmployeeVacation());
        stats.setResignCount(employeeManagementMapper.getCountEmployeeResign());

        // 3. 값이 채워진 DTO 반환
        return stats;
    }

    @Override
    public StaffDetail getEmployeeById(int staffNo) {
        return employeeManagementMapper.getEmployeeById(staffNo);
    }
}
