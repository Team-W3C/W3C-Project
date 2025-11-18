package com.w3c.spring.model.mapper;

import com.w3c.spring.model.vo.Member;
import com.w3c.spring.model.vo.inquiry.BoardMemberSelect;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Mapper
public interface MemberMapper {
    Member getMemberById(@Param("memberId") String memberId, @Param("memberPwd") String memberPwd);
    int signUpMember(Member member);
    int getMemberCountById(@Param("memberId") String memberId);
    int insertGuestMember(Member member);

    BoardMemberSelect selectMemberByBoardId(int boardId);
    // ID로 회원 정보 조회 (Service 오버로딩용) <-- 이 메소드 추가
    Member selectMemberById(@Param("memberId") String memberId);
    // 회원 정보 수정
    int updateMemberInfo(Member member);
    // 회원 번호(PK)로 조회
    Member getMemberByNo(Long memberNo);
    // 비밀번호 업데이트
    int updatePassword(@Param("memberId") String memberId, @Param("newPassword") String newPassword);
    // 회원 탈퇴 (비활성화)
    int deactivateMember(@Param("memberId") String memberId);
    
    // ✅ 환자 목록 조회 (STAFF_NO IS NULL인 일반 환자만)
    List<Member> getPatientList();
}
