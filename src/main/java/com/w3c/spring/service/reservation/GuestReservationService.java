package com.w3c.spring.service.reservation; // (패키지 경로는 실제 프로젝트에 맞게 수정하세요)

import java.util.Map;

public interface GuestReservationService {

    /**
     * 비회원 예약을 등록합니다. (트랜잭션 처리)
     *
     * @param formData 폼에서 받은 파라미터 Map
     * @return 처리 결과 (삽입된 예약 번호)
     * @throws Exception 처리 중 오류 발생 시
     */
    int registerGuestReservation(Map<String, String> formData) throws Exception;
}