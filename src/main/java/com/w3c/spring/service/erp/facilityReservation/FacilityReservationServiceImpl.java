package com.w3c.spring.service.erp.facilityReservation;

import com.w3c.spring.model.mapper.erp.facilityReservation.FacilityReservationMapper;
import com.w3c.spring.model.vo.erp.facilityReservation.FacilityReservation;
import com.w3c.spring.model.vo.erp.facilityReservation.Facility;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class FacilityReservationServiceImpl implements FacilityReservationService {

    private static final int MAX_RESERVATIONS_PER_DAY = 8;

    private final FacilityReservationMapper facilityReservationMapper;

    /**
     * 모든 예약 조회
     */
    @Override
    public List<FacilityReservation> getAllReservations() {
        List<FacilityReservation> list = facilityReservationMapper.selectAllReservations();
        log.debug("예약 목록 조회 완료: {} 건", list.size());
        return list;
    }

    /**
     * 특정 날짜의 예약 조회
     */
    @Override
    public List<FacilityReservation> getReservationsByDate(String date) {
        log.debug("날짜별 예약 조회: {}", date);
        return facilityReservationMapper.selectReservationsByDate(date);
    }

    /**
     * 특정 날짜와 시설의 예약 조회
     */
    @Override
    public List<FacilityReservation> getReservationsByDateAndFacility(String date, int facilityNo) {
        log.debug("날짜별 시설별 예약 조회: {} / 시설번호: {}", date, facilityNo);
        return facilityReservationMapper.selectReservationsByDateAndFacility(date, facilityNo);
    }

    /**
     * 특정 날짜와 시설의 총 예약 개수 조회
     */

    public int getReservationCountByDate(String date, int facilityNo) {
        int count = facilityReservationMapper.selectReservationCountByDate(date, facilityNo);
        log.debug("총 예약 개수 조회: {} / 시설번호: {} / 예약 수: {}", date, facilityNo, count);
        return count;
    }

    /**
     * 예약 추가 (비즈니스 로직 포함)
     *
     * @return
     */
    @Override
    @Transactional
    public int insertReservation(FacilityReservation reservation) {
        // 예약 가능 여부 검증
        String date = reservation.getTreatmentDate().substring(0, 10);
        int currentCount = getReservationCountByDate(date, reservation.getFacilityNo());

        if (currentCount >= MAX_RESERVATIONS_PER_DAY) {
            throw new IllegalStateException(
                    String.format("해당 날짜는 예약이 마감되었습니다. (최대 %d개)", MAX_RESERVATIONS_PER_DAY)
            );
        }

        log.info("예약 등록 시도: 시설번호={}, 환자번호={}, 날짜={}",
                reservation.getFacilityNo(),
                reservation.getMemberNo(),
                reservation.getTreatmentDate());

        int result = facilityReservationMapper.insertReservation(reservation);

        if (result <= 0) {
            throw new RuntimeException("예약 등록에 실패했습니다.");
        }

        log.info("예약 등록 성공: 예약번호={}", reservation.getFacilityReservationNo());
        return currentCount;
    }

    /**
     * 특정 날짜와 시설의 모든 예약 삭제
     */
    @Override
    @Transactional
    public int deleteReservationsByDateAndFacility(String date, int facilityNo) {
        log.info("예약 삭제 시도: {} / 시설번호: {}", date, facilityNo);

        int result = facilityReservationMapper.deleteReservationsByDateAndFacility(date, facilityNo);

        if (result > 0) {
            log.info("예약 삭제 성공: {} 건", result);
        } else {
            log.warn("삭제할 예약이 없습니다.");
        }

        return result;
    }

    /**
     * 모든 시설 조회
     */
    @Override
    public List<Facility> getAllFacilities() {
        List<Facility> facilities = facilityReservationMapper.selectAllFacilities();
        log.debug("시설 목록 조회 완료: {} 건", facilities.size());
        return facilities;
    }
}