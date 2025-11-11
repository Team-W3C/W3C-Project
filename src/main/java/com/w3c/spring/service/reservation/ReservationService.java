package com.w3c.spring.service.reservation;

import com.w3c.spring.model.vo.DepartmentVO;
import com.w3c.spring.model.vo.FullCalendarEventVO;
import com.w3c.spring.model.vo.TimeSlotVO; // (임포트)
import java.util.List;

public interface ReservationService {

    List<FullCalendarEventVO> getReservationSchedule();
    List<TimeSlotVO> getAvailableTimes(String date, int departmentId);
    List<DepartmentVO> getDepartments();
}