// src/main/java/com/w3c/spring\model\mapper\GuestReservationMapper.java

package com.w3c.spring.model.mapper;

import com.w3c.spring.model.vo.GuestReservationVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GuestReservationMapper {

    /*
     * MEMBER_NO를 사용하여 RESERVATION 테이블에 예약 정보를 삽입합니다.
     * @param memberNo 새로 생성된 비회원의 member_no
     * @param reservationVO 예약 상세 정보 (reservationNo가 주입될 필드가 있어야 함)
     * @return 삽입된 행의 수
     */
    int insertReservationForGuest(Long memberNo, GuestReservationVO reservationVO);
}