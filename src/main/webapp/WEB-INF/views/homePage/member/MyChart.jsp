<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 - 나의 예약 현황</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&family=Noto+Sans+KR:wght@400;500;700&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/MyChart.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ConfirmPasswordModal.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/member-sidebar.css">


    <style>
        /* ========================================
           레이아웃 수정: 헤더 바로 아래 붙도록 조정
           ======================================== */
        .mypage-container {
            /* MyChart.css의 기본 padding-top을 오버라이드하여 헤더 바로 아래 붙게 함 */
            padding-top: 20px !important;
        }

        .modal-overlay {
            display: none;
        }
        .modal-overlay.is-open {
            display: flex;
        }
        #open-password-modal {
            cursor: pointer;
        }
        body.modal-open {
            overflow: hidden;
        }

        /* 상태 배지 스타일 (완료, 취소) */
        .status-badge-inline.completed {
            background-color: #f5f5f5;
            border: 1px solid #e0e0e0;
        }
        .status-text.completed {
            color: #757575;
        }

        .status-badge-inline.cancelled {
            background-color: #ffebee;
            border: 1px solid #ffcdd2;
        }
        .status-text.cancelled {
            color: #d32f2f;
        }
        /* ▲▲▲ 상태 배지 ▲▲▲ */


        /* ▼▼▼ [예약 변경] 모달 폼 스타일 - 레이아웃 수정 ▼▼▼ */
        .edit-modal .modal-body {
            /* 모달 헤더와 푸터가 본문과 겹치지 않도록 패딩 조정 */
            padding: 10px 30px;
            max-height: 70vh; /* 모달 본문 최대 높이 지정 */
            overflow-y: auto; /* 내용이 많아지면 스크롤 가능하도록 */
        }
        .edit-form-group {
            margin-bottom: 20px;
        }
        .edit-form-group label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: #333;
            margin-bottom: 8px;
        }
        .edit-form-group select,
        .edit-form-group input,
        .edit-form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            font-family: 'Noto Sans KR', sans-serif;
            box-sizing: border-box;
        }
        .edit-form-group textarea {
            min-height: 100px;
            resize: vertical;
        }
        .edit-modal .modal-footer {
            /* ▼▼▼ [핵심 수정] 푸터를 명확히 분리 ▼▼▼ */
            padding: 15px 30px;
            border-top: 1px solid #eee;
            justify-content: flex-end; /* 버튼을 오른쪽으로 배치 */
            gap: 10px; /* 버튼 사이 간격 */
            position: sticky; /* 스크롤 되어도 푸터는 고정 (선택 사항) */
            bottom: 0;
            background-color: white;
            z-index: 10;
        }
        .edit-modal .modal-footer .btn-cancel {
            margin-right: 10px;
        }
        /* 로딩 스피너 */
        .modal-body .loading-spinner {
            display: none;
            text-align: center;
            padding: 40px 0;
        }
        .modal-body.is-loading .loading-spinner {
            display: block;
        }
        .modal-body.is-loading .edit-form {
            display: none;
        }
        /* ▲▲▲ 모달 스타일 ▲▲▲ */

        /* 1번 이미지 스타일 적용 */
        .mypage-content {
            padding-top: 0; /* 메인 콘텐츠 상단 패딩 제거 */
        }

        .chart-header {
            margin-bottom: 20px; /* 헤더 하단 간격 조정 */
            display: flex; /* 아이콘과 텍스트 정렬 */
            align-items: flex-start; /* 상단 정렬 */
            gap: 10px;
            flex-direction: column; /* 세로 정렬로 변경 */
            padding-bottom: 20px; /* 아래쪽 패딩 */
            border-bottom: 1px solid #eee; /* 아래쪽 구분선 */
        }

        .chart-header .header-icon {
            width: 24px;
            height: 24px;
            /* 아이콘 SVG 스타일 (예시) */
            fill: none;
            stroke: #333; /* 아이콘 색상 */
            stroke-width: 2;
            margin-bottom: 5px; /* 아이콘과 타이틀 간격 */
        }

        .chart-header h1 {
            color: #111; /* 타이틀 색상 변경 */
            font-size: 28px; /* 타이틀 폰트 크기 변경 */
            font-weight: 700;
            margin-bottom: 0; /* 기존 마진 제거 */
        }

        .chart-header p {
            color: #666; /* 서브타이틀 색상 변경 */
            font-size: 16px;
            margin-top: 5px; /* 타이틀과 서브타이틀 간격 */
            margin-bottom: 0;
        }

        .reservation-status .status-header {
            display: none; /* 예약 현황 섹션의 기존 헤더 숨김 */
        }

        .reservation-cards-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr); /* 3열 그리드 */
            gap: 20px; /* 카드 간 간격 */
            margin-top: 20px;
        }

        @media (max-width: 1024px) {
            .reservation-cards-grid {
                grid-template-columns: repeat(2, 1fr); /* 태블릿에서 2열 */
            }
        }
        @media (max-width: 768px) {
            .reservation-cards-grid {
                grid-template-columns: 1fr; /* 모바일에서 1열 */
            }
        }

        .reservation-card {
            padding: 20px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: none; /* 그림자 제거 */
            margin-bottom: 0; /* 그리드 간격 사용 */
            display: flex;
            flex-direction: column;
            justify-content: space-between; /* 내용과 버튼을 상하로 분리 */
            height: auto; /* 높이 자동 조정 */
        }

        .reservation-card .card-header {
            flex-direction: column; /* 세로 정렬 */
            align-items: flex-start; /* 왼쪽 정렬 */
            border-bottom: none; /* 하단 선 제거 */
            padding-bottom: 0;
            margin-bottom: 15px;
        }

        .reservation-card .card-status {
            flex-direction: row; /* 기존처럼 가로 정렬 */
            justify-content: space-between;
            width: 100%; /* 전체 너비 차지 */
            margin-bottom: 10px;
        }

        .reservation-card .status-badge-inline {
            padding: 4px 10px; /* 패딩 조정 */
            border-radius: 4px; /* 모서리 각도 조정 */
            font-size: 12px;
            gap: 4px;
            border: 1px solid; /* 테두리 추가 */
        }

        .reservation-card .status-badge-inline.confirmed {
            background-color: rgba(14, 120, 124, 0.1);
            color: #0E787C;
            border-color: #0E787C;
        }
        .reservation-card .status-badge-inline.pending {
            background-color: rgba(255, 105, 0, 0.1);
            color: #FF6900;
            border-color: #FF6900;
        }
        .reservation-card .status-badge-inline.completed { /* 진료 완료 */
            background-color: rgba(117, 117, 117, 0.1);
            color: #757575;
            border-color: #757575;
        }
        .reservation-card .status-badge-inline.cancelled { /* 예약 취소 */
            background-color: rgba(211, 47, 47, 0.1);
            color: #D32F2F;
            border-color: #D32F2F;
        }


        .reservation-card .status-icon {
            display: none; /* 아이콘 숨김 (1번 이미지에서 텍스트만 표시) */
        }

        .reservation-card .status-text {
            font-weight: 500;
        }

        .reservation-card .reservation-type {
            display: none; /* 예약 타입 숨김 (1번 이미지에서 없음) */
        }

        .reservation-card .card-actions {
            justify-content: flex-end; /* 버튼 오른쪽 정렬 */
            margin-top: 15px; /* 버튼 위 간격 */
        }

        .reservation-card .btn {
            padding: 8px 16px;
            font-size: 13px;
            border-radius: 6px;
        }

        .reservation-card .card-details {
            display: block; /* 그리드 해제 */
            margin-bottom: 15px;
        }

        .reservation-card .detail-item {
            margin-bottom: 10px; /* 각 항목 간 간격 */
            align-items: flex-start; /* 아이콘과 텍스트 시작점 정렬 */
        }

        .reservation-card .detail-icon {
            width: 20px; /* 아이콘 크기 조정 */
            height: 20px;
            background-color: transparent; /* 배경색 제거 */
        }

        .reservation-card .detail-icon svg {
            width: 100%;
            height: 100%;
        }
        .reservation-card .detail-icon.teal svg path,
        .reservation-card .detail-icon.teal svg circle {
            stroke: #0E787C; /* 아이콘 색상 변경 */
        }
        .reservation-card .detail-icon.blue svg rect,
        .reservation-card .detail-icon.blue svg path,
        .reservation-card .detail-icon.blue svg circle {
            stroke: #495565; /* 아이콘 색상 변경 */
        }


        .reservation-card .detail-info h4 {
            font-size: 14px;
            color: #111;
            font-weight: 500;
            margin-bottom: 2px;
        }

        .reservation-card .detail-info p {
            font-size: 15px;
            color: #495565;
        }

        .reservation-card .location-info {
            background: none; /* 배경색 제거 */
            padding: 0;
            margin-top: 15px;
            border-top: 1px solid #eee; /* 구분선 추가 */
            padding-top: 15px;
        }
        .reservation-card .location-info .location-icon svg path,
        .reservation-card .location-info .location-icon svg circle {
            stroke: #495565; /* 아이콘 색상 변경 */
        }
        .reservation-card .location-text h4 {
            color: #111;
            font-weight: 500;
        }
        .reservation-card .location-text p {
            color: #495565;
        }
    </style>

