// DOM이 모두 로드된 후에 스크립트 실행
document.addEventListener('DOMContentLoaded', function () {

    // -------------------------------
    // 공통 설정
    // -------------------------------
    const contextPath = '${pageContext.request.contextPath}';

    // ============================================================
    // 🔹 [1] 회원 탈퇴 모달 관련 로직
    // ============================================================

    const openWithdrawalModalBtn = document.getElementById('open-withdrawal-modal');
    const withdrawalModal = document.querySelector('.withdrawal-modal-overlay');

    if (openWithdrawalModalBtn && withdrawalModal) {
        const wmCloseBtn = withdrawalModal.querySelector('.modal-close');
        const wmCancelBtn = withdrawalModal.querySelector('.btn-cancel');
        const wmBackdrop = withdrawalModal.querySelector('.modal-backdrop');
        const wmAgreeBtn = withdrawalModal.querySelector('.btn-agree');

        const passwordModal = document.querySelector('.password-modal-overlay');
        const pmCloseBtn = passwordModal?.querySelector('.modal-close');
        const pmCancelBtn = passwordModal?.querySelector('.modal-footer .btn-cancel');
        const pmForm = passwordModal?.querySelector('.password-form');
        const pmPasswordInput = passwordModal?.querySelector('#user-password');

        // --- 모달 제어 함수 ---
        function openWithdrawalModal() {
            withdrawalModal.classList.add('is-open');
            document.body.classList.add('modal-open');
        }

        function closeWithdrawalModal() {
            withdrawalModal.classList.remove('is-open');
            document.body.classList.remove('modal-open');
            if (wmAgreeBtn) {
                wmAgreeBtn.disabled = false;
                wmAgreeBtn.innerText = '동의';
            }
        }

        function openPasswordModal() {
            passwordModal.classList.add('is-open');
            document.body.classList.add('modal-open');
        }

        function closePasswordModal() {
            passwordModal.classList.remove('is-open');
            document.body.classList.remove('modal-open');
            if (pmForm) pmForm.reset();
        }

        // --- 이벤트 리스너 ---

        // 탈퇴 모달 열기
        openWithdrawalModalBtn.addEventListener('click', openWithdrawalModal);

        // [모달1] 닫기 버튼들
        wmCloseBtn?.addEventListener('click', closeWithdrawalModal);
        wmCancelBtn?.addEventListener('click', closeWithdrawalModal);
        wmBackdrop?.addEventListener('click', closeWithdrawalModal);

        // [모달2] 닫기 버튼들
        pmCloseBtn?.addEventListener('click', closePasswordModal);
        pmCancelBtn?.addEventListener('click', closePasswordModal);

        // [모달1] → [모달2]로 전환
        wmAgreeBtn?.addEventListener('click', function () {
            wmAgreeBtn.disabled = true;
            wmAgreeBtn.innerText = '확인 중...';
            closeWithdrawalModal();
            openPasswordModal();
        });

        // [모달2] 탈퇴 요청
        pmForm?.addEventListener('submit', function (e) {
            e.preventDefault();

            if (pmPasswordInput.value) {
                alert('회원 탈퇴가 처리되었습니다.');
                closePasswordModal();
                // window.location.href = contextPath + '/logout';
            } else {
                alert('비밀번호를 입력해 주세요.');
            }
        });
    }

    // ============================================================
    // 🔹 [2] 회원 정보 수정 모달 관련 로직
    // ============================================================

    const updateInfoModalOverlay = document.querySelector('.update-info-modal-overlay');
    const openUpdateModalBtn = document.querySelector('.basic-info .btn-primary');
    const closeUpdateModalBtn = updateInfoModalOverlay?.querySelector('.modal-close');
    const updateCancelBtn = updateInfoModalOverlay?.querySelector('.update-cancel-btn');
    const updateInfoForm = document.getElementById('updateInfoForm');
    const updateErrorMessage = document.getElementById('updateErrorMessage');
    const updateSaveBtn = updateInfoModalOverlay?.querySelector('.update-save-btn');

    // --- 모달 제어 함수 ---
    function toggleUpdateInfoModal(isShow) {
        updateInfoModalOverlay.classList.toggle('is-open', isShow);
        document.body.classList.toggle('modal-open', isShow);
        updateErrorMessage.classList.remove('show');
    }

    // --- 이벤트 리스너 연결 ---
    if (openUpdateModalBtn && updateInfoModalOverlay) {
        // 1️⃣ 정보 수정 버튼 클릭 → 모달 열기
        openUpdateModalBtn.addEventListener('click', () => {
            // JSP 값으로 초기화
            document.getElementById('update-name').value = '${loginMember.memberName}';
            document.getElementById('update-phone').value = '${loginMember.memberPhone}';
            document.getElementById('update-email').value = '${loginMember.memberEmail}';
            document.getElementById('update-address').value = '${loginMember.memberAddress}';
            toggleUpdateInfoModal(true);
        });

        // 2️⃣ 모달 닫기 (X, 취소, 배경)
        closeUpdateModalBtn?.addEventListener('click', () => toggleUpdateInfoModal(false));
        updateCancelBtn?.addEventListener('click', () => toggleUpdateInfoModal(false));
        updateInfoModalOverlay?.addEventListener('click', (e) => {
            if (e.target === updateInfoModalOverlay) toggleUpdateInfoModal(false);
        });

        // 3️⃣ 폼 제출 (AJAX로 서버 업데이트)
        updateInfoForm?.addEventListener('submit', async function (e) {
            e.preventDefault();

            updateSaveBtn.disabled = true;
            updateSaveBtn.textContent = '저장 중...';

            const updateData = {
                memberName: document.getElementById('update-name').value,
                memberPhone: document.getElementById('update-phone').value,
                memberEmail: document.getElementById('update-email').value,
                memberAddress: document.getElementById('update-address').value
            };

            const url = contextPath + '/member/updateInfo';

            try {
                const response = await fetch(url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(updateData)
                });

                const result = await response.json();

                if (result.success) {
                    alert('회원 정보가 성공적으로 수정되었습니다.');
                    window.location.reload();
                } else {
                    updateErrorMessage.textContent = result.message || '정보 수정에 실패했습니다.';
                    updateErrorMessage.classList.add('show');
                }
            } catch (error) {
                console.error('정보 수정 AJAX 오류:', error);
                updateErrorMessage.textContent = '네트워크 오류가 발생했습니다.';
                updateErrorMessage.classList.add('show');
            } finally {
                updateSaveBtn.disabled = false;
                updateSaveBtn.textContent = '저장';
            }
        });
    }

});
