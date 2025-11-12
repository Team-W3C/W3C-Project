package com.w3c.spring.model.mapper;

import com.w3c.spring.model.vo.AttendanceVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface AttendanceMapper {
    AttendanceVO findTodayRecordByStaffNo(long staffNo);
    List<AttendanceVO> findHistoryByStaffNo(long staffNo);
    List<AttendanceVO> findApplicationsByStaffNo(long staffNo);
    int insertApplication(AttendanceVO attendance);
    List<AttendanceVO> findAllPendingApplications();
    List<AttendanceVO> findAllCompletedApplications();
    int updateApplicationStatus(Map<String, Object> params);
    List<AttendanceVO> findAllEmployeeStatus(String searchTerm);
}