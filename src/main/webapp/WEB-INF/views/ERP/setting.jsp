<%--
  Created by IntelliJ IDEA.
  User: dream
  Date: 25. 11. 6.
  Time: 오전 11:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>설정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/setting.css">
</head>
<body>

<!-- 메인 컨텐츠 영역 -->
<main class="settings-main">

    <!-- 페이지 제목 -->
    <h1 class="settings-page-title">설정</h1>

    <!-- 카드 -->
    <div class="settings-card">

        <!-- 탭 헤더 -->
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

        <!-- 탭 컨텐츠 -->
        <div class="settings-tab-content">

            <!-- 개인 정보 설정 탭 -->
            <section
                    class="settings-tab-pane active"
                    id="personal-panel"
                    role="tabpanel"
                    aria-labelledby="personal-tab"
            >
                <!-- 정보 메시지 -->
                <div class="settings-info-message">
                    개인 정보를 안전하게 관리하세요. 비밀번호는 정기적으로 변경하는 것을 권장합니다.
                </div>

                <!-- 폼 -->
                <form id="settings-form">

                    <!-- 비밀번호 변경 섹션 -->
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
                                            placeholder="새 비밀번호를 입력하세요"
                                            autocomplete="new-password"
                                    >
                                </div>
                                <div class="settings-form-group">
                                    <label class="settings-form-label" for="confirm-password">비밀번호 확인</label>
                                    <input
                                            type="password"
                                            class="settings-form-input"
                                            id="confirm-password"
                                            placeholder="새 비밀번호를 다시 입력하세요"
                                            autocomplete="new-password"
                                    >
                                </div>
                            </div>
                            <button type="button" class="settings-btn settings-btn-primary" id="verify-password-btn">
                                비밀번호 확인
                            </button>
                        </div>
                    </div>

                    <!-- 개인 정보 섹션 -->
                    <h3 class="settings-section-title">개인 정보</h3>
                    <div class="settings-form-grid">

                        <!-- 이름 -->
                        <div class="settings-form-group full-width">
                            <label class="settings-form-label" for="name">이름</label>
                            <input
                                    type="text"
                                    class="settings-form-input"
                                    id="name"
                                    value="홍길동"
                                    required
                            >
                        </div>

                        <!-- 생년월일 -->
                        <div class="settings-form-group">
                            <label class="settings-form-label" for="birthdate">생년월일</label>
                            <input
                                    type="date"
                                    class="settings-form-input"
                                    id="birthdate"
                                    value="2000-01-01"
                                    required
                            >
                        </div>

                        <!-- 성별 -->
                        <div class="settings-form-group">
                            <label class="settings-form-label" for="gender">성별</label>
                            <select class="settings-form-select" id="gender" required>
                                <option value="male">남</option>
                                <option value="female">여</option>
                                <option value="other">기타</option>
                            </select>
                        </div>

                        <!-- 전화번호 -->
                        <div class="settings-form-group">
                            <label class="settings-form-label" for="phone">전화번호</label>
                            <input
                                    type="tel"
                                    class="settings-form-input"
                                    id="phone"
                                    value="010-1111-2222"
                                    pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}"
                                    required
                            >
                        </div>

                        <!-- 이메일 -->
                        <div class="settings-form-group">
                            <label class="settings-form-label" for="email">이메일</label>
                            <input
                                    type="email"
                                    class="settings-form-input"
                                    id="email"
                                    value="admin@hospital.com"
                                    disabled
                            >
                        </div>

                        <!-- 버튼 -->
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
    // ========== 탭 전환 ==========
    const tabButtons = document.querySelectorAll('.settings-tab-btn');
    const tabPanes = document.querySelectorAll('.settings-tab-pane');

    // ========== 원본 값 저장 ==========
    const originalValues = {
        name: '홍길동',
        birthdate: '2000-01-01',
        gender: 'male',
        phone: '010-1111-2222',
        email: 'admin@hospital.com'
    };

    // ========== 비밀번호 확인 ==========
    document.getElementById('verify-password-btn').addEventListener('click', () => {
        const currentPassword = document.getElementById('current-password').value;
        const newPassword = document.getElementById('new-password').value;
        const confirmPassword = document.getElementById('confirm-password').value;

        if (!currentPassword) {
            alert('현재 비밀번호를 입력해주세요.');
            return;
        }

        if (!newPassword) {
            alert('새 비밀번호를 입력해주세요.');
            return;
        }

        if (newPassword !== confirmPassword) {
            alert('새 비밀번호가 일치하지 않습니다.');
            return;
        }

        if (newPassword.length < 8) {
            alert('비밀번호는 8자 이상이어야 합니다.');
            return;
        }

        alert('비밀번호가 확인되었습니다. 변경사항 저장 버튼을 눌러주세요.');
    });

    // ========== 폼 제출 ==========
    document.getElementById('settings-form').addEventListener('submit', (e) => {
        e.preventDefault();

        const formData = {
            name: document.getElementById('name').value,
            birthdate: document.getElementById('birthdate').value,
            gender: document.getElementById('gender').value,
            phone: document.getElementById('phone').value,
        };

        console.log('설정 저장:', formData);
        alert('설정이 저장되었습니다.');
    });

    // ========== 되돌리기 ==========
    document.getElementById('reset-btn').addEventListener('click', () => {
        if (confirm('모든 변경사항을 되돌리시겠습니까?')) {
            document.getElementById('name').value = originalValues.name;
            document.getElementById('birthdate').value = originalValues.birthdate;
            document.getElementById('gender').value = originalValues.gender;
            document.getElementById('phone').value = originalValues.phone;

            // 비밀번호 필드 초기화
            document.getElementById('current-password').value = '';
            document.getElementById('new-password').value = '';
            document.getElementById('confirm-password').value = '';

            alert('변경사항이 되돌려졌습니다.');
        }
    });

    // ========== 전화번호 자동 포맷팅 ==========
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
</script>

</body>
</html>
