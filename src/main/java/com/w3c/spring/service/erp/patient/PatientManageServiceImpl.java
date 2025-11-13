package com.w3c.spring.service.erp.patient;

import com.w3c.spring.model.mapper.erp.patient.PatientMapper;
import com.w3c.spring.model.vo.erp.patient.PatientListVO;
import com.w3c.spring.model.vo.inquiry.PageInfo;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


@Service
public class PatientManageServiceImpl implements PatientManageService {

    private final PatientMapper patientMapper;

    @Autowired
    public PatientManageServiceImpl(PatientMapper patientMapper) {
        this.patientMapper = patientMapper;
    }

    @Override
    public Map<String, Object> getPatientList(int currentPage,String keyword, String grade) {

        Map<String, Object> param = new HashMap<>();
        param.put("keyword", keyword);
        param.put("grade", grade);

        int listCount = patientMapper.selectPatientListCount(param);

        PageInfo pi = new PageInfo(currentPage, listCount, 5, 5);

        int offset = (currentPage - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

        ArrayList<PatientListVO> list = (ArrayList)patientMapper.selectPatientList(param, rowBounds);

        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("pi", pi);
        map.put("param", param);

        return map;

    }

    @Override
    public Map<String, Object> getPatientStatistics() {
        // 1. "전체 환자"
        int totalCount = patientMapper.selectTotalPatientCount();
        // 2. "오늘 방문"
        int todayCount = patientMapper.selectTodayVisitCount();
        // 3. "신규 환자"
        int newCount = patientMapper.selectNewPatientCountThisMonth();
        //4. vip 환자
        int vipCount = patientMapper.selectVipCount();

        // 맵에 담아서 반환
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalCount", totalCount);
        stats.put("todayCount", todayCount);
        stats.put("newCount", newCount);
        stats.put("vipCount", vipCount);

        return stats;
    }
}
