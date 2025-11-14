package com.w3c.spring.model.mapper;

import com.w3c.spring.model.vo.Member;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Mapper
public interface MemberMapper {
    // 2. 회원가입
    int signUpMember(Member member);

    // 3. ID 중복 확인
    int getMemberCountById(@Param("memberId") String memberId);

    // 4. ID로 회원 정보 조회 (Service 오버로딩용)
    Member selectMemberById(@Param("memberId") String memberId);

    // 5. 회원 정보 수정
    int updateMemberInfo(Member member);

    // 6. 회원 번호(PK)로 조회
    Member getMemberByNo(Long memberNo);

    // 8. 비밀번호 업데이트
    int updatePassword(@Param("memberId") String memberId, @Param("newPassword") String newPassword);

    // 9. 회원 탈퇴 (비활성화)
    int deactivateMember(@Param("memberId") String memberId);
}