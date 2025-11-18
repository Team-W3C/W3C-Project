package com.w3c.spring.service.erp.facilityReservation;

import com.w3c.spring.model.mapper.erp.facilityReservation.FacilityReservationMapper;
import com.w3c.spring.model.vo.erp.facilityReservation.FacilityReservation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class FacilityReservationServiceImpl implements FacilityReservationService {

    private final FacilityReservationMapper facilityReservationMapper;

    @Override
    public List<FacilityReservation> getAllReservations() {
        List<FacilityReservation> list = facilityReservationMapper.selectAllReservations();

        if (list.isEmpty()) {
            log.debug("예약 목록이 비어있습니다.");
        } else {
            log.debug("예약 목록 조회 성공: {} 건", list.size());
        }

        return list;
    }

    @Override
    public List<FacilityReservation> getReservationsByDate(String date) {
        log.debug("날짜별 예약 조회: {}", date);
        return facilityReservationMapper.selectReservationsByDate(date);
    }

    @Override
    public List<FacilityReservation> getReservationsByDateAndFacility(String date, int facilityNo) {
        log.debug("날짜별 시설별 예약 조회: {} / 시설번호: {}", date, facilityNo);
        return facilityReservationMapper.selectReservationsByDateAndFacility(date, facilityNo);
    }

    @Override
    public int getUniquePatientCountByDate(String date, int facilityNo) {
        int count = facilityReservationMapper.selectUniquePatientCountByDate(date, facilityNo);
        log.debug("고유 환자 수 조회: {} / 시설번호: {} / 환자 수: {}", date, facilityNo, count);
        return count;
    }

    @Override
    public int getReservationCountByDate(String date, int facilityNo) {
        int count = facilityReservationMapper.selectReservationCountByDate(date, facilityNo);
        log.debug("총 예약 개수 조회: {} / 시설번호: {} / 예약 수: {}", date, facilityNo, count);
        return count;
    }

    @Override
    @Transactional
    public int insertReservation(FacilityReservation reservation) {
        log.info("예약 등록 시도: 시설번호={}, 환자번호={}, 날짜={}",
                reservation.getFacilityNo(),
                reservation.getMemberNo(),
                reservation.getTreatmentDate());

        int result = facilityReservationMapper.insertReservation(reservation);

        if (result > 0) {
            log.info("예약 등록 성공: 예약번호={}", reservation.getFacilityReservationNo());
        } else {
            log.warn("예약 등록 실패");
        }

        return result;
    }

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
}