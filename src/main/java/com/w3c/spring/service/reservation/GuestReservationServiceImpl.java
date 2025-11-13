package com.w3c.spring.service.reservation;

import com.w3c.spring.model.mapper.GuestReservationMapper;
import com.w3c.spring.model.vo.Member;
import com.w3c.spring.model.vo.ReservationRequestVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@Service
public class GuestReservationServiceImpl implements GuestReservationService {

    @Autowired
    private GuestReservationMapper guestMapper;

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int registerGuestReservation(Map<String, String> formData) throws Exception {

        System.out.println("=== 비회원 예약 시작 ===");

        // 1. RRN과 전화번호 추출
        String birthDate = formData.get("birthDate");
        String birthSuffix = formData.get("birthSuffix");

        if (birthDate == null || birthSuffix == null) {
            throw new Exception("주민등록번호가 올바르지 않습니다.");
        }

        String rrn = birthDate + "-" + birthSuffix;
        String phone = formData.get("phone");

        System.out.println("RRN: " + rrn);
        System.out.println("Phone: " + phone);

        // 2. RRN으로 기존 회원 조회
        Member memberByRrn = guestMapper.findMemberByRrn(rrn);
        int memberNo;

        if (memberByRrn != null) {
            System.out.println("기존 회원 발견: " + memberByRrn.getMemberNo());

            // 전화번호 변경 확인
            if (!memberByRrn.getMemberPhone().equals(phone)) {
                Member memberByPhone = guestMapper.findMemberByPhone(phone);
                if (memberByPhone != null) {
                    throw new Exception("이미 사용 중인 전화번호입니다.");
                }
            }
            memberNo = memberByRrn.getMemberNo();

        } else {
            System.out.println("신규 회원 등록 시작");

            // 전화번호 중복 확인
            Member memberByPhone = guestMapper.findMemberByPhone(phone);
            if (memberByPhone != null) {
                throw new Exception("이미 해당 전화번호로 등록된 사용자가 있습니다.");
            }

            // 신규 회원 정보 생성
            Member newMember = new Member();
            newMember.setMemberName(formData.get("name"));
            newMember.setMemberRrn(rrn);
            newMember.setMemberPhone(phone);
            newMember.setMemberAddress(formData.get("address"));
            newMember.setMemberEmail(formData.get("email"));
            newMember.setMemberBloodType(formData.get("bloodType"));

            String chronicDisease = formData.get("chronicDisease");
            String allergy = formData.get("allergy");

            newMember.setMemberChronicDisease(
                    (chronicDisease == null || chronicDisease.trim().isEmpty()) ? null : chronicDisease
            );
            newMember.setMemberAllergy(
                    (allergy == null || allergy.trim().isEmpty()) ? null : allergy
            );

            newMember.setMemberGender(getGenderFromRrnSuffix(birthSuffix));
            newMember.setMemberStatus("T");

            // 회원 삽입
            int insertMemberResult = guestMapper.insertGuestMember(newMember);
            System.out.println("회원 삽입 결과: " + insertMemberResult);

            if (insertMemberResult <= 0) {
                throw new Exception("회원 등록에 실패했습니다.");
            }

            memberNo = newMember.getMemberNo();
            System.out.println("생성된 회원 번호: " + memberNo);

            // 등급 삽입
            guestMapper.insertGuestGrade(memberNo);
            System.out.println("등급 삽입 완료");
        }

        // 5. 진료과 번호 조회
        String departmentName = formData.get("departmentName");
        System.out.println("진료과: " + departmentName);

        Integer departmentNo = guestMapper.findDepartmentNoByName(departmentName);

        if (departmentNo == null || departmentNo == 0) {
            throw new Exception("선택한 진료과를 찾을 수 없습니다: " + departmentName);
        }
        System.out.println("진료과 번호: " + departmentNo);

        // 6. 예약 정보 생성
        ReservationRequestVO reservation = new ReservationRequestVO();
        reservation.setMemberNo(memberNo);
        reservation.setDepartmentNo(departmentNo);
        reservation.setReservationNotes(formData.get("reservationNotes"));

        String treatmentDate = formData.get("treatmentDate");
        String treatmentTime = formData.get("treatmentTime");

        if (treatmentDate == null || treatmentDate.isEmpty() ||
                treatmentTime == null || treatmentTime.isEmpty()) {
            throw new Exception("날짜와 시간은 필수입니다.");
        }

        reservation.setTreatmentDate(treatmentDate + " " + treatmentTime);
        System.out.println("진료 날짜/시간: " + reservation.getTreatmentDate());

        // 7. 예약 삽입
        int reservationResult = guestMapper.insertGuestReservation(reservation);
        System.out.println("예약 삽입 결과: " + reservationResult);

        if (reservationResult <= 0) {
            throw new Exception("예약 등록에 실패했습니다.");
        }

        System.out.println("=== 비회원 예약 완료 ===");
        return reservationResult;
    }

    private String getGenderFromRrnSuffix(String suffix) {
        if (suffix == null || suffix.length() < 1) {
            return "M";
        }
        char firstChar = suffix.charAt(0);

        if (firstChar == '1' || firstChar == '3') {
            return "M";
        }
        if (firstChar == '2' || firstChar == '4') {
            return "F";
        }

        return "M";
    }
}