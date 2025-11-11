<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 정보</title>
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userInfo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/member-sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/deleteAccountModal.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ConfirmPasswordModal.css">

    <style>
        /* 모달을 기본적으로 숨기고, JS로 제어할 클래스 추가 */
        .withdrawal-modal-overlay,
        .password-modal-overlay {
            /* [수정] 비밀번호 모달 선택자 추가 */
            display: none;
        }

        .withdrawal-modal-overlay.is-open,
        .password-modal-overlay.is-open {
            /* [수정] 비밀번호 모달 선택자 추가 */
            display: flex;
        }

        /* 모달이 열렸을 때 배경 스크롤 방지 */
        body.modal-open {
            overflow: hidden;
        }
    </style>
</head>

<body>
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:setLocale value="ko_KR"/>

<jsp:include page="../../common/homePageMember/header_member.jsp"/>

<div class="member-info-wrap">
    <main class="member-info-container">

        <jsp:include page="../../common/homePageMember/member-sidebar.jsp"/>

        <section class="member-info-content">
            <header class="content-header">
                <h1>회원 정보</h1>
                <p>회원님의 개인 정보를 관리하세요</p>
            </header>

            <section class="info-section basic-info">
                <header class="info-section-header">
                    <h3>기본 정보</h3>
                    <button type="button" class="btn btn-primary">정보 수정</button>
                </header>
                <div class="info-section-body">
                    <ul class="info-list">
                        <li class="info-item">
                            <label for="name" class="info-label">이름</label>
                            <div class="info-value-box">
                                <span id="name">${loginMember.memberName}</span>
                            </div>
                        </li>
                        <li class="info-item">
                            <label for="birthdate" class="info-label">생년월일</label>
                            <div class="info-value-box">
                                <c:set var="rrn" value="${loginMember.memberRrn}"/>
                                <c:if test="${not empty rrn}">
                                    <c:set var="genderMarker" value="${fn:substring(rrn, 7, 8)}"/>

                                    <c:choose>
                                        <c:when test="${genderMarker == '1' || genderMarker == '2'}">
                                            <c:set var="yearPrefix" value="19"/>
                                        </c:when>
                                        <c:when test="${genderMarker == '3' || genderMarker == '4'}">
                                            <c:set var="yearPrefix" value="20"/>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="yearPrefix" value="19"/>
                                        </c:otherwise>
                                    </c:choose>

                                    <c:set var="yy" value="${fn:substring(rrn, 0, 2)}"/>
                                    <c:set var="mm" value="${fn:substring(rrn, 2, 4)}"/>
                                    <c:set var="dd" value="${fn:substring(rrn, 4, 6)}"/>

                                    <span id="birthdate">${yearPrefix}${yy}년 ${mm}월 ${dd}일</span>
                                </c:if>
                            </div>
                        </li>
                        <li class="info-item">

                            <label for="phone" class="info-label">연락처</label>
                            <div class="info-value-box">
                                <span id="phone">${loginMember.memberPhone}</span>

                            </div>
                        </li>
                        <li class="info-item">
                            <label for="email" class="info-label">이메일</label>

                            <div class="info-value-box">
                                <span id="email">${loginMember.memberEmail}</span>
                            </div>
                        </li>

                        <li class="info-item address-item">
                            <label for="address1" class="info-label">주소</label>
                            <div class="info-value-group">

                                <div class="info-value-box">
                                    <span id="address1">${loginMember.memberAddress}</span>
                                </div>
                            </div>
                        </li>
                        <li class="info-item">
                            <label for="join-date" class="info-label">가입일</label>

                            <div class="info-value-box">
                                <span id="join-date">${loginMember.memberJoinDate}</span>
                            </div>

                        </li>
                    </ul>
                </div>
            </section>

            <section class="info-section account-management">
                <header class="info-section-header danger-zone">

                    <h3>계정 관리</h3>
                </header>
                <div class="info-section-body">
                    <h4>회원 탈퇴</h4>
                    <p class="description">

                        회원 탈퇴 시 모든 개인정보와 진료 기록이 삭제되며, 복구가 불가능합니다.
                        신중하게 결정해 주시기 바랍니다.
                    </p>
                    <button type="button" class="btn btn-danger" id="open-withdrawal-modal">회원 탈퇴하기</button>
                </div>
            </section>

            <section class="privacy-notice">
                <div class="notice-text">

                    <h4>개인정보 보호 안내</h4>
                    <p>회원님의 소중한 개인정보는 안전하게 보호되며, 의료법 및 개인정보보호법에 따라 엄격히 관리됩니다.</p>
                </div>
            </section>
        </section>
    </main>
</div>