</head>

<body>
<jsp:include page="../../common/homePageMember/header.jsp"/>

<main class="mypage-container">
    <%-- 사이드바 포함 --%>
    <jsp:include page="../../common/homePageMember/member-sidebar.jsp"/>

    <section class="mypage-content">
        <header class="chart-header">
            <svg class="header-icon" viewBox="0 0 24 24">
                <path d="M12 2C6.47 2 2 6.47 2 12C2 17.53 6.47 22 12 22C17.53 22 22 17.53 22 12C22 6.47 17.53 2 12 2ZM11 15H13V17H11V15ZM11 7H13V13H11V7Z"/>
            </svg>
            <div>
                <h1>나의 예약 현황</h1>
                <p>현재 예약하신 내역을 한눈에 확인하고 변경 및 취소할 수 있습니다.</p>
            </div>
        </header>

        <%-- 예약 현황 섹션 --%>
        <section class="reservation-status">
            <c:choose>
                <%-- 1. 예약 목록이 비어있을 때 (empty) --%>
                <c:when test="${empty reservationList}">
                    <article class="reservation-card">
                        <p style="text-align: center; padding: 20px;">예약 현황이 없습니다.</p>
                    </article>
                </c:when>

                <%-- 2. 예약 목록이 있을 때 (otherwise) --%>
                <c:otherwise>
                    <div class="reservation-cards-grid">
                        <c:forEach var="reservation" items="${reservationList}">

                            <article class="reservation-card" data-reservation-no="${reservation.reservationNo}">
                                <div class="card-header">
                                    <div class="card-status">
                                        <div class="status-badge-inline
                                            <c:choose>
                                                <c:when test="${reservation.status == 'CONFIRMED'}">confirmed</c:when>
                                                <c:when test="${reservation.status == 'PENDING'}">pending</c:when>
                                                <c:when test="${reservation.status == 'COMPLETED'}">completed</c:when>
                                                <c:when test="${reservation.status == 'CANCELLED'}">cancelled</c:when>
                                            </c:choose>">
                                            <span class="status-text
                                                <c:choose>
                                                    <c:when test="${reservation.status == 'CONFIRMED'}">confirmed</c:when>
                                                    <c:when test="${reservation.status == 'PENDING'}">pending</c:when>
                                                    <c:when test="${reservation.status == 'COMPLETED'}">completed</c:when>
                                                    <c:when test="${reservation.status == 'CANCELLED'}">cancelled</c:when>
                                                </c:choose>">
                                                <c:choose>
                                                    <c:when test="${reservation.status == 'CONFIRMED'}">예약 확정</c:when>
                                                    <c:when test="${reservation.status == 'PENDING'}">예약 대기</c:when>
                                                    <c:when test="${reservation.status == 'COMPLETED'}">진료 완료</c:when>
                                                    <c:when test="${reservation.status == 'CANCELLED'}">예약 취소</c:when>
                                                </c:choose>
                                            </span>
                                        </div>
                                            <%-- 진료 날짜를 상태 옆에 배치 --%>
                                        <p style="font-size: 14px; color: #495565; font-weight: 500;">${reservation.date}</p>
                                    </div>

                                        <%-- 진료과 정보 (1번 이미지처럼 배치) --%>
                                    <h4 style="font-size: 16px; color: #111; font-weight: 700; margin-top: 10px;">${reservation.departmentName}</h4>
                                </div>

                                <div class="card-details">
                                        <%-- 담당의사 --%>
                                    <div class="detail-item">
                                        <div class="detail-icon teal">
                                            <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                                                <circle cx="10" cy="7" r="3" stroke="#0E787C" stroke-width="1.67"/>
                                                <path d="M5 17C5 13.5 7 11 10 11C13 11 15 13.5 15 17" stroke="#0E787C" stroke-width="1.67"/>
                                            </svg>
                                        </div>
                                        <div class="detail-info">
                                            <h4>담당의사</h4>
                                            <p>${reservation.doctorName}</p>
                                        </div>
                                    </div>

                                        <%-- 진료 시간 --%>
                                    <div class="detail-item">
                                        <div class="detail-icon blue">
                                            <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                                                <circle cx="10" cy="10" r="8" stroke="#155DFC" stroke-width="1.67"/>
                                                <path d="M10 6V10L13 13" stroke="#155DFC" stroke-width="1.67"/>
                                            </svg>
                                        </div>
                                        <div class="detail-info">
                                            <h4>진료 시간</h4>
                                            <p>${reservation.time}</p>
                                        </div>
                                    </div>

                                        <%-- 증상 (예약 노트) --%>
                                    <div class="detail-item">
                                        <div class="detail-icon blue">
                                            <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                                                <path d="M17 10C17 13.866 13.866 17 10 17C6.13401 17 3 13.866 3 10C3 6.13401 6.13401 3 10 3C13.866 3 17 6.13401 17 10Z" stroke="#155DFC" stroke-width="1.67" stroke-linecap="round" stroke-linejoin="round"/>
                                                <path d="M8 10H8.01M12 10H12.01" stroke="#155DFC" stroke-width="1.67" stroke-linecap="round" stroke-linejoin="round"/>
                                            </svg>
                                        </div>
                                        <div class="detail-info">
                                            <h4>증상</h4>
                                            <p>${reservation.reservationNotes != null && reservation.reservationNotes != '' ? reservation.reservationNotes : '입력된 증상 없음'}</p>
                                        </div>
                                    </div>

                                </div>

                                    <%-- 변경/취소 버튼 --%>
                                <div class="card-actions">
                                    <c:if test="${reservation.status == 'CONFIRMED' || reservation.status == 'PENDING'}">
                                        <button class="btn btn-secondary btn-edit">변경</button>
                                        <button class="btn btn-outline btn-cancel">취소</button>
                                    </c:if>
                                </div>
                            </article>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>

        </section>

        <%-- 본인인증 및 비밀번호 변경 섹션은 주석 처리된 상태를 유지합니다. --%>

    </section>
