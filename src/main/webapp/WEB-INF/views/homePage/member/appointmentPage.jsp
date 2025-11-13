<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib
        prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>진료예약</title>
    <link
            href="https://fonts.googleapis.com/css?family=Inter&display=swap"
            rel="stylesheet"
    />
    <link
            href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap"
            rel="stylesheet"
    />
    <link
            href="${pageContext.request.contextPath}/css/appointmentPage.css"
            rel="stylesheet"
    />
    <link
            href="${pageContext.request.contextPath}/css/guestPatientReservation.css"
            rel="stylesheet"
    />
    <link
            href="${pageContext.request.contextPath}/css/guestReservationCheck.css"
            rel="stylesheet"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">

    <style>
        /* ... (기존 스타일) ... */
        .guest-modal-overlay,
        .guest-check-modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1000;
            display: none;
            align-items: center;
            justify-content: center;
            overflow-y: auto;
            padding: 40px 0;
        }

        .guest-modal-overlay.is-open,
        .guest-check-modal-overlay.is-open {
            display: flex;
        }

        .guest-modal-backdrop {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: -1;
        }

        .patient-modal,
        .modal-container {
            position: relative;
            z-index: 1;
            margin-top: auto;
            margin-bottom: auto;
        }

        body.modal-open {
            overflow: hidden;
        }

        /* ▼▼▼ [추가] 모달 레이아웃 깨짐 현상 긴급 수정 ▼▼▼ */
        .patient-modal .patient-content .patient-form {
            display: block !important;
        }

        .patient-modal .patient-content .patient-form h3 {
            width: 100% !important;
            flex-basis: 100% !important;
            display: block !important;
            margin-top: 20px;
            margin-bottom: 10px;
            color: #0e787c;
            border-bottom: 1px solid #eee;
            padding-bottom: 5px;
            font-size: 16px;
            font-weight: bold;
        }
        .patient-modal .patient-content .patient-form h3:first-of-type {
            margin-top: 0;
        }

        .patient-modal .patient-content .patient-form .form-field {
            width: 100% !important;
            flex-basis: 100% !important;
            display: block !important;
            margin-bottom: 15px;
        }

        .patient-modal .patient-content .patient-form .form-row {
            display: flex;
            flex-direction: column;
            gap: 0;
        }

        .patient-modal .patient-content .patient-form .form-row .form-field {
            width: 100% !important;
            margin-bottom: 15px;
        }
        /* ▲▲▲ [레이아웃 수정 완료] ▲▲▲ */


        /* ▼▼▼ [수정됨] 비회원 모달 내 동적 UI/UX 스타일 ▼▼▼ */
        .patient-form .form-field select,
        .patient-form .form-field input[type="date"],
        .patient-form .form-field input[type="time"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            font-family: inherit;
            background-color: #fff;
            line-height: 1.5;
        }

        /* 1. 진료과 선택 그리드 */
        #guest-dept-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
        }

        .guest-dept-btn {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 15px 10px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            background-color: #fafafa;
            cursor: pointer;
            transition: all 0.2s;
            font-size: 14px;
            color: #333;
        }
        .guest-dept-btn:hover {
            border-color: #0e787c;
            background-color: #f0fafa;
        }
        .guest-dept-btn.selected {
            border-color: #0e787c;
            background-color: #e8f5f5;
            color: #0e787c;
            font-weight: bold;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .guest-dept-btn img {
            width: 32px;
            height: 32px;
            margin-bottom: 8px;
        }

        /* 3. 시간 선택 그리드 */
        #guest-timeslot-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 8px;
        }
        #guest-timeslot-grid p {
            grid-column: 1 / -1;
            color: #777;
            font-size: 14px;
            text-align: center;
            padding: 10px 0;
        }

        .guest-time-btn {
            padding: 12px 5px;
            border: 1px solid #ccc;
            border-radius: 6px;
            background: #fff;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
            text-align: center;
        }
        .guest-time-btn:hover:not(:disabled) {
            border-color: #0e787c;
            color: #0e787c;
        }
        .guest-time-btn.selected {
            background-color: #0e787c;
            color: #fff;
            border-color: #0e787c;
            font-weight: bold;
        }
        .guest-time-btn:disabled {
            background-color: #f5f5f5;
            color: #aaa;
            cursor: not-allowed;
            text-decoration: line-through;
        }
        /* ▲▲▲ [수정 완료] ▲▲▲ */

        /* ▼▼▼ [추가] 성공/오류 메시지 스타일 ▼▼▼ */
        .alert-success {
            background-color: #e8f5f5;
            color: #0e787c;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: bold;
        }
        .alert-danger {
            background-color: #fcebeb;
            color: #b90000;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: bold;
        }
        /* ▲▲▲ [추가 완료] ▲▲▲ */

    </style>