<div class="withdrawal-modal-overlay">
    <div class="modal-backdrop"></div>
    <div class="withdrawal-modal">
        <button type="button"
                class="modal-close" aria-label="닫기">
            <svg width="16" height="16" viewBox="0 0 16 16">
                <path d="M4 4L12 12M12 4L4 12" stroke="currentColor" stroke-width="1.33" stroke-linecap="round"/>
            </svg>
        </button>
        <header class="withdrawal-header">
            <div class="header-content">

                <h2 class="modal-title">
                    <svg class="icon-alert" width="18" height="18" viewBox="0 0 18 18">
                        <path d="M9 1L2 15L16 15L9 1Z" stroke="#0E787C" stroke-width="2" fill="none"/>
                        <line x1="9" y1="6" x2="9" y2="11" stroke="#0E787C" stroke-width="2"/>

                    </svg>
                    탈퇴 확인
                </h2>
                <p class="modal-subtitle">탈퇴를 진행하시겠습니까?</p>
            </div>
        </header>

        <div class="withdrawal-form">

            <div class="info-card">
                <div class="info-icon">
                    <svg width="20" height="20" viewBox="0 0 20 20">
                        <rect x="3" y="3" width="14" height="14" rx="1" stroke="#0E787C" stroke-width="1.67"

                              fill="none"/>
                        <line x1="6" y1="2" x2="6" y2="5" stroke="#0E787C" stroke-width="1.67"/>
                        <line x1="14" y1="2" x2="14" y2="5" stroke="#0E787C" stroke-width="1.67"/>
                        <line x1="3" y1="8" x2="17"
                              y2="8" stroke="#0E787C" stroke-width="1.67"/>
                    </svg>
                </div>
                <div class="info-content">
                    <span class="info-label">탈퇴 날짜</span>
                    <span class="info-value"><fmt:formatDate value="${now}" pattern="yyyy.MM.dd.E"/></span>

                </div>
            </div>
            <div class="info-card">
                <div class="info-icon">
                    <svg width="20" height="20" viewBox="0 0 20 20">

                        <circle cx="10" cy="7" r="3" stroke="#0E787C" stroke-width="1.67" fill="none"/>
                        <path d="M5 17C5 14 7 12 10 12C13 12 15 14 15 17" stroke="#0E787C" stroke-width="1.67"
                              fill="none"/>

                    </svg>
                </div>
                <div class="info-content">
                    <span class="info-label">성함</span>
                    <span class="info-value">${loginMember.memberName}</span>
                </div>

            </div>

            <section class="consent-section">
                <h3 class="consent-label">동의</h3>
                <p class="consent-text">
                    환자의 진료 기록은 의료법에 따라<br>
                    일정 기간 보존해야 하는 의무가 있으므로,<br>

                    "회원 탈퇴"를 하더라도 진료 기록은 삭제되지 않고<br>
                    법정 보존 기간 (10년) 동안 보관됩니다.<br>
                    동의하십니까?
                </p>
                <button type="button" class="btn-agree">동의</button>
            </section>

            <div class="modal-actions">
                <button type="button" class="btn-cancel">취소</button>
            </div>
        </div>
    </div>
</div>

<div class="modal-overlay password-modal-overlay">
    <div class="password-modal">

        <button type="button" class="modal-close" aria-label="닫기">
            ×
        </button>

        <header class="modal-header">
            <h2 class="modal-title">비밀번호 확인</h2>
            <p class="modal-subtitle">회원 탈퇴를 완료하려면 비밀번호를 입력해 주세요</p>
        </header>

        <div class="modal-body">
            <form class="password-form">

                <div class="info-box">
                    <div class="info-header">회원 정보</div>
                    <div class="info-text">회원 탈퇴를 위한 본인 확인 절차입니다.</div>
                </div>

                <div class="field-box">

                    <div class="field-icon">
                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                            <path d="M5 16C5 13.5 7 11 10 11C13 11 15 13.5 15 16" stroke="#0E787C"

                                  stroke-width="1.67"/>
                            <circle cx="10" cy="6" r="3" stroke="#0E787C" stroke-width="1.67"/>
                        </svg>
                    </div>

                    <div class="field-info">
                        <div class="field-label">성함</div>
                        <div class="field-value">${loginMember.memberName}</div>
                    </div>

                </div>

                <div class="field-box password-box">
                    <input type="password" id="user-password" class="password-input" placeholder="비밀번호를 입력하세요">
                    <button type="submit" class="btn-confirm">탈퇴 완료</button>
                </div>
            </form>

        </div>

        <footer class="modal-footer">
            <button type="button" class="btn-cancel">취소</button>
        </footer>
    </div>
</div>
<jsp:include page="../../common/homePageFooter/footer.jsp"/>
<script src="${pageContext.request.contextPath}/js/userInfo.js" defer></script>
</body>

</html>