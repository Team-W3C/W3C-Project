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
    </style>

</head>

<body>
<jsp:include page="../../common/homePageMember/header_member.jsp"/>

<main class="mypage-container">
    <jsp:include page="../../common/homePageMember/member-sidebar.jsp"/>


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
                        <article class="reservation-card">
                            <div class="card-header">
                                <div class="card-status">
                                        <%-- JSTL choose 태그로 예약 상태(status)에 따라 분기 --%>
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
                                        <%-- 다른 상태가 있다면 c:when 추가 --%>
                                    </c:choose>
                                    <span class="reservation-type">${reservation.type}</span>
                                </div>
                                <div class="card-actions">
                                    <button class="btn btn-secondary">변경</button>
                                    <button class="btn btn-outline">취소</button>
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

        <section class="verification-section">
            <div class="verification-header">
                <h3>본인인증을 하시면 더 많은 정보를 볼 수 있습니다.</h3>
                <button class="btn-primary">본인인증하기</button>
            </div>

            <div class="verification-items">
                <div class="verification-item">
                    <div class="verification-icon">
                        <svg width="60" height="60" viewBox="0 0 60 60" fill="none">
                            <rect x="10" y="15" width="40" height="35" rx="3" stroke="#0E787C" stroke-width="2"/>
                            <path d="M20 10V20M40 10V20" stroke="#0E787C" stroke-width="2"/>
                        </svg>
                    </div>
                    <h4>진료내역</h4>
                </div>

                <div class="verification-item">
                    <div class="verification-icon">
                        <svg width="60" height="60" viewBox="0 0 60 60" fill="none">
                            <ellipse cx="30" cy="25" rx="15" ry="20" stroke="#0E787C" stroke-width="2"/>
                            <rect x="20" y="35" width="20" height="15" rx="3" stroke="#0E787C" stroke-width="2"/>
                        </svg>
                    </div>
                    <h4>투약내역</h4>
                </div>

                <div class="verification-item">
                    <div class="verification-icon">
                        <svg width="60" height="60" viewBox="0 0 60 60" fill="none">
                            <circle cx="30" cy="30" r="20" stroke="#0E787C" stroke-width="2"/>
                            <circle cx="30" cy="30" r="10" stroke="#0E787C" stroke-width="2"/>
                        </svg>
                    </div>
                    <h4>진단검사결과</h4>
                </div>
            </div>
        </section>

        <section class="password-section">
            <p>
                소중한 개인정보를 안전하게 보호하기 위해 비밀번호를 정기적으로 변경하실 것을 권고해드립니다.<br>
                MediFlow에서 회원님의 개인정보보호에 최선을 다하겠습니다.
            </p>
            <button class="btn-primary">비밀번호 변경</button>
        </section>

    </section>
</main>

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
                        <%-- EL을 사용하여 세션에 저장된 로그인 멤버의 이름 표시 --%>
                        <div class="field-value">${sessionScope.loginMember.memberName}</div>
                    </div>
                </div>

                <div class="field-box password-box">
                    <input type="password" id="password" class="password-input" placeholder="비밀번호를 입력하세요">
                    <button type="submit" class="btn-confirm">확인</button>
                </div>
            </form>
        </div>

        <footer class="modal-footer">
            <button type="button" class="btn-cancel">취소</button>
        </footer>
    </div>
</div>
<jsp:include page="../../common/homePageFooter/footer.jsp"/>
<script>
    // JSP가 렌더링한 contextPath 값을
    // "contextPath"라는 이름의 JavaScript 전역 변수에 저장합니다.
        const contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/MyChart.js" defer></script>

</body>

</html>