<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 변경</title>

    <%--
      [수정]
      CSS 링크를 한 곳에 통합합니다.
      (경로는 실제 프로젝트에 맞게 확인해주세요.)
    --%>
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/member-sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ConfirmPasswordModal.css">

    <style>
        /* 기본 폰트 및 색상 설정 */
        body {
            font-family: 'Noto Sans KR', sans-serif;
            color: #2B2B2B; /* Text 기본 */
            background-color: #F8F9F9; /* Sidebar BG */
        }

        /* --- 1. changePassword 페이지 자체 스타일 --- */
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
            padding: 24px 40px;
            background-color: #ffffff;
            border-radius: 12px;
            border: 1px solid #E5E5E5; /* Border/Line */
            margin-left: 24px;
        }
        .mypage-header {
            border-bottom: 2px solid #E5E5E5;
            padding-bottom: 16px;
            margin-bottom: 32px;
        }
        .mypage-header h1 { font-size: 28px; font-weight: 700; color: #2B2B2B; margin: 0 0 8px 0; }
        .mypage-header p { font-size: 15px; color: #6B6B6B; margin: 0; }
        .form-container { max-width: 500px; }
        .form-group { margin-bottom: 24px; }
        .form-group label { display: block; font-size: 14px; font-weight: 600; color: #2B2B2B; margin-bottom: 8px; }
        .form-group input[type="password"] {
            width: 100%;
            padding: 12px 14px;
            font-size: 15px;
            border: 1px solid #E5E5E5;
            border-radius: 8px;
            box-sizing: border-box;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-group input[type="password"]:focus {
            outline: none;
            border-color: #0E787C; /* Primary 기본 */
            box-shadow: 0 0 0 3px #E3F3F4; /* Primary Soft background */
        }
        .error-text { display: none; font-size: 13px; color: #D64545; margin-top: 8px; }
        .error-text.show { display: block; }
        .form-group input.invalid { border-color: #D64545; }
        .form-group input.invalid:focus { box-shadow: 0 0 0 3px rgba(214, 69, 69, 0.1); }
        .btn-submit {
            width: 100%;
            padding: 14px 20px;
            font-size: 16px;
            font-weight: 700;
            color: #ffffff;
            background-color: #0E787C; /* Primary 기본 */
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.2s;
            margin-top: 8px;
        }
        .btn-submit:hover { background-color: #0B5F63; /* Primary Hover */ }
        .btn-submit:disabled { background-color: #E5E5E5; cursor: not-allowed; }

        /* --- 2. member-sidebar.jsp에서 가져온 모달 스타일 --- */
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
        .modal-overlay.active { display: flex; }
        .password-modal {
            background: white;
            border-radius: 12px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            position: relative;
            animation: slideDown 0.3s ease-out;
        }
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .modal-close {
            position: absolute; top: 16px; right: 16px;
            background: none; border: none;
            font-size: 28px; color: #666;
            cursor: pointer; width: 32px; height: 32px;
            display: flex; align-items: center; justify-content: center;
            border-radius: 4px; transition: all 0.2s; line-height: 1;
        }
        .modal-close:hover { background-color: #f5f5f5; color: #333; }
        .modal-header { padding: 24px 24px 16px; border-bottom: 1px solid #e0e0e0; }
        .modal-title { font-size: 24px; font-weight: bold; color: #0E787C; margin: 0 0 8px 0; }
        .modal-subtitle { font-size: 14px; color: #666; margin: 0; }
        .modal-body { padding: 24px; }
        .info-box {
            background-color: #f0fafa; border: 1px solid #d0e8e9;
            border-radius: 8px; padding: 16px; margin-bottom: 20px;
        }
        .info-header { font-size: 14px; font-weight: bold; color: #0E787C; margin-bottom: 8px; }
        .info-text { font-size: 13px; color: #555; }
        .field-box {
            display: flex; align-items: center; gap: 12px;
            padding: 16px; background-color: #fafafa;
            border: 1px solid #e0e0e0; border-radius: 8px;
            margin-bottom: 16px;
        }
        .field-icon { flex-shrink: 0; }
        .field-info { flex: 1; }
        .field-label { font-size: 12px; color: #888; margin-bottom: 4px; }
        .field-value { font-size: 16px; font-weight: bold; color: #333; }
        .password-box { padding: 8px 12px; background-color: white; border: 2px solid #0E787C; gap: 8px; }
        .password-input {
            flex: 1; border: none; outline: none;
            font-size: 15px; padding: 8px; background: transparent;
        }
        .password-input::placeholder { color: #aaa; }
        .btn-confirm {
            background-color: #0E787C; color: white; border: none;
            padding: 10px 24px; border-radius: 6px; font-size: 14px;
            font-weight: bold; cursor: pointer; transition: all 0.2s;
            flex-shrink: 0;
        }
        .btn-confirm:hover { background-color: #0a5f63; }
        .btn-confirm:active { transform: scale(0.98); }
        .btn-confirm:disabled { background-color: #ccc; cursor: not-allowed; }
        .modal-footer {
            padding: 16px 24px; border-top: 1px solid #e0e0e0;
            display: flex; justify-content: flex-end;
        }
        .btn-cancel {
            background-color: white; color: #666; border: 1px solid #ddd;
            padding: 10px 24px; border-radius: 6px; font-size: 14px;
            cursor: pointer; transition: all 0.2s;
        }
        .btn-cancel:hover { background-color: #f5f5f5; border-color: #ccc; }
        .error-message {
            color: #d32f2f; font-size: 13px; margin-top: 8px;
            padding: 8px 12px; background-color: #ffebee;
            border-radius: 4px; display: none;
        }
        .error-message.show { display: block; animation: shake 0.3s ease-in-out; }
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }
    </style>
</head>
<body>

<div class="wrap">

    <jsp:include page="/WEB-INF/views/common/homePageMember/header.jsp" />

    <div class="mypage-container">

        <%-- [수정] <jsp:include> 대신 사이드바 HTML 코드를 직접 삽입 --%>
        <aside class="member-sidebar">
            <div class="member-sidebar__user">
                <h2 class="member-sidebar__user-name">${sessionScope.loginMember.memberName}님</h2>
                <p class="member-sidebar__user-id">병원등록번호 : ${sessionScope.loginMember.memberNo}</p>
            </div>
            <nav class="member-sidebar__nav-group">
                <h3 class="member-sidebar__nav-title">진료서비스</h3>
                <ul class="member-sidebar__nav-list">
                    <li class="member-sidebar__nav-item">
                        <a href="${pageContext.request.contextPath}/member/mychart" class="member-sidebar__nav-link">본인예약현황</a>
                    </li>
                    <li class="member-sidebar__nav-item">
                        <a href="${pageContext.request.contextPath}/member/history" class="member-sidebar__nav-link">진료내역</a>
                    </li>
                    <li class="member-sidebar__nav-item">
                        <a href="${pageContext.request.contextPath}/member/results" class="member-sidebar__nav-link">진단검사결과</a>
                    </li>
                </ul>
            </nav>
            <nav class="member-sidebar__nav-group">
                <h3 class="member-sidebar__nav-title">회원정보</h3>
                <ul class="member-sidebar__nav-list">
                    <li class="member-sidebar__nav-item">
                        <a href="${pageContext.request.contextPath}/member/info" id="open-password-modal" class="member-sidebar__nav-link">회원 정보 수정</a>
                    </li>
                    <li class="member-sidebar__nav-item">
                        <%-- 현재 페이지이므로 active 클래스 적용 --%>
                        <a href="${pageContext.request.contextPath}/member/changePassword" class="member-sidebar__nav-link member-sidebar__nav-link--active member-sidebar__nav-link--medium">비밀번호 변경</a>
                    </li>
                    <li class="member-sidebar__nav-item">
                        <a href="${pageContext.request.contextPath}/member/cancelMember" class="member-sidebar__nav-link">회원 탈퇴</a>
                    </li>
                </ul>
            </nav>
        </aside>

        <main class="mypage-content">
            <div class="mypage-header">
                <h1>비밀번호 변경</h1>
                <p>안전한 계정 사용을 위해 비밀번호를 주기적으로 변경해주세요.</p>
            </div>

            <div class="form-container">
                <form id="changePasswordForm">
                    <div class="form-group">
                        <label for="currentPassword">현재 비밀번호</label>
                        <input type="password" id="currentPassword" name="currentPassword" required>
                        <div class="error-text" id="currentPasswordError"></div>
                    </div>
                    <div class="form-group">
                        <label for="newPassword">새 비밀번호</label>
                        <input type="password" id="newPassword" name="newPassword" required>
                        <div class="error-text" id="newPasswordError"></div>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">새 비밀번호 확인</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required>
                        <div class="error-text" id="confirmPasswordError"></div>
                    </div>
                    <button type="submit" id="submitButton" class="btn-submit">비밀번호 변경</button>
                </form>
            </div>
        </main>
    </div>

    <jsp:include page="/WEB-INF/views/common/homePageFooter/footer.jsp" />
</div>

<%-- [수정] 사이드바의 모달 HTML 코드를 직접 삽입 --%>
<div class="modal-overlay password-modal-overlay">
    <div class="password-modal">
        <button type="button" class="modal-close" aria-label="닫기"> × </button>
        <header class="modal-header">
            <h2 class="modal-title">회원 정보</h2>
            <p class="modal-subtitle">회원 정보를 보시려면 비밀번호를 입력하여 주세요</p>
        </header>
        <div class="modal-body">
            <form class="password-form" id="passwordForm">
                <div class="info-box">
                    <div class="info-header">회원 정보</div>
                    <div class="info-text">회원 정보를 보시려면 비밀번호를 입력하여 주세요</div>
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
                    <input type="password" id="password" class="password-input" placeholder="비밀번호를 입력하세요" required>
                    <button type="submit" class="btn-confirm">확인</button>
                </div>
                <div class="error-message" id="errorMessage">
                    비밀번호가 일치하지 않습니다. 다시 입력해주세요.
                </div>
            </form>
        </div>
        <footer class="modal-footer">
            <button type="button" class="btn-cancel">취소</button>
        </footer>
    </div>
</div>


<script>
    // contextPath 전역 변수 설정
    const contextPath = '${pageContext.request.contextPath}';

    // --- 1. changePassword 페이지 폼 스크립트 ---
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('changePasswordForm');
        const currentPassword = document.getElementById('currentPassword');
        const newPassword = document.getElementById('newPassword');
        const confirmPassword = document.getElementById('confirmPassword');
        const submitButton = document.getElementById('submitButton');

        const currentError = document.getElementById('currentPasswordError');
        const newError = document.getElementById('newPasswordError');
        const confirmError = document.getElementById('confirmPasswordError');

        function clearErrors() {
            [currentError, newError, confirmError].forEach(el => el.classList.remove('show'));
            [currentPassword, newPassword, confirmPassword].forEach(el => el.classList.remove('invalid'));
        }

        if (form) { // 이 페이지의 메인 폼
            form.addEventListener('submit', async function(e) {
                e.preventDefault();
                clearErrors();

                const currentPwd = currentPassword.value;
                const newPwd = newPassword.value;
                const confirmPwd = confirmPassword.value;

                let isValid = true;
                if (!newPwd || newPwd.length < 8) {
                    newError.textContent = '비밀번호는 8자 이상이어야 합니다.';
                    newError.classList.add('show');
                    newPassword.classList.add('invalid');
                    isValid = false;
                }
                if (newPwd !== confirmPwd) {
                    confirmError.textContent = '새 비밀번호가 일치하지 않습니다.';
                    confirmError.classList.add('show');
                    confirmPassword.classList.add('invalid');
                    isValid = false;
                }
                if (!currentPwd) {
                    currentError.textContent = '현재 비밀번호를 입력해주세요.';
                    currentError.classList.add('show');
                    currentPassword.classList.add('invalid');
                    isValid = false;
                }
                if (!isValid) return;

                submitButton.disabled = true;
                submitButton.textContent = '변경 중...';

                try {
                    const response = await fetch(contextPath + '/member/updatePassword', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({
                            currentPassword: currentPwd,
                            newPassword: newPwd
                        })
                    });

                    const result = await response.json();

                    if (result.success) {
                        alert('비밀번호가 성공적으로 변경되었습니다. \n다시 로그인해주세요.');
                        window.location.href = contextPath + '/member/logout.me';
                    } else {
                        if (result.field === 'current') {
                            currentError.textContent = result.message;
                            currentError.classList.add('show');
                            currentPassword.classList.add('invalid');
                            currentPassword.focus();
                        } else {
                            alert(result.message || '비밀번호 변경에 실패했습니다.');
                        }
                    }
                } catch (error) {
                    console.error('Error:', error);
                    alert('서버와 통신 중 오류가 발생했습니다.');
                } finally {
                    submitButton.disabled = false;
                    submitButton.textContent = '비밀번호 변경';
                }
            });
        }
    });

    // --- 2. 사이드바 모달 스크립트 ---
    // (이 스크립트가 DOMContentLoaded 안에 있을 필요는 없습니다.
    //  함수 정의는 밖으로 빼도 됩니다.)

    // 모달 열기
    function openPasswordModal() {
        document.querySelector('.password-modal-overlay').classList.add('active');
        document.getElementById('password').value = '';
        document.getElementById('errorMessage').classList.remove('show');
        setTimeout(() => document.getElementById('password').focus(), 100);
    }

    // 모달 닫기
    function closePasswordModal() {
        document.querySelector('.password-modal-overlay').classList.remove('active');
        document.getElementById('password').value = '';
        document.getElementById('errorMessage').classList.remove('show');
    }

    // 사이드바 모달 이벤트 리스너 등록
    document.addEventListener('DOMContentLoaded', function() {
        // 회원정보수정 링크 클릭 시 모달 열기
        const openModalBtn = document.getElementById('open-password-modal');
        if (openModalBtn) {
            openModalBtn.addEventListener('click', function(e) {
                e.preventDefault();
                openPasswordModal();
            });
        }

        // 닫기 버튼
        const closeBtn = document.querySelector('.modal-close');
        if (closeBtn) closeBtn.addEventListener('click', closePasswordModal);

        // 취소 버튼
        const cancelBtn = document.querySelector('.btn-cancel');
        if (cancelBtn) cancelBtn.addEventListener('click', closePasswordModal);

        // 오버레이 클릭
        const overlay = document.querySelector('.password-modal-overlay');
        if (overlay) {
            overlay.addEventListener('click', function(e) {
                if (e.target === this) closePasswordModal();
            });
        }

        // ESC 키
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && document.querySelector('.password-modal-overlay').classList.contains('active')) {
                closePasswordModal();
            }
        });

        // 모달 폼 제출
        const passwordForm = document.getElementById('passwordForm');
        if (passwordForm) {
            passwordForm.addEventListener('submit', async function(e) {
                e.preventDefault();

                const password = document.getElementById('password').value;
                const errorMessage = document.getElementById('errorMessage');
                const submitBtn = this.querySelector('.btn-confirm');

                submitBtn.disabled = true;
                submitBtn.textContent = '확인 중...';

                try {
                    const response = await fetch(contextPath + '/member/verify-password', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ password: password })
                    });
                    const result = await response.json();

                    if (result.success) {
                        window.location.href = contextPath + '/member/info';
                    } else {
                        errorMessage.classList.add('show');
                        document.getElementById('password').value = '';
                        document.getElementById('password').focus();
                        submitBtn.disabled = false;
                        submitBtn.textContent = '확인';
                    }
                } catch (error) {
                    console.error('비밀번호 확인 중 오류:', error);
                    alert('비밀번호 확인 중 오류가 발생했습니다.');
                    submitBtn.disabled = false;
                    submitBtn.textContent = '확인';
                }
            });
        }

        // 모달 비밀번호 입력 시 오류 숨김
        const passwordInput = document.getElementById('password');
        if (passwordInput) {
            passwordInput.addEventListener('input', function() {
                document.getElementById('errorMessage').classList.remove('show');
            });
        }
    });
</script>

</body>
</html>