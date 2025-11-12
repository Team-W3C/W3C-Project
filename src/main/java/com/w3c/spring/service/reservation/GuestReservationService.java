package com.w3c.spring.service.reservation;

// import com.w3c.spring.model.vo.GuestReservationRequest; // ★★★ 삭제 또는 주석 처리 ★★★
import com.w3c.spring.model.vo.GuestReservationVO;

public interface GuestReservationService {

    /**
     * 비회원 예약 정보를 저장하고, 생성된 예약 ID를 반환합니다.
     * @param reservationVO DB 저장을 위한 VO 객체
     * @return 새로 생성된 예약의 고유 ID (Long)
     */
    Long saveReservation(GuestReservationVO reservationVO);
}