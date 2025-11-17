package com.w3c.spring.service.member;

import com.w3c.spring.model.mapper.MemberMapper;
import com.w3c.spring.model.vo.Member;
import com.w3c.spring.model.vo.inquiry.BoardMemberSelect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

// import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder; // BCrypt 제거


@Service
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;

    // private final BCryptPasswordEncoder passwordEncoder; // BCrypt 제거

    @Autowired
    public MemberServiceImpl(MemberMapper memberMapper) { // BCrypt 제거
        this.memberMapper = memberMapper;
        // this.passwordEncoder = passwordEncoder; // BCrypt 제거
    }


    @Override
    public Member getMemberById(String memberId, String memberPwd) {
        System.out.println("=============");
        System.out.println(memberId);
        // 암호화가 없으므로 DB에 저장된 평문과 사용자가 입력한 평문을 비교
        return memberMapper.getMemberById(memberId, memberPwd);
    }

    @Override
    @Transactional
    public int signUpMember(Member member) {
        // 암호화 로직 제거
        // String encryptedPassword = passwordEncoder.encode(member.getMemberPwd());
        // member.setMemberPwd(encryptedPassword);

        // 평문 비밀번호를 그대로 저장
        return memberMapper.signUpMember(member);
    }

    @Override
    public int getMemberCountById(String memberId) {
        return memberMapper.getMemberCountById(memberId);
    }

    @Override
    public BoardMemberSelect selectMemberByBoardId(int boardId) {

        BoardMemberSelect  selectMemberByBoardId = memberMapper.selectMemberByBoardId(boardId);
        return selectMemberByBoardId;
    }

    @Override
    @Transactional
    public int updateMemberInfo(Member member) {
        // Null 처리 및 기본값 설정
        if (member.getMemberBloodType() == null) {
            member.setMemberBloodType("NULL");
        }
        if (member.getMemberChronicDisease() == null) {
            member.setMemberChronicDisease("NULL");
        }
        if (member.getMemberAllergy() == null) {
            member.setMemberAllergy("NULL");
        }

        return memberMapper.updateMemberInfo(member);
    }

    @Override
    public Member getMemberByNo(Long memberNo) {
        return memberMapper.getMemberByNo(memberNo);
    }

    @Override
    // 70행 오류 수정
    public boolean checkPassword(String memberId, String currentPassword) {

        // 1. this.getMemberById(memberId) -> memberMapper.selectMemberById(memberId)로 변경
        Member member = memberMapper.selectMemberById(memberId);

        if (member == null || member.getMemberPwd() == null) {
            return false;
        }

        // 2. BCrypt.matches() -> .equals() 평문 비교로 변경
        return member.getMemberPwd().equals(currentPassword);
    }

    @Override
    @Transactional
    public int updatePassword(String memberId, String newPassword) {
        // 암호화 로직 제거
        // String encryptedPassword = passwordEncoder.encode(newPassword);

        // 평문 비밀번호를 그대로 업데이트
        return memberMapper.updatePassword(memberId, newPassword);
    }

    @Override
    @Transactional
    public int deactivateMember(String memberId) {
        return memberMapper.deactivateMember(memberId);
    }
}