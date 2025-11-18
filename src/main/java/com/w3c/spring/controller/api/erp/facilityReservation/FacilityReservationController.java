package com.w3c.spring.controller.api.erp.facilityReservation;

import com.w3c.spring.model.vo.erp.facilityReservation.FacilityReservation;
import com.w3c.spring.service.erp.facilityReservation.FacilityReservationService;
import com.w3c.spring.service.member.MemberService;
import com.w3c.spring.model.vo.Member;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/facilityReservation")
public class FacilityReservationController {

    private static final Logger log = LoggerFactory.getLogger(FacilityReservationController.class);
    private static final int MAX_RESERVATIONS_PER_DAY = 8;

    private final FacilityReservationService reservationService;
    private final MemberService memberService;

    @Autowired
    public FacilityReservationController(
            FacilityReservationService reservationService,
            MemberService memberService) {
        this.reservationService = reservationService;
        this.memberService = memberService;
    }

    /**
     * 모든 예약 목록 조회
     */
    @GetMapping("/list")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getReservationList() {
        Map<String, Object> result = new HashMap<>();
        try {
            List<FacilityReservation> reservations = reservationService.getAllReservations();
            result.put("success", true);
            result.put("reservations", reservations);
            log.debug("예약 목록 조회 성공: {} 건", reservations.size());
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
            log.error("예약 목록 조회 실패", e);
            return ResponseEntity.ok(result);
        }
    }

    /**
     * 특정 날짜의 예약 조회
     */
    @GetMapping("/date")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getReservationsByDate(
            @RequestParam("date") String date,
            @RequestParam(value = "facilityNo", required = false) Integer facilityNo) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<FacilityReservation> reservations;
            if (facilityNo != null) {
                reservations = reservationService.getReservationsByDateAndFacility(date, facilityNo);
                log.debug("날짜별 시설별 예약 조회: {} / 시설번호: {}", date, facilityNo);
            } else {
                reservations = reservationService.getReservationsByDate(date);
                log.debug("날짜별 예약 조회: {}", date);
            }
            result.put("success", true);
            result.put("reservations", reservations);
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
            log.error("날짜별 예약 조회 실패: {}", date, e);
            return ResponseEntity.ok(result);
        }
    }

    /**
     * 환자 목록 조회 (STAFF_NO IS NULL인 일반 환자만)
     */
    @GetMapping("/patients")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getPatientList() {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Member> patients = memberService.getPatientList();
            result.put("success", true);
            result.put("patients", patients);
            log.debug("환자 목록 조회 성공: {} 명", patients.size());
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
            log.error("환자 목록 조회 실패", e);
            return ResponseEntity.ok(result);
        }
    }

    /**
     * 예약 추가
     */
    @PostMapping("/insert")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> insertReservation(
            @RequestBody FacilityReservation reservation) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 해당 날짜+시설의 총 예약 개수 확인
            String date = reservation.getTreatmentDate().substring(0, 10);
            int reservationCount = reservationService.getReservationCountByDate(date, reservation.getFacilityNo());

            if (reservationCount >= MAX_RESERVATIONS_PER_DAY) {
                result.put("success", false);
                result.put("message", String.format("해당 날짜는 예약이 마감되었습니다. (최대 %d개)", MAX_RESERVATIONS_PER_DAY));
                log.warn("예약 마감: {} / 시설번호: {} / 현재 예약 수: {}", date, reservation.getFacilityNo(), reservationCount);
                return ResponseEntity.ok(result);
            }

            int insertResult = reservationService.insertReservation(reservation);
            if (insertResult > 0) {
                result.put("success", true);
                result.put("message", "예약이 등록되었습니다.");
                log.info("예약 등록 성공: {} / 시설번호: {} / 환자번호: {}",
                        date, reservation.getFacilityNo(), reservation.getMemberNo());
            } else {
                result.put("success", false);
                result.put("message", "예약 등록에 실패했습니다.");
                log.warn("예약 등록 실패: {}", reservation);
            }
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
            log.error("예약 등록 중 오류 발생", e);
            return ResponseEntity.ok(result);
        }
    }

    /**
     * 특정 날짜의 모든 예약 삭제
     */
    @DeleteMapping("/deleteByDate")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteReservationsByDate(
            @RequestBody Map<String, Object> params) {
        Map<String, Object> result = new HashMap<>();
        try {
            String date = (String) params.get("date");
            Integer facilityNo = (Integer) params.get("facilityNo");

            int deleteResult = reservationService.deleteReservationsByDateAndFacility(date, facilityNo);
            if (deleteResult > 0) {
                result.put("success", true);
                result.put("message", "예약이 삭제되었습니다.");
                result.put("deletedCount", deleteResult);
                log.info("예약 삭제 성공: {} / 시설번호: {} / 삭제 건수: {}", date, facilityNo, deleteResult);
            } else {
                result.put("success", false);
                result.put("message", "삭제할 예약이 없습니다.");
                log.warn("삭제할 예약 없음: {} / 시설번호: {}", date, facilityNo);
            }
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
            log.error("예약 삭제 중 오류 발생", e);
            return ResponseEntity.ok(result);
        }
    }
}