</main>

<%-- 비밀번호 확인 모달 --%>
<div class="modal-overlay password-modal-overlay">
    <div class="password-modal">
        <button type="button" class="modal-close" aria-label="닫기">
            ×
        </button>

        <header class="modal-header">
            <h2 class="modal-title">회원 정보</h2>
            <p class="modal-subtitle">회원 정보를 보시려면 비밀번호를 입력하여 주세요</p>
        </header>

        <div class="modal-body">
            <form class="password-form">
                <div class="info-box">
                    <div class="info-header">회원 정보</div>
                    <div class="info-text">회원 정보를 보시려면 비밀번호를 입력하여 주세요</div>
                </div>

                <div class="field-box">
                    <div class="field-icon">
                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                            <path d="M5 16C5 13.5 7 11 10 11C13 11 15 13.5 15 16" stroke="#0E787C" stroke-width="1.67"/>
                            <circle cx="10" cy="6" r="3" stroke="#0E787C" stroke-width="1.67"/>
                        </svg>
                    </div>
                    <div class="field-info">
                        <div class="field-label">성함</div>
                        <div class="field-value">${sessionScope.loginMember.memberName}</div>
                    </div>
                </div>

                <div class="field-box password-box">
                    <input type="password" id="password" class="password-input" placeholder="비밀번호를 입력하세요" required>
                    <button type="submit" class="btn-confirm">확인</button>
                </div>
                <p id="password-error-message" style="color: red; text-align: center; margin-top: 10px; display: none;"></p>
            </form>
        </div>

        <footer class="modal-footer">
            <button type="button" class="btn-cancel">취소</button>
        </footer>
    </div>
