package com.w3c.spring.model.mapper;

import com.w3c.spring.model.vo.ScheduleVO;
import com.w3c.spring.model.vo.TimeSlotVO;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import java.util.Map;

@Mapper
public interface ReservationMapper {

    /**
     * 오늘(sysdate)을 포함하여 이후의 모든 병원 스케줄을 조회합니다.
     * @return ScheduleVO 리스트
     */
    List<ScheduleVO> selectScheduleAfterToday();
    List<TimeSlotVO> findAvailableTimes(Map<String, Object> params);
}