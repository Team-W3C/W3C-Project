package com.w3c.spring.service.member;

import org.apache.ibatis.annotations.Param;

public interface MemberService {
    int loginMember(String memberId);
}
