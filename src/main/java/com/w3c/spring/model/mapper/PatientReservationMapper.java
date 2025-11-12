package com.w3c.spring.model.mapper;

import com.w3c.spring.model.vo.PatientReservationVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PatientReservationMapper {
    List<PatientReservationVO> selectTodayPatients(String searchToday);
}
