package com.w3c.spring.service.reservation;

import com.w3c.spring.model.vo.*;
import com.w3c.spring.model.vo.ReservationDetailVO;

import java.util.List;
import java.util.Map;

public interface ReservationService {

    List<FullCalendarEventVO> getReservationSchedule();

    List<TimeSlotVO> getAvailableTimes(String date, int departmentId);

    List<DepartmentVO> getDepartments();

    boolean submitReservation(ReservationRequestVO reservationData, int memberNo);

    List<ReservationDetailVO> getReservationsByMemberNo(int memberNo);

    boolean cancelReservation(int reservationNo, int memberNo);

    ReservationUpdateVO getReservationForUpdate(int reservationNo, int memberNo);

    boolean updateReservation(ReservationRequestVO reservationData, int reservationNo, int memberNo);

    Map<String, List<ReservationDetailVO>> selectReservationDetailByDate(String selectedDate);
    ReservationDetailVO selectRvtnDetail(int reservationNo);
    int updateRvtnStatus(String status, int reservationNo);
    List<ReservationDetailVO> selectDoctorByDepartmentName(String departmentName);
    int insertErpReservation(Map<String,Object> params);
}