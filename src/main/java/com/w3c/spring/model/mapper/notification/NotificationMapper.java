package com.w3c.spring.model.mapper.notification;

import com.w3c.spring.model.vo.inquiry.Board;
import com.w3c.spring.model.vo.notification.Notification;
import com.w3c.spring.model.vo.notification.NotificationInsert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;
import java.util.Map;

@Mapper
public interface NotificationMapper {
    int selectNotificationListCount(Map<String, Object> param);
    List<Board> selectNotificationList(Map<String, Object> param, RowBounds rowBounds);
    Notification selectNotificationById(int notificationNo);
    int insertNotification(NotificationInsert notificationInsert);

    List<Notification> selectPatientNoticeList(Map<String, Object> param, RowBounds rowBounds);

    int getPatientNoticeListCount(Map<String, Object> param);
    Notification selectPatientNoticeById(int notificationNo);

    List<Notification> getBoardListTop3();
}
