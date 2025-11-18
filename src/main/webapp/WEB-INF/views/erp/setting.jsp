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
                                    <input type="password" class="settings-form-input" id="current-password" placeholder="현재 비밀번호를 입력하세요">
                                </div>
                                <div class="settings-form-group">
                                    <label class="settings-form-label" for="new-password">변경할 비밀번호</label>
                                    <input type="password" class="settings-form-input" id="new-password" placeholder="새 비밀번호를 입력하세요">
                                </div>
                                <div class="settings-form-group">
                                    <label class="settings-form-label" for="confirm-password">비밀번호 확인</label>
                                    <input type="password" class="settings-form-input" id="confirm-password" placeholder="새 비밀번호를 다시 입력하세요">
                                </div>
                            </div>
                            <button type="button" class="settings-btn settings-btn-primary" id="verify-password-btn">
                                비밀번호 확인
                            </button>
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
    // ========== 탭 전환 ==========
    const tabButtons = document.querySelectorAll('.settings-tab-btn');
    const tabPanes = document.querySelectorAll('.settings-tab-pane');

    // ========== 원본 값 저장 (되돌리기 기능용) ==========
    // JSP EL 값을 JS 변수에 할당할 때는 따옴표로 감싸야 합니다.
    const originalValues = {
        name: '${sessionScope.loginMember.memberName}',
        phone: '${sessionScope.loginMember.memberPhone}',
        email: '${sessionScope.loginMember.memberEmail}',
        address: '${sessionScope.loginMember.memberAddress}'
    };

    // ========== 비밀번호 확인 로직 (UI용) ==========
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
        if (newPassword.length < 4) { // 테스트 편의상 4자로 예시 변경
            alert('비밀번호는 4자 이상이어야 합니다.');
            return;
        }

        alert('비밀번호 확인 로직은 별도 Ajax 구현이 필요합니다.');
    });

    // ========== [중요 수정] 폼 제출 처리 ==========
    // 기존 코드에 있던 e.preventDefault()를 제거하여 실제로 서버 전송이 되도록 수정했습니다.
    document.getElementById('settings-form').addEventListener('submit', (e) => {
        // 유효성 검사가 필요하다면 여기서 수행
        if (!confirm('변경된 정보를 저장하시겠습니까?')) {
            e.preventDefault(); // 취소 버튼 누르면 전송 막기
        }
        // 확인 누르면 action 주소로 submit 됨
    });

    // ========== 되돌리기 ==========
    document.getElementById('reset-btn').addEventListener('click', () => {
        if (confirm('모든 변경사항을 되돌리시겠습니까?')) {
            document.getElementById('name').value = originalValues.name;
            document.getElementById('phone').value = originalValues.phone;
            document.getElementById('email').value = originalValues.email;
            if(document.getElementById('address')) {
                document.getElementById('address').value = originalValues.address;
            }

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