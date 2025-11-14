// MyChart.js (전체 파일)

document.addEventListener('DOMContentLoaded', function () {

    // JSP에서 선언된 전역 변수 contextPath를 안전하게 참조
    const contextPath = window.contextPath || '';

    // --- 1. 비밀번호 확인 모달 로직 (정보 수정 페이지 이동 전) ---
    // (이 로직은 MyChart.jsp가 아닌 다른 페이지(예: userInfo.jsp)의
    // 사이드바 '회원정보수정' 클릭 시 사용되는 것으로 보입니다.)
    const openBtn = document.getElementById('open-password-modal');
    const passwordModalOverlay = document.querySelector('.password-modal-overlay');

    if (openBtn && passwordModalOverlay) {
        const closeModalBtn = passwordModalOverlay.querySelector('.modal-close');
        const cancelBtn = passwordModalOverlay.querySelector('.modal-footer .btn-cancel');
        const passwordForm = passwordModalOverlay.querySelector('.password-form');
        const passwordInput = passwordModalOverlay.querySelector('#password');
        const errorMessage = document.getElementById('password-error-message');

        // 모달 열기
        function openModal(e) {
            e.preventDefault();
            passwordModalOverlay.classList.add('is-open');
            document.body.classList.add('modal-open');
            if (errorMessage) {
                errorMessage.style.display = 'none';
            }
        }

        // 모달 닫기
        function closeModal() {
            passwordModalOverlay.classList.remove('is-open');
            document.body.classList.remove('modal-open');
            if (passwordForm) {
                passwordForm.reset();
            }
            if (errorMessage) {
                errorMessage.style.display = 'none';
            }
        }

        // 이벤트 리스너
        openBtn.addEventListener('click', openModal);
        if (closeModalBtn) closeModalBtn.addEventListener('click', closeModal);
        if (cancelBtn) cancelBtn.addEventListener('click', closeModal);

        passwordModalOverlay.addEventListener('click', function (e) {
            if (e.target === passwordModalOverlay) {
                closeModal();
            }
        });

        // 폼 제출 (비밀번호 확인 AJAX)
        if (passwordForm) {
            passwordForm.addEventListener('submit', async function (e) {
                e.preventDefault();

                const password = passwordInput.value;
                if (!password) {
                    alert('비밀번호를 입력해주세요.');
                    return;
                }

                // ✅ 컨트롤러에 /member/verify-password가 구현되어 있어야 함
                const url = contextPath + '/member/verify-password';

                try {
                    const response = await fetch(url, {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ password: password }) // { "password": "..." }
                    });

                    const result = await response.json();

                    if (response.ok && result.success) {
                        // 성공: 모달 닫고, 실제 회원 정보 수정 페이지로 이동
                        closeModal();
                        window.location.href = contextPath + '/member/info'; // '/member/info' 페이지로 이동
                    } else {
                        // 실패: 에러 메시지 표시
                        if (errorMessage) {
                            errorMessage.textContent = result.message || '비밀번호가 일치하지 않습니다.';
                            errorMessage.style.display = 'block';
                        }
                    }

                } catch (error) {
                    console.error('Password verification error:', error);
                    if (errorMessage) {
                        errorMessage.textContent = '서버 통신 중 오류가 발생했습니다.';
                        errorMessage.style.display = 'block';
                    }
                }
            });
        }
    } // --- 1. 비밀번호 확인 모달 로직 끝 ---


    // --- 2. '예약 취소' 로직 (이벤트 위임) ---
    const contentSection = document.querySelector('.mypage-content');

    if (contentSection) {
        contentSection.addEventListener('click', (e) => {
            // '취소' 버튼 클릭 시
            if (e.target.classList.contains('btn-cancel') && e.target.closest('.card-actions')) {
                handleCancelClick(e.target);
            }
            // '변경' 버튼 클릭 시
            if (e.target.classList.contains('btn-edit')) {
                handleEditClick(e.target);
            }
        });
    }

    // [취소] 버튼 클릭 핸들러
    function handleCancelClick(cancelButton) {
        if (confirm('정말로 이 예약을 취소하시겠습니까?\n취소한 예약은 되돌릴 수 없습니다.')) {
            const card = cancelButton.closest('.reservation-card');
            const reservationNo = card.dataset.reservationNo;
            if (reservationNo) {
                handleCancelReservation(reservationNo, card);
            }
        }
    }

    // [취소] AJAX 요청
    async function handleCancelReservation(reservationNo, cardElement) {
        try {
            const response = await fetch(`${contextPath}/member/reservation/cancel`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ reservationNo: parseInt(reservationNo) })
            });

            if (response.ok) {
                alert('예약이 성공적으로 취소되었습니다.');
                updateUICancelled(cardElement); // UI 즉시 변경
            } else {
                const errorText = await response.text();
                alert(`예약 취소에 실패했습니다: ${errorText}`);
            }
        } catch (error) {
            console.error('Error:', error);
            alert('네트워크 오류가 발생했습니다.');
        }
    }

    // [취소] UI 업데이트
    function updateUICancelled(cardElement) {
        cardElement.querySelector('.status-badge-inline').className = 'status-badge-inline cancelled';

        const statusTextElem = cardElement.querySelector('.status-text');
        statusTextElem.className = 'status-text cancelled';
        statusTextElem.textContent = '예약 취소';

        const statusDiv = cardElement.querySelector('.status-badge-inline');
        if (statusDiv) {
            const existingIcon = statusDiv.querySelector('.status-icon');
            if (existingIcon) existingIcon.remove();

            const warningIcon = document.createElement('div');
            warningIcon.className = 'status-icon warning';
            statusDiv.prepend(warningIcon);
        }

        const actionsDiv = cardElement.querySelector('.card-actions');
        if (actionsDiv) {
            actionsDiv.innerHTML = ''; // 버튼 제거
        }
    }


    // --- 3. '예약 변경' 모달 로직 ---
    const editModalOverlay = document.querySelector('.edit-modal-overlay');

    if (editModalOverlay) {
        const editModal = editModalOverlay.querySelector('.edit-modal');
        const editForm = document.getElementById('edit-reservation-form');
        const editModalBody = editModal.querySelector('.modal-body');
        const editDeptSelect = document.getElementById('edit-dept');
        const editDatetimeInput = document.getElementById('edit-datetime');
        const editDoctorInput = document.getElementById('edit-doctor');
        const editNotesTextarea = document.getElementById('edit-notes');
        const editReservationNoInput = document.getElementById('edit-reservation-no');

        // 모달 닫기 이벤트 (X, 취소, 배경 클릭)
        editModal.querySelectorAll('.modal-close, .modal-footer .btn-cancel').forEach(btn => {
            btn.addEventListener('click', closeEditModal);
        });
        editModalOverlay.addEventListener('click', (e) => {
            if (e.target === editModalOverlay) closeEditModal();
        });

        // '변경' 버튼 클릭 핸들러 (이벤트 위임에서 호출됨)
        function handleEditClick(editButton) {
            const card = editButton.closest('.reservation-card');
            const reservationNo = card.dataset.reservationNo;
            if (reservationNo) {
                openEditModal(reservationNo);
            } else {
                alert('예약 번호를 찾을 수 없습니다.');
            }
        }

        // (AJAX 1) 진료과 목록 로드 (최초 1회)
        let departmentsLoaded = false;
        async function loadDepartmentsIntoModal() {
            if (departmentsLoaded) return true;
            try {
                const response = await fetch(`${contextPath}/member/reservation/departments`);
                if (!response.ok) throw new Error('진료과 목록 로드 실패');

                const departments = await response.json();
                editDeptSelect.innerHTML = '<option value="">진료과를 선택하세요</option>';
                departments.forEach(dept => {
                    editDeptSelect.innerHTML += `<option value="${dept.departmentNo}">${dept.departmentName}</option>`;
                });
                departmentsLoaded = true;
                return true;
            } catch (error) {
                console.error(error);
                alert('진료과 목록을 불러오는 데 실패했습니다.');
                return false;
            }
        }

        // (AJAX 2) 특정 예약 정보 로드
        async function loadReservationData(reservationNo) {
            try {
                editModalBody.classList.add('is-loading'); // 로딩 시작

                const response = await fetch(`${contextPath}/member/reservation/detail-json/${reservationNo}`);
                if (!response.ok) throw new Error(await response.text() || '예약 정보를 불러올 수 없습니다.');

                const data = await response.json();

                // Null 방어 및 데이터 포맷팅
                const safeDoctorName = data.doctorName || '';
                const safeTreatmentDate = data.treatmentDate || '';
                const localDateTime = safeTreatmentDate.replace(' ', 'T'); // YYYY-MM-DD HH:MI -> YYYY-MM-DDTHH:MI
                const doctorName = safeDoctorName.startsWith('담당의: ') ? safeDoctorName.replace('담당의: ', '') : safeDoctorName;

                // 폼에 값 채우기
                editReservationNoInput.value = data.reservationNo;
                editDeptSelect.value = data.departmentNo;
                editDatetimeInput.value = localDateTime;
                editDoctorInput.value = doctorName;
                editNotesTextarea.value = data.reservationNotes || '';

            } catch (error) {
                console.error(error);
                alert(error.message);
                closeEditModal();
            } finally {
                editModalBody.classList.remove('is-loading'); // 로딩 끝
            }
        }

        // 모달 열기 (데이터 로드)
        async function openEditModal(reservationNo) {
            editModalOverlay.classList.add('is-open');
            document.body.classList.add('modal-open');
            editModalOverlay.dataset.currentRno = reservationNo; // 현재 예약번호 저장

            const deptLoaded = await loadDepartmentsIntoModal();
            if (deptLoaded) {
                await loadReservationData(reservationNo);
            }
        }

        // 모달 닫기 (폼 리셋)
        function closeEditModal() {
            editModalOverlay.classList.remove('is-open');
            document.body.classList.remove('modal-open');
            editForm.reset();
            editModalOverlay.dataset.currentRno = "";
        }

        // (AJAX 3) '저장' 버튼 (폼 제출)
        editForm.addEventListener('submit', async (e) => {
            e.preventDefault();

            const reservationNo = editModalOverlay.dataset.currentRno;
            if (!reservationNo) {
                alert('오류: 예약 번호를 알 수 없습니다.');
                return;
            }

            const formData = new FormData(editForm);
            const payload = {
                departmentNo: parseInt(formData.get('departmentNo')),
                treatmentDate: formData.get('treatmentDate').replace('T', ' '), // YYYY-MM-DDTHH:MI -> YYYY-MM-DD HH:MI
                doctorName: formData.get('doctorName'),
                reservationNotes: formData.get('reservationNotes'),
                reservationNo: parseInt(reservationNo)
            };

            // 유효성 검사 (간단)
            if (!payload.departmentNo || !payload.treatmentDate) {
                alert('진료과와 예약 시간은 필수입니다.');
                return;
            }

            try {
                // Controller의 submit 메소드에 reservationNo를 쿼리로도 전달
                const response = await fetch(`${contextPath}/member/reservation/submit?reservationNo=${reservationNo}`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(payload)
                });

                const result = await response.json();

                if (response.ok && result.success) {
                    alert(result.message || '예약이 성공적으로 변경되었습니다.');
                    closeEditModal();
                    window.location.reload(); // 성공 시 페이지 새로고침
                } else {
                    throw new Error(result.message || '예약 변경에 실패했습니다.');
                }

            } catch (error) {
                console.error('Update Error:', error);
                alert(error.message); // 서버/네트워크 오류 메시지 표시
            }
        });

    } // --- '예약 변경' 모달 로직 끝 ---

}); // --- DOMContentLoaded 끝 ---