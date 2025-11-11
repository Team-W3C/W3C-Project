package com.w3c.spring.controller.api.hompage.reservation;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/member/reservation")
public class ReservationController {

    /**
     * 예약 메인 페이지
     * URL: /member/reservation/main
     */
    @GetMapping("/main")
    public String showReservationMain() {
        return "homePage/member/appointmentPage";
    }

    // --- (1) 첫 번째 파일의 '/detail' (로그인 체크 O) ---
    @GetMapping("/detail")
    public String showReservationDetail(HttpSession session, HttpServletRequest request, RedirectAttributes redirectAttributes) {

        Object loginMember = session.getAttribute("loginMember");

        if (loginMember != null) {
            return "homePage/member/detailReservation";

        } else {
            // (로그인 X) 로그인 페이지로 리다이렉트
            String originalURL = request.getRequestURI();
            String queryString = request.getQueryString();
            if (queryString != null) {
                originalURL += "?" + queryString;
            }

            redirectAttributes.addAttribute("redirectURL", originalURL);

            // ※ 주의: 리다이렉트 경로는 /api/member/loginPage 가 맞는지 확인 필요
            return "redirect:/api/member/loginPage";
        }
    }

    /**
     * 비회원 환자 예약 페이지
     * URL: /member/reservation/guest
     */
    @GetMapping("/guest")
    public String showGuestReservation() {
        return "homePage/member/guestPatientReservation";
    }

    /**
     * 비회원 예약 확인 페이지
     * URL: /member/reservation/guestCheck
     */
    @GetMapping("/guestCheck")
    public String showGuestCheck() {
        return "homePage/member/guestReservationCheck";
    }

    /**
     * 시스템 예약 페이지
     * URL: /member/reservation/systemReservation
     */
    @GetMapping("/systemReservation")
    public String ShowSystemReservation() {
        return "homePage/systemReservation/systemReservation";
    }
}