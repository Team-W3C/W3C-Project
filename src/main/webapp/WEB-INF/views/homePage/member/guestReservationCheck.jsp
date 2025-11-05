<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css?family=Arial&display=swap" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/guestReservationCheck.css" rel="stylesheet" />
    <title>비회원 환자 예약 확인</title>
</head>

<main class="modal-container">
    <div class="modal-content">
        <button type="button" class="modal-close" aria-label="닫기">
            <svg width="16" height="16" viewBox="0 0 16 16">
                <path d="M4 4L12 12M12 4L4 12" stroke="currentColor" stroke-width="1.33" stroke-linecap="round" />
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
                        <path d="M5 17C5 14 7 12 10 12C13 12 15 14 15 17" stroke="#0E787C" stroke-width="1.67" fill="none" />
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
                    <input type="tel" id="phone-number" name="phone-number" class="input-field" placeholder="번호를 입력하세요"
                           required />
                    <button type="button" class="btn-confirm">확인</button>
                </div>
            </div>

            <div class="modal-actions">
                <button type="button" class="btn-cancel">취소</button>
            </div>
        </form>
    </div>
</main>

</html>