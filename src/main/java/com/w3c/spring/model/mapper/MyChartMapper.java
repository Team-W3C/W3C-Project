package com.w3c.spring.model.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MyChartMapper {

    /**
     * 1. 회원의 진료내역(방문) 목록 조회
     */
    List<Map<String, Object>> selectMedicalHistoryList(int memberNo);

    /**
     * 2-1. 회원의 진단/처방 기록 조회 (Map)
     */
    List<Map<String, Object>> selectDiagnosisRecords(int memberNo);

    /**
     * 2-2. 회원의 시설검사 결과 조회 (Map)
     */
    List<Map<String, Object>> selectTestResults(int memberNo);
}