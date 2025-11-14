package com.w3c.spring.service.member;

import com.w3c.spring.model.mapper.MemberMapper;
import com.w3c.spring.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;

    @Autowired
    public MemberServiceImpl(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
    }

    /**
     * 1. [신규] 로그인 로직 구현
     */
    @Override
    public Member login(String memberId, String memberPwd) {
        // ID로만 회원 정보를 조회 (MEMBER_STATUS = 'T'인 회원)
        Member member = memberMapper.selectMemberById(memberId);

        // 1. 조회된 회원이 없거나, 비밀번호 정보가 없는 경우
        if (member == null || member.getMemberPwd() == null) {
            return null;
        }

        // 2. 비밀번호 비교 (Java에서 비교)
        // (실제 운영 시에는 member.getMemberPwd()는 암호화된 값이므로,
        //  passwordEncoder.matches(memberPwd, member.getMemberPwd())로 비교해야 함)
        if (member.getMemberPwd().equals(memberPwd)) {

            // 3. 로그인 성공 시, 세션에 담기 전 비밀번호 제거
            member.setMemberPwd(null);
            return member;
        }

        // 4. 비밀번호 불일치
        return null;
    }

    // [삭제] public Member getMemberById(String memberId, String memberPwd) { ... }

    @Override
    public int signUpMember(Member member) {
        return memberMapper.signUpMember(member);
    }

    @Override
    public int getMemberCountById(String memberId) {
        return memberMapper.getMemberCountById(memberId);
    }

    /**
     * 4. ID로 회원 정보 조회 (비밀번호 확인, 회원가입 시 중복 ID 체크 등에 사용)
     */
    @Override
    public Member getMemberById(String memberId) {
        // ID로만 회원을 조회 (PW 포함된 전체 정보)
        // mapper의 selectMemberById 호출
        return memberMapper.selectMemberById(memberId);
    }

    @Override
    @Transactional
    public int updateMemberInfo(Member member) {
        return memberMapper.updateMemberInfo(member);
    }

    @Override
    public Member getMemberByNo(Long memberNo) {
        return memberMapper.getMemberByNo(memberNo);
    }

    /**
     * 7. 비밀번호 변경 전 현재 비밀번호 일치 여부 확인 (DB 조회 기반)
     */
    @Override
    public boolean checkPassword(String memberId, String currentPassword) {
        // 1. ID로 회원 정보(및 비밀번호) 조회
        // (주의: getMemberById(memberId)는 selectMemberById를 호출하도록 구현되어 있음)
        Member member = this.getMemberById(memberId);

        if (member == null || member.getMemberPwd() == null) {
            return false; // 회원이 없거나 비밀번호 정보가 없음
        }

        String storedPassword = member.getMemberPwd();

        // 2. 비밀번호 비교 (현재는 평문 비교)
        return storedPassword.equals(currentPassword);
    }

    /**
     * 8. 새 비밀번호로 업데이트 처리
     */
    @Override
    @Transactional
    public int updatePassword(String memberId, String newPassword) {
        return memberMapper.updatePassword(memberId, newPassword);
    }

    /**
     * 9. 회원 탈퇴 (비활성화) 구현
     */
    @Override
    @Transactional
    public int deactivateMember(String memberId) {
        // member_status를 'F'로 변경합니다.
        return memberMapper.deactivateMember(memberId);
    }
}