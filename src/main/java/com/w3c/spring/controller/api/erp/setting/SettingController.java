package com.w3c.spring.controller.api.erp.setting;

import com.w3c.spring.model.vo.Member;
import com.w3c.spring.service.member.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

@Controller
public class SettingController {

    private final MemberService memberService;

    @Autowired
    public SettingController(MemberService memberService) {
        this.memberService = memberService;
    }

    @PostMapping("/erp/updateMember")
    public String updateMember(Member formMember,
                               @RequestParam(value = "currentPassword", required = false) String currentPassword,
                               @RequestParam(value = "newPassword", required = false) String newPassword,
                               HttpSession session) {

        // 1. 로그인 체크
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/"; // 로그인이 안되어있다면 메인으로
        }

        // 2. DB에서 기존 정보를 가져오기
        Member originMember = memberService.getMemberByNo((long) loginMember.getMemberNo());

        // 3. 폼에서 입력받은 수정할 데이터만 기존 정보에 덮어씌움
        originMember.setMemberName(formMember.getMemberName());
        originMember.setMemberPhone(formMember.getMemberPhone());
        originMember.setMemberEmail(formMember.getMemberEmail());
        originMember.setMemberAddress(formMember.getMemberAddress());

        // 4. 비밀번호 변경 로직 (새 비밀번호가 있는 경우에만)
        if (newPassword != null && !newPassword.isEmpty()) {
            if (memberService.checkPassword(originMember.getMemberId(), currentPassword)) {
                memberService.updatePassword(originMember.getMemberId(), newPassword);
            } else {
                return "redirect:/erp/setting?error=password"; // 비밀번호 오류 시 error 파라미터
            }
        }

        // 5. 완성된 객체(기존 정보 + 수정 정보)를 DB에 업데이트 요청
        int result = memberService.updateMemberInfo(originMember);

        // 6. 세션 정보 갱신
        if (result > 0) {
            // 업데이트된 최신 정보를 다시 조회하여 세션에 저장
            Member updatedMember = memberService.getMemberByNo((long) loginMember.getMemberNo());
            session.setAttribute("loginMember", updatedMember);

            // ⭐️ 수정: 성공 시 success=true 파라미터를 추가하여 리다이렉트
            return "redirect:/erp/setting?success=update";
        } else {
            // DB 업데이트 실패 시에도 에러 메시지를 전달할 수 있습니다.
            return "redirect:/erp/setting?error=updateFail";
        }
    }
}