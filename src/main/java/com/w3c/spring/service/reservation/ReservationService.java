package com.w3c.spring.service.reservation;

import com.w3c.spring.model.vo.*;
import com.w3c.spring.model.vo.ReservationDetailVO;

import java.util.List;

public interface ReservationService {

    List<FullCalendarEventVO> getReservationSchedule();

    List<TimeSlotVO> getAvailableTimes(String date, int departmentId);

    List<DepartmentVO> getDepartments();

    boolean submitReservation(ReservationRequestVO reservationData, int memberNo);

    List<ReservationDetailVO> getReservationsByMemberNo(int memberNo);

    boolean cancelReservation(int reservationNo, int memberNo);

    ReservationUpdateVO getReservationForUpdate(int reservationNo, int memberNo);

    boolean updateReservation(ReservationRequestVO reservationData, int reservationNo, int memberNo);
}