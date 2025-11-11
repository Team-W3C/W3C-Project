package com.w3c.spring.service.member;

import com.w3c.spring.model.vo.Member;
import org.apache.ibatis.annotations.Param;

public interface MemberService {
    Member getMemberById(String memberId);
    int signUpMember(Member member);
    int getMemberCountById(String memberId);
}
