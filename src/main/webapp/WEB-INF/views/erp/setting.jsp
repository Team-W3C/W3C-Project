<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>설정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/setting.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/erp/header.jsp"/>

<jsp:include page="/WEB-INF/views/common/erp/sidebar.jsp"/>

<main class="settings-main">

    <h1 class="settings-page-title">설정</h1>

    <div class="settings-card">

        <div class="settings-tabs-header" role="tablist">
            <button
                    class="settings-tab-btn active"
                    role="tab"
                    aria-selected="true"
                    aria-controls="personal-panel"
                    data-tab="personal"
            >
                개인 정보 설정
            </button>
        </div>

        <div class="settings-tab-content">

            <section
                    class="settings-tab-pane active"
                    id="personal-panel"
                    role="tabpanel"
                    aria-labelledby="personal-tab"
            >
                <div class="settings-info-message">
                    개인 정보를 안전하게 관리하세요. 비밀번호는 정기적으로 변경하는 것을 권장합니다.
                </div>

                <form id="settings-form" action="${pageContext.request.contextPath}/erp/updateMember" method="post">

                    <div class="settings-password-section">
                        <h3 class="settings-section-title">비밀번호 변경</h3>
                        <div class="settings-password-grid">
                            <div class="settings-password-fields">
                                <div class="settings-form-group">
                                    <label class="settings-form-label" for="current-password">현재 비밀번호</label>
                                    <input
                                            type="password"
                                            class="settings-form-input"
                                            id="current-password"
                                            name="currentPassword"
                                            placeholder="현재 비밀번호를 입력하세요"
                                            autocomplete="current-password"
                                    >
                                </div>

                                <div class="settings-form-group">
                                    <label class="settings-form-label" for="new-password">변경할 비밀번호</label>
                                    <input
                                            type="password"
                                            class="settings-form-input"
                                            id="new-password"
                                            name="newPassword"
                                            placeholder="새 비밀번호를 입력하세요"
                                            autocomplete="new-password"
                                    >
                                </div>

                                <div class="settings-form-group">
                                    <label class="settings-form-label" for="confirm-password">
                                        비밀번호 확인
                                        <span id="password-message" class="validation-message"></span>
                                    </label>
                                    <input type="password" class="settings-form-input" id="confirm-password" placeholder="새 비밀번호를 다시 입력하세요" autocomplete="new-password">
                                </div>
                            </div>
                        </div>
                    </div>

                    <h3 class="settings-section-title">개인 정보</h3>
                    <div class="settings-form-grid">

                        <div class="settings-form-group full-width">
                            <label class="settings-form-label" for="name">이름</label>
                            <input
                                    type="text"
                                    class="settings-form-input"
                                    id="name"
                                    name="memberName"
                                    value="${sessionScope.loginMember.memberName}"
                                    required
                            >
                        </div>

                        <div class="settings-form-group">
                            <label class="settings-form-label" for="birthdate">생년월일</label>
                            <input
                                    type="date"
                                    class="settings-form-input"
                                    id="birthdate"
                                    value="${sessionScope.loginMember.birthDateForHtml}"
                                    disabled
                            >
                        </div>

                        <div class="settings-form-group">
                            <label class="settings-form-label" for="gender">성별</label>
                            <select class="settings-form-select" id="gender" disabled>
                                <option value="M" ${sessionScope.loginMember.memberGender == 'M' || sessionScope.loginMember.memberGender == '남' ? 'selected' : ''}>남</option>
                                <option value="F" ${sessionScope.loginMember.memberGender == 'F' || sessionScope.loginMember.memberGender == '여' ? 'selected' : ''}>여</option>
                            </select>
                        </div>

                        <div class="settings-form-group">
                            <label class="settings-form-label" for="phone">전화번호</label>
                            <input
                                    type="tel"
                                    class="settings-form-input"
                                    id="phone"
                                    name="memberPhone"
                                    value="${sessionScope.loginMember.memberPhone}"
                                    required
                            >
                        </div>

                        <div class="settings-form-group">
                            <label class="settings-form-label" for="email">이메일</label>
                            <input
                                    type="email"
                                    class="settings-form-input"
                                    id="email"
                                    name="memberEmail"
                                    value="${sessionScope.loginMember.memberEmail}"
                            >
                        </div>

                        <div class="settings-form-group full-width">
                            <label class="settings-form-label" for="address">주소</label>
                            <input
                                    type="text"
                                    class="settings-form-input"
                                    id="address"
                                    name="memberAddress"
                                    value="${sessionScope.loginMember.memberAddress}"
                            >
                        </div>

                        <div class="settings-form-actions">
                            <button type="button" class="settings-btn settings-btn-secondary" id="reset-btn">
                                되돌리기
                            </button>
                            <button type="submit" class="settings-btn settings-btn-primary">
                                변경사항 저장
                            </button>
                        </div>
                    </div>
                </form>
            </section>

        </div>
    </div>

</main>

