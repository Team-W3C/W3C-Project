package com.w3c.spring.model.vo.notification;

public class NoticeRequest {
    private String notificationTitle;
    private String notificationContent;
    private Integer departmentNo;
    private String notifiedType;
    private String notificationType;

    public String getNotificationTitle() {
        return notificationTitle;
    }

    public void setNotificationTitle(String notificationTitle) {
        this.notificationTitle = notificationTitle;
    }

    public String getNotificationContent() {
        return notificationContent;
    }

    public void setNotificationContent(String notificationContent) {
        this.notificationContent = notificationContent;
    }

    public Integer getDepartmentNo() {
        return departmentNo;
    }

    public void setDepartmentNo(Integer departmentNo) {
        this.departmentNo = departmentNo;
    }

    public String getNotifiedType() {
        return notifiedType;
    }

    public void setNotifiedType(String notifiedType) {
        this.notifiedType = notifiedType;
    }

    public String getNotificationType() {
        return notificationType;
    }

    public void setNotificationType(String notificationType) {
        this.notificationType = notificationType;
    }
}
