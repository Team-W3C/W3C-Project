package com.w3c.spring.controller.member.reservation;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member/reservation") // URL이 /patientReservation 으로 시작하는 요청을 처리
public class ReserVationController {

    /**
     * 예약 메인 페이지
     * URL: /patientReservation/main
     */
    @GetMapping("/main.re")
    public String showReservationMain() {
        // /WEB-INF/views/common/member/appointmentPage.jsp 를 반환
        return "homePage/member/appointmentPage";
    }

    /**
     * 비회원 환자 예약 페이지 (모달용이지만, 페이지로도 접근 가능하게)
     * URL: /patientReservation/guest
     */
    @GetMapping("/guest.re")
    public String showGuestReservation() {
        // /WEB-INF/views/homePage/member/guestPatientReservation.jsp 를 반환
        return "homePage/member/guestPatientReservation";
    }

    /**
     * 비회원 예약 확인 페이지 (모달용이지만, 페이지로도 접근 가능하게)
     * URL: /patientReservation/check
     */
    @GetMapping("/guestCheck.re")
    public String showGuestCheck() {
        // /WEB-INF/views/homPage/member/guestReservationCheck.jsp 를 반환
        return "homePage/member/guestReservationCheck";
    }

    @GetMapping("/detail.re")
    public String ShowReservationDetail(){
        return "homePage/member/detailReservation";
    }
}