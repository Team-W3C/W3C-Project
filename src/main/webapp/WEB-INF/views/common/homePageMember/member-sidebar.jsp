<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/member-sidebar.css">
    <title>회원 사이드바</title>
    <style>
        /* (모달 CSS 등 모든 스타일 코드는 기존과 동일 - 생략) */
        .modal-overlay { display: none; /* ... */ }
        .modal-overlay.active { display: flex; }
        .password-modal { background: white; /* ... */ }
        .modal-close { position: absolute; /* ... */ }
        .modal-header { padding: 24px; /* ... */ }
        .modal-title { font-size: 24px; /* ... */ }
        .modal-subtitle { font-size: 14px; /* ... */ }
        .modal-body { padding: 24px; }
        .info-box { background-color: #f0fafa; /* ... */ }
        .info-header { font-size: 14px; /* ... */ }
        .info-text { font-size: 13px; /* ... */ }
        .field-box { display: flex; /* ... */ }
        .field-icon { flex-shrink: 0; }
        .field-info { flex: 1; }
        .field-label { font-size: 12px; /* ... */ }
        .field-value { font-size: 16px; /* ... */ }
        .password-box { padding: 8px 12px; /* ... */ }
        .password-input { flex: 1; /* ... */ }
        .btn-confirm { background-color: #0E787C; /* ... */ }
        .modal-footer { padding: 16px 24px; /* ... */ }
        .btn-cancel { background-color: white; /* ... */ }
        .error-message { color: #d32f2f; /* ... */ }
        .error-message.show { display: block; /* ... */ }
        @keyframes slideDown { /* ... */ }
        @keyframes shake { /* ... */ }
    </style>
</head>
<body>

<aside class="member-sidebar">
    <div class="member-sidebar__user">
        <h2 class="member-sidebar__user-name">${sessionScope.loginMember.memberName}님</h2>
        <p class="member-sidebar__user-id">병원등록번호 : ${sessionScope.loginMember.memberNo}</p>
    </div>

    <nav class="member-sidebar__nav-group">
        <h3 class="member-sidebar__nav-title">진료서비스</h3>
        <ul class="member-sidebar__nav-list">
            <li class="member-sidebar__nav-item">
                <a href="${pageContext.request.contextPath}/member/mychart" class="member-sidebar__nav-link member-sidebar__nav-link--active">본인예약현황</a>
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

            <%-- 이 링크는 id="open-password-modal"이 있어서 스크립트가 모달을 엽니다. --%>
            <li class="member-sidebar__nav-item">
                <a href="${pageContext.request.contextPath}/member/info" id="open-password-modal" class="member-sidebar__nav-link member-sidebar__nav-link--active">회원 정보 수정</a>
            </li>

            <%-- 이 링크는 id가 없어서 스크립트가 무시하고, 페이지로 이동합니다. --%>
            <li class="member-sidebar__nav-item">
                <a href="${pageContext.request.contextPath}/member/changePassword" class="member-sidebar__nav-link member-sidebar__nav-link--medium">비밀번호 변경</a>
            </li>

            <%-- 이 링크는 id가 없어서 스크립트가 무시하고, 페이지로 이동합니다. --%>
            <li class="member-sidebar__nav-item">
                <a href="${pageContext.request.contextPath}/member/cancelMember" class="member-sidebar__nav-link">회원 탈퇴</a>
            </li>
        </ul>
    </nav>
</aside>

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
            <form class="password-form" id="passwordForm">
                <div class="info-box">
                    <div class="info-header">회원 정보</div>
                    <div class="info-text">회원 정보를 보시려면 비밀번호를 입력하여 주세요</div>
                </div>
                <div class="field-box">
                    <div class="field-icon">
                        <svg width="20" height="20" viewBox="0 0 20" fill="none">
                            <path d="M5 16C5 13.5 7 11 10 11C13 11 15 13.5 15 16" stroke="#0E787C" stroke-width="1.67"/>
                            <circle cx="10" cy="6" r="3" stroke="#0E787C" stroke-width="1.67"/>
                        </svg>
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
    // 모달 열기/닫기 함수
    function openPasswordModal() {
        document.querySelector('.password-modal-overlay').classList.add('active');
        document.getElementById('password').value = '';
        document.getElementById('errorMessage').classList.remove('show');
        setTimeout(() => document.getElementById('password').focus(), 100);
    }

    function closePasswordModal() {
        document.querySelector('.password-modal-overlay').classList.remove('active');
        document.getElementById('password').value = '';
        document.getElementById('errorMessage').classList.remove('show');
    }

    // DOM 로드 후 이벤트 등록
    document.addEventListener('DOMContentLoaded', function() {

        // '회원정보수정' 링크(id="open-password-modal") 클릭 시 모달 열기
        const openModalBtn = document.getElementById('open-password-modal');
        if (openModalBtn) {
            openModalBtn.addEventListener('click', function(e) {
                e.preventDefault(); // a태그의 기본 이동(href)을 막음
                e.stopPropagation(); // 이벤트 전파 중지
                openPasswordModal(); // 모달을 엶
            });
        }

        // '회원 탈퇴' 등 다른 링크가 강제로 페이지 이동하도록 수정
        document.querySelectorAll('.member-sidebar__nav-link').forEach(link => {
            // '회원 정보 수정' 링크가 아닌 다른 모든 링크
            if (link.id !== 'open-password-modal') {

                // 덮어쓰기 위해 capture 옵션을 true로 설정
                link.addEventListener('click', function(e) {

                    e.preventDefault();

                    e.stopPropagation(); // 이벤트 전파 중지

                    window.location.href = this.href;

                }, true);
            }
        });


        // 닫기 버튼 클릭
        const closeBtn = document.querySelector('.modal-close');
        if (closeBtn) {
            closeBtn.addEventListener('click', closePasswordModal);
        }
        // 취소 버튼 클릭
        const cancelBtn = document.querySelector('.btn-cancel');
        if (cancelBtn) {
            cancelBtn.addEventListener('click', closePasswordModal);
        }
        // 오버레이 클릭 시 닫기
        const overlay = document.querySelector('.password-modal-overlay');
        if (overlay) {
            overlay.addEventListener('click', function(e) {
                if (e.target === this) {
                    closePasswordModal();
                }
            });
        }
        // ESC 키로 닫기
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && document.querySelector('.password-modal-overlay.active')) {
                closePasswordModal();
            }
        });

        // '정보 수정' 모달 폼 제출 처리 (AJAX - /member/verify-password)
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
                    // contextPath는 부모 JSP에 선언된 전역 변수를 사용합니다.
                    if (typeof contextPath === 'undefined') {
                        console.error('contextPath 변수가 부모 JSP에 정의되지 않았습니다.');
                        alert('페이지 설정 오류가 발생했습니다. (contextPath 누락)');
                        submitBtn.disabled = false;
                        submitBtn.textContent = '확인';
                        return;
                    }

                    const response = await fetch(contextPath + '/member/verify-password', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ password: password })
                    });
                    const result = await response.json();

                    if (result.success) {
                        closePasswordModal();
                        window.location.href = contextPath + '/member/info';
                    } else {
                        errorMessage.textContent = result.message || '비밀번호가 일치하지 않습니다.';
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

        // 비밀번호 입력 시 오류 메시지 숨기기
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