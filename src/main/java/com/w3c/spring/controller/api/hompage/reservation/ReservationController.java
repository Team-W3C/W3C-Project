package com.w3c.spring.controller.api.hompage.reservation;

// (필요한 임포트 목록)
import com.w3c.spring.model.vo.FullCalendarEventVO;
import com.w3c.spring.model.vo.TimeSlotVO;
import com.w3c.spring.service.reservation.ReservationService; // (Service 임포트 확인)
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/member/reservation") // (1) 클래스 전체에 공통 URL 적용
public class ReservationController {

    // (2) Service 주입 (생성자 주입 방식 권장)
    private final ReservationService reservationService;

    @Autowired
    public ReservationController(ReservationService reservationService) {
        this.reservationService = reservationService;
    }

    /**
     * 예약 메인 페이지
     * (URL: /member/reservation/main)
     */
    @GetMapping("/main")
    public String showReservationMain() {
        return "homePage/member/appointmentPage";
    }

    /**
     * 예약 상세 페이지 (로그인 체크)
     * (URL: /member/reservation/detail)
     */
    @GetMapping("/detail")
    public String showReservationDetail(HttpSession session, HttpServletRequest request, RedirectAttributes redirectAttributes) {

        Object loginMember = session.getAttribute("loginMember");

        if (loginMember != null) {
            // (로그인 O) -> 예약 상세 JSP (FullCalendar 있는 곳)
            return "homePage/member/detailReservation";

        } else {
            // (로그인 X) -> 로그인 페이지로 리다이렉트
            String originalURL = request.getRequestURI();
            String queryString = request.getQueryString();
            if (queryString != null) {
                originalURL += "?" + queryString;
            }

            redirectAttributes.addAttribute("redirectURL", originalURL);
            return "redirect:/api/member/loginPage"; // (LoginController가 받을 주소)
        }
    }

    /**
     * [AJAX] FullCalendar가 호출할 스케줄(예약 가능/휴무일) 데이터
     * (URL: /member/reservation/available-dates)
     */
    @GetMapping("/available-dates")
    @ResponseBody // (3) JSON 데이터 반환을 위해 @ResponseBody 추가
    public List<FullCalendarEventVO> getAvailableDates() {

        // Service를 호출하여 스케줄 데이터를 가져옵니다.
        List<FullCalendarEventVO> scheduleList = reservationService.getReservationSchedule();

        return scheduleList;
    }


        @GetMapping("/available-times")
        @ResponseBody
        public List<TimeSlotVO> getAvailableTimes(
                @RequestParam("date") String date,
                @RequestParam("departmentId") int departmentId) {

            return reservationService.getAvailableTimes(date, departmentId);

    }
    /**
     * 비회원 환자 예약 페이지
     * (URL: /member/reservation/guest)
     */
    @GetMapping("/guest")
    public String showGuestReservation() {
        return "homePage/member/guestPatientReservation";
    }

    /**
     * 비회원 예약 확인 페이지
     * (URL: /member/reservation/guestCheck)
     */
    @GetMapping("/guestCheck")
    public String showGuestCheck() {
        return "homePage/member/guestReservationCheck";
    }

    /**
     * 시스템 예약 페이지
     * (URL: /member/reservation/systemReservation)
     */
    @GetMapping("/systemReservation")
    public String ShowSystemReservation() {
        return "homePage/systemReservation/systemReservation";
    }
}