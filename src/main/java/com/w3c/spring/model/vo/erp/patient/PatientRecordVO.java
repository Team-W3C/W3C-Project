package com.w3c.spring.model.vo.erp.patient;

import java.util.Date;
import lombok.Data;

@Data

public class PatientRecordVO {
    private Date visitDate;        // 방문일
    private String departmentName; // 진료과
    private String doctorName;     // 담당의
    private String diagnosis;      // 진단명
    private String status;         // 상태 (완료, 예정)
}

