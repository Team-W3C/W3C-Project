// DOM이 모두 로드된 후에 스크립트 실행
document.addEventListener('DOMContentLoaded', function () {

    // --- 1. 회원 탈퇴 모달 (모달 1) 요소 선택 ---
    const openWithdrawalModalBtn = document.getElementById('open-withdrawal-modal');
    const withdrawalModal = document.querySelector('.withdrawal-modal-overlay');

    if (!openWithdrawalModalBtn || !withdrawalModal) {
        // 페이지에 탈퇴 버튼이나 모달이 없으면 중단
        return;
    }

    const wmCloseBtn = withdrawalModal.querySelector('.modal-close');
    const wmCancelBtn = withdrawalModal.querySelector('.btn-cancel');
    const wmBackdrop = withdrawalModal.querySelector('.modal-backdrop');
    const wmAgreeBtn = withdrawalModal.querySelector('.btn-agree');

    // --- 2. 비밀번호 확인 모달 (모달 2) 요소 선택 ---
    const passwordModal = document.querySelector('.password-modal-overlay');
    if (!passwordModal) {
        // 비밀번호 모달이 없으면 중단
        return;
    }

    const pmCloseBtn = passwordModal.querySelector('.modal-close');
    const pmCancelBtn = passwordModal.querySelector('.modal-footer .btn-cancel');
    const pmForm = passwordModal.querySelector('.password-form');
    const pmPasswordInput = passwordModal.querySelector('#user-password');


    // --- 3. 모달 제어 함수 정의 ---

    // [모달 1: 탈퇴 모달] 열기
    function openWithdrawalModal() {
        withdrawalModal.classList.add('is-open');
        document.body.classList.add('modal-open');
    }

    // [모달 1: 탈퇴 모달] 닫기 (상태 초기화 포함)
    function closeWithdrawalModal() {
        withdrawalModal.classList.remove('is-open');
        document.body.classList.remove('modal-open');

        // '동의' 버튼 상태 초기화
        if (wmAgreeBtn) {
            wmAgreeBtn.disabled = false;
            wmAgreeBtn.innerText = '동의';
        }
    }

    // [모달 2: 비밀번호 모달] 열기
    function openPasswordModal() {
        passwordModal.classList.add('is-open');
        document.body.classList.add('modal-open'); // 스크롤 잠금 유지
    }

    // [모달 2: 비밀번호 모달] 닫기 (상태 초기화 포함)
    function closePasswordModal() {
        passwordModal.classList.remove('is-open');
        document.body.classList.remove('modal-open');

        // 폼 입력값 초기화
        if (pmForm) {
            pmForm.reset();
        }
    }

    // --- 4. 이벤트 리스너 연결 ---

    // "회원 탈퇴하기" 버튼 클릭 -> 모달 1 열기
    openWithdrawalModalBtn.addEventListener('click', openWithdrawalModal);

    // [모달 1] 닫기 버튼들 (X, 취소, 배경)
    wmCloseBtn.addEventListener('click', closeWithdrawalModal);
    wmCancelBtn.addEventListener('click', closeWithdrawalModal);
    wmBackdrop.addEventListener('click', closeWithdrawalModal);

    // [모달 2] 닫기 버튼들 (X, 취소)
    pmCloseBtn.addEventListener('click', closePasswordModal);
    pmCancelBtn.addEventListener('click', closePasswordModal);

    // ★★★ 핵심 로직 ★★★
    // [모달 1]의 "동의" 버튼 클릭 -> 모달 1 닫고 -> 모달 2 열기
    wmAgreeBtn.addEventListener('click', function () {
        // '동의' 버튼 비활성화 (중복 클릭 방지)
        wmAgreeBtn.disabled = true;
        wmAgreeBtn.innerText = '확인 중...';

        // 모달 1 닫기 (초기화 로직 포함된 함수 호출)
        closeWithdrawalModal();

        // 모달 2 열기
        openPasswordModal();
    });

    // [모달 2]의 "탈퇴 완료" (폼 제출)
    pmForm.addEventListener('submit', function (e) {
        // 폼 기본 동작 (새로고침) 방지
        e.preventDefault();

        // (임시) 비밀번호 입력 여부만 확인
        if (pmPasswordInput.value) {
            // 실제 로직:
            // 1. fetch/ajax로 서버에 비밀번호와 탈퇴 요청 전송
            // 2. 서버 응답이 성공일 때 아래 코드 실행

            alert('회원 탈퇴가 처리되었습니다.');
            closePasswordModal(); // 모달 2 닫기

            // (선택) 탈퇴 성공 후 페이지 이동
            // window.location.href = '/logout'; // 예: 로그아웃 또는 메인 페이지로 이동

        } else {
            alert('비밀번호를 입력해 주세요.');
        }
    });

});