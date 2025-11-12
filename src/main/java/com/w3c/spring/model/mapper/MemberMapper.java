package com.w3c.spring.model.mapper;

import com.w3c.spring.model.vo.Member;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

@Mapper
public interface MemberMapper {
    Member getMemberById(@Param("memberId") String memberId, @Param("memberPwd") String memberPwd);
    int signUpMember(Member member);
    int getMemberCountById(@Param("memberId") String memberId);
}
