package com.w3c.spring.service.inquiry;

import com.w3c.spring.model.vo.inquiry.Board;
import com.w3c.spring.model.vo.inquiry.BoardInsert;
import com.w3c.spring.model.vo.notification.Notification;
import com.w3c.spring.model.vo.notification.NotificationInsert;
import org.springframework.stereotype.Service;

import java.util.Map;

public interface BoardService {
    public Map<String, Object> getBoardList(int cpage);
    int selectBoardListCount();

    Map<String, Object> getBoardById(int boardId);

    int insertBoard(BoardInsert boardInsert);
    Board selectInquiryDetail(int boardNo);
    int registerAnswer(int boardId, int staffNo, String answerContent);

    Map<String, Object> selectNotificationList(int curentPage);
    Notification selectNotificationById(int notificationNo);
    int insertNotification(NotificationInsert notificationInsert);
    Map<String, Object> getInquiryStats();

    Map<String, Object> selectPatientNoticeList(int curentPage);

    Notification selectPatientNoticeById(int nNo);
}
