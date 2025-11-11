<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-container">
            <a href="${pageContext.request.contextPath}/">
                <img src="${pageContext.request.contextPath}/img/w3c_icon_100px.png" alt="로고"/>
            </a>
            <nav class="nav">
                <a href="${pageContext.request.contextPath}/member/reservation/main" class="nav-link">예약</a>
                <a href="${pageContext.request.contextPath}/member/notice" class="nav-link">공지사항</a>
                <a href="${pageContext.request.contextPath}/member/inquiry-board" class="nav-link">문의사항</a>
                <c:choose>
                    <c:when test="${empty sessionScope.loginMember}">
                        <a href="${pageContext.request.contextPath}/member/loginPage" class="nav-link nav-link-primary">로그인</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/member/mychart" class="nav-link">나의차트</a>
                        <a href="${pageContext.request.contextPath}/api/member/logOut" class="nav-link nav-link-primary">로그아웃</a>
                    </c:otherwise>
                </c:choose>

            </nav>
        </div>
    </header>

</body>