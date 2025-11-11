package com.w3c.spring.model.mapper;

import com.w3c.spring.model.vo.DepartmentVO;
import com.w3c.spring.model.vo.ScheduleVO;
import com.w3c.spring.model.vo.TimeSlotVO;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import java.util.Map;

@Mapper
public interface ReservationMapper {
    List<ScheduleVO> selectScheduleAfterToday();
    List<TimeSlotVO> findAvailableTimes(Map<String, Object> params);
    List<DepartmentVO> findAllDepartmentsWithDoctors();
}