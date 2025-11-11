package com.w3c.spring.service.reservation;

import com.w3c.spring.model.mapper.ReservationMapper;
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

            // --- FullCalendar 'end' 날짜 계산 ---
            // FullCalendar는 종료일을 '다음 날'로 설정해야 해당 날짜까지 포함합니다.
            Date endDate = schedule.getScheduleEndTime();
            Calendar c = Calendar.getInstance();
            c.setTime(endDate);
            // (수정) 날짜가 아닌 시간 기반일 수 있으므로, 12시간을 더해 날짜가 밀리지 않게 보정
            // (만약 '근무 중'이 11-13 09:00 ~ 11-13 18:00 이라면, end는 11-14가 되어야 함)
            c.add(Calendar.HOUR, 12); // 종료 당일 포함을 위해 시간 보정
            c.add(Calendar.DATE, 1); // FullCalendar는 end 날짜를 미포함하므로 +1일
            String exclusiveEndDate = sdfDate.format(c.getTime());
            // --- 계산 끝 ---

            if ("휴가 중".equals(schedule.getStatus())) {
                eventList.add(new FullCalendarEventVO(
                        "휴무",           // title
                        startDate,        // start
                        exclusiveEndDate, // end
                        "background",     // display
                        "unavailable-date"// className
                ));

            } else if ("근무 중".equals(schedule.getStatus())) {
                eventList.add(new FullCalendarEventVO(
                        "예약가능",       // title
                        startDate,        // start
                        exclusiveEndDate, // end
                        "background",     // display
                        "available-date"  // className
                ));
            }
        }
        return eventList;
    }

    @Override
    public List<TimeSlotVO> getAvailableTimes(String date, int departmentId) {

        // MyBatis에 파라미터를 2개 이상 넘기기 위해 Map 사용
        Map<String, Object> params = new HashMap<>();
        params.put("date", date);
        params.put("departmentId", departmentId);

        // (Mapper 호출)
        return reservationMapper.findAvailableTimes(params);
    }
}