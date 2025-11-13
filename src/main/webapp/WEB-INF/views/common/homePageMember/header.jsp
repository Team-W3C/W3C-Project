<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
<header class="header">
    <div class="header-container">
        <a href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/img/w3c_icon_100px.png" alt="로고"/>
        </a>
        <nav class="nav">

            <a href="${pageContext.request.contextPath}/member/reservation/main" class="nav-link">예약</a>
            <a href="${pageContext.request.contextPath}/member/notice" class="nav-link">공지사항</a>
            <a href="${pageContext.request.contextPath}/member/inquiry-board?cpage=1" class="nav-link">문의사항</a>

            <c:choose>
                <%-- 1. 비로그인 상태 --%>
                <c:when test="${empty sessionScope.loginMember}">
                    <a href="${pageContext.request.contextPath}/member/loginPage" class="nav-link nav-link-primary">로그인</a>
                </c:when>

                <%-- 2. 로그인 상태 --%>
                <c:otherwise>
                    <c:choose>
                        <%-- 2-A. 관리자(admin.kim) 상태: 대시보드 메뉴 추가 --%>
                        <c:when test="${sessionScope.loginMember.memberId eq 'admin.kim'}">
                            <a href="${pageContext.request.contextPath}/erp/dashBoard/enterErp" class="nav-link">대시보드</a>
                        </c:when>

                        <%-- 2-B. 일반 회원 상태: 나의차트 메뉴 추가 --%>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/member/mychart" class="nav-link">나의차트</a>
                        </c:otherwise>
                    </c:choose>

                    <%-- 모든 로그인 사용자에게 로그아웃 버튼 제공 --%>
                    <a href="${pageContext.request.contextPath}/api/member/logOut" class="nav-link nav-link-primary">로그아웃</a>
                </c:otherwise>
            </c:choose>

        </nav>
    </div>
</header>
</body>
</html>