package com.w3c.spring.controller.api.erp.setting;

import com.w3c.spring.model.vo.Member;
import com.w3c.spring.service.member.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

@Controller("erpSettingViewController")
public class SettingController {

    private final MemberService memberService;

    @Autowired
    public SettingController(MemberService memberService) {
        this.memberService = memberService;
    }

    @GetMapping("/erp/setting")
    public String setting() {
        return "erp/setting";
    }

    @PostMapping("/erp/updateMember")
    public String updateMember(Member formMember, // [1] 폼에서 넘어온 껍데기 객체 (이름 변경: member -> formMember)
                               @RequestParam(value = "currentPassword", required = false) String currentPassword,
                               @RequestParam(value = "newPassword", required = false) String newPassword,
                               HttpSession session) {

        // 1. 로그인 체크
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/"; // 로그인이 안되어있다면 메인으로
        }

        // 2. [중요] DB에서 '기존' 정보를 온전히 다 가져옵니다. (혈액형, 알러지 등 보존을 위해)
        Member originMember = memberService.getMemberByNo((long) loginMember.getMemberNo());

        // 3. 폼에서 입력받은 '수정할 데이터'만 기존 정보에 덮어씌웁니다.
        // (formMember에는 null인 필드가 많으므로, 필요한 것만 꺼내서 옮깁니다)
        originMember.setMemberName(formMember.getMemberName());
        originMember.setMemberPhone(formMember.getMemberPhone());
        originMember.setMemberEmail(formMember.getMemberEmail());
        // 주소 입력란이 있다면 아래 주석 해제
        // originMember.setMemberAddress(formMember.getMemberAddress());

        // 4. 비밀번호 변경 로직 (새 비밀번호가 있는 경우에만)
        if (newPassword != null && !newPassword.isEmpty()) {
            if (memberService.checkPassword(originMember.getMemberId(), currentPassword)) {
                memberService.updatePassword(originMember.getMemberId(), newPassword);
            } else {
                return "redirect:/erp/setting?error=password";
            }
        }

        // 5. [중요] 완성된 객체(기존 정보 + 수정 정보)를 DB에 업데이트 요청
        int result = memberService.updateMemberInfo(originMember);

        // 6. 세션 정보 갱신
        if (result > 0) {
            // 업데이트된 최신 정보를 다시 조회하여 세션에 저장
            Member updatedMember = memberService.getMemberByNo((long) loginMember.getMemberNo());
            session.setAttribute("loginMember", updatedMember);
        }

        return "redirect:/erp/setting";
    }
}