<script>
    document.addEventListener('DOMContentLoaded', () => {

        // ========== 1. 탭 전환 로직 ==========
        const tabButtons = document.querySelectorAll('.settings-tab-btn');
        const tabPanes = document.querySelectorAll('.settings-tab-pane');

        tabButtons.forEach(btn => {
            btn.addEventListener('click', () => {
                tabButtons.forEach(b => b.classList.remove('active'));
                tabPanes.forEach(p => p.classList.remove('active'));
                btn.classList.add('active');
                const tabId = btn.getAttribute('data-tab');
                const targetPanel = document.getElementById(tabId + '-panel');
                if (targetPanel) {
                    targetPanel.classList.add('active');
                }
            });
        });

        // ========== 2. 원본 값 저장 (되돌리기 기능용) ==========
        const originalValues = {
            name: '${sessionScope.loginMember.memberName}',
            phone: '${sessionScope.loginMember.memberPhone}',
            email: '${sessionScope.loginMember.memberEmail}',
            birthdate: '${sessionScope.loginMember.birthDateForHtml}',
            gender: '${sessionScope.loginMember.memberGender}'
        };

        // ========== 3. 실시간 비밀번호 확인 로직 (수정됨) ==========
        const newPwInput = document.getElementById('new-password');
        const confirmPwInput = document.getElementById('confirm-password');
        const messageSpan = document.getElementById('password-message');

        // 비밀번호 검증 함수
        function validatePassword() {
            const newPw = newPwInput.value;
            const confirmPw = confirmPwInput.value;

            // 둘 다 비어있으면 메시지 초기화
            if (newPw === "" && confirmPw === "") {
                messageSpan.textContent = "";
                messageSpan.className = "validation-message";
                return;
            }

            // 길이 검사 (예: 4자 미만)
            if (newPw.length > 0 && newPw.length < 4) {
                messageSpan.textContent = "비밀번호는 4자 이상이어야 합니다.";
                messageSpan.className = "validation-message text-danger";
                return;
            }

            // 일치 여부 검사
            if (confirmPw.length > 0) {
                if (newPw === confirmPw) {
                    messageSpan.textContent = "비밀번호가 일치합니다.";
                    messageSpan.className = "validation-message text-success";
                } else {
                    messageSpan.textContent = "비밀번호가 일치하지 않습니다.";
                    messageSpan.className = "validation-message text-danger";
                }
            } else {
                // 새 비밀번호는 쳤는데 확인란이 비어있는 경우
                messageSpan.textContent = "";
            }
        }

        // 입력할 때마다 검증 함수 실행
        newPwInput.addEventListener('input', validatePassword);
        confirmPwInput.addEventListener('input', validatePassword);


        // ========== 4. 폼 제출 처리 (최종 유효성 검사) ==========
        const form = document.getElementById('settings-form');
        const currentPwInput = document.getElementById('current-password');

        form.addEventListener('submit', (e) => {
            const newPw = newPwInput.value;
            const confirmPw = confirmPwInput.value;
            const currentPw = currentPwInput.value;

            // 비밀번호 변경을 시도하는 경우 (새 비밀번호 칸에 값이 있을 때)
            if (newPw.trim() !== "") {

                if (currentPw.trim() === "") {
                    alert('비밀번호를 변경하려면 현재 비밀번호를 입력해야 합니다.');
                    currentPwInput.focus();
                    e.preventDefault();
                    return;
                }

                if (newPw.length < 4) {
                    alert('비밀번호는 4자 이상이어야 합니다.');
                    newPwInput.focus();
                    e.preventDefault();
                    return;
                }

                if (newPw !== confirmPw) {
                    alert('새 비밀번호가 일치하지 않습니다. 다시 확인해주세요.');
                    confirmPwInput.focus();
                    e.preventDefault();
                    return;
                }
            }

            if (!confirm('변경된 정보를 저장하시겠습니까?')) {
                e.preventDefault();
            }
        });

        // ========== 5. 되돌리기 (초기화) ==========
        document.getElementById('reset-btn').addEventListener('click', () => {
            if (confirm('모든 변경사항을 되돌리시겠습니까?')) {
                document.getElementById('name').value = originalValues.name;
                document.getElementById('phone').value = originalValues.phone;
                document.getElementById('email').value = originalValues.email;

                if(document.getElementById('birthdate')) document.getElementById('birthdate').value = originalValues.birthdate;
                if(document.getElementById('gender')) document.getElementById('gender').value = originalValues.gender;

                // 비밀번호 필드 및 메시지 초기화
                currentPwInput.value = '';
                newPwInput.value = '';
                confirmPwInput.value = '';
                messageSpan.textContent = '';

                alert('변경사항이 초기화되었습니다.');
            }
        });

        // ========== 6. 전화번호 자동 포맷팅 ==========
        const phoneInput = document.getElementById('phone');
        phoneInput.addEventListener('input', (e) => {
            let value = e.target.value.replace(/[^0-9]/g, '');
            if (value.length > 3 && value.length <= 7) {
                value = value.slice(0, 3) + '-' + value.slice(3);
            } else if (value.length > 7) {
                value = value.slice(0, 3) + '-' + value.slice(3, 7) + '-' + value.slice(7, 11);
            }
            e.target.value = value;
        });

        // ========== 7. 서버 에러 메시지 확인 ==========
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('error') === 'password') {
            alert('현재 비밀번호가 일치하지 않아 정보 수정에 실패했습니다.');
            window.history.replaceState({}, document.title, window.location.pathname);
        }

    });
</script>

</body>
</html>