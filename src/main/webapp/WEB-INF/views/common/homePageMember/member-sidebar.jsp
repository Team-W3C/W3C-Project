<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/member-sidebar.css">

    <title>Document</title>
</head>
<aside class="member-sidebar">

    <div class="member-sidebar__user">
        <h2 class="member-sidebar__user-name">홍길동님</h2>
        <p class="member-sidebar__user-id">병원등록번호 : 11258411</p>
    </div>

    <nav class="member-sidebar__nav-group">
        <h3 class="member-sidebar__nav-title">진료서비스</h3>
        <ul class="member-sidebar__nav-list">
            <li class="member-sidebar__nav-item">
                <a href="#" class="member-sidebar__nav-link member-sidebar__nav-link--active">본인예약현황</a>
            </li>
            <li class="member-sidebar__nav-item">
                <a href="#" class="member-sidebar__nav-link">진료내역</a>
            </li>
            <li class="member-sidebar__nav-item">
                <a href="#" class="member-sidebar__nav-link">알레르기 이력</a>
            </li>
            <li class="member-sidebar__nav-item">
                <a href="#" class="member-sidebar__nav-link">투약내역</a>
            </li>
            <li class="member-sidebar__nav-item">
                <a href="#" class="member-sidebar__nav-link">진단검사결과</a>
            </li>
            <li class="member-sidebar__nav-item">
                <a href="#" class="member-sidebar__nav-link">건강검진결과</a>
            </li>
        </ul>
    </nav>

    <nav class="member-sidebar__nav-group">
        <h3 class="sidebar-menu-title">
            회원정보
        </h3>
        <ul class="member-sidebar__nav-list">
            <li class="member-sidebar__nav-item" id="open-password-modal">
                <a href="#" class="member-sidebar__nav-link member-sidebar__nav-link--active">회원정보수정</a>
            </li>
            <li class="member-sidebar__nav-item">
                <a href="#" class="member-sidebar__nav-link member-sidebar__nav-link--medium">비밀번호 변경</a>
            </li>
            <li class="member-sidebar__nav-item">
                <a href="${pageContext.request.contextPath}/member/info" class="member-sidebar__nav-link">회원 탈퇴</a>
            </li>
        </ul>
    </nav>

</aside>

</html>