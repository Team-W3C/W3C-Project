<%-- /WEB-INF/views/common/appointment-sidebar.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <%-- JSP 페이지 인코딩과 별개로, 브라우저에게도 UTF-8임을 명시합니다. --%>
    <meta charset="UTF-8">

    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet"/>

    <%--
      <c:url> 태그는 '/css/appointment-sidebar.css' 경로 앞에
      애플리케이션의 컨텍스트 경로(Context Path)를 동적으로 추가해줍니다.
      (예: /my-app/css/appointment-sidebar.css)
    --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/appointment-sidebar.css">

    <title>Document</title>
</head>

<body>
<main class="booking-sidebar">
    <h1 class="booking-sidebar-title">진료예약/안내</h1>

    <nav class="booking-sidebar-nav">
        <ul class="booking-sidebar-menu">
            <li>
                <a href="#" class="booking-sidebar-menu-item">병원안내</a>
            </li>
            <li class="is-active">
                <a href="#" class="booking-sidebar-menu-item">외래진료안내</a>
                <ul class="booking-sidebar-submenu">
                    <li><a href="${pageContext.request.contextPath}/member/reservation/main.re" class="booking-sidebar-submenu-item is-active">진료예약</a></li>
                    <li><a href="${pageContext.request.contextPath}/member/procedure.bo" class="booking-sidebar-submenu-item">진료절차</a></li>
                    <li><a href="${pageContext.request.contextPath}/member/guide.bo" class="booking-sidebar-submenu-item">진료안내</a></li>
                </ul>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/member/reservation/systemReservation.re"
                   class="booking-sidebar-menu-item">검사실 예약</a>
            </li>
        </ul>
    </nav>

    <div class="booking-sidebar-contact">
        <span class="booking-sidebar-contact-label">예약문의</span>
        <span class="booking-sidebar-contact-phone">1111-1111</span>
    </div>
</main>
</body>

</html>