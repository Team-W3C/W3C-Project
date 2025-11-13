package com.w3c.spring.model.mapper.erp.patient;

import com.w3c.spring.model.vo.erp.patient.PatientListVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;
import java.util.Map;

@Mapper
public interface PatientMapper {
    int selectPatientListCount(Map<String, Object> param);
    List<PatientListVO> selectPatientList(Map<String, Object> param, RowBounds rowBounds);

    int selectTotalPatientCount(); //전체 환자 수
    int selectTodayVisitCount(); //오늘 방문 환자수
    int selectNewPatientCountThisMonth();
    int selectVipCount();//이번 달 신규 환자 수
}
