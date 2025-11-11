package com.w3c.spring.controller.api.hompage.reservation;

import com.w3c.spring.model.vo.*;
import com.w3c.spring.service.reservation.ReservationService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus; // [추가]
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/member/reservation")
public class ReservationController {

    private final ReservationService reservationService;

    @Autowired
    public ReservationController(ReservationService reservationService) {
        this.reservationService = reservationService;
    }

    @GetMapping("/main")
    public String showReservationMain() {
        return "homePage/member/appointmentPage";
    }

    // [수정] '변경' 기능이 이 메소드에서 분리되어, 신규 예약 전용 페이지가 됨
    @GetMapping("/detail")
    public String showReservationDetail(HttpSession session, HttpServletRequest request, RedirectAttributes redirectAttributes, Model model) { // Model 추가

        Object loginMember = session.getAttribute("loginMember");

        if (loginMember == null) {
            String originalURL = request.getRequestURI();
            redirectAttributes.addAttribute("redirectURL", originalURL);
            return "redirect:/member/loginPage";
        }

        // [수정] 신규 예약이므로 빈 객체와 신규 제목 전달
        model.addAttribute("reservationData", null);
        model.addAttribute("pageTitle", "진료 예약");

        return "homePage/member/detailReservation";
    }

    @GetMapping("/available-dates")
    @ResponseBody
    public List<FullCalendarEventVO> getAvailableDates() {
        return reservationService.getReservationSchedule();
    }

    @GetMapping("/available-times")
    @ResponseBody
    public List<TimeSlotVO> getAvailableTimes(
            @RequestParam("date") String date,
            @RequestParam("departmentId") int departmentId) {
        return reservationService.getAvailableTimes(date, departmentId);
    }

    @GetMapping("/departments")
    @ResponseBody
    public List<DepartmentVO> getDepartments() {
        return reservationService.getDepartments();
    }

    // [유지] '신규'와 '변경' 저장 시 이 API를 공통으로 사용
    @PostMapping("/submit")
    @ResponseBody
    public ResponseEntity<?> submitReservation(
            @RequestBody ReservationRequestVO reservationData,
            @RequestParam(value = "reservationNo", required = false) Integer reservationNo,
            HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            return ResponseEntity.status(401)
                    .body(Map.of("success", false, "message", "로그인이 필요합니다."));
        }

        try {
            boolean success;
            String message;

            if (reservationNo == null) {
                // 1. 신규 등록
                success = reservationService.submitReservation(reservationData, loginMember.getMemberNo());
                message = success ? "예약이 성공적으로 완료되었습니다." : "예약 등록에 실패했습니다.";
            } else {
                // 2. 수정 (reservationData에 reservationNo가 세팅되어 있어야 함)
                success = reservationService.updateReservation(reservationData, reservationNo, loginMember.getMemberNo());
                message = success ? "예약이 성공적으로 변경되었습니다." : "예약 변경에 실패했습니다.";
            }

            if (success) {
                return ResponseEntity.ok(Map.of("success", true, "message", message));
            } else {
                return ResponseEntity.status(500).body(Map.of("success", false, "message", message));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(Map.of("success", false, "message", "서버 오류: " + e.getMessage()));
        }
    }

    // ▼▼▼▼▼ [신규 추가] '변경' 모달에 데이터를 채우기 위한 API ▼▼▼▼▼
    @GetMapping("/detail-json/{reservationNo}")
    @ResponseBody
    public ResponseEntity<?> getReservationDetailForEdit(
            @PathVariable("reservationNo") int reservationNo,
            HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        try {
            ReservationUpdateVO data = reservationService.getReservationForUpdate(reservationNo, loginMember.getMemberNo());
            if (data == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("예약 정보를 찾을 수 없거나 권한이 없습니다.");
            }
            // (참고) doctorName에 '담당의: ' 접두사가 있다면 Service/Mapper에서 제거하는 것이 좋습니다.
            // 여기서는 JS에서 처리하도록 그대로 반환합니다.
            return ResponseEntity.ok(data);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("데이터 조회 중 오류 발생");
        }
    }
    // ▲▲▲▲▲ [신규 추가] ▲▲▲▲▲


    // --- (기존 /guest, /guestCheck, /systemReservation 메소드 유지) ---
    @GetMapping("/guest")
    public String showGuestReservation() {
        return "homePage/member/guestPatientReservation";
    }

    @GetMapping("/guestCheck")
    public String showGuestCheck() {
        return "homePage/member/guestReservationCheck";
    }

    @GetMapping("/systemReservation")
    public String ShowSystemReservation() {
        return "homePage/systemReservation/systemReservation";
    }
}