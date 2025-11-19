document.addEventListener("DOMContentLoaded", function () {
    const calendarBody = document.getElementById('calendarBody');
    const yearSelect = document.getElementById('yearSelect');
    const monthSelect = document.getElementById('monthSelect');
    const prevMonthBtn = document.getElementById('prevMonthBtn');
    const nextMonthBtn = document.getElementById('nextMonthBtn');
    const todayLegendBadge = document.getElementById('todayLegendBadge');
    const roomList = document.getElementById("roomList");

    // 데이터 저장용 변수
    let facilitiesData = []; // 시설 목록
    let allReservations = []; // 전체 예약 목록

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
    // 0. 초기화 실행 함수 (데이터 페치 후 달력 렌더링)
    // ===========================================
    async function init() {
        try {
            await fetchFacilities(); // 시설 목록 가져오기
            await fetchAllReservations(); // 전체 예약 가져오기
            getInitialDate();
            populateYearMonthSelects();
            updateCalendarAndURL(); // 달력 그리기
        } catch (error) {
            console.error("초기화 중 오류 발생:", error);
        }
    }

    // ===========================================
    // 1. API: 시설 목록 조회 및 버튼 생성
    // ===========================================
    async function fetchFacilities() {
        try {
            const response = await fetch(`${contextPath}/api/facilityReservation/facilities`);
            const result = await response.json();

            if (result.success) {
                facilitiesData = result.facilities;
                renderFacilityButtons();
            } else {
                console.error("시설 목록 조회 실패:", result.message);
                facilitiesData = [];
            }
        } catch (error) {
            console.error("API 호출 중 오류:", error);
            facilitiesData = [];
        }
    }

    function renderFacilityButtons() {
        // 이전에 동적으로 추가된 버튼들 제거
        const dynamicButtons = roomList.querySelectorAll(".room-btn:not([data-room='all'])");
        dynamicButtons.forEach(btn => btn.remove());

        facilitiesData.forEach(facility => {
            const btn = document.createElement('button');
            btn.type = "button";
            btn.classList.add("room-btn");

            const cssClass = mapFacilityToCssClass(facility.facilityName);
            btn.setAttribute("data-room", cssClass);
            btn.setAttribute("data-facility-no", facility.facilityNo);
            btn.setAttribute("aria-pressed", "false");

            btn.innerHTML = `
                <span class="room-indicator"></span>
                <span class="room-name">${facility.facilityName}</span>
                <span class="room-code">(${facility.facilityCode})</span>
            `;

            btn.addEventListener("click", handleRoomFilterClick);
            roomList.appendChild(btn);
        });

        const allBtn = roomList.querySelector('[data-room="all"]');
        if (allBtn) {
            allBtn.removeEventListener("click", handleRoomFilterClick);
            allBtn.addEventListener("click", handleRoomFilterClick);
        }
    }

    function mapFacilityToCssClass(name) {
        if (!name) return "default";
        const lowerName = name.toLowerCase().replace(/\s/g, "");
        if (lowerName.includes("mri")) return "mri";
        if (lowerName.includes("초음파")) return "ultrasound";
        if (lowerName.includes("ct")) return "ct";
        if (lowerName.includes("xray") || lowerName.includes("x-ray")) return "xray";
        if (lowerName.includes("내시경")) return "endoscopy";
        return "default";
    }

    function handleRoomFilterClick() {
        const buttons = roomList.querySelectorAll(".room-btn");
        buttons.forEach(btn => {
            btn.classList.remove("active");
            btn.setAttribute("aria-pressed", "false");
        });
        this.classList.add("active");
        this.setAttribute("aria-pressed", "true");
        applyRoomFilter();
    }

    // ===========================================
    // 2. API: 전체 예약 현황 조회
    // ===========================================
    async function fetchAllReservations() {
        try {
            const response = await fetch(`${contextPath}/api/facilityReservation/list`);
            const result = await response.json();

            if (result.success) {
                allReservations = result.reservations;
            } else {
                console.error("예약 목록 조회 실패:", result.message);
                allReservations = [];
            }
        } catch (error) {
            console.error("API 호출 중 오류:", error);
            allReservations = [];
        }
    }

    function getReservationCount(dateStr, facilityNo) {
        return allReservations.filter(res =>
            res.treatmentDate.startsWith(dateStr) && res.facilityNo == facilityNo
        ).length;
    }

    // ===========================================
    // 3. 날짜 초기화 로직
    // ===========================================
    function getInitialDate() {
        const urlParams = new URLSearchParams(window.location.search);
        const yearParam = parseInt(urlParams.get('year'));
        const monthParam = parseInt(urlParams.get('month'));

        const todayForCompare = new Date(todayYear, todayMonth - 1, 1);
        const paramDate = new Date(yearParam, monthParam - 1, 1);

        if (!isNaN(yearParam) && !isNaN(monthParam) && paramDate >= todayForCompare) {
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
            option.textContent = y + '년';
            if (y === currentYear) option.selected = true;
            yearSelect.appendChild(option);
        }

        const startMonth = (currentYear === todayYear) ? todayMonth : 1;
        for (let m = startMonth; m <= 12; m++) {
            const option = document.createElement('option');
            option.value = m;
            option.textContent = m + '월';
            if (m === currentMonth) option.selected = true;
            monthSelect.appendChild(option);
        }

        yearSelect.onchange = function () {
            currentYear = parseInt(this.value);
            if (currentYear === todayYear && currentMonth < todayMonth) {
                currentMonth = todayMonth;
            }
            updateCalendarAndURL();
        };

        monthSelect.onchange = function () {
            currentMonth = parseInt(this.value);
            updateCalendarAndURL();
        };
    }

    // ===========================================
    // 4. 달력 렌더링 (핵심 로직)
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
                } else if (dayCounter <= daysInMonth) {
                    const currentDay = dayCounter;
                    const dateStr = `${year}-${String(month).padStart(2, '0')}-${String(currentDay).padStart(2, '0')}`;
                    const currentDate = new Date(year, month - 1, currentDay);
                    const isToday = (currentDate.toDateString() === today.toDateString());
                    const isPast = (currentDate < today && !isToday);

                    if (isPast) calendarCell.classList.add('is-past');
                    else if (isToday) calendarCell.classList.add('today');
                    if (j === 0) calendarCell.classList.add('sunday');
                    if (j === 6) calendarCell.classList.add('saturday');

                    const dateSpan = document.createElement('span');
                    dateSpan.classList.add(isToday ? 'date-today' : 'date');
                    dateSpan.textContent = currentDay;
                    calendarCell.appendChild(dateSpan);

                    const statusList = document.createElement('ul');
                    statusList.classList.add('status-list');

                    facilitiesData.forEach(facility => {
                        const reservationUnit = parseInt(facility.reservationUnit || '60', 10);
                        const capacity = Math.floor((18 * 60 - 9 * 60) / reservationUnit);
                        const count = getReservationCount(dateStr, facility.facilityNo);
                        const fixDate = facility.fixDate;

                        let status = 'available';
                        let text = `${facility.facilityName} 가능`;

                        if (fixDate && fixDate.startsWith(dateStr)) {
                            status = 'closed';
                            text = `${facility.facilityName} 점검`;
                        } else if (count >= capacity) {
                            status = 'full';
                            text = `${facility.facilityName} 마감`;
                        }

                        const statusItem = document.createElement('li');
                        const cssClass = mapFacilityToCssClass(facility.facilityName);
                        statusItem.classList.add('status-item', cssClass, status);
                        statusItem.setAttribute('data-room-class', cssClass);
                        statusItem.innerHTML = `<span class="status-dot"></span><span class="status-text">${text}</span>`;

                        if (!isPast) {
                            statusItem.addEventListener('click', function (e) {
                                e.stopPropagation();
                                openModal(year, month, currentDay, facility, status);
                            });
                        }
                        statusList.appendChild(statusItem);
                    });

                    calendarCell.appendChild(statusList);
                    dayCounter++;
                } else {
                    calendarCell.classList.add('empty');
                }
                calendarRow.appendChild(calendarCell);
            }
            calendarBody.appendChild(calendarRow);
            if (dayCounter > daysInMonth) break;
        }
        applyRoomFilter();
    }

    // ===========================================
    // 5. 필터링 적용 로직
    // ===========================================
    function applyRoomFilter() {
        const activeBtn = roomList.querySelector(".room-btn.active");
        const selectedRoomClass = activeBtn ? activeBtn.getAttribute('data-room') : 'all';
        const allItems = document.querySelectorAll(".status-list .status-item");

        allItems.forEach(item => {
            if (selectedRoomClass === 'all' || item.getAttribute('data-room-class') === selectedRoomClass) {
                item.style.display = '';
            } else {
                item.style.display = 'none';
            }
        });
    }

    // ===========================================
    // 6. 모달 관련 로직
    // ===========================================
    const modal = document.getElementById('reservationModal');
    const modalCloseBtn = document.getElementById('modalCloseBtn');
    const modalCancelBtn = document.getElementById('modalCancelBtn');

    function openModal(year, month, day, facility, status) {
        const modalTitle = document.getElementById('modalTitle');
        const modalSubtitle = document.getElementById('modalSubtitle');
        const modalRoomIndicator = document.getElementById('modalRoomIndicator');
        const contentClosed = document.getElementById('modalClosedContent');
        const contentFull = document.getElementById('modalFullContent');
        const contentAvailable = document.getElementById('modalAvailableContent');

        document.getElementById('facilityLocation').textContent = facility.facilityLocation || '정보 없음';
        document.getElementById('facilityManager').textContent = facility.facilityRepresentative || '정보 없음';
        document.getElementById('facilityContact').textContent = facility.facilityPhone || '정보 없음';
        document.getElementById('facilityDuration').textContent = `${facility.reservationUnit || '-'}분`;

        modalTitle.textContent = `${facility.facilityName} - ${month}월 ${day}일`;
        modalSubtitle.textContent = facility.facilityLocation;

        const cssClass = mapFacilityToCssClass(facility.facilityName);
        modalRoomIndicator.className = 'modal-room-indicator';
        modalRoomIndicator.classList.add(cssClass);

        [contentClosed, contentFull, contentAvailable].forEach(el => el.classList.add('hidden'));

        if (status === 'closed') {
            contentClosed.classList.remove('hidden');
        } else if (status === 'full') {
            contentFull.classList.remove('hidden');
        } else {
            // [수정됨] 버튼 대신 div로 단순 출력
            contentAvailable.innerHTML = '';
            const message = document.createElement('p');
            message.textContent = '예약 가능한 시간대 목록입니다.'; // 문구 약간 변경 (선택X -> 목록)
            message.style.color = "#374151";
            message.style.marginBottom = "12px";
            message.style.fontWeight = "500";
            contentAvailable.appendChild(message);

            const timeSlotsContainer = document.createElement('div');
            timeSlotsContainer.className = 'time-grid'; // 기존 ID 대신 클래스 사용 (CSS 매칭)
            contentAvailable.appendChild(timeSlotsContainer);

            const dateStr = `${year}-${String(month).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
            const bookedTimes = allReservations
                .filter(res => res.treatmentDate.startsWith(dateStr) && res.facilityNo == facility.facilityNo)
                .map(res => res.treatmentDate.substring(11, 16));

            const reservationUnit = parseInt(facility.reservationUnit || '60', 10);
            const startTimeInMinutes = 9 * 60;
            const endTimeInMinutes = 16 * 60 + 1;
            let hasAvailableSlots = false;

            for (let timeInMinutes = startTimeInMinutes; timeInMinutes < endTimeInMinutes; timeInMinutes += reservationUnit) {
                const hours = Math.floor(timeInMinutes / 60);
                const minutes = timeInMinutes % 60;
                const timeStr = `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}`;

                const timeSlotEl = document.createElement('div');
                timeSlotEl.className = 'time-slot-display'; // 새로 만든 CSS 클래스 적용
                timeSlotEl.textContent = timeStr;

                if (bookedTimes.includes(timeStr)) {
                    timeSlotEl.classList.add('booked');
                    // 마감된 시간은 클릭 불가 및 스타일 적용
                } else {
                    hasAvailableSlots = true;
                    timeSlotEl.classList.add('available');
                }
                timeSlotsContainer.appendChild(timeSlotEl);
            }

            if (!hasAvailableSlots) {
                message.textContent = '선택하신 날짜에는 예약 가능한 시간이 없습니다.';
            }
            contentAvailable.classList.remove('hidden');
        }
        modal.classList.add('show');
    }

    function closeModal() {
        modal.classList.remove('show');
    }

    modalCloseBtn.addEventListener('click', closeModal);
    modalCancelBtn.addEventListener('click', closeModal);
    modal.addEventListener('click', e => {
        if (e.target === modal) closeModal();
    });

    // ===========================================
    // 7. 네비게이션 및 URL 업데이트
    // ===========================================
    function updateCalendarAndURL() {
        const selectedDate = new Date(currentYear, currentMonth - 1, 1);
        const todayForNav = new Date(todayYear, todayMonth - 1, 1);

        if (selectedDate < todayForNav) {
            currentYear = todayYear;
            currentMonth = todayMonth;
        }

        populateYearMonthSelects();
        renderCalendar(currentYear, currentMonth);

        const newUrl = `${window.location.pathname}?year=${currentYear}&month=${currentMonth}`;
        window.history.pushState({path: newUrl}, '', newUrl);

        updateNavButtons();
    }

    function updateNavButtons() {
        const prevMonthDate = new Date(currentYear, currentMonth - 2, 1);
        const todayForNav = new Date(todayYear, todayMonth - 1, 1);
        prevMonthBtn.disabled = prevMonthDate < todayForNav;
    }

    prevMonthBtn.addEventListener('click', function () {
        if (this.disabled) return;
        currentMonth--;
        if (currentMonth < 1) {
            currentMonth = 12;
            currentYear--;
        }
        updateCalendarAndURL();
    });

    nextMonthBtn.addEventListener('click', function () {
        currentMonth++;
        if (currentMonth > 12) {
            currentMonth = 1;
            currentYear++;
        }
        updateCalendarAndURL();
    });

    // 실행
    init();
});