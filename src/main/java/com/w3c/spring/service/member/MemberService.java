package com.w3c.spring.service.member;

import com.w3c.spring.model.vo.Member;

public interface MemberService {

    Member login(String memberId, String memberPwd);

    int signUpMember(Member member);

    int getMemberCountById(String memberId);

    Member getMemberById(String memberId);

    int updateMemberInfo(Member member);

    Member getMemberByNo(Long memberNo);

    boolean checkPassword(String memberId, String currentPassword);

    int updatePassword(String memberId, String newPassword);

    int deactivateMember(String memberId);
}
