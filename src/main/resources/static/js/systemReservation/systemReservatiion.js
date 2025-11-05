document.addEventListener("DOMContentLoaded", function() {
    const calendarBody = document.getElementById('calendarBody');
    const yearSelect = document.getElementById('yearSelect');
    const monthSelect = document.getElementById('monthSelect');
    const prevMonthBtn = document.getElementById('prevMonthBtn');
    const nextMonthBtn = document.getElementById('nextMonthBtn');
    const todayLegendBadge = document.getElementById('todayLegendBadge');

    let currentYear;
    let currentMonth;

    const today = new Date();
    const todayYear = today.getFullYear();
    const todayMonth = today.getMonth() + 1;
    const todayDate = today.getDate();

    if (todayLegendBadge) {
        todayLegendBadge.textContent = todayDate;
    }

    // ===========================================
    // 1. URL 파라미터에서 현재 년/월 가져오기 또는 기본값 설정
    // ===========================================
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

    // ===========================================
    // 2. 드롭다운 목록 초기화 및 선택된 값 설정
    // ===========================================
    function populateYearMonthSelects() {
        yearSelect.innerHTML = '';
        monthSelect.innerHTML = '';

        for (let y = todayYear; y <= todayYear + 5; y++) {
            const option = document.createElement('option');
            option.value = y;
            option.textContent = y + '년';
            if (y === currentYear) {
                option.selected = true;
            }
            yearSelect.appendChild(option);
        }

        const startMonth = (currentYear === todayYear) ? todayMonth : 1;
        for (let m = startMonth; m <= 12; m++) {
            const option = document.createElement('option');
            option.value = m;
            option.textContent = m + '월';
            if (m === currentMonth) {
                option.selected = true;
            }
            monthSelect.appendChild(option);
        }

        yearSelect.onchange = function() {
            currentYear = parseInt(this.value);
            if (currentYear === todayYear && currentMonth < todayMonth) {
                currentMonth = todayMonth;
            } else if (currentYear !== todayYear && currentMonth < 1) {
                currentMonth = 1;
            }
            updateCalendarAndURL();
        };

        monthSelect.onchange = function() {
            currentMonth = parseInt(this.value);
            updateCalendarAndURL();
        };
    }

    // ===========================================
    // 3. 달력 렌더링 함수
    // ===========================================
    function renderCalendar(year, month) {
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
                    const isPast = (currentDate < today && !isToday);

                    if (isPast) {
                        calendarCell.classList.add('is-past');
                    } else if (isToday) {
                        calendarCell.classList.add('today');
                    }

                    if (j === 0) calendarCell.classList.add('sunday');
                    if (j === 6) calendarCell.classList.add('saturday');

                    const dateSpan = document.createElement('span');
                    dateSpan.classList.add(isToday ? 'date-today' : 'date');
                    dateSpan.textContent = dayCounter;
                    calendarCell.appendChild(dateSpan);

                    if (isToday) {
                        dateSpan.id = "todayDate";
                    }

                    // ===========================================
                    // 예약 상태 목록 (가상 데이터)
                    // 실제 구현 시 서버에서 데이터를 받아와야 합니다
                    // ===========================================
                    const statusList = document.createElement('ul');
                    statusList.classList.add('status-list');

                    const mockStatuses = getMockReservationData(year, month, dayCounter);

                    mockStatuses.forEach(function(s) {
                        const statusItem = document.createElement('li');
                        statusItem.classList.add('status-item', s.roomType, s.status);
                        statusItem.innerHTML = '<span class="status-dot"></span><span class="status-text">' + s.text + '</span>';

                        // 예약 가능 항목 클릭 이벤트 (필요시 추가)
                        if (s.status === 'available') {
                            statusItem.addEventListener('click', function() {
                                handleReservationClick(year, month, dayCounter, s.roomType);
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

    // ===========================================
    // 가상 예약 데이터 생성 (실제 환경에서는 서버 API 호출)
    // ===========================================
    function getMockReservationData(year, month, day) {
        const mockStatuses = [
            { roomType: 'mri', status: 'available', text: 'MRI 가능' },
            { roomType: 'ultrasound', status: 'available', text: '초음파 가능' },
            { roomType: 'ct', status: 'available', text: 'CT 가능' },
            { roomType: 'xray', status: 'available', text: 'X-Ray 가능' },
            { roomType: 'endoscopy', status: 'available', text: '내시경 가능' }
        ];

        // 특정 날짜에 따라 상태 변경 (테스트용)
        if (year === 2025 && month === 10) {
            if (day === 11) mockStatuses[1] = { roomType: 'ultrasound', status: 'closed', text: '초음파 휴진' };
            if (day === 15) {
                mockStatuses[0] = { roomType: 'mri', status: 'closed', text: 'MRI 휴진' };
                mockStatuses[4] = { roomType: 'endoscopy', status: 'full', text: '내시경 마감' };
            }
            if (day === 22) mockStatuses[1] = { roomType: 'ultrasound', status: 'full', text: '초음파 마감' };
        }

        return mockStatuses;
    }

    // ===========================================
    // 예약 클릭 핸들러 (필요시 구현)
    // ===========================================
    function handleReservationClick(year, month, day, roomType) {
        // 예약 페이지로 이동하거나 모달 표시
        console.log('예약 클릭:', year + '년 ' + month + '월 ' + day + '일, 검사실: ' + roomType);
        // 실제 구현 예시:
        // window.location.href = '/reservation/create?year=' + year + '&month=' + month + '&day=' + day + '&room=' + roomType;
    }

    // ===========================================
    // 4. URL 업데이트 및 달력/드롭다운 재렌더링
    // ===========================================
    function updateCalendarAndURL() {
        const selectedDate = new Date(currentYear, currentMonth - 1, 1);
        const todayDate = new Date(todayYear, todayMonth - 1, 1);

        if (selectedDate < todayDate) {
            currentYear = todayYear;
            currentMonth = todayMonth;
        }

        renderCalendar(currentYear, currentMonth);
        populateYearMonthSelects();

        const newUrl = window.location.origin + window.location.pathname + '?year=' + currentYear + '&month=' + currentMonth;
        window.history.pushState({ path: newUrl }, '', newUrl);

        updateNavButtons();
    }

    // ===========================================
    // 5. 이전/다음 버튼 활성화/비활성화
    // ===========================================
    function updateNavButtons() {
        const prevMonth = new Date(currentYear, currentMonth - 2, 1);
        const todayMonthStart = new Date(todayYear, todayMonth - 1, 1);

        if (prevMonth < todayMonthStart) {
            prevMonthBtn.disabled = true;
        } else {
            prevMonthBtn.disabled = false;
        }
        nextMonthBtn.disabled = false;
    }

    // ===========================================
    // 6. 이벤트 리스너 설정
    // ===========================================
    prevMonthBtn.addEventListener('click', function() {
        if(this.disabled) return;

        let newMonth = currentMonth - 1;
        let newYear = currentYear;
        if (newMonth < 1) {
            newMonth = 12;
            newYear--;
        }

        const prevDate = new Date(newYear, newMonth - 1, 1);
        const todayDate = new Date(todayYear, todayMonth - 1, 1);
        if (prevDate < todayDate) {
            return;
        }

        currentYear = newYear;
        currentMonth = newMonth;
        updateCalendarAndURL();
    });

    nextMonthBtn.addEventListener('click', function() {
        if(this.disabled) return;

        let newMonth = currentMonth + 1;
        let newYear = currentYear;
        if (newMonth > 12) {
            newMonth = 1;
            newYear++;
        }
        currentYear = newYear;
        currentMonth = newMonth;
        updateCalendarAndURL();
    });

    // ===========================================
    // 7. 검사실 필터링 로직
    // ===========================================
    const roomList = document.querySelector(".room-list");
    const roomButtons = roomList.querySelectorAll(".room-btn");

    function applyRoomFilter() {
        const allStatusItems = document.querySelectorAll(".status-list .status-item");
        const activeRoomBtn = roomList.querySelector(".room-btn.active");
        const selectedRoom = activeRoomBtn ? activeRoomBtn.getAttribute('data-room') : 'all';

        allStatusItems.forEach(function(item) {
            if (selectedRoom === 'all') {
                item.classList.remove('is-hidden');
            } else {
                if (item.classList.contains(selectedRoom)) {
                    item.classList.remove('is-hidden');
                } else {
                    item.classList.add('is-hidden');
                }
            }
        });
    }

    roomButtons.forEach(function(button) {
        button.addEventListener("click", function() {
            roomButtons.forEach(function(btn) {
                btn.classList.remove("active");
                btn.setAttribute("aria-pressed", "false");
            });
            this.classList.add("active");
            this.setAttribute("aria-pressed", "true");
            applyRoomFilter();
        });
    });

    // ===========================================
    // 초기 로드 시 달력 및 드롭다운 렌더링
    // ===========================================
    getInitialDate();
    updateCalendarAndURL();
});