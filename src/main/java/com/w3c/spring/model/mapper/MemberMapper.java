package com.w3c.spring.model.mapper;

import com.w3c.spring.model.vo.Member;
import com.w3c.spring.model.vo.inquiry.BoardMemberSelect;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MemberMapper {
    Member getMemberById(@Param("memberId") String memberId, @Param("memberPwd") String memberPwd);
    int signUpMember(Member member);
    int getMemberCountById(@Param("memberId") String memberId);
    int insertGuestMember(Member member);
    BoardMemberSelect selectMemberByBoardId(int boardId);
    Member selectMemberById(@Param("memberId") String memberId);
    int updateMemberInfo(Member member);
    Member getMemberByNo(Long memberNo);
    int updatePassword(@Param("memberId") String memberId, @Param("newPassword") String newPassword);
    int deactivateMember(@Param("memberId") String memberId);
    List<Member> getPatientList();
    String findMemberIdByNameAndPhone(@Param("memberName") String memberName, @Param("memberPhone") String memberPhone);
}