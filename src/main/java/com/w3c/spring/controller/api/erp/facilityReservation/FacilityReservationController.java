package com.w3c.spring.controller.api.erp.facilityReservation;

import com.w3c.spring.model.vo.erp.facilityReservation.FacilityInfo;
import com.w3c.spring.model.vo.erp.facilityReservation.FacilityReservation;
import com.w3c.spring.service.erp.facilityReservation.FacilityReservationService;
import com.w3c.spring.service.member.MemberService;
import com.w3c.spring.model.vo.Member;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/facilityReservation")
public class FacilityReservationController {

    private static final Logger log = LoggerFactory.getLogger(FacilityReservationController.class);

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
    public ResponseEntity<Map<String, Object>> getReservationList() {
        Map<String, Object> result = new HashMap<>();
        try {
            List<FacilityReservation> reservations = reservationService.getAllReservations();
            result.put("success", true);
            result.put("reservations", reservations);
            log.debug("예약 목록 조회 성공: {} 건", reservations.size());
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            log.error("예약 목록 조회 실패", e);
            result.put("success", false);
            result.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
    }

    /**
     * 시설 목록 조회
     */
    @GetMapping("/facilities")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getFacilities() {
        Map<String, Object> result = new HashMap<>();
        try {
            List<FacilityInfo> facilities = reservationService.selectAllFacilities();
            result.put("success", true);
            result.put("facilities", facilities);
            log.debug("시설 목록 조회 성공: {} 건", facilities.size());
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
            log.error("시설 목록 조회 실패", e);
            return ResponseEntity.ok(result);
        }
    }

    /**
     * 특정 날짜의 예약 조회
     */
    @GetMapping("/date")
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
            log.error("날짜별 예약 조회 실패: {}", date, e);
            result.put("success", false);
            result.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
    }

    /**
     * 환자 목록 조회 (STAFF_NO IS NULL인 일반 환자만)
     */
    @GetMapping("/patients")
    public ResponseEntity<Map<String, Object>> getPatientList() {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Member> patients = memberService.getPatientList();
            result.put("success", true);
            result.put("patients", patients);
            log.debug("환자 목록 조회 성공: {} 명", patients.size());
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            log.error("환자 목록 조회 실패", e);
            result.put("success", false);
            result.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
    }

    /**
     * 예약 추가
     */
    @PostMapping("/insert")
    public ResponseEntity<Map<String, Object>> insertReservation(
            @RequestBody FacilityReservation reservation) {
        Map<String, Object> result = new HashMap<>();
        try {
            reservationService.insertReservation(reservation);
            result.put("success", true);
            result.put("message", "예약이 등록되었습니다.");

            String date = reservation.getTreatmentDate().substring(0, 10);
            log.info("예약 등록 성공: {} / 시설번호: {} / 환자번호: {}",
                    date, reservation.getFacilityNo(), reservation.getMemberNo());
            return ResponseEntity.ok(result);
        } catch (IllegalStateException e) {
            // 비즈니스 로직 예외 (예약 마감 등)
            log.warn("예약 등록 실패: {}", e.getMessage());
            result.put("success", false);
            result.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(result);
        } catch (Exception e) {
            log.error("예약 등록 중 오류 발생", e);
            result.put("success", false);
            result.put("message", "예약 등록 중 오류가 발생했습니다.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
    }

    /**
     * 특정 날짜의 모든 예약 삭제
     */
    @DeleteMapping("/deleteByDate")
    public ResponseEntity<Map<String, Object>> deleteReservationsByDate(
            @RequestBody Map<String, Object> params) {
        Map<String, Object> result = new HashMap<>();
        try {
            String date = (String) params.get("date");
            Object facilityNoObj = params.get("facilityNo");
            Integer facilityNo = null;
            if (facilityNoObj != null) {
                facilityNo = Integer.parseInt(String.valueOf(facilityNoObj));
            }

            if (date == null || facilityNo == null) {
                result.put("success", false);
                result.put("message", "날짜와 시설번호는 필수입니다.");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(result);
            }

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
            log.error("예약 삭제 중 오류 발생", e);
            result.put("success", false);
            result.put("message", "예약 삭제 중 오류가 발생했습니다.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
    }



}