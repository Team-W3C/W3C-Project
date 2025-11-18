package com.w3c.spring.service.mychart;

import java.util.List;
import java.util.Map;

public interface MyChartService {

    /**
     * 1. 회원의 진료내역(방문) 목록 조회
     *
     * @param memberNo 회원 번호
     * @return 진료내역 Map 리스트
     */
    List<Map<String, Object>> getMedicalHistoryList(int memberNo);
    /**
     * 2-1. 회원의 진단/처방 기록 조회 (Map)
     */
    List<Map<String, Object>> getDiagnosisRecords(int memberNo);

    /**
     * 2-2. 회원의 시설검사 결과 조회 (Map)
     */
    List<Map<String, Object>> getTestResults(int memberNo);
}