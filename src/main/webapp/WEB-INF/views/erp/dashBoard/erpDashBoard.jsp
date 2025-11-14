<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                <span class="stat-card__badge stat-card__badge--positive">+12%</span>
            </div>
            <p class="stat-card__label">오늘 예약</p>
            <p class="stat-card__value">${getTodayReservationCount}건</p>
        </article>

        <article class="stat-card stat-card--sky">
            <div class="stat-card__header">
                <div class="stat-card__icon stat-card__icon--sky">
                    <img class="img" src="https://c.animaapp.com/mhegd33xAGdRVb/img/container-3.svg"/>
                </div>
                <span class="stat-card__badge stat-card__badge--negative">-5%</span>
            </div>
            <p class="stat-card__label">대기 환자</p>
            <p class="stat-card__value">${getStandbyPatient}명</p>
        </article>

        <article class="stat-card stat-card--amber">
            <div class="stat-card__header">
                <div class="stat-card__icon stat-card__icon--amber">
                    <img class="img" src="https://c.animaapp.com/mhegd33xAGdRVb/img/container-1.svg"/>
                </div>
                <span class="stat-card__badge stat-card__badge--positive">+8%</span>
            </div>
            <p class="stat-card__label">장비 가동률</p>
            <p class="stat-card__value"><fmt:formatNumber value="${getEquipmentUtilizationRate}" pattern="#.##" />%</p>
        </article>
    </section>

    <!-- 차트 섹션 -->
    <section class="dashboard-charts">
        <article class="chart-card">
            <h2 class="chart-card__title">주간 예약 현황</h2>
            <div class="chart-card__content">
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
                    <span class="legend-item__value">60%</span>
                </li>
                <li class="legend-item">
                    <div class="legend-item__info">
                        <span class="legend-item__dot legend-item__dot--sky"></span>
                        <span class="legend-item__label">우선예약</span>
                    </div>
                    <span class="legend-item__value">25%</span>
                </li>
                <li class="legend-item">
                    <div class="legend-item__info">
                        <span class="legend-item__dot legend-item__dot--amber"></span>
                        <span class="legend-item__label">VIP</span>
                    </div>
                    <span class="legend-item__value">15%</span>
                </li>
            </ul>
        </article>

        <!-- 최근 예약 -->
        <article class="reservation-card">
            <h2 class="reservation-card__title">최근 예약</h2>
            <ul class="reservation-list">
                <li class="reservation-item">
                    <div class="reservation-item__user">
                        <div class="reservation-item__avatar">김</div>
                        <div class="reservation-item__info">
                            <p class="reservation-item__name">김민수</p>
                            <p class="reservation-item__dept">정형외과</p>
                        </div>
                    </div>
                    <div class="reservation-item__status">
                        <span class="reservation-item__time">10:00</span>
                        <span class="reservation-badge reservation-badge--confirmed">예약확정</span>
                    </div>
                </li>
                <li class="reservation-item">
                    <div class="reservation-item__user">
                        <div class="reservation-item__avatar">이</div>
                        <div class="reservation-item__info">
                            <p class="reservation-item__name">이영희</p>
                            <p class="reservation-item__dept">내과</p>
                        </div>
                    </div>
                    <div class="reservation-item__status">
                        <span class="reservation-item__time">10:30</span>
                        <span class="reservation-badge reservation-badge--waiting">대기중</span>
                    </div>
                </li>
                <li class="reservation-item">
                    <div class="reservation-item__user">
                        <div class="reservation-item__avatar">박</div>
                        <div class="reservation-item__info">
                            <p class="reservation-item__name">박철수</p>
                            <p class="reservation-item__dept">신경외과</p>
                        </div>
                    </div>
                    <div class="reservation-item__status">
                        <span class="reservation-item__time">11:00</span>
                        <span class="reservation-badge reservation-badge--confirmed">예약확정</span>
                    </div>
                </li>
                <li class="reservation-item">
                    <div class="reservation-item__user">
                        <div class="reservation-item__avatar">정</div>
                        <div class="reservation-item__info">
                            <p class="reservation-item__name">정수연</p>
                            <p class="reservation-item__dept">이비인후과</p>
                        </div>
                    </div>
                    <div class="reservation-item__status">
                        <span class="reservation-item__time">11:30</span>
                        <span class="reservation-badge reservation-badge--confirmed">예약확정</span>
                    </div>
                </li>
                <li class="reservation-item">
                    <div class="reservation-item__user">
                        <div class="reservation-item__avatar">한</div>
                        <div class="reservation-item__info">
                            <p class="reservation-item__name">한지민</p>
                            <p class="reservation-item__dept">피부과</p>
                        </div>
                    </div>
                    <div class="reservation-item__status">
                        <span class="reservation-item__time">14:00</span>
                        <span class="reservation-badge reservation-badge--waiting">대기중</span>
                    </div>
                </li>
            </ul>
        </article>
    </section>
</main>

<script src="${pageContext.request.contextPath}/js/erp/dashBoard/erpDashBoard.js"></script>
</body>
</html>