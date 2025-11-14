package com.w3c.spring.service.member;

import com.w3c.spring.model.vo.Member;

public interface MemberService {

    // 1. [신규] 로그인
    Member login(String memberId, String memberPwd);

    // [삭제] getMemberById(String memberId, String memberPwd);

    // 2. 회원가입
    int signUpMember(Member member);

    // 3. ID 중복 확인
    int getMemberCountById(String memberId);

    // 4. ID로 회원 정보 조회 (비밀번호 확인용)
    Member getMemberById(String memberId);

    // 5. 회원 정보 수정
    int updateMemberInfo(Member member);

    // 6. 회원 번호(No)로 회원 정보 조회
    Member getMemberByNo(Long memberNo);

    // 7. 비밀번호 확인
    boolean checkPassword(String memberId, String currentPassword);

    // 8. 비밀번호 업데이트
    int updatePassword(String memberId, String newPassword);

    // 9. 회원 탈퇴 (비활성화)
    int deactivateMember(String memberId);
}