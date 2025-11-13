package com.w3c.spring.service.member;

import com.w3c.spring.model.mapper.MemberMapper;
import com.w3c.spring.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@Service
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;

    @Autowired
    public MemberServiceImpl(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
    }

    @Override
    public Member getMemberById(String memberId, String memberPwd) {
        System.out.println("=============");
        System.out.println(memberId);
        return memberMapper.getMemberById(memberId, memberPwd);
    }

    @Override
    public int signUpMember(Member member) {
        return memberMapper.signUpMember(member);
    }

    @Override
    public int getMemberCountById(String memberId) {
        return memberMapper.getMemberCountById(memberId);
    }

    @Override
    public Member getMemberById(String memberId) {
        return memberMapper.selectMemberById(memberId);
    }

    /**
     * 비밀번호 확인
     *
     * @param inputPassword 사용자가 입력한 비밀번호
     * @param storedPassword DB에 저장된 비밀번호
     * @return 일치 여부
     */
    @Override
    public boolean checkPassword(String inputPassword, String storedPassword) {
        // 방법 1: 평문 비교 (보안 취약 - 개발 환경에서만 사용)
        return inputPassword.equals(storedPassword);

        // 방법 2: BCrypt 암호화 비교 (권장)
        // return passwordEncoder.matches(inputPassword, storedPassword);
    }

    @Override
    public int updateMemberInfo(Member member) {
        return memberMapper.updateMemberInfo(member);
    }

    @Override
    public Member getMemberByNo(Long memberNo) {
        return memberMapper.getMemberByNo(memberNo);
    }
}
