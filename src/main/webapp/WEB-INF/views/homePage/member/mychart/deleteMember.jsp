<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy.MM.dd.E" var="todayDateString"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 탈퇴</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/member-sidebar.css">

    <%--
      이 페이지의 스타일은 <style> 블록 안에 인라인으로 작성되어 있으므로,
      외부 CSS 파일 링크는 필요하지 않을 수 있습니다.
      (만약 별도 CSS 파일이 있다면 여기에 추가)
    --%>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: #F5F7FA;
            color: #1A202C;
            line-height: 1.6;
        }

        .wrap {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .mypage-container {
            display: flex;
            max-width: 1280px;
            width: 100%;
            margin: 40px auto;
            gap: 24px;
            flex: 1;
            padding: 0 20px;
        }

        .mypage-content {
            flex: 1;
            background: #FFFFFF;
            border-radius: 16px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        /* ===== 헤더 영역 ===== */
        .page-header {
            background: linear-gradient(135deg, #EF4444 0%, #DC2626 100%);
            padding: 40px;
            color: white;
            text-align: center;
        }

        .page-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .page-header p {
            font-size: 15px;
            opacity: 0.9;
        }

        /* ===== 컨텐츠 영역 ===== */
        .content-wrapper {
            padding: 48px;
            max-width: 700px;
            margin: 0 auto;
        }

        /* 경고 박스 */
        .warning-box {
            background: #FEF2F2;
            border: 2px solid #FEE2E2;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 32px;
        }

        .warning-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }

        .warning-icon {
            width: 32px;
            height: 32px;
            background: #DC2626;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
            font-weight: bold;
            flex-shrink: 0;
        }

        .warning-title {
            font-size: 18px;
            font-weight: 700;
            color: #991B1B;
        }

        .warning-list {
            list-style: none;
            padding: 0;
        }

        .warning-list li {
            padding: 10px 0 10px 44px;
            position: relative;
            color: #7F1D1D;
            font-size: 14px;
            line-height: 1.6;
        }

        .warning-list li:before {
            content: "•";
            position: absolute;
            left: 32px;
            font-weight: bold;
            color: #DC2626;
        }

        /* 섹션 */
        .section {
            margin-bottom: 40px;
        }

        .section-title {
            font-size: 18px;
            font-weight: 700;
            color: #1A202C;
            margin-bottom: 16px;
            padding-bottom: 12px;
            border-bottom: 2px solid #E2E8F0;
        }

        /* 정보 카드 */
        .info-cards {
            display: grid;
            gap: 16px;
            margin-bottom: 32px;
        }

        .info-card {
            background: #F8FAFC;
            border: 1px solid #E2E8F0;
            border-radius: 10px;
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .info-icon {
            width: 48px;
            height: 48px;
            background: white;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .info-content {
            flex: 1;
        }

        .info-label {
            font-size: 13px;
            color: #64748B;
            margin-bottom: 4px;
        }

        .info-value {
            font-size: 16px;
            font-weight: 600;
            color: #1A202C;
        }

        /* 체크박스 리스트 */
        .checkbox-list {
            background: #FFFFFF;
            border: 1px solid #E2E8F0;
            border-radius: 10px;
            padding: 20px;
        }

        .checkbox-item {
            display: flex;
            align-items: flex-start;
            padding: 16px 0;
            border-bottom: 1px solid #F1F5F9;
        }

        .checkbox-item:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .checkbox-item:first-child {
            padding-top: 0;
        }

        .checkbox-wrapper {
            position: relative;
            display: flex;
            align-items: center;
            margin-right: 16px;
        }

        .checkbox-wrapper input[type="checkbox"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
            margin: 0;
            accent-color: #DC2626;
        }

        .checkbox-text {
            flex: 1;
            font-size: 14px;
            color: #475569;
            line-height: 1.6;
            cursor: pointer;
        }

        /* 비밀번호 입력 영역 */
        .password-section {
            background: #F8FAFC;
            border: 2px solid #E2E8F0;
            border-radius: 12px;
            padding: 24px;
            margin-top: 32px;
            display: none;
        }

        .password-section.show {
            display: block;
            animation: slideDown 0.3s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .password-input-group {
            margin-top: 16px;
        }

        .password-input-wrapper {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .password-input {
            flex: 1;
            padding: 14px 16px;
            border: 2px solid #CBD5E1;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.2s;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .password-input:focus {
            outline: none;
            border-color: #DC2626;
            box-shadow: 0 0 0 3px rgba(220, 38, 38, 0.1);
        }

        .error-message {
            color: #DC2626;
            font-size: 13px;
            margin-top: 8px;
            display: none;
        }

        .error-message.show {
            display: block;
        }

        /* 버튼 */
        .button-group {
            display: flex;
            gap: 12px;
            margin-top: 32px;
            justify-content: center;
        }

        .btn {
            padding: 14px 32px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .btn-danger {
            background: #DC2626;
            color: white;
        }

        .btn-danger:hover:not(:disabled) {
            background: #B91C1C;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3);
        }

        .btn-danger:disabled {
            background: #CBD5E1;
            cursor: not-allowed;
        }

        .btn-secondary {
            background: #F1F5F9;
            color: #475569;
            border: 1px solid #CBD5E1;
        }

        .btn-secondary:hover {
            background: #E2E8F0;
        }

        .btn-confirm {
            background: #DC2626;
            color: white;
            padding: 14px 28px;
        }

        .btn-confirm:hover:not(:disabled) {
            background: #B91C1C;
        }

        .btn-confirm:disabled {
            background: #CBD5E1;
            cursor: not-allowed;
        }

        /* 반응형 */
        @media (max-width: 768px) {
            .mypage-container {
                flex-direction: column;
                margin: 20px auto;
                padding: 0 16px;
            }

            .content-wrapper {
                padding: 32px 24px;
            }

            .page-header {
                padding: 32px 24px;
            }

            .page-header h1 {
                font-size: 24px;
            }

            .button-group {
                flex-direction: column-reverse;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<div class="wrap">
    <jsp:include page="/WEB-INF/views/common/homePageMember/header.jsp" />

    <div class="mypage-container">
        <jsp:include page="/WEB-INF/views/common/homePageMember/member-sidebar.jsp" />

        <main class="mypage-content">
            <div class="page-header">
                <h1>회원 탈퇴</h1>
                <p>탈퇴 전 아래 내용을 반드시 확인해 주세요</p>
            </div>

            <div class="content-wrapper">
                <div class="warning-box">
                    <div class="warning-header">
                        <div class="warning-icon">!</div>
                        <h2 class="warning-title">탈퇴 시 주의사항</h2>
                    </div>
                    <ul class="warning-list">
                        <li>회원 탈퇴 시 모든 개인정보가 즉시 삭제되며 복구가 불가능합니다.</li>
                        <li>진료 기록은 의료법에 따라 10년간 보관되며 삭제되지 않습니다.</li>
                        <li>탈퇴 후 동일한 아이디로 재가입이 불가능할 수 있습니다.</li>
                        <li>진행 중인 예약이나 상담 내역이 있다면 먼저 취소해 주세요.</li>
                    </ul>
                </div>

                <div class="section">
                    <h3 class="section-title">회원 정보</h3>
                    <div class="info-cards">
                        <div class="info-card">
                            <div class="info-icon">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                    <path d="M20 21V19C20 17.9391 19.5786 16.9217 18.8284 16.1716C18.0783 15.4214 17.0609 15 16 15H8C6.93913 15 5.92172 15.4214 5.17157 16.1716C4.42143 16.9217 4 17.9391 4 19V21" stroke="#DC2626" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                    <circle cx="12" cy="7" r="4" stroke="#DC2626" stroke-width="2"/>
                                </svg>
                            </div>
                            <div class="info-content">
                                <div class="info-label">성함</div>
                                <div class="info-value">${sessionScope.loginMember.memberName}</div>
                            </div>
                        </div>

                        <div class="info-card">
                            <div class="info-icon">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                    <rect x="3" y="4" width="18" height="18" rx="2" stroke="#DC2626" stroke-width="2"/>
                                    <line x1="3" y1="10" x2="21" y2="10" stroke="#DC2626" stroke-width="2"/>
                                    <line x1="8" y1="2" x2="8" y2="6" stroke="#DC2626" stroke-width="2" stroke-linecap="round"/>
                                    <line x1="16" y1="2" x2="16" y2="6" stroke="#DC2626" stroke-width="2" stroke-linecap="round"/>
                                </svg>
                            </div>
                            <div class="info-content">
                                <div class="info-label">탈퇴 날짜</div>
                                <div class="info-value">${todayDateString}</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="section">
                    <h3 class="section-title">탈퇴 동의</h3>
                    <div class="checkbox-list">
                        <div class="checkbox-item">
                            <div class="checkbox-wrapper">
                                <input type="checkbox" id="agree1" class="agree-checkbox">
                            </div>
                            <label for="agree1" class="checkbox-text">
                                위 주의사항을 모두 확인하였으며, 이에 동의합니다.
                            </label>
                        </div>

                        <div class="checkbox-item">
                            <div class="checkbox-wrapper">
                                <input type="checkbox" id="agree2" class="agree-checkbox">
                            </div>
                            <label for="agree2" class="checkbox-text">
                                회원 탈퇴 시 개인정보가 삭제되며 복구가 불가능함을 이해하였습니다.
                            </label>
                        </div>

                        <div class="checkbox-item">
                            <div class="checkbox-wrapper">
                                <input type="checkbox" id="agree3" class="agree-checkbox">
                            </div>
                            <label for="agree3" class="checkbox-text">
                                진료 기록은 의료법에 따라 10년간 보관됨을 확인하였습니다.
                            </label>
                        </div>
                    </div>
                </div>

                <div class="password-section" id="passwordSection">
                    <h3 class="section-title">본인 확인</h3>
                    <p style="color: #64748B; font-size: 14px; margin-bottom: 16px;">
                        회원 탈퇴를 완료하려면 비밀번호를 입력해 주세요.
                    </p>
                    <form id="withdrawalForm">
                        <div class="password-input-group">
                            <div class="password-input-wrapper">
                                <input
                                        type="password"
                                        id="passwordInput"
                                        class="password-input"
                                        placeholder="비밀번호를 입력하세요"
                                        autocomplete="current-password"
                                >
                            </div>
                            <div class="error-message" id="errorMessage"></div>
                        </div>
                    </form>
                </div>

                <div class="button-group">
                    <button type="button" class="btn btn-secondary" id="cancelBtn">
                        취소
                    </button>
                    <button type="button" class="btn btn-danger" id="nextBtn" disabled>
                        다음 단계
                    </button>
                    <button type="submit" class="btn btn-danger" id="finalWithdrawalBtn" form="withdrawalForm" style="display: none;">
                        탈퇴 완료
                    </button>
                </div>
            </div>
        </main>
    </div>

    <jsp:include page="/WEB-INF/views/common/homePageFooter/footer.jsp" />
</div>

<%--
  ================================================
  ✅ 수정된 스크립트
  ================================================
  - 불필요한 이벤트 리스너를 제거하고,
    체크박스의 'change' 이벤트 하나로 버튼 상태를 제어하도록 단순화했습니다.
  - '탈퇴 완료' 버튼의 form 속성을 이용해 폼을 제출하도록 수정했습니다.
--%>
<script>

    document.addEventListener('DOMContentLoaded', function() {
        let contextPath = '${pageContext.request.contextPath}';

        // DOM 요소 가져오기
        const checkboxes = document.querySelectorAll('.agree-checkbox');
        console.log(checkboxes);
        const nextBtn = document.getElementById('nextBtn');
        const finalWithdrawalBtn = document.getElementById('finalWithdrawalBtn');
        const passwordSection = document.getElementById('passwordSection');
        const cancelBtn = document.getElementById('cancelBtn');
        const withdrawalForm = document.getElementById('withdrawalForm');
        const passwordInput = document.getElementById('passwordInput');
        const errorMessage = document.getElementById('errorMessage');

        // 체크 상태를 확인하고 '다음 단계' 버튼을 업데이트하는 함수
        function updateNextButtonState() {
            // 모든 체크박스가 체크되었는지 확인
            const allChecked = Array.from(checkboxes).every(cb => cb.checked);

            // 비밀번호 섹션이 아직 보이지 않을 때만 '다음 단계' 버튼 상태를 업데이트
            if (!passwordSection.classList.contains('show')) {
                nextBtn.disabled = !allChecked;
            }
        }

        // 페이지 로드 시 및 각 체크박스 변경 시 버튼 상태 업데이트
        updateNextButtonState(); // 페이지 로드 시 초기 상태
        checkboxes.forEach(checkbox => {
            // 'click' 대신 'change' 이벤트를 사용해야 라벨을 클릭해도 동작합니다.
            checkbox.addEventListener('change', updateNextButtonState);
        });

        // '다음 단계' 버튼 클릭 이벤트
        nextBtn.addEventListener('click', function() {
            if (nextBtn.disabled) return; // 버튼이 비활성화면 중단

            // 비밀번호 섹션 표시
            passwordSection.classList.add('show');
            passwordSection.scrollIntoView({ behavior: 'smooth', block: 'center' });
            setTimeout(() => passwordInput.focus(), 300); // 애니메이션 후 포커스

            // 버튼 상태 변경: '다음 단계' 숨기고 '탈퇴 완료' 표시
            nextBtn.style.display = 'none';
            finalWithdrawalBtn.style.display = 'block';
        });

        // '취소' 버튼 클릭 이벤트
        cancelBtn.addEventListener('click', function() {
            if (confirm('회원 탈퇴를 취소하시겠습니까?')) {
                // 사용자가 'mypage' 또는 'main' 등 원하는 페이지로 이동
                window.location.href = contextPath + '/member/mypage';
            }
        });

        // '탈퇴 완료' 버튼은 'submit' 타입이며 form 속성으로 폼을 지정했으므로,
        // 별도의 'click' 이벤트 리스너 대신 'form'의 'submit' 이벤트를 처리합니다.

        // 폼 제출 이벤트 (탈퇴 처리)
        withdrawalForm.addEventListener('submit', async function(e) {
            e.preventDefault(); // 폼의 기본 제출 동작 중단

            const password = passwordInput.value.trim();

            // 비밀번호 유효성 검사
            if (!password) {
                errorMessage.textContent = '비밀번호를 입력해 주세요.';
                errorMessage.classList.add('show');
                passwordInput.focus();
                return;
            }

            // 최종 탈퇴 확인
            if (!confirm('정말로 회원 탈퇴를 진행하시겠습니까?\n\n이 작업은 되돌릴 수 없습니다.')) {
                return; // 사용자가 '취소'를 누르면 중단
            }

            // 버튼 비활성화 및 로딩 상태 표시
            finalWithdrawalBtn.disabled = true;
            finalWithdrawalBtn.textContent = '처리 중...';
            errorMessage.classList.remove('show');

            try {
                // 서버로 탈퇴 요청
                const response = await fetch(contextPath + '/member/deleteAccount', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ password: password })
                });

                const result = await response.json();

                if (result.success) {
                    // 탈퇴 성공
                    alert('회원 탈퇴가 완료되었습니다.\n그동안 이용해 주셔서 감사합니다.');
                    window.location.href = contextPath + '/member/logout.me'; // 로그아웃 및 메인페이지 이동
                } else {
                    // 탈퇴 실패 (비밀번호 오류 등)
                    errorMessage.textContent = result.message || '비밀번호가 일치하지 않습니다.';
                    errorMessage.classList.add('show');
                    finalWithdrawalBtn.disabled = false;
                    finalWithdrawalBtn.textContent = '탈퇴 완료';
                    passwordInput.value = ''; // 비밀번호 필드 비우기
                    passwordInput.focus();
                }
            } catch (error) {
                // 네트워크 오류 등
                console.error('Account Deletion Error:', error);
                errorMessage.textContent = '서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.';
                errorMessage.classList.add('show');
                finalWithdrawalBtn.disabled = false;
                finalWithdrawalBtn.textContent = '탈퇴 완료';
            }
        });
    });
</script>

</body>
</html>