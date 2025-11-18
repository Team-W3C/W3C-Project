package com.w3c.spring.service.member;

import com.w3c.spring.model.vo.Member;
import com.w3c.spring.model.vo.inquiry.BoardMemberSelect;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MemberService {
    Member getMemberById(String memberId, String memberPwd);
    int signUpMember(Member member);
    int getMemberCountById(String memberId);
    BoardMemberSelect selectMemberByBoardId(int boardId);
    int updateMemberInfo(Member member);
    Member getMemberByNo(Long memberNo);
    boolean checkPassword(String memberId, String currentPassword);
    int updatePassword(String memberId, String newPassword);
    int deactivateMember(String memberId);
    
    // ✅ 환자 목록 조회
    List<Member> getPatientList();
}
