// MyChart.js (전체 파일)

document.addEventListener('DOMContentLoaded', function () {

    // --- 1. 비밀번호 모달 로직 ---
    const openBtn = document.getElementById('open-password-modal');
    const passwordModalOverlay = document.querySelector('.password-modal-overlay');

    if (openBtn && passwordModalOverlay) {
        // [비밀번호 모달 로직 생략]
        const closeModalBtn = passwordModalOverlay.querySelector('.modal-close');
        const cancelBtn = passwordModalOverlay.querySelector('.modal-footer .btn-cancel');
        const passwordForm = passwordModalOverlay.querySelector('.password-form');
        const passwordInput = passwordModalOverlay.querySelector('#password');

        // 모달 함수 정의
        function openModal() {
            passwordModalOverlay.classList.add('is-open');
            document.body.classList.add('modal-open');
        }

        function closeModal() {
            passwordModalOverlay.classList.remove('is-open');
            document.body.classList.remove('modal-open');
            if (passwordForm) {
                passwordForm.reset();
            }
        }

        // 이벤트 리스너 연결
        openBtn.addEventListener('click', function (e) {
            e.preventDefault();
            openModal();
        });

        if (closeModalBtn) closeModalBtn.addEventListener('click', closeModal);
        if (cancelBtn) cancelBtn.addEventListener('click', closeModal);

        passwordModalOverlay.addEventListener('click', function (e) {
            if (e.target === passwordModalOverlay) {
                closeModal();
            }
        });

        // 폼 제출 (비밀번호 확인)
        if (passwordForm) {
            passwordForm.addEventListener('submit', function (e) {
                e.preventDefault();

                if (passwordInput && passwordInput.value) {
                    window.location.href = contextPath + '/member/info';
                } else {
                    alert('비밀번호를 입력해주세요.');
                }
            });
        }
    } // --- 비밀번호 모달 로직 끝 ---


    // --- 2. '예약 취소' & '변경' 이벤트 리스너 ---
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

    // [취소 로직 - 함수 정의]
    function handleCancelClick(cancelButton) {
        const isConfirmed = confirm('정말로 이 예약을 취소하시겠습니까?\n취소한 예약은 되돌릴 수 없습니다.');
        if (isConfirmed) {
            const card = cancelButton.closest('.reservation-card');
            const reservationNo = card.dataset.reservationNo;
            if (reservationNo) {
                handleCancelReservation(reservationNo, card);
            }
        }
    }
    // [취소 로직 - AJAX]
    async function handleCancelReservation(reservationNo, cardElement) {
        try {
            const response = await fetch(`${contextPath}/member/reservation/cancel`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ reservationNo: parseInt(reservationNo) })
            });

            if (response.ok) {
                alert('예약이 성공적으로 취소되었습니다.');
                updateUICancelled(cardElement);
            } else {
                const errorText = await response.text();
                alert(`예약 취소에 실패했습니다: ${errorText}`);
            }
        } catch (error) {
            console.error('Error:', error);
            alert('네트워크 오류가 발생했습니다.');
        }
    }
    // [취소 로직 - UI 업데이트]
    function updateUICancelled(cardElement) {
        const statusDiv = cardElement.querySelector('.card-status .status-badge-inline');
        if (statusDiv) {
            statusDiv.className = 'status-badge-inline cancelled';
            statusDiv.innerHTML = `<div class="status-icon warning"></div><span class="status-text cancelled">예약 취소</span>`;
            statusDiv.style.backgroundColor = '#ffebee';
            statusDiv.style.color = '#d32f2f';
        }
        const actionsDiv = cardElement.querySelector('.card-actions');
        if (actionsDiv) {
            actionsDiv.innerHTML = '';
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


        // 모달 닫기 버튼 (X 버튼, 하단 '취소' 버튼)
        editModal.querySelectorAll('.modal-close, .modal-footer .btn-cancel').forEach(btn => {
            btn.addEventListener('click', closeEditModal);
        });

        // 모달 배경 클릭 시 닫기
        editModalOverlay.addEventListener('click', (e) => {
            if (e.target === editModalOverlay) {
                closeEditModal();
            }
        });

        // '변경' 버튼 클릭 핸들러
        function handleEditClick(editButton) {
            const card = editButton.closest('.reservation-card');
            const reservationNo = card.dataset.reservationNo;

            if (!reservationNo) {
                alert('예약 번호를 찾을 수 없습니다.');
                return;
            }
            openEditModal(reservationNo);
        }

        // (AJAX 1) 진료과 목록을 모달 select에 채우기 (최초 1회만)
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

        // (AJAX 2) 특정 예약 정보를 가져와 모달 폼에 채우기
        async function loadReservationData(reservationNo) {
            try {
                // 폼을 숨기고 로딩 스피너 표시
                editModalBody.classList.add('is-loading');

                // API 호출
                const response = await fetch(`${contextPath}/member/reservation/detail-json/${reservationNo}`);

                if (!response.ok) {
                    const errorText = await response.text();
                    throw new Error(errorText || '예약 정보를 불러올 수 없습니다. 서버 상태를 확인하세요.');
                }

                const data = await response.json();

                // ▼▼▼▼▼ [핵심 수정] Null 값 방어 로직 추가 ▼▼▼▼▼
                const safeDoctorName = data.doctorName || '';
                const safeTreatmentDate = data.treatmentDate || '';

                // 'YYYY-MM-DD HH24:MI' 형식을 'YYYY-MM-DDTHH:MI' (datetime-local) 형식으로 변경
                const localDateTime = safeTreatmentDate.replace(' ', 'T');

                // '담당의: 이름' 에서 '이름'만 추출 (null이 아니라는 것이 보장됨)
                const doctorName = safeDoctorName.replace('담당의: ', '');

                // 폼 필드에 값 채우기
                editReservationNoInput.value = data.reservationNo; // hidden field
                editDeptSelect.value = data.departmentNo;
                editDatetimeInput.value = localDateTime;
                editDoctorInput.value = doctorName;
                editNotesTextarea.value = data.reservationNotes || ''; // 증상도 null 방어

            } catch (error) {
                console.error(error);
                alert(error.message);
                closeEditModal();
            } finally {
                // 로딩 스피너 숨기고 폼 표시
                editModalBody.classList.remove('is-loading');
            }
        }

        // 모달 열기
        async function openEditModal(reservationNo) {
            editModalOverlay.classList.add('is-open');
            document.body.classList.add('modal-open');

            editModalOverlay.dataset.currentRno = reservationNo;

            const deptLoaded = await loadDepartmentsIntoModal();

            if (deptLoaded) {
                await loadReservationData(reservationNo);
            }
        }

        // 모달 닫기
        function closeEditModal() {
            editModalOverlay.classList.remove('is-open');
            document.body.classList.remove('modal-open');
            editForm.reset();
            editModalOverlay.dataset.currentRno = "";
        }

        // (AJAX 3) '저장' 버튼 클릭 (폼 제출) 핸들러
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
                treatmentDate: formData.get('treatmentDate').replace('T', ' '),
                doctorName: formData.get('doctorName'),
                reservationNotes: formData.get('reservationNotes'),
                reservationNo: parseInt(reservationNo)
            };

            try {
                const response = await fetch(`${contextPath}/member/reservation/submit?reservationNo=${reservationNo}`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(payload)
                });

                const result = await response.json();

                if (response.ok && result.success) {
                    alert(result.message || '예약이 성공적으로 변경되었습니다.');
                    closeEditModal();
                    window.location.reload();
                } else {
                    throw new Error(result.message || '예약 변경에 실패했습니다.');
                }

            } catch (error) {
                console.error('Update Error:', error);
                alert(error.message);
            }
        });

    } // --- '예약 변경' 모달 로직 끝 ---

}); // --- DOMContentLoaded 끝 ---