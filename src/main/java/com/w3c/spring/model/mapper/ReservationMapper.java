package com.w3c.spring.model.mapper;

import com.w3c.spring.model.vo.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface ReservationMapper {

    // ... (기존 메소드 생략) ...

    /**
     * [getDepartments]
     * 의사가 1명이라도 있는 모든 진료과 목록 (아이콘 URL 포함)
     */
    List<DepartmentVO> findDepartmentsWithDoctors();

    /**
     * [submitReservation]
     * 예약을 DB에 INSERT
     */
    int insertReservation(ReservationRequestVO data);

    /**
     * [MyChart]
     * 나의 차트 페이지에 보여줄 예약 목록 조회
     */
    List<ReservationDetailVO> selectReservationsByMemberNo(int memberNo);

    /**
     * [Cancel]
     * 예약 상태를 변경합니다. (예: '취소')
     */
    int updateReservationStatus(@Param("reservationNo") int reservationNo,
                                @Param("memberNo") int memberNo,
                                @Param("status") String status);

    // ▼▼▼▼▼ [수정] Map을 받도록 시그니처 변경 ▼▼▼▼▼
    /**
     * [Update Form]
     * 예약 변경 페이지에 필요한 기존 예약 정보 조회
     * (ServiceImpl에서 Map으로 변환하여 전달함)
     */
    ReservationUpdateVO selectReservationForUpdate(Map<String, Integer> params);
    // ▲▲▲▲▲ [수정] ▲▲▲▲▲

    /**
     * [Update Submit]
     * 예약 정보를 DB에 수정(UPDATE)
     */
    int updateReservation(ReservationRequestVO reservationData);

    // --- (오류 방지를 위해 추가된 기존 메소드들) ---
    List<AbsenceVO> findApprovedAbsences();
    List<WorkingDoctorVO> findWorkingDoctorsByDeptOnDate(Map<String, Object> params);
    List<Map<String, Object>> findBookedTimeCountsByDeptOnDate(Map<String, Object> params);

    List<ReservationDetailVO> selectReservationDetailByDate(@Param("selectedDate") String selectedDate);
    int updateRvtnStatus(Map<String, Object> params);
    ReservationDetailVO selectRvtnDetail(@Param("reservationNo") int reservationNo);
    List<ReservationDetailVO> selectDoctorByDepartmentName(@Param("departmentName") String departmentName );

    int findDepartmentNo(@Param("departmentName") String departmentName);
    int findMemberNo(@Param("memberName") String memberName);
    int insertErpReservation(Map<String, Object> params);
}