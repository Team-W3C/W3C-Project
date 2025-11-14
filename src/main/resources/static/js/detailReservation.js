/*
 * ==========================================
 * 진료 예약 페이지 동적 스크립트
 * (모달 + FullCalendar + AJAX 연동)
 * ==========================================
 */
document.addEventListener('DOMContentLoaded', function () {

    /*
     * ==========================================
     * [섹션 1] 비회원 예약/조회 모달 (사용자가 제공한 코드)
     * ==========================================
     */

    // --- [모달 1: 비회원 *예약*] ---
    const openGuestReservationModalBtn = document.getElementById('open-guest-modal');
    const guestReservationModal = document.querySelector('.guest-modal-overlay');

    if (openGuestReservationModalBtn && guestReservationModal) {
        const backdrop1 = guestReservationModal.querySelector('.guest-modal-backdrop');
        const closeBtnHeader1 = guestReservationModal.querySelector('.btn-close-header');
        const patientForm1 = guestReservationModal.querySelector('.patient-form');

        function openGuestReservationModal(e) {
            e.preventDefault();
            guestReservationModal.classList.add('is-open');
            document.body.classList.add('modal-open');
        }

        function closeGuestReservationModal() {
            guestReservationModal.classList.remove('is-open');
            document.body.classList.remove('modal-open');
            if (patientForm1) {
                patientForm1.reset();
            }
        }

        openGuestReservationModalBtn.addEventListener('click', openGuestReservationModal);

        if (closeBtnHeader1) {
            closeBtnHeader1.addEventListener('click', closeGuestReservationModal);
        }
        if (backdrop1) {
            backdrop1.addEventListener('click', closeGuestReservationModal);
        }
        if (patientForm1) {
            patientForm1.addEventListener('submit', function (e) {
                e.preventDefault();
                alert('비회원 예약이 요청되었습니다.');
                closeGuestReservationModal();
            });
        }
    }

    // --- [모달 2: 비회원 *조회*] ---
    const openGuestCheckModalBtn = document.getElementById('open-guest-check-modal');
    const guestCheckModal = document.querySelector('.guest-check-modal-overlay');

    if (openGuestCheckModalBtn && guestCheckModal) {
        const backdrop2 = guestCheckModal.querySelector('.guest-modal-backdrop');
        const closeBtnHeader2 = guestCheckModal.querySelector('.modal-close');
        const cancelBtn2 = guestCheckModal.querySelector('.btn-cancel');
        const patientForm2 = guestCheckModal.querySelector('.reservation-form');

        function openGuestCheckModal(e) {
            e.preventDefault();
            guestCheckModal.classList.add('is-open');
            document.body.classList.add('modal-open');
        }

        function closeGuestCheckModal() {
            guestCheckModal.classList.remove('is-open');
            document.body.classList.remove('modal-open');
            if (patientForm2) {
                patientForm2.reset();
            }
        }

        openGuestCheckModalBtn.addEventListener('click', openGuestCheckModal);

        if (closeBtnHeader2) {
            closeBtnHeader2.addEventListener('click', closeGuestCheckModal);
        }
        if (backdrop2) {
            backdrop2.addEventListener('click', closeGuestCheckModal);
        }
        if (cancelBtn2) {
            cancelBtn2.addEventListener('click', closeGuestCheckModal);
        }
        if (patientForm2) {
            patientForm2.addEventListener('submit', function (e) {
                e.preventDefault();
                alert('비회원 예약 조회를 요청합니다.');
                closeGuestCheckModal();
            });
        }
    }


    /*
    * ==========================================
    * [섹션 2] 진료 예약 (FullCalendar + AJAX)
    * ==========================================
    */

    // --- 1. 전역 변수 및 요소 선택 ---
    const calendarEl = document.getElementById('calendar');
    const deptGrid = document.getElementById('department-grid');
    const timeslotGrid = document.getElementById('timeslot-grid');
    const summaryDate = document.getElementById('summary-date');
    const summaryDept = document.getElementById('summary-dept');
    const submitReservationBtn = document.getElementById('submit-reservation-btn');
    const notesTextarea = document.getElementById('reservation-notes');

    // 사용자의 선택 상태
    let selectedDate = null;
    let selectedDeptId = null;
    let selectedDeptName = null;
    let selectedTimeSlot = null; // 선택한 시간 버튼 DOM 요소
    let selectedTimeSlotData = null; // 선택한 시간의 데이터

    const contextPath = "/member/reservation";

    // --- 2. FullCalendar 초기화 (높이 고정 추가) ---
    if (calendarEl) {
        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'ko',
            height: 'auto',
            aspectRatio: 1.35,
            headerToolbar: {
                left: 'prev',
                center: 'title',
                right: 'next',
            },
            events: contextPath + '/available-dates',
            selectable: true,
            dayMaxEvents: false,
            fixedWeekCount: false,
            showNonCurrentDates: true,

            dayCellDidMount: function (info) {
                const cellDate = new Date(info.date);
                cellDate.setHours(0, 0, 0, 0);
                const today = new Date();
                today.setHours(0, 0, 0, 0);

                info.el.classList.add('calendar-day');

                if (cellDate < today) {
                    info.el.classList.add('disabled', 'fc-day-past');
                } else {
                    info.el.classList.add('available');
                }
            },

            dateClick: function (info) {
                const clickedDate = new Date(info.date);
                clickedDate.setHours(0, 0, 0, 0);
                const today = new Date();
                today.setHours(0, 0, 0, 0);

                // 과거 날짜는 클릭 불가
                if (clickedDate < today) {
                    return;
                }

                if (info.dayEl.classList.contains('unavailable-date')) {
                    return;
                }

                // 이전 선택 제거
                const prevSelected = calendarEl.querySelector('.calendar-day.selected');
                if (prevSelected) {
                    prevSelected.classList.remove('selected');
                }

                // 새로운 선택
                info.dayEl.classList.add('selected');
                selectedDate = info.dateStr;

                console.log('Selected date:', selectedDate);

                updateSummary();
                checkAndLoadTimes();
                checkReservationButtonState();
            },
        });

        calendar.render();

        // 렌더링 후 과거 날짜 비활성화 확인
        setTimeout(() => {
            const today = new Date();
            today.setHours(0, 0, 0, 0);

            document.querySelectorAll('.fc-daygrid-day').forEach(dayEl => {
                const dateStr = dayEl.getAttribute('data-date');
                if (dateStr) {
                    const cellDate = new Date(dateStr);
                    cellDate.setHours(0, 0, 0, 0);

                    if (cellDate < today) {
                        dayEl.style.pointerEvents = 'none';
                        dayEl.style.opacity = '0.5';
                    }
                }
            });
        }, 100);
    }


    // --- 3. [AJAX] 진료과 목록 동적 로드 ---
    async function loadDepartments() {
        if (!deptGrid) return;

        try {
            const response = await fetch(contextPath + '/departments');
            if (!response.ok) throw new Error('진료과 로딩 실패');

            const departments = await response.json();

            if (departments.length === 0) {
                deptGrid.innerHTML = '<p>조회 가능한 진료과가 없습니다.</p>';
                return;
            }

            deptGrid.innerHTML = departments.map(dept => `
                <button type="button" class="department-btn" data-dept-id="${dept.departmentNo}" data-dept-name="${dept.departmentName}">
                    <img src="${dept.iconUrl || 'https://c.animaapp.com/mhjva9g3rpbRQm/img/container.svg'}" alt="" class="department-icon" />
                    <span>${dept.departmentName}</span>
                    <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-1.svg" alt="선택됨" class="check-icon" />
                </button>
            `).join('');

            addDepartmentClickHandlers();

        } catch (error) {
            console.error(error);
            deptGrid.innerHTML = '<p>진료과를 불러오는 중 오류가 발생했습니다.</p>';
        }
    }

    // --- 4. [AJAX] 예약 가능 시간표 로드 ---
    async function loadAvailableTimes(date, deptId) {
        if (!timeslotGrid) return;

        timeslotGrid.innerHTML = '<p>예약 가능한 시간을 조회 중입니다...</p>';

        selectedTimeSlot = null;
        selectedTimeSlotData = null;
        checkReservationButtonState();

        try {
            const response = await fetch(`${contextPath}/available-times?date=${date}&departmentId=${deptId}`);
            if (!response.ok) throw new Error('시간표 로딩 실패');

            const times = await response.json();

            if (!times || times.length === 0) {
                timeslotGrid.innerHTML = '<p>해당 날짜에 예약 가능한 시간이 없습니다.</p>';
                return;
            }

            timeslotGrid.innerHTML = times.map(slot => {
                const timeRange = `${slot.time}~${(parseInt(slot.time.split(':')[0]) + 1).toString().padStart(2, '0')}:00`;

                if (slot.available) {
                    return `
                        <button type="button" class="timeslot-card available" 
                                data-time="${slot.time}" 
                                data-doctor="${slot.doctorName}" 
                                data-location="${slot.location}">
                            <div class="timeslot-header">
                                <div class="timeslot-time">
                                    <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-4.svg" alt="" />
                                    <span>${timeRange}</span>
                                </div>
                                <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-8.svg" alt="예약 가능" class="status-icon" />
                            </div>
                            <div class="timeslot-info">
                                <p class="doctor-info">
                                    <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-2.svg" alt="" />
                                    <span>${slot.doctorName} 교수</span>
                                </p>
                                <p class="location-info">
                                    <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-7.svg" alt="" />
                                    <span>${slot.location}</span>
                                </p>
                            </div>
                        </button>
                    `;
                } else {
                    return `
                        <div class="timeslot-card unavailable">
                            <div class="timeslot-header">
                                <div class="timeslot-time">
                                    <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-9.svg" alt="" />
                                    <span>${timeRange}</span>
                                </div>
                                <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-11.svg" alt="예약 마감" class="status-icon" />
                            </div>
                            <span class="unavailable-badge">예약 마감</span>
                        </div>
                    `;
                }
            }).join('');

            addTimeslotClickHandlers();

        } catch (error) {
            console.error(error);
            timeslotGrid.innerHTML = '<p>시간표를 불러오는 중 오류가 발생했습니다.</p>';
        }
    }


    // --- 5. 유틸리티 및 이벤트 핸들러 ---
    function addDepartmentClickHandlers() {
        deptGrid.querySelectorAll('.department-btn').forEach(button => {
            button.addEventListener('click', function () {
                deptGrid.querySelectorAll('.department-btn').forEach(btn => btn.classList.remove('selected'));
                this.classList.add('selected');
                selectedDeptId = this.dataset.deptId;
                selectedDeptName = this.dataset.deptName;
                updateSummary();
                checkAndLoadTimes();
                checkReservationButtonState();
            });
        });
    }

    function addTimeslotClickHandlers() {
        timeslotGrid.querySelectorAll('.timeslot-card.available').forEach(button => {
            button.addEventListener('click', function () {
                if (selectedTimeSlot) {
                    selectedTimeSlot.classList.remove('selected');
                    const icon = selectedTimeSlot.querySelector('.status-icon');
                    if (icon) {
                        icon.src = 'https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-8.svg';
                        icon.alt = '예약 가능';
                    }
                }

                this.classList.add('selected');
                selectedTimeSlot = this;
                selectedTimeSlotData = {
                    time: this.dataset.time,
                    doctor: this.dataset.doctor,
                    location: this.dataset.location
                };

                const icon = this.querySelector('.status-icon');
                if (icon) {
                    icon.src = 'https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-1.svg';
                    icon.alt = '선택됨';
                }

                checkReservationButtonState();
            });
        });
    }

    if (notesTextarea) {
        notesTextarea.addEventListener('input', checkReservationButtonState);
    }

    function checkReservationButtonState() {
        if (submitReservationBtn) {
            const notesValue = notesTextarea ? notesTextarea.value.trim() : '';

            if (selectedDate && selectedDeptId && selectedTimeSlotData && notesValue !== '') {
                submitReservationBtn.disabled = false;
            } else {
                submitReservationBtn.disabled = true;
            }
        }
    }

    function checkAndLoadTimes() {
        if (selectedDate && selectedDeptId) {
            loadAvailableTimes(selectedDate, selectedDeptId);
        } else {
            timeslotGrid.innerHTML = '<p>날짜와 진료과를 먼저 선택해주세요.</p>';
            selectedTimeSlot = null;
            selectedTimeSlotData = null;
            checkReservationButtonState();
        }
    }

    function updateSummary() {
        if (summaryDept) {
            summaryDept.textContent = selectedDeptName || '선택안함';
        }
        if (summaryDate) {
            if (selectedDate) {
                const [year, month, day] = selectedDate.split('-');
                const localDate = new Date(year, month - 1, day);
                const options = { year: 'numeric', month: 'long', day: 'numeric', weekday: 'short' };
                summaryDate.textContent = localDate.toLocaleDateString('ko-KR', options);
            } else {
                summaryDate.textContent = '선택안함';
            }
        }
    }

    // --- 6. 예약 제출 (DB 연동) ---
    if (submitReservationBtn) {
        submitReservationBtn.addEventListener('click', async function() {
            const reservationNotes = notesTextarea.value.trim();

            if (!selectedDate || !selectedDeptId || !selectedTimeSlotData || reservationNotes === '') {
                alert("날짜, 진료과, 시간, 증상을 모두 선택(입력)해주세요.");
                return;
            }

            const reservationData = {
                departmentNo: parseInt(selectedDeptId, 10),
                treatmentDate: `${selectedDate} ${selectedTimeSlotData.time}`,
                reservationNotes: reservationNotes,
                doctorName: selectedTimeSlotData.doctor
            };

            this.disabled = true;
            this.textContent = "예약 처리 중...";

            try {
                const response = await fetch(contextPath + '/submit', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(reservationData)
                });

                const result = await response.json();

                if (response.ok && result.success) {
                    alert(result.message);
                    window.location.reload();

                } else {
                    alert("예약 실패: " + (result.message || "알 수 없는 오류"));
                    this.disabled = false;
                    this.textContent = "예약하기";
                }

            } catch (error) {
                console.error("Error submitting reservation:", error);
                alert("예약 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
                this.disabled = false;
                this.textContent = "예약하기";
            }
        });
    }

    // --- 7. 초기 실행 ---
    if (deptGrid) {
        loadDepartments();
    }

});