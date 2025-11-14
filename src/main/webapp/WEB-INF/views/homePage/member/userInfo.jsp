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

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/member-sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ConfirmPasswordModal.css">

    <%--
      userInfo.css가 sidebar.css보다 *뒤에* 와야
      스타일 충돌 시 userInfo.css가 이길 수 있습니다.
    --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userInfo.css">

    <%-- ✅ [삭제] 충돌을 일으키는 인라인 <style> 블록 전체 삭제 --%>

</head>

<body>
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:setLocale value="ko_KR"/>

<jsp:include page="../../common/homePageMember/header.jsp"/>

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
                    <%-- 모달을 열기 위한 클래스 (변경 없음) --%>
                    <button type="button" class="btn btn-primary open-update-modal-btn">정보 수정</button>
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

            <section class="privacy-notice">
                <div class="notice-text">

                    <h4>개인정보 보호 안내</h4>
                    <p>회원님의 소중한 개인정보는 안전하게 보호되며, 의료법 및 개인정보보호법에 따라 엄격히 관리됩니다.</p>
                </div>
            </section>
        </section>
    </main>
</div>

<%-- 정보 수정 모달 --%>
<%-- ✅ [수정] 모달을 열기 위한 is-open 클래스가 JS에 의해 제어됩니다. --%>
<div class="modal-overlay update-info-modal-overlay">
    <div class="password-modal update-info-modal">
        <button type="button" class="modal-close" aria-label="닫기">
            ×
        </button>

        <header class="modal-header">
            <h2 class="modal-title">개인 정보 수정</h2>
            <p class="modal-subtitle">수정할 정보를 입력 후 저장 버튼을 눌러주세요.</p>
        </header>

        <div class="modal-body">
            <form class="update-info-form" id="updateInfoForm">

                <input type="hidden" id="update-memberNo" value="${loginMember.memberNo}">

                <div class="field-box">
                    <label for="update-name" class="field-label">성함</label>
                    <input type="text" id="update-name" class="form-input"
                           value="${loginMember.memberName}" required>
                </div>

                <div class="field-box">
                    <label for="update-phone" class="field-label">연락처</label>
                    <input type="tel" id="update-phone" class="form-input"
                           value="${loginMember.memberPhone}" required>
                </div>

                <div class="field-box">
                    <label for="update-email" class="field-label">이메일</label>
                    <input type="email" id="update-email" class="form-input"
                           value="${loginMember.memberEmail}" required>
                </div>

                <div class="field-box address-field">
                    <label for="update-address" class="field-label">주소</label>
                    <div class="address-group">
                        <input type="text" id="update-address" class="form-input"
                               value="${loginMember.memberAddress}" placeholder="주소를 입력하세요">
                    </div>
                </div>

                <div class="error-message" id="updateErrorMessage">
                    정보 수정 중 오류가 발생했습니다.
                </div>
            </form>
        </div>

        <footer class="modal-footer">
            <button type="button" class="btn-cancel update-cancel-btn">취소</button>
            <button type="submit" class="btn-confirm update-save-btn" form="updateInfoForm">저장</button>
        </footer>
    </div>
</div>

<jsp:include page="../../common/homePageFooter/footer.jsp"/>

<script>const contextPath = '${pageContext.request.contextPath}';</script>
<script src="${pageContext.request.contextPath}/js/userInfo.js" defer></script>
</body>

</html>