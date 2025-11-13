package com.w3c.spring.model.mapper; // (패키지 경로는 실제 프로젝트에 맞게 수정하세요)

import com.w3c.spring.model.vo.Member;
import com.w3c.spring.model.vo.ReservationRequestVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List; // [추가]
import java.util.Map; // [추가]

@Mapper
public interface GuestReservationMapper {

    /**
     * 주민등록번호(RRN)로 회원 정보를 조회합니다.
     */
    Member findMemberByRrn(String rrn);

    /**
     * 전화번호(PHONE)로 회원 정보를 조회합니다.
     */
    Member findMemberByPhone(@Param("phone") String phone);

    /**
     * 비회원(환자) 정보를 MEMBER 테이블에 삽입합니다.
     */
    int insertGuestMember(Member member);

    /**
     * 신규 회원의 등급을 '일반'으로 GRADE 테이블에 삽입합니다.
     */
    void insertGuestGrade(int memberNo);

    /**
     * 진료과 이름(String)으로 진료과 번호(NUMBER)를 조회합니다.
     */
    Integer findDepartmentNoByName(String departmentName);

    /**
     * 예약 정보를 RESERVATION 테이블에 삽입합니다.
     */
    int insertGuestReservation(ReservationRequestVO reservation);

    /**
     * 이름과 전화번호로 예약 내역을 조회합니다.
     */
    List<Map<String, Object>> findGuestReservationsMap(
            @Param("name") String name,
            @Param("phone") String phone
    );
}