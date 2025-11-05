<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta charset="utf-8" />
    <title>병원 예약 시스템 - ERP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/systemReservation.css">
</head>
<body>

<main class="reservation-container">

    <section class="reservation-header">
        <h1>예약</h1>
    </section>

    <section class="reservation-rooms">
        <h2>검사실 선택</h2>
        <div class="room-list" role="group" aria-label="검사실 필터">
            <button type="button" class="room-btn active" data-room="all" aria-pressed="true">
                <span class="room-indicator"></span>
                <span class="room-name">전체</span>
            </button>
            <button type="button" class="room-btn" data-room="mri" aria-pressed="false">
                <span class="room-indicator"></span>
                <span class="room-name">MRI</span>
                <span class="room-code">(MRI-01)</span>
            </button>
            <button type="button" class="room-btn" data-room="ultrasound" aria-pressed="false">
                <span class="room-indicator"></span>
                <span class="room-name">초음파</span>
                <span class="room-code">(초음파-01)</span>
            </button>
            <button type="button" class="room-btn" data-room="ct" aria-pressed="false">
                <span class="room-indicator"></span>
                <span class="room-name">CT</span>
                <span class="room-code">(CT-01)</span>
            </button>
            <button type="button" class="room-btn" data-room="xray" aria-pressed="false">
                <span class="room-indicator"></span>
                <span class="room-name">X-Ray</span>
                <span class="room-code">(X Ray-01)</span>
            </button>
            <button type="button" class="room-btn" data-room="endoscopy" aria-pressed="false">
                <span class="room-indicator"></span>
                <span class="room-name">내시경</span>
                <span class="room-code">(내시경-01)</span>
            </button>
        </div>
    </section>

    <section class="reservation-calendar-nav">
        <button class="btn-nav" type="button" aria-label="이전 달" id="prevMonthBtn">
            <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" />
            </svg>
        </button>

        <div class="calendar-nav-selects">
            <select id="yearSelect" class="calendar-select"></select>
            <select id="monthSelect" class="calendar-select"></select>
        </div>

        <button class="btn-nav" type="button" aria-label="다음 달" id="nextMonthBtn">
            <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
            </svg>
        </button>
    </section>

    <section class="reservation-calendar">
        <header class="calendar-header" role="row">
            <div class="calendar-day sunday" role="columnheader">일</div>
            <div class="calendar-day" role="columnheader">월</div>
            <div class="calendar-day" role="columnheader">화</div>
            <div class="calendar-day" role="columnheader">수</div>
            <div class="calendar-day" role="columnheader">목</div>
            <div class="calendar-day" role="columnheader">금</div>
            <div class="calendar-day saturday" role="columnheader">토</div>
        </header>
        <div class="calendar-body" id="calendarBody" role="grid"></div>
    </section>

    <section class="reservation-legend">
        <h2>상태 안내</h2>
        <div class="legend-list">
            <div class="legend-item">
                <span class="legend-box available"></span>
                <span class="legend-text">예약 가능</span>
            </div>
            <div class="legend-item">
                <span class="legend-box full"></span>
                <span class="legend-text">예약 마감</span>
            </div>
            <div class="legend-item">
                <span class="legend-box closed"></span>
                <span class="legend-text">점검 중</span>
            </div>
            <div class="legend-item">
                <span class="legend-badge" id="todayLegendBadge"></span>
                <span class="legend-text">오늘</span>
            </div>
        </div>
    </section>

</main>

<script src="${pageContext.request.contextPath}/js/systemReservation.js"></script>

</body>
</html>