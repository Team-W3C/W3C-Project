document.addEventListener('DOMContentLoaded', function () {

    /*
     * ==========================================
     * [섹션 1] 비회원 예약/조회 모달 (기존 로직)
     * ==========================================
     */
    const ajaxContextPath = g_contextPath + "/member/reservation";

    // --- [모달 1: 비회원 *예약*] ---
    const openGuestReservationModalBtn = document.getElementById('open-guest-modal');
    const guestReservationModal = document.querySelector('.guest-modal-overlay');

    // [수정] 모달 내부 요소 선택
    const guestDeptGrid = document.getElementById('guest-dept-grid');
    const guestDateInput = document.getElementById('guest-treatment-date');
    const guestTimeslotGrid = document.getElementById('guest-timeslot-grid');
    const guestSubmitBtn = document.getElementById('guest-submit-btn');

    // [수정] Hidden Input (폼 전송용)
    const hiddenDeptName = document.getElementById('guest-hidden-deptName');
    const hiddenDate = document.getElementById('guest-hidden-date');
    const hiddenTime = document.getElementById('guest-hidden-time');

    // [수정] 선택 상태 변수
    let selectedGuestDeptId = null;
    let selectedGuestDeptName = null;
    let selectedGuestDate = null;
    let selectedGuestTime = null;

    // ▼▼▼ [추가] 버튼 활성화를 위한 필수 입력 필드 목록 ▼▼▼
    const guestNameInput = document.getElementById('patient-name');
    const guestBirthDateInput = document.getElementById('birth-date');
    const guestBirthSuffixInput = document.getElementById('birth-suffix');
    const guestPhoneInput = document.getElementById('phone');
    const guestAddressInput = document.getElementById('address');
    const guestEmailInput = document.getElementById('email');
    const guestBloodTypeInput = document.getElementById('bloodType');

    const requiredGuestInputs = [
        guestNameInput,
        guestBirthDateInput,
        guestBirthSuffixInput,
        guestPhoneInput,
        guestAddressInput,
        guestEmailInput,
        guestBloodTypeInput
    ];

    if (openGuestReservationModalBtn && guestReservationModal) {
        const backdrop1 = guestReservationModal.querySelector('.guest-modal-backdrop');
        const closeBtnHeader1 = guestReservationModal.querySelector('.btn-close-header');
        const patientForm = document.getElementById('guestReservationForm');

        // 모달 열기
        function openGuestReservationModal(e) {
            e.preventDefault();
            guestReservationModal.classList.add('is-open');
            document.body.classList.add('modal-open');

            // 오늘 날짜 설정 (min 속성)
            const today = new Date();
            const year = today.getFullYear();
            const month = (today.getMonth() + 1).toString().padStart(2, '0');
            const day = today.getDate().toString().padStart(2, '0');
            const yyyyMmDd = `${year}-${month}-${day}`;

            if (guestDateInput) {
                guestDateInput.setAttribute('min', yyyyMmDd);
                guestDateInput.value = "";
            }

            // 모달 열 때 진료과 목록 로드
            loadGuestDepartments();
        }

        // 모달 닫기
        function closeGuestReservationModal() {
            guestReservationModal.classList.remove('is-open');
            document.body.classList.remove('modal-open');
            if (patientForm) {
                patientForm.reset();
            }
            guestDeptGrid.innerHTML = '<p>진료과 목록을 불러오는 중...</p>';
            guestTimeslotGrid.innerHTML = '<p style="color: #777; font-size: 14px;">진료과와 날짜를 먼저 선택해주세요.</p>';
            selectedGuestDeptId = null;
            selectedGuestDeptName = null;
            selectedGuestDate = null;
            selectedGuestTime = null;
            checkGuestSubmitButtonState();
        }

        openGuestReservationModalBtn.addEventListener('click', openGuestReservationModal);

        if (closeBtnHeader1) {
            closeBtnHeader1.addEventListener('click', closeGuestReservationModal);
        }
        if (backdrop1) {
            backdrop1.addEventListener('click', closeGuestReservationModal);
        }
    }

    /*
     * ==========================================
     * [모달 2: 비회원 *조회*] (AJAX 기능으로 교체됨)
     * ==========================================
     */
    const openGuestCheckModalBtn = document.getElementById('open-guest-check-modal');
    const guestCheckModal = document.querySelector('.guest-check-modal-overlay');

    if (openGuestCheckModalBtn && guestCheckModal) {
        const backdrop2 = guestCheckModal.querySelector('.guest-modal-backdrop');
        const closeBtnHeader2 = guestCheckModal.querySelector('.modal-close');

        const checkForm = document.getElementById('guestCheckForm');
        const nameInput = document.getElementById('guest-check-name');
        const phoneInput = document.getElementById('guest-check-phone');
        const submitBtn = document.getElementById('guest-check-submit-btn');
        const cancelBtn = document.getElementById('guest-check-cancel-btn');
        const resultsContainer = document.getElementById('guest-check-results');
        const errorContainer = document.getElementById('guest-check-error');

        function openGuestCheckModal(e) {
            e.preventDefault();
            guestCheckModal.classList.add('is-open');
            document.body.classList.add('modal-open');
        }

        function closeGuestCheckModal() {
            guestCheckModal.classList.remove('is-open');
            document.body.classList.remove('modal-open');
            if (checkForm) {
                checkForm.reset();
            }
            if (resultsContainer) {
                resultsContainer.innerHTML = `<p style="text-align: center; padding: 20px 0; color: #888;">성함과 전화번호를 입력 후 '확인' 버튼을 눌러주세요.</p>`;
            }
            if (errorContainer) {
                errorContainer.textContent = '';
                errorContainer.style.display = 'none';
            }
        }

        openGuestCheckModalBtn.addEventListener('click', openGuestCheckModal);

        if (closeBtnHeader2) {
            closeBtnHeader2.addEventListener('click', closeGuestCheckModal);
        }
        if (backdrop2) {
            backdrop2.addEventListener('click', closeGuestCheckModal);
        }
        if (cancelBtn) {
            cancelBtn.addEventListener('click', closeGuestCheckModal);
        }

        if (checkForm) {
            checkForm.addEventListener('submit', async function (e) {
                e.preventDefault();
                const name = nameInput.value.trim();
                const phone = phoneInput.value.trim();

                if (!name || !phone) {
                    showGuestCheckError('성함과 전화번호를 모두 입력해주세요.');
                    return;
                }

                if (!/^\d{3}-\d{3,4}-\d{4}$/.test(phone)) {
                    showGuestCheckError("전화번호를 '-' 포함하여 올바르게 입력해주세요. (예: 010-1234-5678)");
                    return;
                }

                submitBtn.disabled = true;
                submitBtn.textContent = '조회 중...';
                resultsContainer.innerHTML = '<p style="text-align: center; padding: 20px 0;">예약 내역을 조회 중입니다...</p>';
                errorContainer.style.display = 'none';

                try {
                    const checkUrl = `${g_contextPath}/guest/reservation/check`;
                    const response = await fetch(`${checkUrl}?name=${encodeURIComponent(name)}&phone=${encodeURIComponent(phone)}`);
                    if (!response.ok) throw new Error('서버 통신 중 오류가 발생했습니다.');
                    const reservations = await response.json();

                    if (reservations.length === 0) {
                        showGuestCheckError('일치하는 예약 내역이 없습니다.');
                        resultsContainer.innerHTML = '';
                    } else {
                        renderGuestReservations(reservations);
                    }
                } catch (error) {
                    console.error(error);
                    showGuestCheckError('조회 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
                    resultsContainer.innerHTML = '';
                } finally {
                    submitBtn.disabled = false;
                    submitBtn.textContent = '확인';
                }
            });
        }

        function showGuestCheckError(message) {
            if (errorContainer) {
                errorContainer.textContent = message;
                errorContainer.style.display = 'block';
            }
        }

        function renderGuestReservations(reservations) {
            if (!resultsContainer) return;
            const html = reservations.map(res => `
            <section class="info-card">
                <div class="info-icon">
                    <svg width="20" height="20" viewBox="0 0 20 20">
                        <circle cx="10" cy="7" r="3" stroke="#0E787C" stroke-width="1.67" fill="none"/>
                        <path d="M5 17C5 14 7 12 10 12C13 12 15 14 15 17" stroke="#0E787C" stroke-width="1.67" fill="none"/>
                    </svg>
                </div>
                <div class="info-content">
                    <span class="info-label">${res.patientName || '환자명'}</span>
                    <span class="info-value" style="color: #0E787C; font-weight: bold;">
                        ${res.status || '예약완료'}
                    </span>
                </div>
                <div class="info-content" style="flex-basis: 100%; border-top: 1px dashed #eee; padding-top: 10px; margin-top: 10px;">
                    <span class="info-label">진료과</span>
                    <span class="info-value">${res.departmentName || '정보없음'}</span>
                </div>
                <div class="info-content">
                    <span class="info-label">진료일시</span>
                    <span class="info-value">${res.treatmentDate || '날짜정보없음'} ${res.treatmentTime || ''}</span>
                </div>
            </section>
        `).join('');
            resultsContainer.innerHTML = html;
        }
    }


    /*
     * ==========================================
     * [섹션 2] 비회원 예약 동적 AJAX 로직
     * ==========================================
     */

    requiredGuestInputs.forEach(input => {
        if (input) {
            input.addEventListener('input', checkGuestSubmitButtonState);
            input.addEventListener('change', checkGuestSubmitButtonState);
        }
    });

    async function loadGuestDepartments() {
        if (!guestDeptGrid) return;
        guestDeptGrid.innerHTML = '<p>진료과 목록을 불러오는 중...</p>';

        try {
            const response = await fetch(ajaxContextPath + '/departments');
            if (!response.ok) throw new Error('진료과 로딩 실패');
            const departments = await response.json();

            if (departments.length === 0) {
                guestDeptGrid.innerHTML = '<p>조회 가능한 진료과가 없습니다.</p>';
                return;
            }

            guestDeptGrid.innerHTML = departments.map(dept => `
                <button type="button" class="guest-dept-btn" 
                        data-dept-id="${dept.departmentNo}" 
                        data-dept-name="${dept.departmentName}">
                    <img src="${g_contextPath}${dept.iconUrl || '/img/icons/default.png'}" alt="">
                    ${dept.departmentName}
                </button>
            `).join('');
        } catch (error) {
            console.error(error);
            guestDeptGrid.innerHTML = '<p>진료과 로딩 중 오류가 발생했습니다.</p>';
        }
    }

    async function loadGuestTimes() {
        if (!guestTimeslotGrid || !selectedGuestDeptId || !selectedGuestDate) {
            guestTimeslotGrid.innerHTML = '<p>진료과와 날짜를 먼저 선택해주세요.</p>';
            return;
        }

        guestTimeslotGrid.innerHTML = '<p>시간을 조회 중입니다...</p>';
        selectedGuestTime = null;
        checkGuestSubmitButtonState();

        try {
            const response = await fetch(`${ajaxContextPath}/available-times?date=${selectedGuestDate}&departmentId=${selectedGuestDeptId}`);
            if (!response.ok) throw new Error('시간표 로딩 실패');
            const times = await response.json();

            if (!times || times.length === 0) {
                guestTimeslotGrid.innerHTML = '<p style="color: red; font-size: 14px;">선택한 날짜에 예약 가능한 시간이 없습니다.</p>';
                return;
            }

            // (참고) 서버에서 이미 지난 시간은 available: false로 내려주므로
            // 아래 disabled 속성이 자동으로 적용됩니다.
            guestTimeslotGrid.innerHTML = times.map(slot => `
                <button type="button" class="guest-time-btn" 
                        data-time="${slot.time}" 
                        ${!slot.available ? 'disabled' : ''}>
                    ${slot.time}
                </button>
            `).join('');
        } catch (error) {
            console.error(error);
            guestTimeslotGrid.innerHTML = '<p>시간표 로딩 중 오류가 발생했습니다.</f>';
        }
    }

    if (guestDeptGrid) {
        guestDeptGrid.addEventListener('click', function (e) {
            const target = e.target.closest('.guest-dept-btn');
            if (!target) return;
            guestDeptGrid.querySelectorAll('.guest-dept-btn').forEach(btn => btn.classList.remove('selected'));
            target.classList.add('selected');
            selectedGuestDeptId = target.dataset.deptId;
            selectedGuestDeptName = target.dataset.deptName;
            if (hiddenDeptName) hiddenDeptName.value = selectedGuestDeptName;
            loadGuestTimes();
            checkGuestSubmitButtonState();
        });
    }

    if (guestDateInput) {
        guestDateInput.addEventListener('change', function () {
            selectedGuestDate = this.value;
            if (hiddenDate) hiddenDate.value = selectedGuestDate;
            loadGuestTimes();
            checkGuestSubmitButtonState();
        });
    }

    if (guestTimeslotGrid) {
        guestTimeslotGrid.addEventListener('click', function (e) {
            const target = e.target.closest('.guest-time-btn');
            if (!target || target.disabled) return;
            guestTimeslotGrid.querySelectorAll('.guest-time-btn').forEach(btn => btn.classList.remove('selected'));
            target.classList.add('selected');
            selectedGuestTime = target.dataset.time;
            if (hiddenTime) hiddenTime.value = selectedGuestTime;
            checkGuestSubmitButtonState();
        });
    }

    function checkGuestSubmitButtonState() {
        if (guestSubmitBtn) {
            const dynamicSelectionsValid = selectedGuestDeptId && selectedGuestDate && selectedGuestTime;
            const staticInputsValid = requiredGuestInputs.every(input => {
                return input && input.value.trim() !== '';
            });
            if (dynamicSelectionsValid && staticInputsValid) {
                guestSubmitBtn.disabled = false;
            } else {
                guestSubmitBtn.disabled = true;
            }
        }
    }

    /*
     * ==========================================
     * [섹션 3] 비회원 예약 폼 유효성 검사
     * ==========================================
     */
    const guestReservationForm = document.getElementById('guestReservationForm');

    if (guestReservationForm) {
        guestReservationForm.addEventListener('submit', function (e) {
            const deptName = document.getElementById('guest-hidden-deptName').value;
            const date = document.getElementById('guest-hidden-date').value;
            const time = document.getElementById('guest-hidden-time').value;

            if (!deptName || !date || !time) {
                alert('진료과, 진료 날짜, 예약 시간을 모두 선택해주세요.');
                e.preventDefault();
                return;
            }

            // [수정] 프론트엔드에서 과거 시간 선택 여부 재확인
            if (date && time) {
                const selectedDateTime = new Date(`${date}T${time}:00`);
                const now = new Date();
                // 선택한 시간이 현재 시간보다 이전이면 차단
                if (selectedDateTime < now) {
                    alert('현재 시간보다 이전 시간으로 예약할 수 없습니다.');
                    e.preventDefault();
                    return;
                }
            }

            const name = document.getElementById('patient-name');
            const birthDate = document.getElementById('birth-date');
            const birthSuffix = document.getElementById('birth-suffix');
            const phone = document.getElementById('phone');
            const address = document.getElementById('address');
            const email = document.getElementById('email');
            const bloodType = document.getElementById('bloodType');

            if (!name.value.trim()) {
                alert('이름을 입력해주세요.');
                e.preventDefault();
                name.focus();
                return;
            }
            if (birthDate.value.length !== 6 || !/^\d{6}$/.test(birthDate.value)) {
                alert('생년월일 6자리를 올바르게 입력해주세요. (예: 950101)');
                e.preventDefault();
                birthDate.focus();
                return;
            }
            if (birthSuffix.value.length !== 7 || !/^\d{7}$/.test(birthSuffix.value)) {
                alert('주민번호 뒷자리 7자리를 올바르게 입력해주세요.');
                e.preventDefault();
                birthSuffix.focus();
                return;
            }
            if (!/^\d{3}-\d{3,4}-\d{4}$/.test(phone.value)) {
                alert("전화번호를 '-' 포함하여 올바르게 입력해주세요. (예: 010-1234-5678)");
                e.preventDefault();
                phone.focus();
                return;
            }
            if (!address.value.trim()) {
                alert('주소를 입력해주세요.');
                e.preventDefault();
                address.focus();
                return;
            }
            if (!bloodType.value) {
                alert('혈액형을 선택해주세요.');
                e.preventDefault();
                bloodType.focus();
                return;
            }
            if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) {
                alert('유효한 이메일 주소를 입력해주세요.');
                e.preventDefault();
                email.focus();
                return;
            }
        });
    }
});