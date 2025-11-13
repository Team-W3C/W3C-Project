package com.w3c.spring.service.reservation;

import java.util.List;
import java.util.Map;

public interface GuestReservationService {

    /**
     * 비회원 예약 등록
     */
    int registerGuestReservation(Map<String, String> formData) throws Exception;

    /**
     * 비회원 예약 조회
     */
    List<Map<String, Object>> findGuestReservationsByNameAndPhone(String name, String phone);
}