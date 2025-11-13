package com.w3c.spring.service.member;

import com.w3c.spring.model.mapper.MemberMapper;
import com.w3c.spring.model.vo.Member;
import com.w3c.spring.model.vo.inquiry.BoardMemberSelect;
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
    public BoardMemberSelect selectMemberByBoardId(int boardId) {

        BoardMemberSelect  selectMemberByBoardId = memberMapper.selectMemberByBoardId(boardId);
        return selectMemberByBoardId;
    }

}
