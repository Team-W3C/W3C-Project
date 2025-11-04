// DOM이 모두 로드된 후에 스크립트 실행
document.addEventListener('DOMContentLoaded', function () {

    // --- 1. 비밀번호 모달 관련 DOM 요소 선택 ---
    const openBtn = document.getElementById('open-password-modal');
    const modalOverlay = document.querySelector('.password-modal-overlay'); // ConfirmPasswordModal.css의 .modal-overlay

    // 이 페이지에 모달 버튼이나 모달 자체가 없으면 실행 중단
    if (!openBtn || !modalOverlay) {
        return;
    }

    const closeModalBtn = modalOverlay.querySelector('.modal-close');
    const cancelBtn = modalOverlay.querySelector('.modal-footer .btn-cancel');
    const passwordForm = modalOverlay.querySelector('.password-form');

    // --- 2. 함수 정의 ---

    // 모달 열기 함수
    function openModal() {
        modalOverlay.classList.add('is-open');
        document.body.classList.add('modal-open');
    }

    // 모달 닫기 함수
    function closeModal() {
        modalOverlay.classList.remove('is-open');
        document.body.classList.remove('modal-open');
        // 폼 초기화 (선택 사항)
        if (passwordForm) {
            passwordForm.reset();
        }
    }

    // --- 3. 이벤트 리스너 연결 ---

    // '회원정보' 제목 클릭 시 모달 열기
    openBtn.addEventListener('click', function (e) {
        e.preventDefault(); // h3 클릭의 기본 동작 방지
        openModal();
    });

    // 모달의 'X' 버튼 클릭 시 모달 닫기
    if (closeModalBtn) {
        closeModalBtn.addEventListener('click', closeModal);
    }

    // 모달의 '취소' 버튼 클릭 시 모달 닫기
    if (cancelBtn) {
        cancelBtn.addEventListener('click', closeModal);
    }

    // 모달 배경 클릭 시 모달 닫기
    modalOverlay.addEventListener('click', function (e) {
        // 클릭된 요소가 정확히 배경(overlay) 자신일 때만 닫힘
        if (e.target === modalOverlay) {
            closeModal();
        }
    });

    // (중요) 폼 제출(확인) 이벤트 처리
    if (passwordForm) {
        passwordForm.addEventListener('submit', function (e) {
            // 폼의 기본 동작(페이지 새로고침) 방지
            e.preventDefault();

            // (임시) 실제 비밀번호 확인 로직 대신, 
            // 확인 버튼을 누르면 회원정보 페이지(userInfo.jsp)로 이동한다고 가정합니다.

            const passwordInput = modalOverlay.querySelector('#password');
            if (passwordInput.value) {
                // 실제로는 여기서 fetch 등으로 서버에 비밀번호를 보내 검증해야 합니다.
                alert('비밀번호가 확인되었습니다. 회원정보 페이지로 이동합니다.');

                // ★★★★★ 수정된 부분 ★★★★★
                // 비밀번호 확인 성공 시 /member/info (컨트롤러 주소)로 이동
                window.location.href = '/member/info';

                // 실패 시에는 닫지 않고 오류 메시지를 표시할 수 있습니다.
                // 예: alert('비밀번호가 올바르지 않습니다.');
            } else {
                alert('비밀번호를 입력해주세요.');
            }
        });
    }

});