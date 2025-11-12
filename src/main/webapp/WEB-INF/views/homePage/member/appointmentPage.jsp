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
        /* ... 기존 스타일 유지 ... */
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
        }

        body.modal-open {
            overflow: hidden;
        }
    </style>
</head>

<body>
<jsp:include page="../../common/homePageMember/header.jsp"/>
<div class="main-container">
    <jsp:include page="../../common/homePageMember/appointment-sidebar.jsp"/>

    <main class="reservation-content">
        <h1>진료예약</h1>

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
                        <circle
                                cx="7.5"
                                cy="4.5"
                                r="2.5"
                                stroke="#0E787C"
                                stroke-width="1.33"
                                fill="none"
                        />
                        <path
                                d="M3.5 11.5C3.5 9 5 7.5 7.5 7.5C10 7.5 11.5 9 11.5 11.5"
                                stroke="#0E787C"
                                stroke-width="1.33"
                                fill="none"
                        />
                    </svg>
                    <h1>비회원 환자 예약</h1>
                </div>
                <button type="button" class="btn-close-header" aria-label="닫기">
                    <svg width="19" height="19" viewBox="0 0 19 19">
                        <path
                                d="M5 5L14 14M14 5L5 14"
                                stroke="#6B7280"
                                stroke-width="1.66"
                                stroke-linecap="round"
                        />
                    </svg>
                </button>
            </div>
        </header>
        <div class="patient-content">
            <form class="patient-form" id="guestReservationForm"
                  action="${pageContext.request.contextPath}/guest/reserve" method="post">

                <h3 style="margin-top: 0; margin-bottom: 10px; color: #0e787c;">예약 정보 선택</h3>

                <div class="form-field">
                    <label for="departmentName">진료과 이름</label>
                    <select id="departmentName" name="departmentName" required>
                        <option value="">진료과 선택</option>
                        <option value="정형외과">정형외과</option>
                        <option value="내과">내과</option>
                        <option value="피부과">피부과</option>
                        <option value="응급의학과">응급의학과</option>
                        <option value="안과">안과</option>
                    </select>
                </div>

                <div class="form-row">
                    <div class="form-field">
                        <label for="treatmentDate">날짜</label>
                        <select id="treatmentDate" name="treatmentDate" required>
                            <option value="">날짜 선택</option>
                            <option value="2025-11-13">2025-11-13 (목)</option>
                            <option value="2025-11-14">2025-11-14 (금)</option>
                            <option value="2025-11-17">2025-11-17 (월)</option>
                        </select>
                    </div>
                    <div class="form-field">
                        <label for="treatmentTime">시간</label>
                        <select id="treatmentTime" name="treatmentTime" required>
                            <option value="">시간 선택</option>
                            <option value="09:00">09:00</option>
                            <option value="10:30">10:30</option>
                            <option value="14:00">14:00</option>
                        </select>
                    </div>
                </div>

                <h3 style="margin-top: 20px; margin-bottom: 10px; color: #0e787c;">환자 정보 입력</h3>

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
                        <label for="birth-suffix">뒷자리 (첫 글자)</label>
                        <input
                                type="password"
                                id="birth-suffix"
                                name="birthSuffix"
                                placeholder="뒷자리"
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
                            placeholder="전화번호"
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
                    />
                </div>
                <div class="form-field">
                    <label for="email">이메일</label>
                    <input
                            type="email"
                            id="email"
                            name="email"
                            placeholder="이메일"
                    />
                </div>
                <div class="form-field">
                    <label for="notes">특이사항 (증상, 기저질환, 알레르기)</label>
                    <input
                            type="text"
                            id="notes"
                            name="notes"
                            placeholder="예: 허리 통증, 고혈압, 견과류 알레르기"
                    />
                </div>

                <button type="submit" class="btn-submit">예약하기</button>
            </form>
        </div>
    </main>
</div>
<div class="guest-check-modal-overlay">
    <div class="guest-modal-backdrop"></div>
</div>
<jsp:include page="../../common/homePageFooter/footer.jsp"/>

<script
        src="${pageContext.request.contextPath}/js/appointment.js"
        defer
></script>
</body>
</html>