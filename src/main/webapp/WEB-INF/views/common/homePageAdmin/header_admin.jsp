<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-container">
            <a href="${pageContext.request.contextPath}/member/backToHomePage.me">
                <img src="${pageContext.request.contextPath}/img/w3c_icon_100px.png" alt="로고"/>
            </a>
            <nav class="nav">
                <a href="#" class="nav-link">관리자 전용</a>
                <a href="${pageContext.request.contextPath}/member/reservation/main.re" class="nav-link">예약</a>
                <a href="${pageContext.request.contextPath}/member/notice.bo" class="nav-link">공지사항</a>
                <a href="${pageContext.request.contextPath}/member/inquiry-board.bo" class="nav-link">문의사항</a>
                <a href="${pageContext.request.contextPath}/dashBoard/enterErp.erp" class="nav-link nav-link-primary">대시보드</a>
            </nav>
        </div>
    </header>
</body>