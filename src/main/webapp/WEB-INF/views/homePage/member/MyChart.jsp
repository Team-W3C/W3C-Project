<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&family=Noto+Sans+KR:wght@400;500;700&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/MyChart.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ConfirmPasswordModal.css">

    <style>
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

    </style>

</head>

<body>
<jsp:include page="../../common/homePageMember/header.jsp"/>

<main class="mypage-container">
    <jsp:include page="/WEB-INF/views/common/homePageMember/member-sidebar.jsp" />


    <section class="mypage-content">
        <header class="chart-header">
            <h1>나의 차트</h1>
            <p>예약 현황을 한눈에 확인하세요</p>
        </header>

        <section class="reservation-status">
            <div class="status-header">
                <div class="status-title">
                    <h2>예약 현황</h2>
                </div>
                <span class="status-badge">총 ${fn:length(reservationList)}건</span>
            </div>

            <c:choose>
                <%-- 1. 예약 목록이 비어있을 때 (empty) --%>
                <c:when test="${empty reservationList}">
                    <article class="reservation-card">
                        <p style="text-align: center; padding: 20px;">예약 현황이 없습니다.</p>
                    </article>
                </c:when>

                <%-- 2. 예약 목록이 있을 때 (otherwise) --%>
                <c:otherwise>
                    <c:forEach var="reservation" items="${reservationList}">

                        <article class="reservation-card" data-reservation-no="${reservation.reservationNo}">
                            <div class="card-header">
                                <div class="card-status">
                                    <c:choose>
                                        <c:when test="${reservation.status == 'CONFIRMED'}">
                                            <div class="status-badge-inline confirmed">
                                                <div class="status-icon check"></div>
                                                <span class="status-text confirmed">예약 확정</span>
                                            </div>
                                        </c:when>
                                        <c:when test="${reservation.status == 'PENDING'}">
                                            <div class="status-badge-inline pending">
                                                <div class="status-icon warning"></div>
                                                <span class="status-text pending">예약 대기</span>
                                            </div>
                                        </c:when>
                                        <c:when test="${reservation.status == 'COMPLETED'}">
                                            <div class="status-badge-inline completed">
                                                <div class="status-icon check"></div>
                                                <span class="status-text completed">진료 완료</span>
                                            </div>
                                        </c:when>
                                        <c:when test="${reservation.status == 'CANCELLED'}">
                                            <div class="status-badge-inline cancelled">
                                                <div class="status-icon warning"></div>
                                                <span class="status-text cancelled">예약 취소</span>
                                            </div>
                                        </c:when>
                                    </c:choose>
                                    <span class="reservation-type">${reservation.type}</span>
                                </div>

                                <div class="card-actions">
                                    <c:if test="${reservation.status == 'CONFIRMED' || reservation.status == 'PENDING'}">
                                        <button class="btn btn-secondary btn-edit">변경</button>
                                        <button class="btn btn-outline btn-cancel">취소</button>
                                    </c:if>
                                </div>
                            </div>

                            <div class="card-details">
                                <div class="detail-item">
                                    <div class="detail-icon teal">
                                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                                            <path d="M10 2L2 7L10 12L18 7L10 2Z" stroke="#0E787C" stroke-width="1.67"/>
                                            <path d="M2 12L10 17L18 12" stroke="#0E787C" stroke-width="1.67"/>
                                        </svg>
                                    </div>
                                    <div class="detail-info">
                                        <h4>진료과</h4>
                                        <p>${reservation.departmentName}</p>
                                    </div>
                                </div>

                                <div class="detail-item">
                                    <div class="detail-icon blue">
                                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                                            <rect x="3" y="4" width="14" height="14" rx="2" stroke="#155DFC" stroke-width="1.67"/>
                                            <path d="M7 2V6M13 2V6" stroke="#155DFC" stroke-width="1.67"/>
                                        </svg>
                                    </div>
                                    <div class="detail-info">
                                        <h4>진료 날짜</h4>
                                        <p>${reservation.date}</p>
                                    </div>
                                </div>

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
                            </div>

                            <div class="location-info">
                                <svg class="location-icon" viewBox="0 0 20 20" fill="none">
                                    <path d="M10 2C6.5 2 3.5 5 3.5 8.5C3.5 13 10 18 10 18C10 18 16.5 13 16.5 8.5C16.5 5 13.5 2 10 2Z" stroke="#0E787C" stroke-width="1.67"/>
                                    <circle cx="10" cy="8.5" r="2.5" stroke="#0E787C" stroke-width="1.67"/>
                                </svg>
                                <div class="location-text">
                                    <h4>진료실 위치</h4>
                                    <p>${reservation.location}</p>
                                </div>
                            </div>
                        </article>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

        </section>
        <section class="password-section">
            <p>
                소중한 개인정보를 안전하게 보호하기 위해 비밀번호를 정기적으로 변경하실 것을 권고해드립니다.<br>
                MediFlow에서 회원님의 개인정보보호에 최선을 다하겠습니다.
            </p>
            <button class="btn-primary">비밀번호 변경</button>
        </section>

    </section> </main>

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