</head>

<body>
<jsp:include page="../../common/homePageMember/header.jsp"/>
<div class="main-container">
    <jsp:include page="../../common/homePageMember/appointment-sidebar.jsp"/>

    <main class="reservation-content">
        <h1>진료예약</h1>

        <%-- alert() 창으로 띄우는 방식 --%>
        <c:if test="${not empty message}">
            <script>
                window.onload = function() {
                    alert("${message}");
                };
            </script>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <script>
                window.onload = function() {
                    alert("오류: ${errorMessage}");
                };
            </script>
        </c:if>
        <section class="reservation-cards-container">
            <div class="reservation-column">
                <article class="reservation-card">
                    <div class="reservation-card-header">
                        <h2>
                            <img
                                    src="${pageContext.request.contextPath}/img/v216_2656.png"
                                    alt=""
                                    class="icon-small"
                            />
                            진료를 처음 보시는 경우
                        </h2>
                    </div>
                    <div class="reservation-card-body">
                        <p>
                            비회원 예약이 어려우신 경우 아래의 번호로 전화를 하시면 상담 간호사가 예약을
                            도와드립니다.
                        </p>
                        <div class="reservation-card-actions">
                            <a href="${pageContext.request.contextPath}/member/procedure" class="btn-primary">예약방법</a>
                        </div>
                        <div class="reservation-card-info info-box-phone">
                            <span class="info-label">첫방문 고객<br/>예약번호 안내</span>
                            <span class="info-number">02-0724-0303</span>
                        </div>
                    </div>
                </article>

                <article class="reservation-card">
                    <div class="reservation-card-header">
                        <h2>
                            <img
                                    src="${pageContext.request.contextPath}/img/v216_2692.png"
                                    alt=""
                                    class="icon-small"
                            />
                            회원이 예약을 할 경우
                        </h2>
                    </div>
                    <div class="reservation-card-body">
                        <p>로그인 후 본인의 진료예약 및 조회를 하실 수 있습니다.</p>
                        <div class="reservation-card-actions">
                            <c:choose>
                                <%-- 1. 세션에 'loginMember' 정보가 없는 경우 (로그아웃 상태) --%>
                                <c:when test="${empty sessionScope.loginMember}">
                                    <a
                                            href="${pageContext.request.contextPath}/member/loginPage"
                                            class="btn-primary"
                                    >예약하기</a
                                    >
                                </c:when>
                                <%-- 2. 세션에 'loginMember' 정보가 있는 경우 (로그인 상태) --%>
                                <c:otherwise>
                                    <a
                                            href="${pageContext.request.contextPath}/member/reservation/detail"
                                            class="btn-primary"
                                    >예약하기</a
                                    >
                                </c:otherwise>
                            </c:choose>

                            <c:choose>
                                <%-- 1. 세션에 'loginMember' 정보가 없는 경우 (로그아웃 상태) --%>
                                <c:when test="${empty sessionScope.loginMember}">
                                    <a
                                            href="${pageContext.request.contextPath}/member/loginPage"
                                            class="btn-primary"
                                    >본인 예약 조회하기</a
                                    >
                                </c:when>
                                <%-- 2. 세션에 'loginMember' 정보가 있는 경우 (로그인 상태) --%>
                                <c:otherwise>
                                    <a
                                            href="${pageContext.request.contextPath}/member/mychart"
                                            class="btn-primary"
                                    >본인 예약 조회하기</a
                                    >
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </article>
            </div>

            <div class="reservation-column">
                <article class="reservation-card">
                    <div class="reservation-card-header">
                        <h2>
                            <img
                                    src="${pageContext.request.contextPath}/img/v216_2674.png"
                                    alt=""
                                    class="icon-small"
                            />
                            회원가입을 하지 않아도
                        </h2>
                    </div>
                    <div class="reservation-card-body">
                        <p>
                            진료예약 및 조회가 가능합니다. 단, 일부 서비스 이용이 제한될 수
                            있습니다.
                        </p>
                        <div class="reservation-card-actions">
                            <a href="#" class="btn-primary" id="open-guest-modal"
                            >비회원 예약하기</a
                            >
                            <a href="#" class="btn-primary" id="open-guest-check-modal"
                            >비회원 예약 조회하기</a
                            >
                        </div>
                        <div class="reservation-card-info">
                            회원가입을 하실 경우 『나의차트』에서 진료 및
                            <strong> 진단검사결과</strong> 등 개인화
                            서비스를 이용하실 수 있습니다.
                        </div>
                    </div>
                </article>
                <article class="reservation-card">
                    <div class="reservation-card-header">
                        <h2>
                            <img
                                    src="${pageContext.request.contextPath}/img/v216_2656.png"
                                    alt=""
                                    class="icon-small"
                            />
                            시설 예약현황을 확인 하는 경우
                        </h2>
                    </div>
                    <div class="reservation-card-body">
                        <p>
                            홈페이지에서 시설 예약 현황을 확인하세요.
                        </p>
                        <div class="reservation-card-actions">
                            <a href="${pageContext.request.contextPath}/member/reservation/systemReservation" class="btn-primary">시설 예약현황</a>
                        </div>
                    </div>
                </article>
            </div>
        </section>

        <section class="reservation-phone-banner">
            <div class="phone-number">전화문의 1111-1111</div>
            <div class="phone-notice"></div>
        </section>

        <nav class="reservation-quick-nav">
            <ul>
                <li>
                    <a href="${pageContext.request.contextPath}/member/signUpPage">
                        <img
                                src="${pageContext.request.contextPath}/img/icon-signup.png"
                                alt=""
                        />
                        <span>회원가입</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/member/loginPage">
                        <img
                                src="${pageContext.request.contextPath}/img/icon-login.png"
                                alt=""
                        />
                        <span>로그인</span>
                    </a>
                    <a href="#" class="nav-sublink">아이디/비밀번호찾기</a>
                </li>
                <li>
                    <a href="#">
                        <img
                                src="${pageContext.request.contextPath}/img/icon-doctor.png"
                                alt=""
                        />
                        <span>의료진/진료과 보기</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/member/mychart">
                        <img
                                src="${pageContext.request.contextPath}/img/icon-chart.png"
                                alt=""
                        />
                        <span>나의차트</span>
                    </a>
                </li>
            </ul>
        </nav>
    </main>
