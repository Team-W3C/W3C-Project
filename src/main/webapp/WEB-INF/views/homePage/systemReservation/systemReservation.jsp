<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta charset="utf-8" />
    <title>병원 예약 시스템 - ERP</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/systemReservation/systemReservation.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/appointment-sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/index.css">

    <script>
        const contextPath = "${pageContext.request.contextPath}";
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/homePageMember/header.jsp" />

<div class="page-wrapper">

    <jsp:include page="/WEB-INF/views/common/homePageMember/appointment-sidebar.jsp"/>

    <main class="intro-container">

        <section class="reservation-header">
            <h1>예약</h1>
        </section>

        <section class="reservation-rooms">
            <h2>검사실 선택</h2>
            <div class="room-list" id="roomList" role="group" aria-label="검사실 필터">
                <button type="button" class="room-btn active" data-room="all" aria-pressed="true">
                    <span class="room-indicator"></span>
                    <span class="room-name">전체</span>
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
</div> <%-- /.page-wrapper --%>

<div class="modal-overlay" id="reservationModal">
    <div class="modal-container">
        <div class="modal-header">
            <div class="modal-title-section">
                <div class="modal-room-indicator" id="modalRoomIndicator"></div>
                <div class="modal-title-text">
                    <h2 id="modalTitle"></h2>
                    <p id="modalSubtitle"></p>
                </div>
            </div>
            <button class="modal-close-btn" id="modalCloseBtn" aria-label="닫기">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M18 6L6 18M6 6l12 12"/>
                </svg>
            </button>
        </div>

        <div class="modal-body">

            <div id="modalClosedContent" class="hidden">
                <div class="status-notice notice-closed">
                    <svg class="notice-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.33 16c-.77 1.333.192 3 1.732 3z" />
                    </svg>
                    <span class="notice-text">정기 점검 실행중입니다</span>
                </div>
                <div class="status-details">
                    <span class="details-label">점검 안내</span>
                    <p class="details-text" id="modalClosedDetailsText">
                        이 날짜는 정기 점검 일정입니다. 점검 시간 동안 예약이 불가능합니다.
                    </p>
                </div>
            </div>

            <div id="modalFullContent" class="hidden">
                <div class="status-notice notice-full">
                    <svg class="notice-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                    <span class="notice-text">예약이 마감되었습니다</span>
                </div>
                <div class="status-details">
                    <span class="details-label">마감 안내</span>
                    <p class="details-text" id="modalFullDetailsText">
                        이 날짜의 모든 예약이 마감되었습니다. 다른 날짜를 선택해 주세요.
                    </p>
                </div>
            </div>

            <div id="modalAvailableContent" class="hidden">
                <div class="availability-notice">
                    <svg class="availability-notice-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    <span class="availability-notice-text">✓ 예약 가능한 시간대가 있습니다</span>
                </div>
                <div class="time-selection-section">
                    <div class="section-label">예약 가능 시간</div>
                    <div class="time-grid" id="timeGrid">
                        <p style="color: #666; font-size: 0.9rem;">해당 날짜에 예약이 가능합니다.</p>
                    </div>
                </div>
            </div>

            <div class="facility-info-section">
                <div class="info-item">
                    <span class="info-label">시설 위치</span>
                    <span class="info-value" id="facilityLocation">-</span>
                </div>
                <div class="info-item">
                    <span class="info-label">예약 시간 단위</span>
                    <span class="info-value" id="facilityDuration">-</span>
                </div>
                <div class="info-item">
                    <span class="info-label">담당자</span>
                    <span class="info-value" id="facilityManager">-</span>
                </div>
                <div class="info-item">
                    <span class="info-label">연락처</span>
                    <span class="info-value" id="facilityContact">-</span>
                </div>
            </div>

        </div>

        <div class="modal-footer">
            <button class="modal-btn modal-btn-cancel" id="modalCancelBtn">닫기</button>
            <button class="modal-btn modal-btn-confirm hidden" id="modalConfirmBtn" disabled>예약하기</button>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/systemReservation/systemReservation.js"></script>
<jsp:include page="/WEB-INF/views/common/homePageFooter/footer.jsp" />
</body>
</html>