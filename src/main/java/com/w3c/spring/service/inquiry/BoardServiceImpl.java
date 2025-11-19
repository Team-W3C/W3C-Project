package com.w3c.spring.service.inquiry;

import com.w3c.spring.model.mapper.inquiry.BoardMapper;
import com.w3c.spring.model.mapper.notification.NotificationMapper;
import com.w3c.spring.model.vo.inquiry.Answer;
import com.w3c.spring.model.vo.inquiry.Board;
import com.w3c.spring.model.vo.inquiry.BoardInsert;
import com.w3c.spring.model.vo.inquiry.PageInfo;
import com.w3c.spring.model.vo.notification.Notification;
import com.w3c.spring.model.vo.notification.NotificationInsert;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
@RequiredArgsConstructor
@Service
public class BoardServiceImpl implements BoardService{

    private final BoardMapper boardMapper;
    private final NotificationMapper notificationMapper;

    @Override
    public Map<String, Object> getBoardList(int cpage, String keyword, String category, String status) {
        Map<String, Object> param = new HashMap<>();
        param.put("keyword", keyword);
        param.put("category", category);
        param.put("status", status);

        int listCount = boardMapper.selectBoardListCount(param);

        PageInfo pi = new PageInfo(cpage, listCount, 5, 10);

        int offset = (cpage - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

        ArrayList<Board> list = (ArrayList)boardMapper.selectBoardList(param, rowBounds);

        for (Board b : list) {
            enrichBoard(b);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("pi", pi);
        return map;
    }


//    @Override
//    public int selectBoardListCount() {
//        return boardMapper.selectBoardListCount(param);
//    }



    @Override
    public Board getBoardById(int boardId) {
        Map<String, Object> map = new HashMap<>();

        Board board = boardMapper.getBoardById(boardId);

        if(board != null) {
            enrichBoard(board);
            int memberId = boardMapper.getBoardMemberId(boardId);
            board.setMemberNo(memberId);
            return board;
        }else{
            return null;
        }

    }

    @Override
    public int insertBoard(BoardInsert boardInsert) {
        int result = boardMapper.insertBoard(boardInsert);



        return result;
    }

    @Override
    public Board selectInquiryDetail(int boardNo) {
        Board board = boardMapper.getBoardById(boardNo);
        enrichBoard(board);
        return board;
    }

    @Override
    public int registerAnswer(int boardId, int staffNo, String answerContent) {
        Answer answer = new Answer();
        answer.setBoardId(boardId);
        answer.setStaffNo(staffNo);
        answer.setAnswerContent(answerContent);

        int result = boardMapper.insertAnswer(answer);
        if (result > 0) {
            boardMapper.updateBoardStatus(boardId, "완료"); // 정책에 따라 상태 변경
        }
        return result;
    }

    // 공지사항
    @Override
    public Map<String, Object> selectNotificationList(int cpage, String keyword, String category) {
        Map<String, Object> param = new HashMap<>();
        param.put("keyword", keyword);
        param.put("category", category);

        int listCount = notificationMapper.selectNotificationListCount(param);

        PageInfo pi = new PageInfo(cpage, listCount, 5, 10);

        int offset = (cpage - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

        ArrayList<Notification> list = (ArrayList)notificationMapper.selectNotificationList(param, rowBounds);

        for (Notification n : list) {
            notifiType(n);
        }
        System.out.println(list);

        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("pi", pi);
        return map;


    }
    //공지사항 상세
    @Override
    public Notification selectNotificationById(int notificationNo) {
        Notification notification = notificationMapper.selectNotificationById(notificationNo);
        if (notification != null) {
            notifiType(notification);
        }
        return notification;
    }

    @Override
    public int insertNotification(NotificationInsert notificationInsert) {
        return notificationMapper.insertNotification(notificationInsert);
    }

    @Override
    public Map<String, Object> getInquiryStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("total", boardMapper.selectBoardCountAll());
        stats.put("waiting", boardMapper.selectBoardCountByStatus("대기중"));
        stats.put("completed", boardMapper.selectBoardCountByStatus("완료"));
        stats.put("todayCount", boardMapper.selectBoardCountToday());
        return stats;
    }

    @Override
    public Map<String, Object> selectPatientNoticeList(int curentPage, String keyword, String category) {
        Map<String, Object> param = new HashMap<>();
        param.put("keyword", keyword);
        param.put("category", category);

        int listCount = notificationMapper.getPatientNoticeListCount(param);

        PageInfo pi = new PageInfo(curentPage, listCount, 5, 10);

        int offset = (curentPage - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

        ArrayList<Notification> list = (ArrayList)notificationMapper.selectPatientNoticeList(param, rowBounds);

        for (Notification n : list) {
            notifiType(n);
        }
        System.out.println(list);
        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("pi", pi);
        return map;
    }

    @Override
    public Notification selectPatientNoticeById(int nNo) {
        Notification notification = notificationMapper.selectPatientNoticeById(nNo);
        if (notification != null) {
            return notification;
        }else{
            return null;
        }

    }

    @Override
    public Map<String, Object> getBoardListTop3() {

        ArrayList<Notification> list = (ArrayList)notificationMapper.getBoardListTop3();
        Map<String, Object> map = new HashMap<>();
        System.out.println(list);
        map.put("list", list);
        return map;
    }


    private void enrichBoard(Board b) {
        switch (b.getBoardType()) {
            case 1 : b.setBoardTypeName("결제"); break;
            case 2 : b.setBoardTypeName("진료"); break;
            case 3 : b.setBoardTypeName("기타");break;
            case 4 : b.setBoardTypeName("시스템"); break;
            case 5 : b.setBoardTypeName("예약");break;
            default : b.setBoardTypeName("알수없음");break;
        }
        b.setBoardSecretTypeName("T".equals(b.getBoardSecretType()) ? "비밀" : "공개");
    }

    private void notifiType(Notification n) {
        switch (n.getNotificationType()) {
            case 1: n.setNotificationTypeName("시스템"); break;
            case 2: n.setNotificationTypeName("운영"); break;
            case 3: n.setNotificationTypeName("진료"); break;
            default: n.setNotificationTypeName("기타"); break;
        }
        switch (n.getNotifiedType()) {
            case 1: n.setNotifiedTypeName("환자 공지"); break;
            case 2: n.setNotifiedTypeName("직원 공지"); break;
            case 3: n.setNotifiedTypeName("전체 공지"); break;
            default: n.setNotifiedTypeName("기타"); break;
        }
    }
}
