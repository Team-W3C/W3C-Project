package com.w3c.spring.controller.api.hompage.reservation;

import com.w3c.spring.model.vo.GuestReservationRequest;
import com.w3c.spring.model.vo.GuestReservationVO;
import com.w3c.spring.service.reservation.GuestReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/guest")
public class GuestReservationController {

    private final GuestReservationService reservationService;

    @Autowired
    public GuestReservationController(GuestReservationService reservationService) {
        this.reservationService = reservationService;
    }

    @PostMapping("/reserve")
    public ResponseEntity<?> reserveGuest(@RequestBody GuestReservationRequest request) {
        try {
            GuestReservationVO vo = convertToVO(request);
            Long reservationNo = reservationService.saveReservation(vo);

            Map<String, Object> response = new HashMap<>();
            response.put("reservationNo", reservationNo);
            response.put("message", "비회원 예약이 성공적으로 처리되었습니다.");

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("예약 처리 중 서버 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * DTO의 분리된 날짜/시간 및 진료과 이름을 VO로 변환합니다.
     */
    private GuestReservationVO convertToVO(GuestReservationRequest request) {
        GuestReservationVO vo = new GuestReservationVO();

        // 1. 개인 정보
        vo.setName(request.getName());
        String ssnCombined = request.getBirthDate() + request.getBirthSuffix();
        vo.setSsn(ssnCombined);
        vo.setPhone(request.getPhone());
        vo.setAddress(request.getAddress());
        vo.setEmail(request.getEmail());
        vo.setNotes(request.getNotes());

        // 2. 예약 정보 처리
        vo.setDepartmentName(request.getDepartmentName());

        // 날짜와 시간을 조합하여 DB가 요구하는 포맷(YYYY-MM-DD HH:MI)으로 만듭니다.
        // 이 문자열은 Mapper에서 TO_DATE 함수를 통해 DATE 타입으로 변환됩니다.
        String combinedDateTime = request.getTreatmentDate() + " " + request.getTreatmentTime();
        vo.setTreatmentDateString(combinedDateTime);

        return vo;
    }
}