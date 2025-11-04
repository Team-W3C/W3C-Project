<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css?family=Arial&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/guestPatientReservation.css" rel="stylesheet" />
    <title>비회원 환자 예약</title>
</head>

<body>
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
                    <path d="M5 5L14 14M14 5L5 14" stroke="#6B7280" stroke-width="1.66" stroke-linecap="round" />
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
</main>
</body>

</html>