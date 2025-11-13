package com.w3c.spring.controller.api.hompage.reservation;

import com.w3c.spring.service.reservation.GuestReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model; // Model 추가
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;

@Controller
@RequestMapping("/guest/reservation")
public class GuestReservationController {

    @Autowired
    private GuestReservationService guestReservationService;

    /**
     * 비회원 예약 등록 요청을 처리합니다.
     * - 성공 시: 기존처럼 'redirect'
     * - 실패 시: 'error/errorModal'로 'forward'
     */
    @PostMapping("/new")
    public String registerGuestReservation(
            @RequestParam Map<String, String> formData,
            RedirectAttributes ra,
            Model model) { // <-- 1. Model 파라미터 추가

        try {
            // 서비스 호출
            int result = guestReservationService.registerGuestReservation(formData);

            if (result > 0) {
                // === 성공 로직 ===
                ra.addFlashAttribute("message", "비회원 예약이 성공적으로 완료되었습니다.");
                // 성공 시 예약 메인 페이지로 리다이렉트
                return "redirect:/member/reservation/main";
            } else {
                // 서비스에서 0을 반환한 경우 (일반적으론 예외가 발생함)
                throw new Exception("예약이 정상적으로 등록되지 않았습니다.");
            }

        } catch (Exception e) {
            // === 실패 로직 (JSP 모달 띄우기) ===
            e.printStackTrace();

            // 1. Model에 JSP가 필요로 하는 3가지 값 저장
            model.addAttribute("modalTitle", "예약 실패");
            model.addAttribute("modalMessage", "예약 처리 중 오류가 발생했습니다: " + e.getMessage());

            // 2. '확인' 버튼 클릭 시 돌아갈 URL (컨텍스트 패스 불필요, JSP가 처리)
            model.addAttribute("redirectUrl", "/member/reservation/main");

            // 3. 에러 모달 페이지로 포워드
            return "homePage/errorModal";
        }
    }
}