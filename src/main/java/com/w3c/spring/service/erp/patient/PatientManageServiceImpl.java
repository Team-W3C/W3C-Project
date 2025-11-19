package com.w3c.spring.service.erp.patient;

import com.w3c.spring.model.mapper.erp.patient.PatientMapper;
import com.w3c.spring.model.vo.MedicalRecord;
import com.w3c.spring.model.vo.Member;
import com.w3c.spring.model.vo.erp.patient.PatientListVO;
import com.w3c.spring.model.vo.erp.patient.PatientRecordVO;
import com.w3c.spring.model.vo.erp.patient.ReservationVO;
import com.w3c.spring.model.vo.inquiry.PageInfo;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;


@Service
public class PatientManageServiceImpl implements PatientManageService {

    private final PatientMapper patientMapper;

    @Autowired
    public PatientManageServiceImpl(PatientMapper patientMapper) {
        this.patientMapper = patientMapper;
    }

    @Override
    public Map<String, Object> getPatientList(int currentPage, String keyword, String grade) {

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

    //신규 환자 등록
    @Override
    public int registerPatient(Member member) {
        // 1. 가입일: 현재 날짜 (SYSDATE)
        member.setMemberJoinDate(new Date());

        // 2. 환자 상태: 'T' (정상)
        member.setMemberStatus("T");

        String rrn = member.getMemberRrn();
        if (rrn != null && rrn.length() == 13 && !rrn.contains("-")) {
            // 0111133123456 -> 011113-3123456
            String formattedRrn = rrn.substring(0, 6) + "-" + rrn.substring(6);
            member.setMemberRrn(formattedRrn);
        }

        // Mapper 호출
        return patientMapper.insertPatient(member);
    }

    @Override
    public Map<String, Object> getPatientDetail(int memberNo) {

        // 1. 환자 기본 정보 (주소, 알러지, 혈액형 등)
        Member member = patientMapper.selectPatientDetail(memberNo);

        // 2. 환자 진료 기록 (여러 건)
        List<PatientRecordVO> records = patientMapper.selectMedicalRecords(memberNo);

        List<ReservationVO> reservations = patientMapper.selectReservations(memberNo);

        // 3. Map에 담아 반환
        Map<String, Object> detail = new HashMap<>();
        detail.put("member", member);
        detail.put("records", records);
        detail.put("reservations", reservations);

        return detail;
    }
}
