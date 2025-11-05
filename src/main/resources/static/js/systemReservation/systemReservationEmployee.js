document.addEventListener("DOMContentLoaded", function() {
    const calendarBody = document.getElementById('calendarBody');
    const yearSelect = document.getElementById('yearSelect');
    const monthSelect = document.getElementById('monthSelect');
    const prevMonthBtn = document.getElementById('prevMonthBtn');
    const nextMonthBtn = document.getElementById('nextMonthBtn');
    const todayLegendBadge = document.getElementById('todayLegendBadge');

    // 모달 요소들
    const modal = document.getElementById('reservationModal');
    const modalCloseBtn = document.getElementById('modalCloseBtn');
    const modalCancelBtn = document.getElementById('modalCancelBtn');
    const modalConfirmBtn = document.getElementById('modalConfirmBtn');
    const modalTitle = document.getElementById('modalTitle');
    const modalSubtitle = document.getElementById('modalSubtitle');
    const modalRoomIndicator = document.getElementById('modalRoomIndicator');
    const timeGrid = document.getElementById('timeGrid');
    const facilityHours = document.getElementById('facilityHours');
    const facilityDuration = document.getElementById('facilityDuration');
    const facilityManager = document.getElementById('facilityManager');
    const facilityContact = document.getElementById('facilityContact');

    const modalAvailableContent = document.getElementById('modalAvailableContent');
    const modalClosedContent = document.getElementById('modalClosedContent');
    const modalFullContent = document.getElementById('modalFullContent');
    const modalClosedDetailsText = document.getElementById('modalClosedDetailsText');
    const modalFullDetailsText = document.getElementById('modalFullDetailsText');

    let currentYear;
    let currentMonth;
    let selectedTime = null;

    const today = new Date();
    const todayYear = today.getFullYear();
    const todayMonth = today.getMonth() + 1;
    const todayDate = today.getDate();

    if (todayLegendBadge) {
        todayLegendBadge.textContent = todayDate;
    }

    // [ ✏️ 수정 ]
    // JSP 코드를 삭제했으므로, facilityData를 JS가 다시 정의합니다.
    const facilityData = {
        mri: {
            name: 'MRI',
            fullName: 'MRI 촬영실',
            location: '2층 영상의학과',
            hours: '평일 09:00 - 18:00',
            duration: '30-60분',
            manager: '김영희 기사',
            contact: '내선 2201',
            color: '#0e787c',
            code: 'MRI-01'
        },
        ultrasound: {
            name: '초음파',
            fullName: '초음파 검사실',
            location: '2층 영상의학과',
            hours: '평일 09:00 - 17:00',
            duration: '20-30분',
            manager: '이철수 기사',
            contact: '내선 2202',
            color: '#0ea5e9',
            code: '초음파-01'
        },
        ct: {
            name: 'CT',
            fullName: 'CT 촬영실',
            location: '2층 영상의학과',
            hours: '평일 08:00 - 18:00',
            duration: '15-30분',
            manager: '박민수 기사',
            contact: '내선 2203',
            color: '#8b5cf6',
            code: 'CT-01'
        },
        xray: {
            name: 'X-Ray',
            fullName: 'X-Ray 촬영실',
            location: '1층 영상의학과',
            hours: '평일 08:00 - 19:00',
            duration: '10-15분',
            manager: '정수진 기사',
            contact: '내선 1101',
            color: '#f59e0b',
            code: 'X Ray-01'
        },
        endoscopy: {
            name: '내시경',
            fullName: '내시경 검사실',
            location: '3층 소화기내과',
            hours: '평일 08:00 - 16:00',
            duration: '30-45분',
            manager: '최영호 기사',
            contact: '내선 3301',
            color: '#ec4899',
            code: '내시경-01'
        }
    };


    /**
     * openModal 함수
     */
    function openModal(roomType, year, month, date, status) {
        const facility = facilityData[roomType];
        if (!facility) {
            console.error("Facility data not found for:", roomType);
            return;
        }

        // --- 1. 공통 정보 업데이트 ---
        modalTitle.textContent = `${facility.name} - ${month}월 ${date}일`;
        modalSubtitle.textContent = facility.location;
        modalRoomIndicator.style.backgroundColor = facility.color;
        facilityHours.textContent = facility.hours;
        facilityDuration.textContent = facility.duration;
        facilityManager.textContent = facility.manager;
        facilityContact.textContent = facility.contact;

        // --- 2. 모든 콘텐츠 섹션과 '예약하기' 버튼을 일단 숨김 ---
        modalAvailableContent.classList.add('hidden');
        modalClosedContent.classList.add('hidden');
        modalFullContent.classList.add('hidden');
        modalConfirmBtn.classList.add('hidden');

        // --- 3. status 값에 따라 적절한 콘텐츠만 표시 ---
        if (status === 'available') {
            modalAvailableContent.classList.remove('hidden');
            modalConfirmBtn.classList.remove('hidden');
            generateTimeSlots(roomType, year, month, date);
            selectedTime = null;
            updateConfirmButton();

        } else if (status === 'closed') {
            modalClosedContent.classList.remove('hidden');
            modalClosedDetailsText.textContent = `이 날짜(${month}월 ${date}일)는 ${facility.fullName}(${facility.code})의 정기 점검 일정입니다. 점검 시간 동안 예약이 불가능합니다. (문의: ${facility.contact})`;

        } else if (status === 'full') {
            modalFullContent.classList.remove('hidden');
            modalFullDetailsText.textContent = `이 날짜(${month}월 ${date}일)의 ${facility.fullName} 예약이 모두 마감되었습니다. 다른 날짜를 선택해 주세요.`;
        }

        // --- 4. 모달창 표시 ---
        modal.classList.add('active');
        document.body.style.overflow = 'hidden';
    }


    // 시간 슬롯 생성 함수
    function generateTimeSlots(roomType, year, month, date) {
        timeGrid.innerHTML = '';
        const times = [
            '09:00', '10:00', '11:00', '13:00',
            '14:00', '15:00', '16:00', '17:00'
        ];

        times.forEach(time => {
            const button = document.createElement('button');
            button.className = 'time-btn';
            button.textContent = time;
            button.dataset.time = time;

            if (Math.random() > 0.7) {
                button.disabled = true;
            }

            button.addEventListener('click', function() {
                if (this.disabled) return;
                timeGrid.querySelectorAll('.time-btn').forEach(btn => {
                    btn.classList.remove('selected');
                });
                this.classList.add('selected');
                selectedTime = this.dataset.time;
                updateConfirmButton();
            });

            timeGrid.appendChild(button);
        });
    }

    // 확인 버튼 활성화 함수
    function updateConfirmButton() {
        modalConfirmBtn.disabled = !selectedTime;
    }

    // 모달 닫기 함수
    function closeModal() {
        modal.classList.remove('active');
        document.body.style.overflow = '';
        selectedTime = null;
    }

    // 모달 이벤트 리스너
    modalCloseBtn.addEventListener('click', closeModal);
    modalCancelBtn.addEventListener('click', closeModal);
    modal.addEventListener('click', function(e) {
        if (e.target === modal) {
            closeModal();
        }
    });
    modalConfirmBtn.addEventListener('click', function() {
        if (selectedTime) {
            alert(`예약이 완료되었습니다!\n선택 시간: ${selectedTime}`);
            closeModal();
        }
    });
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape' && modal.classList.contains('active')) {
            closeModal();
        }
    });


    // 날짜 초기화 및 렌더링 함수들
    function getInitialDate() {
        const urlParams = new URLSearchParams(window.location.search);
        const yearParam = parseInt(urlParams.get('year'));
        const monthParam = parseInt(urlParams.get('month'));

        if (!isNaN(yearParam) && !isNaN(monthParam) &&
            new Date(yearParam, monthParam - 1, 1) >= new Date(todayYear, todayMonth - 1, 1)) {
            currentYear = yearParam;
            currentMonth = monthParam;
        } else {
            currentYear = todayYear;
            currentMonth = todayMonth;
        }
    }

    function populateYearMonthSelects() {
        yearSelect.innerHTML = '';
        monthSelect.innerHTML = '';

        for (let y = todayYear; y <= todayYear + 5; y++) {
            const option = document.createElement('option');
            option.value = y;
            option.textContent = `${y}년`;
            if (y === currentYear) {
                option.selected = true;
            }
            yearSelect.appendChild(option);
        }

        const startMonth = (currentYear === todayYear) ? todayMonth : 1;
        for (let m = startMonth; m <= 12; m++) {
            const option = document.createElement('option');
            option.value = m;
            option.textContent = `${m}월`;
            if (m === currentMonth) {
                option.selected = true;
            }
            monthSelect.appendChild(option);
        }

        // [ ✏️ 수정 ]
        // JSP 페이지 이동 방식이 아닌, JS로 달력만 다시 그리는 방식으로 변경
        yearSelect.onchange = function() {
            currentYear = parseInt(this.value);
            if (currentYear === todayYear && currentMonth < todayMonth) {
                currentMonth = todayMonth;
            }
            updateCalendarAndURL(); // 페이지 새로고침 대신 함수 호출
        };

        monthSelect.onchange = function() {
            currentMonth = parseInt(this.value);
            updateCalendarAndURL(); // 페이지 새로고침 대신 함수 호출
        };
    }

    /**
     * [ ✏️ 수정된 함수 ]
     * renderCalendar 함수 : JS가 가짜 데이터를 다시 만들도록 수정
     */
    function renderCalendar(year, month) {
        if (!calendarBody) {
            console.error("calendarBody 요소를 찾을 수 없습니다.");
            return;
        }
        calendarBody.innerHTML = '';

        const firstDay = new Date(year, month - 1, 1);
        const lastDay = new Date(year, month, 0);
        const daysInMonth = lastDay.getDate();
        const startDayOfWeek = firstDay.getDay();

        let dayCounter = 1;

        for (let i = 0; i < 6; i++) {
            const calendarRow = document.createElement('div');
            calendarRow.classList.add('calendar-row');

            for (let j = 0; j < 7; j++) {
                const calendarCell = document.createElement('div');
                calendarCell.classList.add('calendar-cell');

                if (i === 0 && j < startDayOfWeek) {
                    calendarCell.classList.add('empty');
                }
                else if (dayCounter <= daysInMonth) {
                    const currentDate = new Date(year, month - 1, dayCounter);
                    const isToday = (currentDate.getFullYear() === today.getFullYear() &&
                        currentDate.getMonth() === today.getMonth() &&
                        currentDate.getDate() === today.getDate());
                    const isPast = (currentDate < new Date(today.setHours(0,0,0,0)) && !isToday);

                    if (isPast) calendarCell.classList.add('is-past');
                    else if (isToday) calendarCell.classList.add('today');

                    if (j === 0) calendarCell.classList.add('sunday');
                    if (j === 6) calendarCell.classList.add('saturday');

                    const dateSpan = document.createElement('span');
                    dateSpan.classList.add(isToday ? 'date-today' : 'date');
                    dateSpan.textContent = dayCounter;
                    calendarCell.appendChild(dateSpan);

                    const statusList = document.createElement('ul');
                    statusList.classList.add('status-list');

                    // [ ✏️ 수정 ]
                    // 1. 모든 검사실을 'available'로 기본 설정 (mock data)
                    const mockStatuses = [
                        { roomType: 'mri', status: 'available', text: 'MRI 가능' },
                        { roomType: 'ultrasound', status: 'available', text: '초음파 가능' },
                        { roomType: 'ct', status: 'available', text: 'CT 가능' },
                        { roomType: 'xray', status: 'available', text: 'X-Ray 가능' },
                        { roomType: 'endoscopy', status: 'available', text: '내시경 가능' }
                    ];

                    // 2. [ ✏️ 수정 ]
                    // JSP의 calendarExceptionData 대신, 하드코딩된 예외처리(mock)로 복귀
                    // (현재 2025년 11월 5일 기준)
                    if (year === 2025 && month === 11) {
                        if (dayCounter === 11) mockStatuses[1] = { roomType: 'ultrasound', status: 'closed', text: '초음파 점검' };
                        if (dayCounter === 15) {
                            mockStatuses[0] = { roomType: 'mri', status: 'closed', text: 'MRI 점검' };
                            mockStatuses[4] = { roomType: 'endoscopy', status: 'full', text: '내시경 마감' };
                        }
                        if (dayCounter === 22) mockStatuses[1] = { roomType: 'ultrasound', status: 'full', text: '초음파 마감' };
                    }

                    const currentDay = dayCounter;

                    // 3. 최종 목록(mockStatuses)으로 <li> 태그 생성
                    mockStatuses.forEach(s => {
                        const statusItem = document.createElement('li');
                        statusItem.classList.add('status-item', s.roomType, s.status);
                        statusItem.innerHTML = `<span class="status-dot"></span><span class="status-text">${s.text}</span>`;

                        if (!isPast) {
                            statusItem.style.cursor = 'pointer';
                            statusItem.addEventListener('click', function(e) {
                                e.stopPropagation();
                                openModal(s.roomType, year, month, currentDay, s.status);
                            });
                        }
                        statusList.appendChild(statusItem);
                    });

                    calendarCell.appendChild(statusList);
                    dayCounter++;
                }
                else {
                    calendarCell.classList.add('empty');
                }
                calendarRow.appendChild(calendarCell);
            }
            calendarBody.appendChild(calendarRow);

            if (dayCounter > daysInMonth) {
                break;
            }
        }
        applyRoomFilter();
    }

    // [ ✏️ 수정 ]
    // 페이지 새로고침 방식이 아닌, JS로 달력만 다시 그리는 방식으로 변경
    function updateCalendarAndURL() {
        const selectedDate = new Date(currentYear, currentMonth - 1, 1);
        const todayDate = new Date(todayYear, todayMonth - 1, 1);

        if (selectedDate < todayDate) {
            currentYear = todayYear;
            currentMonth = todayMonth;
        }

        // 페이지 새로고침 대신 달력을 다시 그리고, Select만 업데이트
        renderCalendar(currentYear, currentMonth);
        populateYearMonthSelects();

        // URL 변경 (선택사항)
        const newUrl = `?year=${currentYear}&month=${currentMonth}`;
        window.history.pushState({ path: newUrl }, '', newUrl);
    }

    // 검사실 필터 적용 함수
    function applyRoomFilter() {
        const selectedRoomBtn = document.querySelector('.room-btn.active');
        if (!selectedRoomBtn) return;
        const selectedRoom = selectedRoomBtn.dataset.room;
        const statusItems = document.querySelectorAll('.status-item');

        statusItems.forEach(item => {
            if (selectedRoom === 'all') {
                item.style.display = 'flex';
            } else {
                if (item.classList.contains(selectedRoom)) {
                    item.style.display = 'flex';
                } else {
                    item.style.display = 'none';
                }
            }
        });
    }

    // --- 초기화 (페이지 로드 시 실행) ---
    getInitialDate();
    populateYearMonthSelects();
    renderCalendar(currentYear, currentMonth); // JS가 가진 데이터로 달력 최초 렌더링
    applyRoomFilter();

    // --- 이벤트 리스너 (버튼 클릭 등) ---
    prevMonthBtn.addEventListener('click', () => {
        currentMonth--;
        if (currentMonth < 1) {
            currentMonth = 12;
            currentYear--;
        }
        if (currentYear < todayYear || (currentYear === todayYear && currentMonth < todayMonth)) {
            currentYear = todayYear;
            currentMonth = todayMonth;
        }
        updateCalendarAndURL(); // 페이지 새로고침 대신 함수 호출
    });

    nextMonthBtn.addEventListener('click', () => {
        currentMonth++;
        if (currentMonth > 12) {
            currentMonth = 1;
            currentYear++;
        }
        updateCalendarAndURL(); // 페이지 새로고침 대신 함수 호출
    });

    document.querySelectorAll('.room-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            document.querySelectorAll('.room-btn').forEach(b => {
                b.classList.remove('active');
                b.setAttribute('aria-pressed', 'false');
            });
            this.classList.add('active');
            this.setAttribute('aria-pressed', 'true');
            applyRoomFilter();
        });
    });

}); // DOMContentLoaded 닫는 괄호