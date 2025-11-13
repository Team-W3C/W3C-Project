package com.w3c.spring.service.member;

import com.w3c.spring.model.vo.Member;
import org.apache.ibatis.annotations.Param;

import java.util.Map;

public interface MemberService {
    Member getMemberById(String memberId, String memberPwd);
    int signUpMember(Member member);
    int getMemberCountById(String memberId);
    Member getMemberById(String memberId);
    boolean checkPassword(String inputPassword, String storedPassword);
    int updateMemberInfo(Member member);
    Member getMemberByNo(Long memberNo);
}