</div>

<div class="guest-modal-overlay">
    <div class="guest-modal-backdrop"></div>
    <main class="patient-modal">
        <header class="patient-header">
            <div class="header-content">
                <div class="header-title">
                    <svg class="icon-user" width="15" height="15" viewBox="0 0 15 15">
                        <circle cx="7.5" cy="4.5" r="2.5" stroke="#0E787C" stroke-width="1.33" fill="none"/>
                        <path d="M3.5 11.5C3.5 9 5 7.5 7.5 7.5C10 7.5 11.5 9 11.5 11.5" stroke="#0E787C" stroke-width="1.33" fill="none"/>
                    </svg>
                    <h1>비회원 환자 예약</h1>
                </div>
                <button type="button" class="btn-close-header" aria-label="닫기">
                    <svg width="19" height="19" viewBox="0 0 19 19">
                        <path d="M5 5L14 14M14 5L5 14" stroke="#6B7280" stroke-width="1.66" stroke-linecap="round"/>
                    </svg>
                </button>
            </div>
        </header>
        <div class="patient-content">

            <form class="patient-form" id="guestReservationForm"
                  action="${pageContext.request.contextPath}/guest/reservation/new" method="post">

                <h3>1. 진료과 선택</h3>
                <div class="form-field">
                    <div id="guest-dept-grid">
                        <p>진료과 목록을 불러오는 중...</p>
                    </div>
                </div>

                <h3>2. 날짜 선택</h3>
                <div class="form-field">
                    <label for="guest-treatment-date" style="margin-bottom: 5px; display: block;">진료를 원하시는 날짜를 선택하세요.</label>
                    <input type="date" id="guest-treatment-date" required />
                </div>

                <h3>3. 시간 선택</h3>
                <div class="form-field">
                    <div id="guest-timeslot-grid">
                        <p>진료과와 날짜를 먼저 선택해주세요.</p>
                    </div>
                </div>
                <h3>4. 환자 정보 입력</h3>

                <input type="hidden" id="guest-hidden-deptName" name="departmentName" value="">
                <input type="hidden" id="guest-hidden-date" name="treatmentDate" value="">
                <input type="hidden" id="guest-hidden-time" name="treatmentTime" value="">


                <div class="form-field">
                    <label for="patient-name">성함</label>
                    <input
                            type="text"
                            id="patient-name"
                            name="name"
                            placeholder="성함"
                            required
                    />
                </div>

                <div class="form-row">
                    <div class="form-field">
                        <label for="birth-date">주민등록번호 (앞 6자리)</label>
                        <input
                                type="text"
                                id="birth-date"
                                name="birthDate"
                                placeholder="생년월일 6자리"
                                maxlength="6"
                                required
                        />
                    </div>
                    <div class="form-field">
                        <label for="birth-suffix">뒷자리 (7자리)</label>
                        <input
                                type="password"
                                id="birth-suffix"
                                name="birthSuffix"
                                placeholder="뒷 7자리"
                                maxlength="7"
                                required
                        />
                    </div>
                </div>
                <div class="form-field">
                    <label for="phone">전화번호</label>
                    <input
                            type="tel"
                            id="phone"
                            name="phone"
                            placeholder="'-' 포함하여 입력 (예: 010-1234-5678)"
                            required
                    />
                </div>
                <div class="form-field">
                    <label for="address">주소</label>
                    <input
                            type="text"
                            id="address"
                            name="address"
                            placeholder="주소"
                            required
                    />
                </div>
                <div class="form-field">
                    <label for="email">이메일</label>
                    <input
                            type="email"
                            id="email"
                            name="email"
                            placeholder="이메일"
                            required
                    />
                </div>

                <div class="form-field">
                    <label for="bloodType">혈액형</label>
                    <select id="bloodType" name="bloodType" required>
                        <option value="">혈액형 선택</option>
                        <option value="A+">A+</option>
                        <option value="A-">A-</option>
                        <option value="B+">B+</option>
                        <option value="B-">B-</option>
                        <option value="O+">O+</option>
                        <option value="O-">O-</option>
                        <option value="AB+">AB+</option>
                        <option value="AB-">AB-</option>
                    </select>
                </div>

                <div class="form-field">
                    <label for="chronicDisease">기저질환</label>
                    <input
                            type="text"
                            id="chronicDisease"
                            name="chronicDisease"
                            placeholder="기저질환 (예: 고혈압, 당뇨 / 없을 시 '없음' 입력)"
                    />
                </div>

                <div class="form-field">
                    <label for="allergy">알레르기</label>
                    <input
                            type="text"
                            id="allergy"
                            name="allergy"
                            placeholder="알레르기 (예: 견과류, 갑각류 / 없을 시 '없음' 입력)"
                    />
                </div>

                <div class="form-field">
                    <label for="reservationNotes">주요 증상</label>
                    <input
                            type="text"
                            id="reservationNotes"
                            name="reservationNotes"
                            placeholder="예약 사유 (예: 허리 통증, 감기 증상)"
                    />
                </div>

                <button type="submit" class="btn-submit" id="guest-submit-btn" disabled>
                    예약하기
                </button>
            </form>
        </div>
    </main>
