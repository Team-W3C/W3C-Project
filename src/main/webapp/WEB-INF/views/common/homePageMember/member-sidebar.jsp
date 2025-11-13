<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/member-sidebar.css">

    <style>
        /* 모달 오버레이 */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 9999;
            justify-content: center;
            align-items: center;
        }

        .modal-overlay.active {
            display: flex;
        }

        /* 모달 컨테이너 */
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
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* 닫기 버튼 */
        .modal-close {
            position: absolute;
            top: 16px;
            right: 16px;
            background: none;
            border: none;
            font-size: 28px;
            color: #666;
            cursor: pointer;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
            transition: all 0.2s;
            line-height: 1;
        }

        .modal-close:hover {
            background-color: #f5f5f5;
            color: #333;
        }

        /* 모달 헤더 */
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

        /* 모달 바디 */
        .modal-body {
            padding: 24px;
        }

        /* 정보 박스 */
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

        .info-text {
            font-size: 13px;
            color: #555;
        }

        /* 필드 박스 */
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

        .field-icon {
            flex-shrink: 0;
        }

        .field-info {
            flex: 1;
        }

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

        /* 비밀번호 입력 박스 */
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

        .password-input::placeholder {
            color: #aaa;
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
            transition: all 0.2s;
            flex-shrink: 0;
        }

        .btn-confirm:hover {
            background-color: #0a5f63;
        }

        .btn-confirm:active {
            transform: scale(0.98);
        }

        .btn-confirm:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        /* 모달 푸터 */
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
            transition: all 0.2s;
        }

        .btn-cancel:hover {
            background-color: #f5f5f5;
            border-color: #ccc;
        }

        /* 오류 메시지 */
        .error-message {
            color: #d32f2f;
            font-size: 13px;
            margin-top: 8px;
            padding: 8px 12px;
            background-color: #ffebee;
            border-radius: 4px;
            display: none;
        }

        .error-message.show {
            display: block;
            animation: shake 0.3s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }
    </style>

    <title>회원 사이드바</title>
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
                <a href="${pageContext.request.contextPath}/mychart/history" class="member-sidebar__nav-link">진료내역</a>
            </li>
            <li class="member-sidebar__nav-item">
                <a href="${pageContext.request.contextPath}/mychart/results" class="member-sidebar__nav-link">진단검사결과</a>
            </li>
        </ul>
    </nav>

    <nav class="member-sidebar__nav-group">
        <h3 class="member-sidebar__nav-title">회원정보</h3>
        <ul class="member-sidebar__nav-list">
            <li class="member-sidebar__nav-item">
                <!-- 클릭 시 모달 열기 -->
                <a href="#" id="open-password-modal" class="member-sidebar__nav-link member-sidebar__nav-link--active">회원정보수정</a>
            </li>
            <li class="member-sidebar__nav-item">
                <a href="#" class="member-sidebar__nav-link member-sidebar__nav-link--medium">비밀번호 변경</a>
            </li>
            <li class="member-sidebar__nav-item">
                <a href="${pageContext.request.contextPath}/member/mychart/cancelMember" class="member-sidebar__nav-link">회원 탈퇴</a>
            </li>
        </ul>
    </nav>
</aside>

<!-- 비밀번호 확인 모달 -->
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
                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
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
    // contextPath 설정
    const contextPath = '${pageContext.request.contextPath}';

    // 모달 열기
    function openPasswordModal() {
        document.querySelector('.password-modal-overlay').classList.add('active');
        document.getElementById('password').value = '';
        document.getElementById('errorMessage').classList.remove('show');
        setTimeout(() => {
            document.getElementById('password').focus();
        }, 100);
    }

    // 모달 닫기
    function closePasswordModal() {
        document.querySelector('.password-modal-overlay').classList.remove('active');
        document.getElementById('password').value = '';
        document.getElementById('errorMessage').classList.remove('show');
    }

    // DOM 로드 후 이벤트 등록
    document.addEventListener('DOMContentLoaded', function() {
        // 회원정보수정 링크 클릭 시 모달 열기
        const openModalBtn = document.getElementById('open-password-modal');
        if (openModalBtn) {
            openModalBtn.addEventListener('click', function(e) {
                e.preventDefault();
                openPasswordModal();
            });
        }

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
            if (e.key === 'Escape') {
                const isOpen = document.querySelector('.password-modal-overlay').classList.contains('active');
                if (isOpen) {
                    closePasswordModal();
                }
            }
        });

        // 폼 제출 처리
        const passwordForm = document.getElementById('passwordForm');
        if (passwordForm) {
            passwordForm.addEventListener('submit', async function(e) {
                e.preventDefault();

                const password = document.getElementById('password').value;
                const errorMessage = document.getElementById('errorMessage');
                const submitBtn = this.querySelector('.btn-confirm');

                // 버튼 비활성화 (중복 제출 방지)
                submitBtn.disabled = true;
                submitBtn.textContent = '확인 중...';

                try {
                    // 서버에 비밀번호 확인 요청
                    const response = await fetch(contextPath + '/member/verify-password', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({ password: password })
                    });

                    const result = await response.json();

                    if (result.success) {
                        // 비밀번호 일치 - userinfo 페이지로 이동
                        window.location.href = contextPath + 'homePage/member/userinfo';
                    } else {
                        // 비밀번호 불일치 - 오류 메시지 표시
                        errorMessage.classList.add('show');
                        document.getElementById('password').value = '';
                        document.getElementById('password').focus();

                        // 버튼 원상복귀
                        submitBtn.disabled = false;
                        submitBtn.textContent = '확인';
                    }
                } catch (error) {
                    console.error('비밀번호 확인 중 오류:', error);
                    alert('비밀번호 확인 중 오류가 발생했습니다. 다시 시도해주세요.');

                    // 버튼 원상복귀
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