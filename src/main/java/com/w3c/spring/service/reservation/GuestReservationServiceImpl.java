package com.w3c.spring.service.reservation;

import com.w3c.spring.model.mapper.DepartmentMapper; // ★★★ DepartmentMapper 추가 필요 ★★★
import com.w3c.spring.model.mapper.GuestReservationMapper;
import com.w3c.spring.model.mapper.MemberMapper;
import com.w3c.spring.model.vo.GuestReservationVO;
import com.w3c.spring.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class GuestReservationServiceImpl implements GuestReservationService {

    private final GuestReservationMapper reservationMapper;
    private final MemberMapper memberMapper;
    private final DepartmentMapper departmentMapper; // ★★★ 추가된 의존성 ★★★

    @Autowired
    public GuestReservationServiceImpl(GuestReservationMapper reservationMapper, MemberMapper memberMapper, DepartmentMapper departmentMapper) {
        this.reservationMapper = reservationMapper;
        this.memberMapper = memberMapper;
        this.departmentMapper = departmentMapper;
    }

    @Override
    @Transactional
    public Long saveReservation(GuestReservationVO reservationVO) {

        // 1. 비회원 정보를 Member VO로 변환
        Member guestMember = convertToGuestMember(reservationVO);

        // 2. DEPARTMENT_NAME을 DEPARTMENT_NO로 변환
        // Long departmentNo = departmentMapper.selectDepartmentNoByName(reservationVO.getDepartmentName());
        // if (departmentNo == null) {
        //    throw new RuntimeException("유효하지 않은 진료과 이름입니다: " + reservationVO.getDepartmentName());
        // }
        // reservationVO.setDepartmentNo(departmentNo);

        // ★★★ (임시) DepartmentMapper가 없을 경우, 이름이 '정형외과'면 1, '내과'면 2 등으로 임시 매핑 ★★★
        if ("정형외과".equals(reservationVO.getDepartmentName())) {
            reservationVO.setDepartmentNo(1L);
        } else if ("내과".equals(reservationVO.getDepartmentName())) {
            reservationVO.setDepartmentNo(2L);
        } else {
            // 임시로 기본값 설정 (DB에 존재하는 유효한 번호여야 함)
            reservationVO.setDepartmentNo(1L);
        }

        // 3. MEMBER 테이블에 비회원 정보 삽입
        memberMapper.insertGuestMember(guestMember);

        int memberNoInt = guestMember.getMemberNo();
        if (memberNoInt == 0) {
            throw new RuntimeException("비회원 등록에 실패했습니다. (MemberNo 획득 실패)");
        }

        Long memberNo = (long)memberNoInt;

        // 4. RESERVATION 테이블에 예약 정보를 저장
        int affectedRows = reservationMapper.insertReservationForGuest(memberNo, reservationVO);

        if (affectedRows == 0) {
            throw new RuntimeException("예약 정보 저장에 실패했습니다.");
        }

        // 5. 새로 생성된 예약 번호 반환
        return reservationVO.getReservationNo();
    }

    /**
     * GuestReservationVO 데이터를 MEMBER 테이블 삽입용 Member VO로 변환합니다.
     */
    private Member convertToGuestMember(GuestReservationVO vo) {
        Member member = new Member();
        member.setMemberName(vo.getName());
        member.setMemberRrn(vo.getSsn());
        member.setMemberPhone(vo.getPhone());
        member.setMemberEmail(vo.getEmail());
        member.setMemberAddress(vo.getAddress());
        member.setMemberGender("M");
        member.setMemberBloodType("O+");
        member.setMemberStatus("T");
        member.setMemberChronicDisease(vo.getNotes());
        member.setMemberId(null);
        member.setMemberPwd(null);
        member.setStaffNo(null);
        return member;
    }
}