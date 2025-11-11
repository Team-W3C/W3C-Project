package com.w3c.spring.service.member;

import com.w3c.spring.model.mapper.MemberMapper;
import com.w3c.spring.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;

    @Autowired
    public MemberServiceImpl(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
    }

    @Override
    public Member getMemberById(String memberId) {
        System.out.println("=============");
        System.out.println(memberId);
        return memberMapper.getMemberById(memberId);
    }

    @Override
    public int signUpMember(Member member) {
        return memberMapper.signUpMember(member);
    }
}
