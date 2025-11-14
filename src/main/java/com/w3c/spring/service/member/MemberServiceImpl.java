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

    @Override
    public Member login(String memberId, String memberPwd) {
        Member member = memberMapper.selectMemberById(memberId);

        if (member == null || member.getMemberPwd() == null) {
            return null;
        }

        if (member.getMemberPwd().equals(memberPwd)) {
            member.setMemberPwd(null);
            return member;
        }

        return null;
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

    @Override
    @Transactional
    public int updateMemberInfo(Member member) {
        // Null 처리 및 기본값 설정
        if (member.getMemberBloodType() == null) {
            member.setMemberBloodType("알수없음");
        }
        if (member.getMemberChronicDisease() == null) {
            member.setMemberChronicDisease("없음");
        }
        if (member.getMemberAllergy() == null) {
            member.setMemberAllergy("없음");
        }

        return memberMapper.updateMemberInfo(member);
    }

    @Override
    public Member getMemberByNo(Long memberNo) {
        return memberMapper.getMemberByNo(memberNo);
    }

    @Override
    public boolean checkPassword(String memberId, String currentPassword) {
        Member member = this.getMemberById(memberId);

        if (member == null || member.getMemberPwd() == null) {
            return false;
        }

        return member.getMemberPwd().equals(currentPassword);
    }

    @Override
    @Transactional
    public int updatePassword(String memberId, String newPassword) {
        return memberMapper.updatePassword(memberId, newPassword);
    }

    @Override
    @Transactional
    public int deactivateMember(String memberId) {
        return memberMapper.deactivateMember(memberId);
    }
}
