<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 대시보드 페이지 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>병원 ERP 시스템 대시보드</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashBoard/erpDashBoard.css">
</head>
<body>
<!-- Header Include -->
<jsp:include page="/WEB-INF/views/common/erp/header.jsp"/>

<!-- sidebar Include -->
<jsp:include page="/WEB-INF/views/common/erp/sidebar.jsp"/>

<main class="dashboard-main">
    <!-- 페이지 타이틀 -->
    <section class="dashboard-header">
        <h1 class="dashboard-title">대시보드</h1>
    </section>

    <!-- 통계 카드 섹션 -->
    <section class="dashboard-stats">
        <article class="stat-card stat-card--primary">
            <div class="stat-card__header">
                <div class="stat-card__icon stat-card__icon--primary">
                    <img class="img" src="https://c.animaapp.com/mhegd33xAGdRVb/img/container.svg"/>
                </div>
                <c:choose>
                <c:when test="${getReservationIncreaseRate>0}">
                <span class="stat-card__badge stat-card__badge--positive">
                            +<fmt:formatNumber value="${getReservationIncreaseRate}" pattern="#.##"/>%
                        </c:when>
                        <c:when test="${getReservationIncreaseRate<0}">
                    <span class="stat-card__badge stat-card__badge--negative">
                        <fmt:formatNumber value="${getReservationIncreaseRate}" pattern="#.##"/>%
                        </c:when>
                    </c:choose>
                </span>
            </div>
            <p class="stat-card__label">오늘 예약</p>
            <p class="stat-card__value">${getTodayReservationCount}건</p>
        </article>

        <article class="stat-card stat-card--sky">
            <div class="stat-card__header">
                <div class="stat-card__icon stat-card__icon--sky">
                    <img class="img" src="https://c.animaapp.com/mhegd33xAGdRVb/img/container-3.svg"/>
                </div>
                <span class="stat-card__badge stat-card__badge--positive">
                    완료율: <fmt:formatNumber value="${getStandbyPatientIncreaseRate}" pattern="#.##"/>%
                </span>
            </div>
            <p class="stat-card__label">대기 환자</p>
            <p class="stat-card__value">${getStandbyPatient}명</p>
        </article>

        <article class="stat-card stat-card--amber">
            <div class="stat-card__header">
                <div class="stat-card__icon stat-card__icon--amber">
                    <img class="img" src="https://c.animaapp.com/mhegd33xAGdRVb/img/container-1.svg"/>
                </div>
                <span class="stat-card__badge stat-card__badge--positive">
                    완료율: <fmt:formatNumber value="${getEquipmentUtilizationIncreaseRate}" pattern="#.##"/>%
                </span>
            </div>
            <p class="stat-card__label">장비 가동률</p>
            <p class="stat-card__value"><fmt:formatNumber value="${getEquipmentUtilizationRate}" pattern="#.##"/>%</p>
        </article>
    </section>

    <!-- 차트 섹션 -->
    <section class="dashboard-charts">
        <article class="chart-card">
            <h2 class="chart-card__title">주간 예약 현황</h2>
            <div class="chart-card__content ">
                <canvas id="weeklyChart" width="503" height="250"></canvas>
            </div>
        </article>

        <article class="chart-card">
            <h2 class="chart-card__title">장비 이용률</h2>
            <div class="chart-card__content">
                <canvas id="equipmentChart" width="503" height="250"></canvas>
            </div>
        </article>
    </section>

    <!-- 하단 섹션 -->
    <section class="dashboard-bottom">
        <!-- 환자 등급 분포 -->
        <article class="distribution-card">
            <h2 class="distribution-card__title">환자 등급 분포</h2>
            <div class="distribution-card__chart">
                <canvas id="patientChart" width="311" height="200"></canvas>
            </div>
            <ul class="distribution-card__legend">
                <li class="legend-item">
                    <div class="legend-item__info">
                        <span class="legend-item__dot legend-item__dot--gray"></span>
                        <span class="legend-item__label">일반</span>
                    </div>
                    <span class="legend-item__value nomarl_val">60%</span>
                </li>
                <li class="legend-item">
                    <div class="legend-item__info">
                        <span class="legend-item__dot legend-item__dot--sky"></span>
                        <span class="legend-item__label">우선예약</span>
                    </div>
                    <span class="legend-item__value first_val">25%</span>
                </li>
                <li class="legend-item">
                    <div class="legend-item__info">
                        <span class="legend-item__dot legend-item__dot--amber"></span>
                        <span class="legend-item__label vip_val">VIP</span>
                    </div>
                    <span class="legend-item__value">15%</span>
                </li>
            </ul>
        </article>

        <!-- 최근 예약 -->
        <article class="reservation-card">
            <h2 class="reservation-card__title">최근 예약</h2>
            <ul class="reservation-list">
                <c:forEach var="reservation" items="${recentReservations}" varStatus="status">
                    <c:if test="${status.index < 5}">
                        <li class="reservation-item">
                            <div class="reservation-item__user">
                                <div class="reservation-item__avatar">${fn:substring(reservation.memberName, 0, 1)}</div>
                                <div class="reservation-item__info">
                                    <p class="reservation-item__name">${reservation.memberName}</p>
                                    <p class="reservation-item__dept">${reservation.departmentName}</p>
                                </div>
                            </div>
                            <div class="reservation-item__status">
                                <span class="reservation-item__time">${reservation.treatmentDate}</span>
                                <c:choose>
                                    <c:when test="${reservation.reservationStatus == '대기'||reservation.reservationStatus == '확정' || reservation.reservationStatus == '진행중'}">
                                        <span class="reservation-badge reservation-badge--waiting">예약 대기</span>
                                    </c:when>
                                    <c:when test="${reservation.reservationStatus == '완료'}">
                                        <span class="reservation-badge reservation-badge--confirmed">완료</span>
                                    </c:when>
                                </c:choose>
                            </div>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
        </article>
    </section>
</main>

<script src="${pageContext.request.contextPath}/js/erp/dashBoard/erpDashBoard.js"></script>
</body>
</html>