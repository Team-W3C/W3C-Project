package com.w3c.spring.model.mapper.notification;

import com.w3c.spring.model.vo.inquiry.Board;
import com.w3c.spring.model.vo.notification.Notification;
import com.w3c.spring.model.vo.notification.NotificationInsert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface NotificationMapper {
    int selectNotificationListCount();
    List<Board> selectNotificationList(RowBounds rowBounds);
    Notification selectNotificationById(int notificationNo);
    int insertNotification(NotificationInsert notificationInsert);

    List<Notification> selectPatientNoticeList(RowBounds rowBounds);

    int getPatientNoticeListCount();
    Notification selectPatientNoticeById(int notificationNo);
}