</div>


<%-- 예약 변경 모달 --%>
<div class="modal-overlay edit-modal-overlay" data-current-rno="">
    <div class="password-modal edit-modal">
        <button type="button" class="modal-close" aria-label="닫기">
            ×
        </button>

        <header class="modal-header">
            <h2 class="modal-title">예약 변경</h2>
            <p class="modal-subtitle">예약 정보를 수정 후 '저장' 버튼을 눌러주세요.</p>
        </header>

        <div class="modal-body">
            <div class="loading-spinner">
                <p>예약 정보를 불러오는 중입니다...</p>
            </div>

            <form class="edit-form" id="edit-reservation-form">

                <input type="hidden" id="edit-reservation-no" name="reservationNo">

                <div class="edit-form-group">
                    <label for="edit-dept">진료과</label>
                    <select id="edit-dept" name="departmentNo" required>
                        <option value="">진료과를 선택하세요</option>
                    </select>
                </div>

                <div class="edit-form-group">
                    <label for="edit-datetime">예약 일시</label>
                    <input type="datetime-local" id="edit-datetime" name="treatmentDate" required>
                </div>

                <div class="edit-form-group">
                    <label for="edit-doctor">담당의</label>
                    <input type="text" id="edit-doctor" name="doctorName" placeholder="담당의 이름을 입력하세요">
                </div>

                <div class="edit-form-group">
                    <label for="edit-notes">증상</label>
                    <textarea id="edit-notes" name="reservationNotes" placeholder="증상을 입력해주세요."></textarea>
                </div>

            </form>
        </div>

        <footer class="modal-footer">
            <button type="button" class="btn-cancel">취소</button>
            <button type="submit" form="edit-reservation-form" class="btn-confirm btn-primary">저장</button>
        </footer>
    </div>
</div>
<jsp:include page="../../common/homePageFooter/footer.jsp"/>
<script>
    const contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/MyChart.js" defer></script>

</body>
</html>