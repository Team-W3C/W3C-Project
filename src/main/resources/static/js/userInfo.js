// DOM이 모두 로드된 후에 스크립트 실행
document.addEventListener('DOMContentLoaded', function () {

    // ------------------------------------------------------------
    // 🔹 공통 설정
    // ------------------------------------------------------------

    // contextPath 변수는 이 스크립트를 불러온 .jsp 파일에서
    // 이미 전역 변수로 선언했으므로, 여기서는 선언 없이 바로 사용합니다.

    // ============================================================
    // 🔹 [1] 회원 탈퇴 모달 관련 로직
    // ============================================================

    const openWithdrawalModalBtn = document.getElementById('open-withdrawal-modal');
    const withdrawalModal = document.querySelector('.withdrawal-modal-overlay');

    if (openWithdrawalModalBtn && withdrawalModal) {
        const wmCloseBtn = withdrawalModal.querySelector('.modal-close');
        const wmCancelBtn = withdrawalModal.querySelector('.btn-cancel');
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
            if (passwordModal) {
                passwordModal.classList.add('is-open');
                document.body.classList.add('modal-open');
            }
        }

        function closePasswordModal() {
            if (passwordModal) {
                passwordModal.classList.remove('is-open');
                document.body.classList.remove('modal-open');
                if (pmForm) pmForm.reset();
            }
        }

        // --- 이벤트 리스너 연결 ---
        openWithdrawalModalBtn.addEventListener('click', openWithdrawalModal);
        wmCloseBtn?.addEventListener('click', closeWithdrawalModal);
        wmCancelBtn?.addEventListener('click', closeWithdrawalModal);

        withdrawalModal.addEventListener('click', (e) => {
            if (e.target === withdrawalModal) closeWithdrawalModal();
        });


        pmCloseBtn?.addEventListener('click', closePasswordModal);
        pmCancelBtn?.addEventListener('click', closePasswordModal);

        if (passwordModal) {
            passwordModal.addEventListener('click', (e) => {
                if (e.target === passwordModal) closePasswordModal();
            });
        }

        wmAgreeBtn?.addEventListener('click', function () {
            wmAgreeBtn.disabled = true;
            wmAgreeBtn.innerText = '확인 중...';
            closeWithdrawalModal();
            openPasswordModal();
        });

        pmForm?.addEventListener('submit', function (e) {
            e.preventDefault();
            if (pmPasswordInput && pmPasswordInput.value) {
                alert('회원 탈퇴가 처리되었습니다.'); // (추후 실제 탈퇴 로직 AJAX로 구현 필요)
                closePasswordModal();
                // 예: window.location.href = contextPath + '/member/withdraw';
            } else {
                alert('비밀번호를 입력해 주세요.');
            }
        });
    }

    // ============================================================
    // 🔹 [2] 회원 정보 수정 모달 관련 로직 (수정된 부분)
    // ============================================================

    const updateModal = document.querySelector('.update-info-modal-overlay');
    const openUpdateModalBtn = document.querySelector('.open-update-modal-btn'); // 클래스 이름 확인

    const closeModalBtn = updateModal?.querySelector('.modal-close');
    const cancelBtn = updateModal?.querySelector('.update-cancel-btn');
    const saveBtn = updateModal?.querySelector('.update-save-btn');
    const form = document.querySelector('#updateInfoForm');
    const updateErrorMessage = document.getElementById('updateErrorMessage');

    if (updateModal && openUpdateModalBtn && form) {

        // --- 모달 열기 함수 ---
        const openModal = () => {
            // JSP 값으로 초기화 (페이지에 표시된 현재 값)
            const currentMemberData = {
                memberName: document.getElementById('name')?.textContent || '',
                memberPhone: document.getElementById('phone')?.textContent || '',
                memberEmail: document.getElementById('email')?.textContent || '',
                memberAddress: document.getElementById('address1')?.textContent || ''
            };

            // 모달 입력 필드에 현재 정보 채우기
            form.querySelector('#update-name').value = currentMemberData.memberName;
            form.querySelector('#update-phone').value = currentMemberData.memberPhone;
            form.querySelector('#update-email').value = currentMemberData.memberEmail;
            form.querySelector('#update-address').value = currentMemberData.memberAddress;

            updateModal.classList.add('is-open');
            document.body.classList.add('modal-open');
        };

        // --- 모달 닫기 함수 ---
        const closeModal = () => {
            updateModal.classList.remove('is-open');
            document.body.classList.remove('modal-open');
            if (updateErrorMessage) {
                updateErrorMessage.classList.remove('show');
                updateErrorMessage.style.display = 'none'; // JSP 스타일시트와 일관성 유지
            }
        };

        // --- 이벤트 리스너 연결 ---
        openUpdateModalBtn.addEventListener('click', openModal);
        closeModalBtn?.addEventListener('click', closeModal);
        cancelBtn?.addEventListener('click', closeModal);
        updateModal?.addEventListener('click', (e) => {
            if (e.target === updateModal) closeModal();
        });

        // --- 저장 버튼 클릭 / 폼 제출 ---
        form.addEventListener('submit', async (e) => {
            e.preventDefault();

            if (!saveBtn) return;

            saveBtn.disabled = true;
            saveBtn.textContent = '저장 중...';

            if (updateErrorMessage) {
                updateErrorMessage.style.display = 'none';
                updateErrorMessage.classList.remove('show');
            }

            const memberNoInput = form.querySelector('#update-memberNo');

            if (!memberNoInput || !memberNoInput.value) {
                alert('회원 정보를 식별할 수 없습니다. 페이지를 새로고침해주세요.');
                saveBtn.disabled = false;
                saveBtn.textContent = '저장';
                return;
            }

            const memberData = {
                memberNo: memberNoInput.value,
                memberName: form.querySelector('#update-name').value,
                memberPhone: form.querySelector('#update-phone').value,
                memberEmail: form.querySelector('#update-email').value,
                memberAddress: form.querySelector('#update-address').value
            };

            try {
                // 'contextPath'는 .jsp에서 선언된 전역 변수를 사용합니다.
                const res = await fetch(`${contextPath}/member/updateInfo`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(memberData)
                });

                if (!res.ok) throw new Error('서버 응답 실패');

                const data = await res.json();

                if (data.success) {
                    alert('회원 정보가 성공적으로 수정되었습니다.');

                    // ✅ [수정] location.reload() 대신 화면에 직접 그리기
                    document.getElementById('name').textContent = memberData.memberName;
                    document.getElementById('phone').textContent = memberData.memberPhone;
                    document.getElementById('email').textContent = memberData.memberEmail;
                    document.getElementById('address1').textContent = memberData.memberAddress;

                    // ✅ [추가] 모달 닫기
                    closeModal();

                } else {
                    if (updateErrorMessage) {
                        updateErrorMessage.textContent = data.message || '정보 수정 실패';
                        updateErrorMessage.classList.add('show');
                        updateErrorMessage.style.display = 'block';
                    }
                }
            } catch (err) {
                console.error('정보 수정 오류:', err);
                if (updateErrorMessage) {
                    updateErrorMessage.textContent = '네트워크 오류가 발생했습니다.';
                    updateErrorMessage.classList.add('show');
                    updateErrorMessage.style.display = 'block';
                }
            } finally {
                saveBtn.disabled = false;
                saveBtn.textContent = '저장';
            }
        });
    }
});