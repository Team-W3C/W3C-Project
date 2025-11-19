package com.w3c.spring.service.member;

import com.w3c.spring.model.mapper.MemberMapper;
import com.w3c.spring.model.vo.Member;
import com.w3c.spring.model.vo.inquiry.BoardMemberSelect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;

    @Autowired
    public MemberServiceImpl(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
    }

    @Override
    public Member getMemberById(String memberId, String memberPwd) {
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
    public BoardMemberSelect selectMemberByBoardId(int boardId) {
        return memberMapper.selectMemberByBoardId(boardId);
    }

    @Override
    @Transactional
    public int updateMemberInfo(Member member) {
        if (member.getMemberBloodType() == null) member.setMemberBloodType("NULL");
        if (member.getMemberChronicDisease() == null) member.setMemberChronicDisease("NULL");
        if (member.getMemberAllergy() == null) member.setMemberAllergy("NULL");
        return memberMapper.updateMemberInfo(member);
    }

    @Override
    public Member getMemberByNo(Long memberNo) {
        return memberMapper.getMemberByNo(memberNo);
    }

    @Override
    public boolean checkPassword(String memberId, String currentPassword) {
        Member member = memberMapper.selectMemberById(memberId);
        if (member == null || member.getMemberPwd() == null) return false;
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

    @Override
    public List<Member> getPatientList() {
        return memberMapper.getPatientList();
    }

    @Override
    public String findMemberIdByNameAndPhone(String memberName, String memberPhone) {
        return memberMapper.findMemberIdByNameAndPhone(memberName, memberPhone);
    }

    @Override
    public Member getMemberByIdOnly(String memberId) {
        return memberMapper.selectMemberById(memberId);
    }
}