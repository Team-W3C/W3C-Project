<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%-- JSTL을 사용해 현재 날짜 객체 생성 --%>
<jsp:useBean id="now" class="java.util.Date" />

<c:set var="todayDateString">
    <fmt:formatDate value="${now}" pattern="yyyy.MM.dd.E"/>
</c:set>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 탈퇴</title>
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet"/>
    <%-- 공통 CSS --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/member-sidebar.css">
    <%-- 사이드바 모달 CSS (기존 유지) --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ConfirmPasswordModal.css">

    <style>
        /* --- (모든 CSS는 이전과 동일하게 유지) --- */
        body {
            font-family: 'Noto Sans KR', sans-serif;
            color: #2B2B2B;
            background-color: #F8F9F9;
        }
        .wrap { width: 100%; min-height: 100vh; }
        .mypage-container {
            display: flex;
            width: 100%;
            max-width: 1280px;
            margin: 40px auto;
            min-height: 70vh;
        }
        .mypage-content {
            flex-grow: 1;
            background-color: #ffffff;
            border-radius: 12px;
            border: 1px solid #E5E5E5;
            margin-left: 24px;
        }
        .account-management .info-section-header.danger-zone {
            background: #FEF2F2;
            border-bottom-color: #FEE2E2;
        }
        .account-management .info-section-header.danger-zone h3 {
            color: #B91C1C;
        }
        .account-management .info-section-body {
            padding: 24px;
        }
        .account-management .info-section-body h4 {
            font-size: 16px;
            font-weight: 700;
            color: #1F2937;
            margin-bottom: 8px;
        }
        .account-management .info-section-body .description {
            font-size: 14px;
            color: #4B5563;
            line-height: 1.6;
            margin-bottom: 16px;
        }
        .btn.btn-danger {
            background-color: #DC2626;
            color: white;
            border: none;
            padding: 10px 16px;
            font-size: 14px;
            font-weight: 700;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .btn.btn-danger:hover {
            background-color: #B91C1C;
        }
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 9999;
            justify-content: center;
            align-items: center;
        }
        .modal-overlay.active {
            display: flex;
        }
        .password-modal {
            background: white;
            border-radius: 12px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            position: relative;
        }
        .modal-close {
            position: absolute;
            top: 16px;
            right: 16px;
            background: none;
            border: none;
            font-size: 28px;
            color: #666;
            cursor: pointer;
        }
        .modal-header {
            padding: 24px 24px 16px;
            border-bottom: 1px solid #e0e0e0;
        }
        .modal-title {
            font-size: 24px;
            font-weight: bold;
            color: #0E787C;
            margin: 0 0 8px 0;
        }
        .modal-subtitle {
            font-size: 14px;
            color: #666;
            margin: 0;
        }
        .modal-body { padding: 24px; }
        .info-box {
            background-color: #f0fafa;
            border: 1px solid #d0e8e9;
            border-radius: 8px;
            padding: 16px;
            margin-bottom: 20px;
        }
        .info-header {
            font-size: 14px;
            font-weight: bold;
            color: #0E787C;
            margin-bottom: 8px;
        }
        .info-text { font-size: 13px; color: #555; }
        .field-box {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 16px;
            background-color: #fafafa;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            margin-bottom: 16px;
        }
        .field-icon { flex-shrink: 0; }
        .field-info { flex: 1; }
        .field-label {
            font-size: 12px;
            color: #888;
            margin-bottom: 4px;
        }
        .field-value {
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }
        .password-box {
            padding: 8px 12px;
            background-color: white;
            border: 2px solid #0E787C;
            gap: 8px;
        }
        .password-input {
            flex: 1;
            border: none;
            outline: none;
            font-size: 15px;
            padding: 8px;
            background: transparent;
        }
        .btn-confirm {
            background-color: #0E787C;
            color: white;
            border: none;
            padding: 10px 24px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }
        .modal-footer {
            padding: 16px 24px;
            border-top: 1px solid #e0e0e0;
            display: flex;
            justify-content: flex-end;
        }
        .btn-cancel {
            background-color: white;
            color: #666;
            border: 1px solid #ddd;
            padding: 10px 24px;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
        }
        .error-message {
            color: #d32f2f;
            font-size: 13px;
            margin-top: 8px;
            display: none;
        }
        .error-message.show { display: block; }
        .withdrawal-content-area {
            margin-top: 24px;
            border-top: 1px solid #E5E5E5;
            padding-top: 24px;
            display: none;
        }
        .withdrawal-form-inline {
            background: #FDFDFD;
            border: 1px solid #E5E5E5;
            border-radius: 8px;
            padding: 24px;
        }
        .withdrawal-form-inline .form-header {
            text-align: center;
            margin-bottom: 24px;
        }
        .withdrawal-form-inline .form-title {
            font-size: 20px;
            font-weight: bold;
            color: #0E787C;
            margin: 0 0 8px 0;
        }
        .withdrawal-form-inline .form-subtitle {
            font-size: 14px;
            color: #666;
            margin: 0;
        }
        .withdrawal-form-inline .info-card {
            display: flex;
            align-items: center;
            background: #fff;
            border: 1px solid #E0E0E0;
            border-radius: 8px;
            padding: 16px;
            margin-bottom: 16px;
            gap: 16px;
        }
        .withdrawal-form-inline .info-icon { flex-shrink: 0; }
        .withdrawal-form-inline .info-content { flex-grow: 1; }
        .withdrawal-form-inline .info-label {
            display: block;
            font-size: 12px;
            color: #888;
            margin-bottom: 4px;
        }
        .withdrawal-form-inline .info-value {
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }
        .withdrawal-form-inline .consent-section {
            margin-top: 20px;
            text-align: center;
            background: #F8F9F9;
            padding: 20px;
            border-radius: 8px;
        }
        .withdrawal-form-inline .consent-label {
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 8px;
            color: #1F2937;
        }
        .withdrawal-form-inline .consent-text {
            font-size: 14px;
            color: #4B5563;
            line-height: 1.6;
            margin-bottom: 16px;
        }
        .withdrawal-form-inline .btn-agree {
            background-color: #0E787C;
            color: white;
            border: none;
            padding: 10px 24px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }
        .withdrawal-form-inline .form-actions {
            margin-top: 16px;
            text-align: right;
        }
        .password-form-inline {
            background: #FDFDFD;
            border: 1px solid #E5E5E5;
            border-radius: 8px;
            padding: 24px;
        }
        .password-form-inline .form-header {
            border-bottom: 1px solid #e0e0e0;
            padding-bottom: 16px;
            margin-bottom: 24px;
        }
        .password-form-inline .form-title {
            font-size: 20px;
            font-weight: bold;
            color: #0E787C;
            margin: 0 0 8px 0;
        }
        .password-form-inline .form-subtitle {
            font-size: 14px;
            color: #666;
            margin: 0;
        }
        .password-form-inline .form-body {
            padding: 0;
        }
        .password-form-inline .form-footer {
            padding-top: 16px;
            margin-top: 24px;
            border-top: 1px solid #e0e0e0;
            display: flex;
            justify-content: flex-end;
        }
    </style>
</head>
<body>

<div class="wrap">

    <jsp:include page="/WEB-INF/views/common/homePageMember/header.jsp" />

    <div class="mypage-container">

        <jsp:include page="/WEB-INF/views/common/homePageMember/member-sidebar.jsp" />

        <main class="mypage-content">
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

                    <%-- JS가 폼을 삽입할 영역 --%>
                    <div id="withdrawal-content-area" class="withdrawal-content-area">
                    </div>

                    <%--
                      ✅ [신규]
                      JSP가 JS 대신 템플릿을 미리 만들어 둡니다.
                      이름과 날짜가 JSTL/EL에 의해 여기에 직접 렌더링됩니다.
                    --%>
                    <template id="withdrawal-step1-template">
                        <div class="withdrawal-form-inline">
                            <header class="form-header">
                                <h2 class="form-title">
                                    <svg class="icon-alert" width="18" height="18" viewBox="0 0 18 18" style="vertical-align: middle; margin-right: 4px;"><path d="M9 1L2 15L16 15L9 1Z" stroke="#0E787C" stroke-width="2" fill="none"/><line x1="9" y1="6" x2="9" y2="11" stroke="#0E787C" stroke-width="2"/></svg>
                                    탈퇴 확인
                                </h2>
                                <p class="form-subtitle">탈퇴를 진행하시겠습니까?</p>
                            </header>
                            <div class="info-card">
                                <div class="info-icon">
                                    <svg width="20" height="20" viewBox="0 0 20 20"><rect x="3" y="3" width="14" height="14" rx="1" stroke="#0E787C" stroke-width="1.67" fill="none"/><line x1="6" y1="2" x2="6" y2="5" stroke="#0E787C" stroke-width="1.67"/><line x1="14" y1="2" x2="14" y2="5" stroke="#0E787C" stroke-width="1.67"/><line x1="3" y1="8" x2="17" y2="8" stroke="#0E787C" stroke-width="1.67"/></svg>
                                </div>
                                <div class="info-content">
                                    <span class="info-label">탈퇴 날짜</span>
                                    <%-- JSP가 직접 값을 렌더링 --%>
                                    <span class="info-value">${todayDateString}</span>
                                </div>
                            </div>
                            <div class="info-card">
                                <div class="info-icon">
                                    <svg width="20" height="20" viewBox="0 0 20 20"><circle cx="10" cy="7" r="3" stroke="#0E787C" stroke-width="1.67" fill="none"/><path d="M5 17C5 14 7 12 10 12C13 12 15 14 15 17" stroke="#0E787C" stroke-width="1.67" fill="none"/></svg>
                                </div>
                                <div class="info-content">
                                    <span class="info-label">성함</span>
                                    <%-- JSP가 직접 값을 렌더링 --%>
                                    <span class="info-value"><c:out value="${sessionScope.loginMember.memberName}"/></span>
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
                                <button type="button" class="btn-agree" id="inline-agree-btn">동의</button>
                            </section>
                            <div class="form-actions">
                                <button type="button" class="btn-cancel" id="inline-cancel-btn">취소</button>
                            </div>
                        </div>
                    </template>

                    <%-- ✅ [신규] 2단계 템플릿 --%>
                    <template id="withdrawal-step2-template">
                        <div class="password-form-inline">
                            <header class="form-header">
                                <h2 class="form-title">비밀번호 확인</h2>
                                <p class="form-subtitle">회원 탈퇴를 완료하려면 비밀번호를 입력해 주세요</p>
                            </header>
                            <div class="form-body">
                                <form id="withdrawalPasswordFormInline">
                                    <div class="info-box">
                                        <div class="info-header">회원 정보</div>
                                        <div class="info-text">회원 탈퇴를 위한 본인 확인 절차입니다.</div>
                                    </div>
                                    <div class="field-box">
                                        <div class="field-icon">
                                            <svg width="20" height="20" viewBox="0 0 20 20" fill="none"><path d="M5 16C5 13.5 7 11 10 11C13 11 15 13.5 15 16" stroke="#0E787C" stroke-width="1.67"/><circle cx="10" cy="6" r="3" stroke="#0E787C" stroke-width="1.67"/></svg>
                                        </div>
                                        <div class="field-info">
                                            <div class="field-label">성함</div>
                                            <%-- JSP가 직접 값을 렌더링 --%>
                                            <div class="field-value"><c:out value="${sessionScope.loginMember.memberName}"/></div>
                                        </div>
                                    </div>
                                    <div class="field-box password-box">
                                        <input type="password" id="withdrawal-password-inline" class="password-input" placeholder="비밀번호를 입력하세요" required>
                                        <button type="submit" class="btn-confirm">탈퇴 완료</button>
                                    </div>
                                    <div class="error-message"></div>
                                </form>
                            </div>
                            <footer class="form-footer">
                                <button type="button" class="btn-cancel" id="inline-cancel-btn">취소</button>
                            </footer>
                        </div>
                    </template>

                </div>
            </section>
        </main>

    </div> <%-- .mypage-container 닫기 --%>


    <%-- 사이드바 '회원 정보 수정' 모달 (유지) --%>
    <div class="modal-overlay" id="sidebar-password-modal">
        <%-- (모달 코드는 변경 없음) --%>
        <div class="password-modal">
            <button type="button" class="modal-close" aria-label="닫기"> × </button>
            <header class="modal-header">
                <h2 class="modal-title">회원 정보</h2>
                <p class="modal-subtitle">회원 정보를 보시려면 비밀번호를 입력하여 주세요</p>
            </header>
            <div class="modal-body">
                <form id="sidebarPasswordForm">
                    <div class="info-box">
                        <div class="info-header">회원 정보</div>
                        <div class="info-text">회원 정보를 위한 본인 확인 절차입니다.</div>
                    </div>
                    <div class="field-box">
                        <div class="field-icon">
                            <svg width="20" height="20" viewBox="0 0 20 20" fill="none"><path d="M5 16C5 13.5 7 11 10 11C13 11 15 13.5 15 16" stroke="#0E787C" stroke-width="1.67"/><circle cx="10" cy="6" r="3" stroke="#0E787C" stroke-width="1.67"/></svg>
                        </div>
                        <div class="field-info">
                            <div class="field-label">성함</div>
                            <div class="field-value">${sessionScope.loginMember.memberName}</div>
                        </div>
                    </div>
                    <div class="field-box password-box">
                        <input type="password" id="sidebar-password" class="password-input" placeholder="비밀번호를 입력하세요" required>
                        <button type="submit" class="btn-confirm">확인</button>
                    </div>
                    <div class="error-message"></div>
                </form>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn-cancel">취소</button>
            </footer>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/homePageFooter/footer.jsp" />

</div> <%-- .wrap 닫기 --%>


<script>
    const contextPath = '${pageContext.request.contextPath}';

    document.addEventListener('DOMContentLoaded', function() {

        // --- 1. 공통 변수 선언 (사이드바) ---
        const sidebarModal = document.getElementById('sidebar-password-modal');
        const openSidebarModalBtn = document.getElementById('open-password-modal');
        const sidebarForm = document.getElementById('sidebarPasswordForm');

        // --- 2. 사이드바 '회원정보 수정' 모달 로직 (변경 없음) ---
        if (openSidebarModalBtn && sidebarModal && sidebarForm) {
            openSidebarModalBtn.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                sidebarModal.classList.add('active');
                sidebarForm.reset();
                sidebarModal.querySelector('.error-message').classList.remove('show');
                setTimeout(() => sidebarModal.querySelector('#sidebar-password').focus(), 100);
            });

            sidebarForm.addEventListener('submit', async function(e) {
                e.preventDefault();
                const password = sidebarModal.querySelector('#sidebar-password').value;
                const errorMessage = sidebarModal.querySelector('.error-message');
                const submitBtn = sidebarModal.querySelector('.btn-confirm');
                submitBtn.disabled = true;
                submitBtn.textContent = '확인 중...';

                try {
                    const response = await fetch(contextPath + '/member/verify-password', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/json'},
                        body: JSON.stringify({ password: password })
                    });
                    const result = await response.json();
                    if (result.success) {
                        window.location.href = contextPath + '/member/info';
                    } else {
                        errorMessage.textContent = result.message || '비밀번호가 일치하지 않습니다.';
                        errorMessage.classList.add('show');
                        submitBtn.disabled = false;
                        submitBtn.textContent = '확인';
                    }
                } catch (error) {
                    console.error('Verify Password Error:', error);
                    errorMessage.textContent = '서버 통신 오류';
                    errorMessage.classList.add('show');
                    submitBtn.disabled = false;
                    submitBtn.textContent = '확인';
                }
            });
        }

        // --- 3. '회원 탈퇴' 인라인 폼 로직 ---

        const openWithdrawalBtn = document.getElementById('open-withdrawal-modal');
        const withdrawalContentArea = document.getElementById('withdrawal-content-area');

        // ✅ [삭제] HTML 템플릿 함수들 (getStep1AgreementHTML, getStep2PasswordHTML) 모두 삭제

        // --- 인라인 폼 이벤트 핸들러 ---
        if (openWithdrawalBtn && withdrawalContentArea) {

            // (A) '회원 탈퇴하기' 버튼(id="open-withdrawal-modal") 클릭 시
            openWithdrawalBtn.addEventListener('click', function() {

                // ✅ [수정] 템플릿 태그에서 1단계 폼을 복사
                const template = document.getElementById('withdrawal-step1-template');
                if (!template) {
                    console.error('1단계 탈퇴 템플릿을 찾을 수 없습니다.');
                    return;
                }
                const content = template.content.cloneNode(true);

                // 1단계 폼 삽입
                withdrawalContentArea.innerHTML = ''; // 기존 내용 비우기
                withdrawalContentArea.appendChild(content); // 복사한 템플릿 삽입
                withdrawalContentArea.style.display = 'block';
                openWithdrawalBtn.style.display = 'none';

                withdrawalContentArea.scrollIntoView({ behavior: 'smooth', block: 'center' });
            });

            // (B) 이벤트 위임 사용 (동의, 취소, 제출)
            withdrawalContentArea.addEventListener('click', function(e) {
                // 1단계 '동의' 버튼(#inline-agree-btn) 클릭
                if (e.target.id === 'inline-agree-btn') {

                    // ✅ [수정] 템플릿 태그에서 2단계 폼을 복사
                    const template = document.getElementById('withdrawal-step2-template');
                    if (!template) {
                        console.error('2단계 탈퇴 템플릿을 찾을 수 없습니다.');
                        return;
                    }
                    const content = template.content.cloneNode(true);

                    // 2단계 폼으로 교체
                    withdrawalContentArea.innerHTML = ''; // 기존 내용 비우기
                    withdrawalContentArea.appendChild(content); // 복사한 템플릿 삽입
                    withdrawalContentArea.scrollIntoView({ behavior: 'smooth', block: 'center' });

                    setTimeout(() => document.getElementById('withdrawal-password-inline').focus(), 100);
                }

                // '취소' 버튼(#inline-cancel-btn) 클릭 (1, 2단계 공통)
                if (e.target.id === 'inline-cancel-btn') {
                    withdrawalContentArea.innerHTML = '';
                    withdrawalContentArea.style.display = 'none';
                    openWithdrawalBtn.style.display = 'block';
                }
            });

            // (B-2) 폼 제출(submit) 이벤트 처리 (변경 없음)
            withdrawalContentArea.addEventListener('submit', async function(e) {
                if (e.target.id === 'withdrawalPasswordFormInline') {
                    e.preventDefault();
                    const form = e.target;
                    const password = form.querySelector('#withdrawal-password-inline').value;
                    const errorMessage = form.querySelector('.error-message');
                    const submitBtn = form.querySelector('.btn-confirm');

                    if (!password) {
                        errorMessage.textContent = '비밀번호를 입력해주세요.';
                        errorMessage.classList.add('show');
                        return;
                    }

                    submitBtn.disabled = true;
                    submitBtn.textContent = '처리 중...';

                    try {
                        const response = await fetch(contextPath + '/member/deleteAccount', {
                            method: 'POST',
                            headers: {'Content-Type': 'application/json'},
                            body: JSON.stringify({ password: password })
                        });

                        const result = await response.json();
                        if (result.success) {
                            alert('회원 탈퇴가 완료되었습니다.');
                            window.location.href = contextPath + '/member/logout.me';
                        } else {
                            errorMessage.textContent = result.message || '비밀번호가 일치하지 않습니다.';
                            errorMessage.classList.add('show');
                            submitBtn.disabled = false;
                            submitBtn.textContent = '탈퇴 완료';
                        }
                    } catch (error) {
                        console.error('Account Deletion Error:', error);
                        errorMessage.textContent = '서버 통신 오류. 다시 시도해주세요.';
                        errorMessage.classList.add('show');
                        submitBtn.disabled = false;
                        submitBtn.textContent = '탈퇴 완료';
                    }
                }
            });
        }

        // --- 4. 공통 모달 닫기 로직 (사이드바 모달 전용) ---
        document.querySelectorAll('#sidebar-password-modal .modal-close, #sidebar-password-modal .btn-cancel').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const parentModal = e.target.closest('.modal-overlay');
                if (parentModal) {
                    parentModal.classList.remove('active');
                }
            });
        });

        if(sidebarModal) {
            sidebarModal.addEventListener('click', function(e) {
                if (e.target === sidebarModal) {
                    sidebarModal.classList.remove('active');
                }
            });
        }

        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                document.querySelectorAll('.modal-overlay.active').forEach(modal => {
                    modal.classList.remove('active');
                });
                if (withdrawalContentArea && withdrawalContentArea.style.display === 'block') {
                    withdrawalContentArea.innerHTML = '';
                    withdrawalContentArea.style.display = 'none';
                    openWithdrawalBtn.style.display = 'block';
                }
            }
        });
    });
</script>

</body>
</html>