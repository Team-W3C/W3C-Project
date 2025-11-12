<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>진료예약 - 병원 예약 시스템</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/detailReservation.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/index.css">

</head>
<body>
<jsp:include page="../../common/homePageMember/header.jsp" />

<div class="reservation">
    <main class="reservation-main">
        <jsp:include page="../../common/homePageMember/appointment-sidebar.jsp"/>

        <section class="reservation-content">
            <header class="reservation-header">
                <h1 class="page-title">진료예약</h1>
                <p class="page-subtitle">
                    원하시는 날짜와 시간을 선택하여 진료를 예약하세요.
                </p>
            </header>

            <article class="reservation-card">
                <div class="card-header">
                    <div class="step-badge"><span class="step-number">1</span></div>
                    <h2 class="card-title">날짜 및 진료과 선택</h2>
                </div>
                <div class="card-body">
                    <div class="selection-section">
                        <h3 class="section-title">날짜 선택</h3>
                        <div class="calendar-wrapper">
                            <div id="calendar"></div>
                        </div>
                    </div>
                    <div class="selection-section department-section">
                        <h3 class="section-title">진료과 선택</h3>
                        <div class="department-grid" id="department-grid">
                            <p>진료과 목록을 불러오는 중입니다...</p>
                        </div>
                    </div>
                </div>
            </article>

            <div class="selection-summary">
                <div class="summary-item">
                    <span class="summary-dot"></span>
                    <span class="summary-label">선택 진료과:</span>
                    <span class="summary-value" id="summary-dept">선택안함</span>
                </div>
                <div class="summary-item">
                    <span class="summary-dot"></span>
                    <span class="summary-label">선택 날짜:</span>
                    <span class="summary-value" id="summary-date">선택안함</span>
                </div>
            </div>

            <article class="reservation-card">
                <div class="card-header">
                    <div class="step-badge"><span class="step-number">2</span></div>
                    <h2 class="card-title">시간 선택</h2>
                    <div class="legend">
                           <span class="legend-item">
                            <img
                                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-13.svg"
                                    alt=""
                            />
                            예약 가능
                          </span>
                        <span class="legend-item">
                            <img
                                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-31.svg"
                                    alt=""
                            />
                            예약 마감
                          </span>
                    </div>
                </div>
                <div class="card-body">
                    <div class="timeslot-grid" id="timeslot-grid">
                        <p>날짜와 진료과를 먼저 선택해주세요.</p>
                    </div>
                </div>
            </article>

            <article class="reservation-card notes-card">
                <div class="card-header">
                    <div class="step-badge">
                        <span class="step-number">3</span>
                    </div>
                    <h2 class="card-title">증상 입력</h2>
                </div>
                <div class="card-body notes-body">
                        <textarea id="reservation-notes" class="notes-textarea"
                                  placeholder="예약 사유 또는 증상을 입력해주세요. (예: 정기 검진, 최근 OO이 불편함)"></textarea>
                </div>
            </article>

            <div class="reservation-submit-area">
                <button type="button" id="submit-reservation-btn" class="submit-btn" disabled>
                    예약하기
                </button>
            </div>

        </section>
    </main>
    <jsp:include page="../../common/homePageFooter/footer.jsp" />
</div>

<script src="${pageContext.request.contextPath}/js/index.global.min.js"></script>

<script src="${pageContext.request.contextPath}/js/detailReservation.js"></script>

</body>
</html>