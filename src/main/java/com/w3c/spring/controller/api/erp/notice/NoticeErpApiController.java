package com.w3c.spring.controller.api.erp.notice;


import com.w3c.spring.model.vo.Member;
import com.w3c.spring.model.vo.notification.NoticeRequest;
import com.w3c.spring.model.vo.notification.NotifiSelect;
import com.w3c.spring.model.vo.notification.Notification;
import com.w3c.spring.model.vo.notification.NotificationInsert;
import com.w3c.spring.service.inquiry.BoardService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/api/erp")
public class NoticeErpApiController {

    private final BoardService boardService;

    @GetMapping("/notice/detail/{noticeNo}")
    @ResponseBody
    public Notification getNoticeDetail(@PathVariable("noticeNo") int noticeNo) {
        Notification notification = boardService.selectNotificationById(noticeNo);
        return notification;
    }
    @PostMapping("/notice/create")
    @ResponseBody
    public Map<String, Object> createNotice(@RequestBody NoticeRequest request, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        // 로그인 체크
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return response;
        }

        // 입력값 검증
        if (request.getNotificationTitle() == null || request.getNotificationTitle().trim().isEmpty()) {
            response.put("success", false);
            response.put("message", "제목을 입력하세요.");
            return response;
        }

        if (request.getNotificationContent() == null || request.getNotificationContent().trim().isEmpty()) {
            response.put("success", false);
            response.put("message", "내용을 입력하세요.");
            return response;
        }

        if (request.getDepartmentNo() == null || request.getDepartmentNo() == 0) {
            response.put("success", false);
            response.put("message", "부서를 선택하세요.");
            return response;
        }

        // 타입 변환 및 공지사항 등록
        NotificationInsert notificationInsert = new NotificationInsert();

        // notifiedType 변환: "all" -> 3, "patient" -> 1, "employee" -> 2
        int notifiedType = 3;
        if ("patient".equals(request.getNotifiedType())) {
            notifiedType = 1;
        } else if ("employee".equals(request.getNotifiedType())) {
            notifiedType = 2;
        }

        // notificationType 변환: "system" -> 1, "operate" -> 2, "medical" -> 3
        int notificationType = 1;
        if ("operate".equals(request.getNotificationType())) {
            notificationType = 2;
        } else if ("medical".equals(request.getNotificationType())) {
            notificationType = 3;
        }

        notificationInsert.setNotificationType(notificationType);
        notificationInsert.setDepartmentNo(request.getDepartmentNo());
        notificationInsert.setNotificationTitle(request.getNotificationTitle().trim());
        notificationInsert.setNotificationContent(request.getNotificationContent().trim());
        notificationInsert.setNotifiedType(notifiedType);
        notificationInsert.setStaffNo(loginMember.getStaffNo());
        int result = boardService.insertNotification(notificationInsert);

        if (result > 0) {
            response.put("success", true);
            response.put("message", "공지사항이 등록되었습니다.");
        } else {
            response.put("success", false);
            response.put("message", "공지사항 등록 중 문제가 발생했습니다.");
        }

        return response;
    }


}


