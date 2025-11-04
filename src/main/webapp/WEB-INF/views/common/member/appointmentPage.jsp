<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>진료예약</title>
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/appointmentPage.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/guestPatientReservation.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/guestReservationCheck.css" rel="stylesheet" />

    <style>
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
<main class="reservation-content">
    <h1>진료예약</h1>

    <section class="reservation-cards-container">
        <div class="reservation-column">
            <article class="reservation-card">
                <div class="reservation-card-header">
                    <h2>
                        <img src="${pageContext.request.contextPath}/img/v216_2656.png" alt="" class="icon-small" />
                        진료를 처음 보시는 경우
                    </h2>
                </div>
                <div class="reservation-card-body">
                    <p>
                        연락처를 남겨 주시면 상담 간호사가 전화를 드려 예약을
                        도와드립니다.
                    </p>
                    <div class="reservation-card-actions">
                        <a href="#" class="btn-primary">첫방문 고객 예약하기</a>
                    </div>
                    <div class="reservation-card-info info-box-phone">
                        <span class="info-label">첫방문 고객<br />예약번호 안내</span>
                        <span class="info-number">02-1111-1111</span>
                    </div>
                </div>
            </article>

            <article class="reservation-card">
                <div class="reservation-card-header">
                    <h2>
                        <img src="${pageContext.request.contextPath}/img/v216_2692.png" alt="" class="icon-small" />
                        회원이 본인 예약을 할 경우
                    </h2>
                </div>
                <div class="reservation-card-body">
                    <p>
                        로그인 후 본인의 진료예약 및 조회를 하실 수 있습니다.
                    </p>
                    <div class="reservation-card-actions">
                        <a href="#" class="btn-primary">본인 예약하기</a>
                        <a href="#" class="btn-primary">본인 예약 조회하기</a>
                    </div>
                </div>
            </article>
        </div>

        <div class="reservation-column">
            <article class="reservation-card">
                <div class="reservation-card-header">
                    <h2>
                        <img src="${pageContext.request.contextPath}/img/v216_2674.png" alt="" class="icon-small" />
                        회원가입을 하지 않아도
                    </h2>
                </div>
                <div class="reservation-card-body">
                    <p>
                        진료예약 및 조회가 가능합니다. 단, 일부 서비스 이용이 제한될 수
                        있습니다.
                    </p>
                    <div class="reservation-card-actions">
                        <a href="#" class="btn-primary" id="open-guest-modal">비회원 예약하기</a>
                        <a href="#" class="btn-primary" id="open-guest-check-modal">비회원 예약 조회하기</a>
                    </div>
                    <div class="reservation-card-info">
                        회원가입을 하실 경우 『나의차트』에서 진료 및
                        <strong>투약내역, 복약상담, 진단검사결과</strong> 등 개인화
                        서비스를 이용하실 수 있습니다.
                    </div>
                </div>
            </article>
        </div>
    </section>

    <section class="reservation-phone-banner">
        <div class="phone-number">전화문의 1111-1111</div>
        <div class="phone-notice">
        </div>
    </section>

    <nav class="reservation-quick-nav">
        <ul>
            <li>
                <a href="#">
                    <img src="${pageContext.request.contextPath}/img/icon-signup.png" alt="" />
                    <span>회원가입</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <img src="${pageContext.request.contextPath}/img/icon-login.png" alt="" />
                    <span>로그인</span>
                </a>
                <a href="#" class="nav-sublink">아이디/비밀번호찾기</a>
            </li>
            <li>
                <a href="#">
                    <img src="${pageContext.request.contextPath}/img/icon-doctor.png" alt="" />
                    <span>의료진/진료과 보기</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <img src="${pageContext.request.contextPath}/img/icon-chart.png" alt="" />
                    <span>나의차트</span>
                </a>
            </li>
        </ul>
    </nav>
</main>
<div class="guest-modal-overlay">
    <div class="guest-modal-backdrop"></div>
    <main class="patient-modal">
        <header class="patient-header">
            <div class="header-content">
                <div class="header-title">
                    <svg class="icon-user" width="15" height="15" viewBox="0 0 15 15">
                        <circle cx="7.5" cy="4.5" r="2.5" stroke="#0E787C" stroke-width="1.33" fill="none" />
                        <path d="M3.5 11.5C3.5 9 5 7.5 7.5 7.5C10 7.5 11.5 9 11.5 11.5" stroke="#0E787C"
                              stroke-width="1.33" fill="none" />
                    </svg>
                    <h1>비회원 환자 예약</h1>
                </div>
                <button type="button" class="btn-close-header" aria-label="닫기">
                    <svg width="19" height="19" viewBox="0 0 19 19">
                        <path d="M5 5L14 14M14 5L5 14" stroke="#6B7280" stroke-width="1.66"
                              stroke-linecap="round" />
                    </svg>
                </button>
            </div>
        </header>
        <div class="patient-content">
            <form class="patient-form">
                <div class="form-field">
                    <label for="patient-name">성함</label>
                    <input type="text" id="patient-name" name="name" placeholder="성함" required />
                </div>
                <div class="form-row">
                    <div class="form-field">
                        <label for="birth-date">주민등록번호</label>
                        <input type="text" id="birth-date" name="birth-date" placeholder="생년월일 6자리" maxlength="6"
                               required />
                    </div>
                    <div class="form-field">
                        <label for="birth-suffix">뒷자리</label>
                        <input type="password" id="birth-suffix" name="birth-suffix" placeholder="뒷자리" maxlength="7"
                               required />
                    </div>
                </div>
                <div class="form-field">
                    <label for="phone">전화번호</label>
                    <input type="tel" id="phone" name="phone" placeholder="전화번호" required />
                </div>
                <div class="form-field">
                    <label for="address">주소</label>
                    <input type="text" id="address" name="address" placeholder="주소" />
                </div>
                <div class="form-field">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" placeholder="이메일" />
                </div>
                <div class="form-field">
                    <label for="notes">특이사항(기저질환, 알레르기)</label>
                    <input type="text" id="notes" name="notes" placeholder="특이사항" />
                </div>
                <button type="submit" class="btn-submit">예약하기</button>
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
                    <path d="M4 4L12 12M12 4L4 12" stroke="currentColor" stroke-width="1.33"
                          stroke-linecap="round" />
                </svg>
            </button>

            <header class="modal-header">
                <h2 class="modal-title">비회원 예약내역</h2>
                <p class="modal-subtitle">비회원 예약내역을 위해 번호를 입력하여 주세요</p>
            </header>

            <form class="reservation-form">
                <section class="info-section">
                    <div class="section-header">
                        <h3 class="section-title">회원 정보</h3>
                        <p class="section-description">회원 정보를 보시려면 번호를 입력하여 주세요</p>
                    </div>
                </section>

                <section class="info-card">
                    <div class="info-icon">
                        <svg width="20" height="20" viewBox="0 0 20 20">
                            <circle cx="10" cy="7" r="3" stroke="#0E787C" stroke-width="1.67" fill="none" />
                            <path d="M5 17C5 14 7 12 10 12C13 12 15 14 15 17" stroke="#0E787C" stroke-width="1.67"
                                  fill="none" />
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
                        <input type="tel" id="phone-number" name="phone-number" class="input-field"
                               placeholder="번호를 입력하세요" required />

                        <button type="button" class="btn-cancel">취소</button>
                        <button type="submit" class="btn-confirm">확인</button>
                    </div>
                </div>

            </form>
        </div>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/appointment.js" defer></script>
</body>

</html>