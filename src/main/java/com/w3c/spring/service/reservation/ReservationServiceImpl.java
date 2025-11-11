package com.w3c.spring.service.reservation;

import com.w3c.spring.model.mapper.ReservationMapper;
import com.w3c.spring.model.vo.DepartmentVO;
import com.w3c.spring.model.vo.FullCalendarEventVO;
import com.w3c.spring.model.vo.ScheduleVO;
import com.w3c.spring.model.vo.TimeSlotVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class ReservationServiceImpl implements ReservationService {

    private final ReservationMapper reservationMapper;

    @Autowired
    public ReservationServiceImpl(ReservationMapper reservationMapper) {
        this.reservationMapper = reservationMapper;
    }

    @Override
    public List<FullCalendarEventVO> getReservationSchedule() {

        List<ScheduleVO> scheduleFromDB = reservationMapper.selectScheduleAfterToday();
        List<FullCalendarEventVO> eventList = new ArrayList<>();

        SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");

        for (ScheduleVO schedule : scheduleFromDB) {

            String startDate = sdfDate.format(schedule.getScheduleStartTime());

            Date endDate = schedule.getScheduleEndTime();
            Calendar c = Calendar.getInstance();
            c.setTime(endDate);
            c.add(Calendar.HOUR, 12);
            c.add(Calendar.DATE, 1);
            String exclusiveEndDate = sdfDate.format(c.getTime());

            // "휴가 중"인 데이터만 '예약 불가능(빨간색)'으로 캘린더에 보냅니다.
            if ("휴가 중".equals(schedule.getStatus())) {
                eventList.add(new FullCalendarEventVO(
                        "휴무",           // title
                        startDate,        // start
                        exclusiveEndDate, // end
                        "background",     // display
                        "unavailable-date"// className
                ));
            }
        }
        return eventList;
    }

    @Override
    public List<TimeSlotVO> getAvailableTimes(String date, int departmentId) {
        // 이 로직은 "하얀 날"을 클릭했을 때 실제 근무자를 찾는 로직이므로 수정 X
        Map<String, Object> params = new HashMap<>();
        params.put("date", date);
        params.put("departmentId", departmentId);
        return reservationMapper.findAvailableTimes(params);
    }

    @Override
    public List<DepartmentVO> getDepartments() {
        // [수정] "근무 중" 여부와 상관없이, 의사가 있는 모든 진료과를 가져옵니다.
        return reservationMapper.findAllDepartmentsWithDoctors(); // (Mapper 메소드명 변경)
    }
}