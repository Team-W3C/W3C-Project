package com.w3c.spring.controller.member;

import com.w3c.spring.model.vo.Member;
import com.w3c.spring.service.member.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/member")
public class PasswordVerifyController {

    @Autowired
    private MemberService memberService;

    /**
     * 비밀번호 확인 API
     * 세션의 로그인 사용자 비밀번호와 입력한 비밀번호를 비교합니다.
     */
    @PostMapping("/verify-password")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> verifyPassword(
            @RequestBody Map<String, String> request,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        try {
            // 1. 세션에서 로그인 회원 정보 가져오기
            Member loginMember = (Member) session.getAttribute("loginMember");

            if (loginMember == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return ResponseEntity.ok(result);
            }

            // 2. 입력받은 비밀번호
            String inputPassword = request.get("password");

            if (inputPassword == null || inputPassword.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "비밀번호를 입력해주세요.");
                return ResponseEntity.ok(result);
            }

            // 3. DB에서 최신 회원 정보 조회 (보안을 위해)
            Member dbMember = memberService.getMemberById(loginMember.getMemberId());

            if (dbMember == null) {
                result.put("success", false);
                result.put("message", "회원 정보를 찾을 수 없습니다.");
                return ResponseEntity.ok(result);
            }

            // 4. 비밀번호 확인
            // 주의: 실제 환경에서는 암호화된 비밀번호 비교 (BCrypt 등 사용)
            boolean isPasswordMatch = memberService.checkPassword(inputPassword, dbMember.getMemberPwd());

            if (isPasswordMatch) {
                result.put("success", true);
                result.put("message", "비밀번호가 확인되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "비밀번호가 일치하지 않습니다.");
            }

            return ResponseEntity.ok(result);

        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "비밀번호 확인 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
    }
}