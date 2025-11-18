<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta charset="utf-8" />
    <title>병원 예약 시스템 - ERP</title>

    <!-- FullCalendar CDN -->
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.19/main.min.css' rel='stylesheet' />
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.19/index.global.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.19/locales/ko.js'></script>


    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/systemReservation/systemReservationEmployee.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/erpCommon/erpHeader.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/erpCommon/erpSidebar.css">

    <script>
        // JS 전역 변수로 contextPath를 선언
        const gContextPath = "${pageContext.request.contextPath}";
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/erp/header.jsp" />
<jsp:include page="/WEB-INF/views/common/erp/sidebar.jsp" />

<body>
<<!-- 시설 예약 관리 페이지 -->
<main class="reservation-main">
    <!-- 페이지 헤더 -->
    <header class="reservation-header">
        <h1>시설 예약 관리</h1>
    </header>

    <!-- 검사실 선택 -->
    <section class="reservation-card">
        <h2>검사실 선택</h2>
        <div class="room-list">
            <button class="room-btn active" data-room="all" data-facility-no="" type="button">
                <span>전체</span>
            </button>
            <button class="room-btn" data-room="mri" data-facility-no="1" type="button">
                <span class="room-indicator mri"></span>
                <div>
                    <span>MRI</span>
                    <span class="room-code">(MRI-01)</span>
                </div>
            </button>
            <button class="room-btn" data-room="ct" data-facility-no="2" type="button">
                <span class="room-indicator ct"></span>
                <div>
                    <span>CT</span>
                    <span class="room-code">(CT-01)</span>
                </div>
            </button>
            <button class="room-btn" data-room="ultrasound" data-facility-no="3" type="button">
                <span class="room-indicator ultrasound"></span>
                <div>
                    <span>초음파</span>
                    <span class="room-code">(초음파-01)</span>
                </div>
            </button>
            <button class="room-btn" data-room="xray" data-facility-no="5" type="button">
                <span class="room-indicator xray"></span>
                <div>
                    <span>X-Ray</span>
                    <span class="room-code">(X Ray-01)</span>
                </div>
            </button>
            <button class="room-btn" data-room="endoscopy" data-facility-no="7" type="button">
                <span class="room-indicator endoscopy"></span>
                <div>
                    <span>내시경</span>
                    <span class="room-code">(내시경-01)</span>
                </div>
            </button>
        </div>
    </section>

    <!-- 예약 가능 항목 -->
    <section class="reservation-card">
        <h2>예약 가능 항목</h2>
        <div class="draggable-events" id="external-events">
            <div class="fc-event" data-room="mri" data-facility-no="1" data-title="MRI 가능">
                <span class="event-indicator mri"></span>
                <span>MRI 가능</span>
            </div>
            <div class="fc-event" data-room="ct" data-facility-no="5" data-title="CT 가능">
                <span class="event-indicator ct"></span>
                <span>CT 가능</span>
            </div>
            <div class="fc-event" data-room="xray" data-facility-no="2" data-title="X-ray 가능">
                <span class="event-indicator xray"></span>
                <span>X-ray 가능</span>
            </div>
            <div class="fc-event" data-room="ultrasound" data-facility-no="4" data-title="초음파 가능">
                <span class="event-indicator ultrasound"></span>
                <span>초음파 가능</span>
            </div>
            <div class="fc-event" data-room="endoscopy" data-facility-no="3" data-title="내시경 가능">
                <span class="event-indicator endoscopy"></span>
                <span>내시경 가능</span>
            </div>
        </div>
    </section>

    <!-- 달력 네비게이션 -->
    <section class="reservation-card">
        <nav class="calendar-nav">
            <!-- 년도 선택 -->
            <div class="year-selector">
                <button class="btn-nav" id="prevYear" type="button" title="이전 년도">
                    <svg width="20" height="20" fill="none" viewBox="0 0 20 20">
                        <path d="M15 15L10 10L15 5M10 15L5 10L10 5" stroke="currentColor" stroke-width="2"
                              stroke-linecap="round" stroke-linejoin="round" />
                    </svg>
                </button>
                <span class="year-display" id="currentYear">2025년</span>
                <button class="btn-nav" id="nextYear" type="button" title="다음 년도">
                    <svg width="20" height="20" fill="none" viewBox="0 0 20 20">
                        <path d="M5 15L10 10L5 5M10 15L15 10L10 5" stroke="currentColor" stroke-width="2"
                              stroke-linecap="round" stroke-linejoin="round" />
                    </svg>
                </button>
            </div>

            <!-- 월 선택 -->
            <div class="calendar-nav-controls">
                <button class="btn-nav" id="prevMonth" type="button" title="이전 달">
                    <svg width="20" height="20" fill="none" viewBox="0 0 20 20">
                        <path d="M12.5 15L7.5 10L12.5 5" stroke="currentColor" stroke-width="2"
                              stroke-linecap="round" stroke-linejoin="round" />
                    </svg>
                </button>
                <span class="calendar-current-date" id="currentMonth">11월</span>
                <button class="btn-nav" id="nextMonth" type="button" title="다음 달">
                    <svg width="20" height="20" fill="none" viewBox="0 0 20 20">
                        <path d="M7.5 15L12.5 10L7.5 5" stroke="currentColor" stroke-width="2"
                              stroke-linecap="round" stroke-linejoin="round" />
                    </svg>
                </button>
            </div>

            <!-- Today 버튼 -->
            <div class="today-wrapper">
                <button class="btn-today" id="todayBtn" type="button">
                    <svg width="16" height="16" fill="none" viewBox="0 0 16 16">
                        <path
                                d="M5.333 1.333V4M10.667 1.333V4M2 6.667h12M3.333 2.667h9.334c.736 0 1.333.597 1.333 1.333v9.333c0 .737-.597 1.334-1.333 1.334H3.333A1.333 1.333 0 012 13.333V4c0-.736.597-1.333 1.333-1.333z"
                                stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                stroke-linejoin="round" />
                    </svg>
                    <span>오늘</span>
                </button>
            </div>
        </nav>
    </section>

    <!-- 달력 -->
    <section class="reservation-card">
        <div id="calendar"></div>
    </section>

    <!-- 상태 안내 -->
    <section class="reservation-card">
        <h2>상태 안내</h2>
        <div class="legend-list">
            <div class="legend-item">
                <div class="legend-box available"></div>
                <span class="legend-text">예약 가능</span>
            </div>
            <div class="legend-item">
                <div class="legend-box full"></div>
                <span class="legend-text">예약 마감</span>
            </div>
            <div class="legend-item">
                <div class="legend-box closed"></div>
                <span class="legend-text">운영 중단</span>
            </div>
            <div class="legend-item">
                <div class="legend-box completed"></div>
                <span class="legend-text">완료</span>
            </div>
            <div class="legend-item">
                <span class="legend-badge">T</span>
                <span class="legend-text">오늘</span>
            </div>
        </div>
    </section>

    <!-- 모달 -->
    <div class="modal-overlay" id="reservationModal">
        <div class="modal-container">
            <div class="modal-header">
                <div class="modal-title-section">
                    <div class="modal-room-indicator" id="modalRoomIndicator"></div>
                    <div class="modal-title-text">
                        <h2 id="modalTitle">MRI 예약</h2>
                        <p id="modalDate">2025년 11월 1일 (금)</p>
                    </div>
                </div>
                <button class="modal-close-btn" id="closeModal" type="button">
                    <svg width="24" height="24" fill="none" viewBox="0 0 24 24">
                        <path d="M18 6L6 18M6 6l12 12" stroke="currentColor" stroke-width="2"
                              stroke-linecap="round" />
                    </svg>
                </button>
            </div>

            <div class="modal-body">
                <div id="statusNotice"></div>

                <div class="time-selection-section" id="timeSelection">
                    <label class="section-label">예약 시간 선택</label>
                    <div class="time-grid" id="timeGrid"></div>
                </div>

                <!-- ✅ 예약 메모 입력 영역 추가 -->
                <div class="memo-section" id="memoSection">
                    <label class="section-label">예약 정보 입력</label>
                    <div class="memo-grid">
                        <!-- ✅ 환자 선택 드롭다운 추가 -->
                        <div class="memo-item" style="grid-column: 1 / -1;">
                            <span class="info-label">환자 선택 <span style="color: red;">*</span></span>
                            <select id="patientSelect" class="patient-select">
                                <option value="">환자를 선택해주세요</option>
                            </select>
                        </div>

                        <div class="memo-item">
                            <span class="info-label">예약 내용 (Notes)</span>
                            <textarea id="reservationNotes" class="memo-textarea"
                                      placeholder="예: 검사 목적, 주의사항 등을 입력하세요."></textarea>
                        </div>
                        <div class="memo-item">
                            <span class="info-label">내부 메모 (Memo)</span>
                            <textarea id="reservationMemo" class="memo-textarea"
                                      placeholder="직원 전용 메모를 입력하세요."></textarea>
                        </div>
                    </div>
                </div>

                <div class="facility-info-section">
                    <div class="info-item">
                        <span class="info-label">시설명</span>
                        <span class="info-value" id="facilityName">MRI (MRI-01)</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">운영 시간</span>
                        <span class="info-value" id="operatingHours">09:00 - 18:00</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">예약 단위</span>
                        <span class="info-value" id="reservationUnit">1시간</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">담당자</span>
                        <span class="info-value" id="manager">김담당</span>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button class="modal-btn modal-btn-delete hidden" id="deleteBtn" type="button">
                    <svg width="16" height="16" fill="none" viewBox="0 0 16 16" style="margin-right: 4px;">
                        <path
                                d="M2 4h12M5.333 4V2.667a1.333 1.333 0 011.334-1.334h2.666a1.333 1.333 0 011.334 1.334V4m2 0v9.333a1.333 1.333 0 01-1.334 1.334H4.667a1.333 1.333 0 01-1.334-1.334V4h9.334z"
                                stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                stroke-linejoin="round" />
                    </svg>
                    삭제
                </button>
                <button class="modal-btn modal-btn-cancel" id="cancelBtn" type="button">취소</button>
                <button class="modal-btn modal-btn-confirm hidden" id="confirmBtn" type="button">예약 확인</button>
            </div>
        </div>
    </div>
</main>
<script src="${pageContext.request.contextPath}/js/systemReservation/systemReservationEmployee.js"></script>
</body>
</html>