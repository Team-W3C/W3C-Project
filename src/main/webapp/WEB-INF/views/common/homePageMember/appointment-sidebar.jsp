<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/appointment-sidebar.css">
    <title>Document</title>
</head>

<body>

<%-- 현재 페이지 URI 가져오기 --%>
<c:set var="currentURI" value="${pageContext.request.requestURI}" />

<c:set var="isDetailActive" value="${fn:contains(currentURI, '/detail')}" />
<c:set var="isMainActive" value="${fn:contains(currentURI, '/reservation/main')}" />
<c:set var="isProcedureActive" value="${fn:contains(currentURI, '/procedure')}" />
<c:set var="isGuideActive" value="${fn:contains(currentURI, '/guide')}" />
<c:set var="isSystemActive" value="${fn:contains(currentURI, '/systemReservation')}" />

<%-- 외래진료안내 부모 메뉴 활성화 여부 --%>
<c:set var="isOutpatientActive" value="${isMainActive or isProcedureActive or isGuideActive}" />

<main class="booking-sidebar">
    <h1 class="booking-sidebar-title">진료예약/안내</h1>

    <nav class="booking-sidebar-nav">
        <ul class="booking-sidebar-menu">
            <%-- 병원안내 --%>
            <li class="${isDetailActive ? 'is-active' : ''}">
                <a href="${pageContext.request.contextPath}/detail" class="booking-sidebar-menu-item">병원안내</a>
            </li>

            <%-- 외래진료안내 --%>
            <li class="${isOutpatientActive ? 'is-active' : ''}">
                <a href="${pageContext.request.contextPath}/member/reservation/main" class="booking-sidebar-menu-item">외래진료안내</a>
                <ul class="booking-sidebar-submenu">
                    <li>
                        <a href="${pageContext.request.contextPath}/member/reservation/main"
                           class="booking-sidebar-submenu-item ${isMainActive ? 'is-active' : ''}">진료예약</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/member/procedure"
                           class="booking-sidebar-submenu-item ${isProcedureActive ? 'is-active' : ''}">예약절차</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/member/guide"
                           class="booking-sidebar-submenu-item ${isGuideActive ? 'is-active' : ''}">진료안내</a>
                    </li>
                </ul>
            </li>

            <%-- 검사실 예약현황 --%>
            <li class="${isSystemActive ? 'is-active' : ''}">
                <a href="${pageContext.request.contextPath}/member/reservation/systemReservation"
                   class="booking-sidebar-menu-item">검사실 예약현황</a>
            </li>
        </ul>
    </nav>

    <div class="booking-sidebar-contact">
        <span class="booking-sidebar-contact-label">예약문의</span>
        <span class="booking-sidebar-contact-phone">1111-2222</span>
    </div>
</main>
</body>

</html>