</div>

<div class="guest-check-modal-overlay">
    <div class="guest-modal-backdrop"></div>
    <main class="modal-container">
        <div class="modal-content">
            <button type="button" class="modal-close" aria-label="닫기">
                <svg width="16" height="16" viewBox="0 0 16 16">
                    <path
                            d="M4 4L12 12M12 4L4 12"
                            stroke="currentColor"
                            stroke-width="1.33"
                            stroke-linecap="round"
                    />
                </svg>
            </button>

            <header class="modal-header">
                <h2 class="modal-title">비회원 예약내역</h2>
                <p class="modal-subtitle">
                    비회원 예약내역을 위해 번호를 입력하여 주세요
                </p>
            </header>

            <form class="reservation-form">
                <section class="info-section">
                    <div class="section-header">
                        <h3 class="section-title">회원 정보</h3>
                        <p class="section-description">
                            회원 정보를 보시려면 번호를 입력하여 주세요
                        </p>
                    </div>
                </section>

                <section class="info-card">
                    <div class="info-icon">
                        <svg width="20" height="20" viewBox="0 0 20 20">
                            <circle
                                    cx="10"
                                    cy="7"
                                    r="3"
                                    stroke="#0E787C"
                                    stroke-width="1.67"
                                    fill="none"
                            />
                            <path
                                    d="M5 17C5 14 7 12 10 12C13 12 15 14 15 17"
                                    stroke="#0E787C"
                                    stroke-width="1.67"
                                    fill="none"
                            />
                        </svg>
                    </div>
                    <div class="info-content">
                        <span class="info-label">성함</span>
                        <span class="info-value">홍길동</span>
                    </div>
                </section>

                <div class="input-group">
                    <label for="phone-number" class="input-label">번호</label>
                    <div class="input-wrapper">
                        <input
                                type="tel"
                                id="phone-number"
                                name="phone-number"
                                class="input-field"
                                placeholder="번호를 입력하세요"
                                required
                        />

                        <button type="button" class="btn-cancel">취소</button>
                        <button type="submit" class="btn-confirm">확인</button>
                    </div>
                </div>
            </form>
        </div>
    </main>
</div>

<jsp:include page="../../common/homePageFooter/footer.jsp"/>

<script>
    // 404 오류 방지를 위해 JSP가 동적으로 contextPath를 JS에 전달합니다.
    const g_contextPath = "${pageContext.request.contextPath}";
</script>
<script
        src="${pageContext.request.contextPath}/js/appointment.js"
        defer
></script>
</body>
</html>