package com.w3c.spring.service.mychart;

import java.util.List;
import java.util.Map;

import com.w3c.spring.model.mapper.MyChartMapper;
import com.w3c.spring.service.mychart.MyChartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MyChartServiceImpl implements MyChartService {

    @Autowired
    private MyChartMapper myChartMapper;

    @Override
    public List<Map<String, Object>> getMedicalHistoryList(int memberNo) {
        // Mapper가 Map 리스트를 반환하므로 그대로 반환
        return myChartMapper.selectMedicalHistoryList(memberNo);
    }

    @Override
    public List<Map<String, Object>> getDiagnosisRecords(int memberNo) {
        return myChartMapper.selectDiagnosisRecords(memberNo);
    }

    @Override
    public List<Map<String, Object>> getTestResults(int memberNo) {
        return myChartMapper.selectTestResults(memberNo);
    }
}