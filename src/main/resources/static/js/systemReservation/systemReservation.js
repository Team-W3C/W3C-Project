document.addEventListener("DOMContentLoaded", function() {
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
            }
        } catch (error) {
            console.error("API 호출 중 오류:", error);
        }
    }

    function renderFacilityButtons() {
        // '전체' 버튼만 남기고 초기화 (혹은 유지하고 뒤에 추가)
        // roomList.innerHTML = ''; // 기존 '전체' 버튼 유지를 위해 주석 처리

        facilitiesData.forEach(facility => {
            const btn = document.createElement('button');
            btn.type = "button";
            btn.classList.add("room-btn");

            // 시설 이름에 따라 CSS 클래스 매핑 (DB이름 -> CSS클래스)
            const cssClass = mapFacilityToCssClass(facility.facilityName);
            btn.setAttribute("data-room", cssClass);
            btn.setAttribute("data-facility-no", facility.facilityNo); // 시설 번호 저장
            btn.setAttribute("aria-pressed", "false");

            btn.innerHTML = `
                <span class="room-indicator"></span>
                <span class="room-name">${facility.facilityName}</span>
                <span class="room-code">(${facility.facilityCode})</span>
            `;

            // 클릭 이벤트 리스너 추가
            btn.addEventListener("click", handleRoomFilterClick);

            roomList.appendChild(btn);
        });

        // '전체' 버튼에도 리스너 재확인/추가
        const allBtn = roomList.querySelector('[data-room="all"]');
        if(allBtn) allBtn.addEventListener("click", handleRoomFilterClick);
    }

    // 시설명을 CSS 클래스로 매핑하는 헬퍼 함수
    function mapFacilityToCssClass(name) {
        const lowerName = name.toLowerCase().replace(/\s/g, ""); // 소문자 변환 및 공백 제거
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

        applyRoomFilter(); // 필터 적용하여 다시 표시 (DOM hide/show)
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
            }
        } catch (error) {
            console.error("API 호출 중 오류:", error);
        }
    }

    // 날짜와 시설 번호로 예약 수 계산
    function getReservationCount(dateStr, facilityNo) {
        // dateStr 형식: YYYY-MM-DD
        // allReservations의 treatmentDate는 'YYYY-MM-DD HH:mm:ss' 형식이므로 앞 10자리 비교
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
                }
                else if (dayCounter <= daysInMonth) {
                    // 날짜 포맷팅 (YYYY-MM-DD)
                    const dateStr = `${year}-${String(month).padStart(2, '0')}-${String(dayCounter).padStart(2, '0')}`;
                    const currentDate = new Date(year, month - 1, dayCounter);

                    const isToday = (currentDate.toDateString() === today.toDateString());
                    const isPast = (currentDate < today && !isToday);

                    if (isPast) calendarCell.classList.add('is-past');
                    else if (isToday) calendarCell.classList.add('today');

                    if (j === 0) calendarCell.classList.add('sunday');
                    if (j === 6) calendarCell.classList.add('saturday');

                    const dateSpan = document.createElement('span');
                    dateSpan.classList.add(isToday ? 'date-today' : 'date');
                    dateSpan.textContent = dayCounter;
                    calendarCell.appendChild(dateSpan);

                    // 상태 목록 컨테이너 생성
                    const statusList = document.createElement('ul');
                    statusList.classList.add('status-list');

                    // *** 동적 상태 생성 ***
                    facilitiesData.forEach(facility => {
                        // 1. 상태 계산
                        const count = getReservationCount(dateStr, facility.facilityNo);
                        const capacity = 8;
                        const fixDate = facility.fixDate; // 점검일 (YYYY-MM-DD 문자열로 가정)

                        let status = 'available';
                        let text = `${facility.facilityName} 가능`;

                        // 점검일 체크
                        if (fixDate && fixDate === dateStr) {
                            status = 'closed';
                            text = `${facility.facilityName} 점검`;
                        }
                        // 예약 마감 체크
                        else if (count >= capacity) {
                            status = 'full';
                            text = `${facility.facilityName} 마감`;
                        }

                        // 2. DOM 요소 생성
                        const statusItem = document.createElement('li');
                        const cssClass = mapFacilityToCssClass(facility.facilityName);

                        statusItem.classList.add('status-item', cssClass, status);
                        // 필터링을 위해 데이터 속성 추가
                        statusItem.setAttribute('data-room-class', cssClass);

                        statusItem.innerHTML = `<span class="status-dot"></span><span class="status-text">${text}</span>`;

                        // 클릭 이벤트 (모달 열기)
                        if (!isPast) {
                            statusItem.addEventListener('click', function(e) {
                                e.stopPropagation(); // 버블링 방지
                                openModal(year, month, dayCounter, facility, status);
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
            if (selectedRoomClass === 'all') {
                item.classList.remove('is-hidden');
            } else {
                if (item.classList.contains(selectedRoomClass)) {
                    item.classList.remove('is-hidden');
                } else {
                    item.classList.add('is-hidden');
                }
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

        // 시설 정보 매핑
        document.getElementById('facilityLocation').textContent = facility.facilityLocation || '정보 없음';
        document.getElementById('facilityManager').textContent = facility.facilityRepresentative || '정보 없음';
        document.getElementById('facilityContact').textContent = facility.facilityPhone || '정보 없음';
        document.getElementById('facilityDuration').textContent = (facility.reservationUnit) + '명/일' || '-';

        // 헤더 설정
        modalTitle.textContent = `${facility.facilityName} - ${month}월 ${day}일`;
        modalSubtitle.textContent = facility.facilityLocation;

        // 색상 클래스 적용
        const cssClass = mapFacilityToCssClass(facility.facilityName);
        modalRoomIndicator.className = 'modal-room-indicator'; // reset
        modalRoomIndicator.classList.add(cssClass);

        // 컨텐츠 표시/숨김
        contentClosed.classList.add('hidden');
        contentFull.classList.add('hidden');
        contentAvailable.classList.add('hidden');

        if (status === 'closed') {
            contentClosed.classList.remove('hidden');
        } else if (status === 'full') {
            contentFull.classList.remove('hidden');
        } else {
            contentAvailable.classList.remove('hidden');
        }

        modal.classList.add('show');
    }

    function closeModal() {
        modal.classList.remove('show');
    }

    modalCloseBtn.addEventListener('click', closeModal);
    modalCancelBtn.addEventListener('click', closeModal);
    // 모달 바깥 클릭 시 닫기
    modal.addEventListener('click', function(e) {
        if (e.target === modal) closeModal();
    });

    // ===========================================
    // 7. 네비게이션 및 URL 업데이트
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

    function updateNavButtons() {
        const prevMonth = new Date(currentYear, currentMonth - 2, 1);
        const todayMonthStart = new Date(todayYear, todayMonth - 1, 1);
        prevMonthBtn.disabled = (prevMonth < todayMonthStart);
        nextMonthBtn.disabled = false;
    }

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
        if (prevDate < todayDate) return;

        currentYear = newYear;
        currentMonth = newMonth;
        updateCalendarAndURL();
    });

    nextMonthBtn.addEventListener('click', function() {
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

    // 실행
    init();
});