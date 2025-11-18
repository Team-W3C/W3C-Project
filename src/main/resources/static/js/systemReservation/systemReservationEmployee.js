// systemReservationEmployee.js - 수정본

document.addEventListener('DOMContentLoaded', function () {
    if (typeof FullCalendar === 'undefined') {
        alert('FullCalendar 라이브러리가 로드되지 않았습니다.');
        return;
    }

    let calendar;
    let selectedRoom = 'all';
    let selectedFacilityNo = null;
    const maxEventsPerDay = 8;
    let currentEvent = null;

    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const minYear = today.getFullYear() - 3;
    const maxYear = today.getFullYear() + 3;

    // 시설별 정보
    let facilityInfo = {

    };

    // ✅ 모달 요소들 (patientSelect 추가)
    const modal = document.getElementById('reservationModal');
    const modalCloseBtn = document.getElementById('closeModal');
    const modalCancelBtn = document.getElementById('cancelBtn');
    const modalConfirmBtn = document.getElementById('confirmBtn');
    const modalDeleteBtn = document.getElementById('deleteBtn');
    const modalTitle = document.getElementById('modalTitle');
    const modalDate = document.getElementById('modalDate');
    const modalRoomIndicator = document.getElementById('modalRoomIndicator');
    const timeGrid = document.getElementById('timeGrid');
    const facilityNameEl = document.getElementById('facilityName');
    const facilityHoursEl = document.getElementById('operatingHours');
    const facilityDurationEl = document.getElementById('reservationUnit');
    const facilityManagerEl = document.getElementById('manager');
    const timeSelection = document.getElementById('timeSelection');
    const statusNotice = document.getElementById('statusNotice');
    const memoSection = document.getElementById('memoSection');
    const reservationNotesInput = document.getElementById('reservationNotes');
    const reservationMemoInput = document.getElementById('reservationMemo');
    const patientSelect = document.getElementById('patientSelect'); // ✅ 추가

    let selectedTime = null;
    let currentSelectedDate = null;

    // FullCalendar 초기화
    const calendarEl = document.getElementById('calendar');

    if (!calendarEl) {
        console.error('Calendar element not found!');
        return;
    }

    calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        headerToolbar: false,
        locale: 'ko',
        editable: true,
        droppable: true,
        dayMaxEvents: maxEventsPerDay,
        moreLinkText: '개 더보기',
        eventResizableFromStart: false,

        eventAllow: function (dropInfo, draggedEvent) {
            const dropDate = new Date(dropInfo.startStr);
            dropDate.setHours(0, 0, 0, 0);
            return dropDate >= today;
        },

        eventDidMount: function (info) {
            const eventDate = new Date(info.event.startStr);
            eventDate.setHours(0, 0, 0, 0);

            if (eventDate < today) {
                info.el.classList.add('fc-event-past');
                info.el.style.cursor = 'pointer';
                info.el.setAttribute('draggable', 'false');

                const pastColor = '#E0E7FF';
                info.event.setProp('backgroundColor', pastColor);
                info.event.setProp('borderColor', pastColor);
                info.event.setProp('textColor', '#1f2937');
            }
        },

        eventContent: function (arg) {
            const room = arg.event.extendedProps.room;
            const roomColor = facilityInfo[room]?.color || '#0e787c';

            return {
                html: `
                    <div class="fc-event-title">
                        <span class="fc-event-dot" style="background-color: ${roomColor};"></span>
                        <span>${arg.event.title}</span>
                    </div>
                `
            };
        },

        dayCellDidMount: function (info) {
            const cellDate = new Date(info.date);
            cellDate.setHours(0, 0, 0, 0);

            if (cellDate < today) {
                info.el.classList.add('fc-day-past');
                info.el.style.pointerEvents = 'none';
            }

            const todayDate = new Date();
            todayDate.setHours(0, 0, 0, 0);
            if (cellDate.getTime() === todayDate.getTime()) {
                const badge = document.createElement('span');
                badge.className = 'legend-badge today-badge';
                badge.textContent = 'T';

                info.el.style.position = 'relative';
                info.el.appendChild(badge);
            }
        },

        eventReceive: function (info) {
            const dateStr = info.event.startStr;
            const eventDate = new Date(dateStr);
            eventDate.setHours(0, 0, 0, 0);

            if (eventDate < today) {
                alert('과거 날짜에는 예약을 추가할 수 없습니다.');
                info.event.remove();
                return;
            }

            const eventsOnDate = calendar.getEvents().filter(e => e.startStr === dateStr);

            if (eventsOnDate.length > maxEventsPerDay) {
                alert(`하루 최대 ${maxEventsPerDay}개까지만 추가할 수 있습니다.`);
                info.event.remove();
                return;
            }

            const room = info.event.extendedProps.room;
            const facilityNo = info.event.extendedProps.facilityNo;

            selectedRoom = room;
            selectedFacilityNo = facilityNo;
            currentSelectedDate = dateStr;

            info.event.remove();

            loadReservationsForDate(dateStr, room, 'available', true);
        },

        eventDrop: function (info) {
            const dateStr = info.event.startStr;
            const eventDate = new Date(dateStr);
            eventDate.setHours(0, 0, 0, 0);

            if (eventDate < today) {
                alert('과거 날짜로는 이동할 수 없습니다.');
                info.revert();
                return;
            }

            const eventsOnDate = calendar.getEvents().filter(e =>
                e.startStr === dateStr && e.id !== info.event.id
            );

            if (eventsOnDate.length >= maxEventsPerDay) {
                alert(`하루 최대 ${maxEventsPerDay}개까지만 추가할 수 있습니다.`);
                info.revert();
            }
        },

        dateClick: function (info) {
            const clickedDate = new Date(info.dateStr);
            clickedDate.setHours(0, 0, 0, 0);

            if (clickedDate < today) {
                alert('과거 날짜는 선택할 수 없습니다.');
                return;
            }

            currentEvent = null;
            currentSelectedDate = info.dateStr;
            selectedRoom = 'all';
            selectedFacilityNo = null;

            openModal(info.dateStr, 'available', [], false);
        },

        eventClick: function (info) {
            const roomType = info.event.extendedProps.room;
            const dateStr = info.event.startStr;
            const status = info.event.extendedProps.status || 'available';

            const eventDate = new Date(dateStr);
            eventDate.setHours(0, 0, 0, 0);
            const isPast = eventDate < today;

            if (isPast) {
                currentEvent = null;
                openPastEventModal(dateStr, roomType, status);
            } else {
                currentEvent = info.event;
                selectedRoom = roomType;
                selectedFacilityNo = info.event.extendedProps.facilityNo || null;

                loadReservationsForDate(dateStr, roomType, status, true);
            }
        },

        events: []
    });

    calendar.render();
    updateMonthTitle();
    updateYearButtons();
    // ✅ 시설 목록을 먼저 로드한 후 예약 데이터 로드
    loadFacilityList().then(() => {
        loadInitialReservations();
    });
    loadPatientList();

    // 외부 이벤트 드래그 가능하게 설정
    const externalEventsEl = document.getElementById('external-events');
    if (externalEventsEl) {
        new FullCalendar.Draggable(externalEventsEl, {
            itemSelector: '.fc-event',
            eventData: function (eventEl) {
                return {
                    title: eventEl.dataset.title,
                    backgroundColor: '#dcfce7',
                    borderColor: '#dcfce7',
                    textColor: '#1f2937',
                    extendedProps: {
                        room: eventEl.dataset.room,
                        facilityNo: eventEl.dataset.facilityNo,
                        status: 'available'
                    }
                };
            }
        });
    }

    /**
     * DB에서 초기 예약 데이터 로드
     */
    function loadInitialReservations() {
        fetch(`${gContextPath}/api/facilityReservation/list`)
            .then(response => response.json())
            .then(data => {
                if (data.success && data.reservations) {
                    const groupMap = new Map();
                    data.reservations.forEach(reservation => {
                        const dateStr = reservation.treatmentDate.split(' ')[0].split('T')[0];
                        const facilityNo = parseInt(reservation.facilityNo, 10);
                        const key = `${dateStr}_${facilityNo}`;

                        if (!groupMap.has(key)) {
                            groupMap.set(key, []);
                        }
                        groupMap.get(key).push(reservation);
                    });

                    groupMap.forEach((reservations, key) => {
                        const [dateStr, facilityNoStr] = key.split('_');
                        const facilityNo = parseInt(facilityNoStr, 10);
                        const roomType = getRoomTypeByFacilityNo(facilityNo);

                        const reservationCount = reservations.length;
                        const status = (() => {
                            const anyCancelled = reservations.some(r => r.reservationStatus === '취소');
                            if (reservationCount >= 8) return 'full';
                            if (anyCancelled) return 'closed';
                            return 'available';
                        })();

                        upsertCalendarEvent(
                            dateStr,
                            facilityNo,
                            reservationCount,
                            status,
                            roomType
                        );
                    });
                }
            })
            .catch(error => {
                console.error('예약 데이터 로드 실패:', error);
            });
    }

    /**
     * 특정 날짜의 예약 정보를 DB에서 조회
     */
    function loadReservationsForDate(dateStr, roomType = null, statusOverride = null, isEdit = false) {
        const params = new URLSearchParams({
            date: dateStr
        });

        if (selectedFacilityNo) {
            params.append('facilityNo', selectedFacilityNo);
        }

        fetch(`${gContextPath}/api/facilityReservation/date?${params}`)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const reservations = data.reservations || [];
                    const uniquePatients = new Set(reservations.map(r => r.memberNo));

                    let finalStatus;
                    if (statusOverride) {
                        finalStatus = statusOverride;
                    } else {
                        finalStatus = (uniquePatients.size >= 8) ? 'full' : 'available';
                    }

                    openModalWithRoom(dateStr, roomType || selectedRoom, finalStatus, reservations, isEdit);
                }
            })
            .catch(error => {
                console.error('날짜별 예약 조회 실패:', error);
                openModalWithRoom(dateStr, roomType || selectedRoom, statusOverride || 'available', [], isEdit);
            });
    }

    /**
     * ✅ 시설 목록 동적 로드
     */
    function loadFacilityList() {
        return fetch(`${gContextPath}/api/facilityReservation/facilities`)
            .then(response => response.json())
            .then(data => {
                if (data.success && data.facilities) {
                    // 시설 정보를 facilityInfo 객체로 변환
                    const facilityMap = {};
                    const colorMap = {
                        'MRI': '#0e787c',
                        'CT': '#8b5cf6',
                        '초음파': '#0ea5e9',
                        'X-Ray': '#f59e0b',
                        '내시경': '#ec4899'
                    };

                    data.facilities.forEach(facility => {
                        // FACILITY_TYPE을 기반으로 키 생성 (소문자, 공백/하이픈 제거)
                        let typeKey = facility.facilityType?.toLowerCase().replace(/\s+/g, '').replace(/-/g, '') || '';

                        // typeKey가 없거나 이미 존재하면 facilityCode 기반으로 생성
                        if (!typeKey || facilityMap[typeKey]) {
                            typeKey = facility.facilityCode?.toLowerCase().replace(/\s+/g, '').replace(/-/g, '') ||
                                `facility${facility.facilityNo}`;
                        }

                        facilityMap[typeKey] = {
                            name: facility.facilityName || facility.facilityCode || '',
                            fullName: facility.facilityName || '',
                            location: facility.facilityLocation || '',
                            hours: '09:00 - 18:00', // 기본값 (DB에 컬럼이 없으면 기본값 사용)
                            duration: facility.reservationUnit || '60분',
                            manager: facility.facilityRepresentative || '',
                            contact: facility.facilityPhone || '',
                            color: colorMap[facility.facilityType] || '#0e787c',
                            code: facility.facilityCode || '',
                            facilityNo: facility.facilityNo,
                            facilityType: facility.facilityType || ''
                        };
                    });

                    facilityInfo = facilityMap;

                    // 외부 이벤트 목록 동적 생성
                    updateExternalEvents();

                    console.log('시설 목록 로드 완료:', facilityInfo);
                } else {
                    console.warn('시설 목록이 비어있습니다.');
                }
            })
            .catch(error => {
                console.error('시설 목록 로드 실패:', error);
                // 실패 시 기본값 사용 (선택사항)
            });
    }

    /**
     * ✅ 외부 이벤트 목록 동적 생성
     */
    function updateExternalEvents() {
        const externalEventsEl = document.getElementById('external-events');
        if (!externalEventsEl) return;

        externalEventsEl.innerHTML = '';

        Object.entries(facilityInfo).forEach(([key, facility]) => {
            const eventEl = document.createElement('div');
            eventEl.className = 'fc-event';
            eventEl.dataset.title = facility.name;
            eventEl.dataset.room = key;
            eventEl.dataset.facilityNo = facility.facilityNo;
            eventEl.style.backgroundColor = facility.color;
            eventEl.style.borderColor = facility.color;
            eventEl.textContent = facility.name;
            externalEventsEl.appendChild(eventEl);
        });

        // Draggable 재초기화
        if (externalEventsEl && Object.keys(facilityInfo).length > 0) {
            new FullCalendar.Draggable(externalEventsEl, {
                itemSelector: '.fc-event',
                eventData: function (eventEl) {
                    return {
                        title: eventEl.dataset.title,
                        backgroundColor: '#dcfce7',
                        borderColor: '#dcfce7',
                        textColor: '#1f2937',
                        extendedProps: {
                            room: eventEl.dataset.room,
                            facilityNo: eventEl.dataset.facilityNo,
                            status: 'available'
                        }
                    };
                }
            });
        }
    }

    /**
     * 과거 이벤트 읽기 전용 모달
     */
    function openPastEventModal(dateStr, roomType, status) {
        currentSelectedDate = dateStr;
        const facility = facilityInfo[roomType];

        // ✅ facility가 없을 경우 처리
        if (!facility) {
            console.error('시설 정보를 찾을 수 없습니다:', roomType);
            alert('시설 정보를 불러올 수 없습니다.');
            return;
        }

        const date = new Date(dateStr);
        const month = date.getMonth() + 1;
        const day = date.getDate();

        modalTitle.textContent = `${facility.name} - ${month}월 ${day}일 (완료)`;
        modalDate.textContent = facility.location;
        modalRoomIndicator.style.backgroundColor = facility.color;

        facilityNameEl.textContent = `${facility.fullName} (${facility.code})`;
        facilityHoursEl.textContent = facility.hours;
        facilityDurationEl.textContent = facility.duration;
        facilityManagerEl.textContent = facility.manager;

        modalDeleteBtn.classList.add('hidden');
        modalConfirmBtn.classList.add('hidden');

        statusNotice.innerHTML = `
            <div class="status-notice notice-completed">
                <svg class="notice-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <span class="notice-text">완료된 예약입니다. (읽기 전용)</span>
            </div>
        `;

        timeSelection.classList.add('hidden');

        if (memoSection) memoSection.classList.add('hidden');
        if (patientSelect) patientSelect.style.display = 'none';

        modal.classList.add('active');
    }

    /**
     * 모달 열기 함수
     */
    function openModal(dateStr, status, reservations = [], isEdit = false) {
        currentSelectedDate = dateStr;
        const date = new Date(dateStr);
        const year = date.getFullYear();
        const month = date.getMonth() + 1;
        const day = date.getDate();
        const dayNames = ['일', '월', '화', '수', '목', '금', '토'];
        const dayName = dayNames[date.getDay()];

        if (selectedRoom !== 'all' && selectedFacilityNo) {
            openModalWithRoom(dateStr, selectedRoom, status, reservations, isEdit);
            return;
        }

        modalTitle.textContent = '시설 예약';
        modalDate.textContent = `${year}년 ${month}월 ${day}일 (${dayName})`;
        modalRoomIndicator.style.backgroundColor = '#0e787c';
        facilityNameEl.textContent = '시설을 선택해주세요';
        facilityHoursEl.textContent = '-';
        facilityDurationEl.textContent = '-';
        facilityManagerEl.textContent = '-';

        modalDeleteBtn.classList.add('hidden');

        let roomButtonsHtml = '';
        for (const [roomKey, info] of Object.entries(facilityInfo)) {
            roomButtonsHtml += `
                <button type="button" 
                        class="modal-room-option" 
                        data-room="${roomKey}" 
                        data-facility-no="${info.facilityNo}">
                    ${info.name} (${info.code})
                </button>
            `;
        }

        statusNotice.innerHTML = `
            <div class="status-notice notice-full">
                <svg class="notice-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M12 9V13M12 17H12.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <span class="notice-text">날짜를 선택했습니다. 검사실을 선택해주세요.</span>
            </div>
            <div class="modal-room-list">
                ${roomButtonsHtml}
            </div>
        `;

        timeSelection.classList.add('hidden');
        modalConfirmBtn.classList.add('hidden');
        if (memoSection) memoSection.classList.add('hidden');
        if (patientSelect) patientSelect.style.display = 'none';

        document.querySelectorAll('.modal-room-option').forEach(btn => {
            btn.addEventListener('click', function () {
                document.querySelectorAll('.modal-room-option').forEach(b => b.classList.remove('active'));
                this.classList.add('active');

                selectedRoom = this.dataset.room;
                selectedFacilityNo = this.dataset.facilityNo || null;

                if (currentSelectedDate && selectedFacilityNo) {
                    loadReservationsForDate(currentSelectedDate, selectedRoom, 'available', true);
                }
            });
        });

        modal.classList.add('active');
    }

    /**
     * 검사실 선택된 경우 모달
     */
    function openModalWithRoom(dateStr, roomType, status, reservations, showDeleteBtn) {
        currentSelectedDate = dateStr;
        const facility = facilityInfo[roomType];

        // ✅ facility가 없을 경우 처리
        if (!facility) {
            console.error('시설 정보를 찾을 수 없습니다:', roomType);
            // 시설 정보가 아직 로드되지 않았을 수 있으므로 다시 시도
            if (Object.keys(facilityInfo).length === 0) {
                loadFacilityList().then(() => {
                    // 시설 정보 로드 후 roomType 재확인
                    const retryFacility = facilityInfo[roomType];
                    if (retryFacility) {
                        openModalWithRoom(dateStr, roomType, status, reservations, showDeleteBtn);
                    } else {
                        // facilityNo로 시설 찾기
                        const facilityByNo = Object.values(facilityInfo).find(f => f.facilityNo == selectedFacilityNo);
                        if (facilityByNo) {
                            const newRoomType = Object.keys(facilityInfo).find(key => facilityInfo[key] === facilityByNo);
                            if (newRoomType) {
                                openModalWithRoom(dateStr, newRoomType, status, reservations, showDeleteBtn);
                                return;
                            }
                        }
                        alert('시설 정보를 불러올 수 없습니다.');
                    }
                });
            } else {
                alert('시설 정보를 찾을 수 없습니다.');
            }
            return;
        }

        const date = new Date(dateStr);
        const month = date.getMonth() + 1;
        const day = date.getDate();

        modalTitle.textContent = `${facility.name} - ${month}월 ${day}일`;
        modalDate.textContent = facility.location;
        modalRoomIndicator.style.backgroundColor = facility.color;

        facilityNameEl.textContent = `${facility.fullName} (${facility.code})`;
        facilityHoursEl.textContent = facility.hours;
        facilityDurationEl.textContent = facility.duration;
        facilityManagerEl.textContent = facility.manager;

        if (showDeleteBtn) {
            modalDeleteBtn.classList.remove('hidden');
        } else {
            modalDeleteBtn.classList.add('hidden');
        }

        if (status === 'available') {
            statusNotice.innerHTML = `
                <div class="status-notice notice-available">
                    <svg class="notice-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                    <span class="notice-text">예약 가능한 시간대입니다.</span>
                </div>
            `;
            timeSelection.classList.remove('hidden');
            modalConfirmBtn.classList.remove('hidden');
            if (memoSection) memoSection.classList.remove('hidden');
            if (patientSelect) patientSelect.style.display = '';
            generateTimeSlots(reservations);
        } else if (status === 'closed') {
            statusNotice.innerHTML = `
                <div class="status-notice notice-closed">
                    <svg class="notice-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.33 16c-.77 1.333.192 3 1.732 3z" />
                    </svg>
                    <span class="notice-text">정기 점검 실행중입니다</span>
                </div>
            `;
            timeSelection.classList.add('hidden');
            modalConfirmBtn.classList.add('hidden');
            if (memoSection) memoSection.classList.add('hidden');
            if (patientSelect) patientSelect.style.display = 'none';
        } else if (status === 'full') {
            statusNotice.innerHTML = `
                <div class="status-notice notice-full">
                    <svg class="notice-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                    <span class="notice-text">예약이 마감되었습니다 (8개)</span>
                </div>
            `;
            timeSelection.classList.add('hidden');
            modalConfirmBtn.classList.add('hidden');
            if (memoSection) memoSection.classList.add('hidden');
            if (patientSelect) patientSelect.style.display = 'none';
        }

        modal.classList.add('active');
        selectedTime = null;
        modalConfirmBtn.disabled = true;
    }

    /**
     * 시간 슬롯 생성 (DB 예약 정보 반영)
     */
    function generateTimeSlots(reservations = []) {
        timeGrid.innerHTML = '';

        const times = [
            '09:00', '10:00', '11:00', '12:00',
            '13:00', '14:00', '15:00', '16:00'
        ];

        const reservedTimes = reservations.map(r => {
            const datetime = new Date(r.treatmentDate);
            const hours = String(datetime.getHours()).padStart(2, '0');
            const minutes = String(datetime.getMinutes()).padStart(2, '0');
            return `${hours}:${minutes}`;
        });

        times.forEach(time => {
            const btn = document.createElement('button');
            btn.className = 'time-btn';
            btn.textContent = time;
            btn.dataset.time = time;

            if (reservedTimes.includes(time)) {
                btn.disabled = true;
            }

            btn.addEventListener('click', function () {
                if (!this.disabled) {
                    document.querySelectorAll('.time-btn').forEach(b => b.classList.remove('selected'));
                    this.classList.add('selected');
                    selectedTime = this.dataset.time;
                    modalConfirmBtn.disabled = false;
                }
            });

            timeGrid.appendChild(btn);
        });
    }

    /**
     * 모달 닫기
     */
    function closeModal() {
        modal.classList.remove('active');
        currentSelectedDate = null;
        selectedTime = null;
        currentEvent = null;

        if (reservationNotesInput) reservationNotesInput.value = '';
        if (reservationMemoInput) reservationMemoInput.value = '';
        if (patientSelect) patientSelect.value = '';
    }

    modalCloseBtn.addEventListener('click', closeModal);
    modalCancelBtn.addEventListener('click', closeModal);

    modal.addEventListener('click', function (e) {
        if (e.target === modal) {
            closeModal();
        }
    });

    /**
     * ✅ 예약 확인 (환자 선택 검증 추가)
     */
    modalConfirmBtn.addEventListener('click', function () {
        // ✅ 환자 선택 검증
        const selectedPatient = patientSelect.value;
        if (!selectedPatient) {
            alert('환자를 선택해주세요.');
            patientSelect.focus();
            return;
        }

        if (selectedFacilityNo && selectedTime && currentSelectedDate) {
            const selectedDate = new Date(currentSelectedDate);
            selectedDate.setHours(0, 0, 0, 0);

            if (selectedDate < today) {
                alert('과거 날짜에는 예약을 추가할 수 없습니다.');
                closeModal();
                return;
            }

            const notes = reservationNotesInput ? reservationNotesInput.value.trim() : '';
            const memo  = reservationMemoInput ? reservationMemoInput.value.trim() : '';

            const reservationData = {
                facilityNo: selectedFacilityNo,
                treatmentDate: `${currentSelectedDate} ${selectedTime}:00`,
                reservationStatus: '확정',
                reservationNotes: notes || '직원 예약',
                facilityReservationMemo: memo || null,
                memberNo: selectedPatient, // ✅ 선택한 환자 번호 사용
                staffNo: 1
            };

            const dateForRefresh = currentSelectedDate;
            const facilityForRefresh = selectedFacilityNo;
            const roomForRefresh = selectedRoom;

            fetch(`${gContextPath}/api/facilityReservation/insert`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(reservationData)
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('예약이 완료되었습니다.');
                        closeModal();

                        refreshCalendarForDateFacility(
                            dateForRefresh,
                            facilityForRefresh,
                            roomForRefresh
                        );
                    } else {
                        alert('예약 저장에 실패했습니다: ' + (data.message || ''));
                    }
                })
                .catch(error => {
                    console.error('예약 저장 실패:', error);
                    alert('예약 저장 중 오류가 발생했습니다.');
                });
        }
    });

    /**
     * 삭제 버튼 (DB DELETE - 해당 날짜의 모든 예약 삭제)
     */
    modalDeleteBtn.addEventListener('click', function () {
        if (!currentSelectedDate || !selectedFacilityNo) {
            alert('삭제할 수 없는 예약입니다.');
            return;
        }

        const eventDate = new Date(currentSelectedDate);
        eventDate.setHours(0, 0, 0, 0);

        if (eventDate < today) {
            alert('과거 예약은 삭제할 수 없습니다.');
            return;
        }

        if (confirm('이 날짜의 모든 예약을 삭제하시겠습니까?')) {
            fetch(`${gContextPath}/api/facilityReservation/deleteByDate`, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    date: currentSelectedDate,
                    facilityNo: selectedFacilityNo
                })
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        const eventsToRemove = calendar.getEvents().filter(e =>
                            e.startStr === currentSelectedDate &&
                            e.extendedProps.facilityNo == selectedFacilityNo
                        );

                        eventsToRemove.forEach(e => e.remove());

                        alert('예약이 삭제되었습니다.');
                        closeModal();
                    } else {
                        alert('예약 삭제에 실패했습니다: ' + (data.message || ''));
                    }
                })
                .catch(error => {
                    console.error('예약 삭제 실패:', error);
                    alert('예약 삭제 중 오류가 발생했습니다.');
                });
        }
    });

    // ESC 키로 모달 닫기
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape' && modal.classList.contains('active')) {
            closeModal();
        }
    });

    // 검사실 필터링
    document.querySelectorAll('.room-btn').forEach(btn => {
        btn.addEventListener('click', function () {
            document.querySelectorAll('.room-btn').forEach(b => b.classList.remove('active'));
            this.classList.add('active');
            selectedRoom = this.dataset.room;
            selectedFacilityNo = this.dataset.facilityNo || null;
            filterEvents();

            if (currentSelectedDate && selectedFacilityNo) {
                loadReservationsForDate(currentSelectedDate, selectedRoom, 'available', true);
            }
        });
    });

    function filterEvents() {
        const events = calendar.getEvents();
        events.forEach(event => {
            if (selectedRoom === 'all') {
                event.setProp('display', 'auto');
            } else {
                const eventRoom = event.extendedProps.room;
                event.setProp('display', eventRoom === selectedRoom ? 'auto' : 'none');
            }
        });
    }

    // 년도 버튼 업데이트
    function updateYearButtons() {
        const currentDate = calendar.getDate();
        const currentYear = currentDate.getFullYear();

        document.getElementById('prevYear').disabled = currentYear <= minYear;
        document.getElementById('nextYear').disabled = currentYear >= maxYear;
    }

    // 년도 네비게이션
    document.getElementById('prevYear').addEventListener('click', function () {
        const currentDate = calendar.getDate();
        const newDate = new Date(currentDate);
        newDate.setFullYear(currentDate.getFullYear() - 1);

        if (newDate.getFullYear() >= minYear) {
            calendar.gotoDate(newDate);
            updateMonthTitle();
            updateYearButtons();
        }
    });

    document.getElementById('nextYear').addEventListener('click', function () {
        const currentDate = calendar.getDate();
        const newDate = new Date(currentDate);
        newDate.setFullYear(currentDate.getFullYear() + 1);

        if (newDate.getFullYear() <= maxYear) {
            calendar.gotoDate(newDate);
            updateMonthTitle();
            updateYearButtons();
        }
    });

    // 월 네비게이션
    document.getElementById('prevMonth').addEventListener('click', function () {
        calendar.prev();
        updateMonthTitle();
        updateYearButtons();
    });

    document.getElementById('nextMonth').addEventListener('click', function () {
        calendar.next();
        updateMonthTitle();
        updateYearButtons();
    });

    // Today 버튼
    document.getElementById('todayBtn').addEventListener('click', function () {
        calendar.today();
        updateMonthTitle();
        updateYearButtons();
    });

    function updateMonthTitle() {
        const date = calendar.getDate();
        const year = date.getFullYear();
        const month = date.getMonth() + 1;
        document.getElementById('currentYear').textContent = `${year}년`;
        document.getElementById('currentMonth').textContent = `${month}월`;
    }

    /**
     * 유틸리티 함수들
     */

    // Facility No로 Room Type 가져오기
    function getRoomTypeByFacilityNo(facilityNo) {
        for (const [key, value] of Object.entries(facilityInfo)) {
            if (value.facilityNo == facilityNo) {
                return key;
            }
        }
        // ✅ 기본값 반환 (시설이 없을 경우 첫 번째 시설 또는 null)
        const firstKey = Object.keys(facilityInfo)[0];
        return firstKey || null;
    }

    // 상태별 색상 가져오기
    function getStatusColor(status) {
        const colorMap = {
            'available': '#dcfce7',
            'full': '#fef9c2',
            'closed': '#ffe2e2'
        };
        return colorMap[status] || '#dcfce7';
    }

    // 특정 날짜+시설에 대한 이벤트를 1개만 유지하면서 상태/카운트 반영
    function upsertCalendarEvent(dateStr, facilityNo, uniquePatientCount, status, roomType) {
        const room = roomType || getRoomTypeByFacilityNo(facilityNo);

        const eventDate = new Date(dateStr);
        eventDate.setHours(0, 0, 0, 0);
        const isPast = eventDate < today;

        const color = isPast ? '#E0E7FF' : getStatusColor(status);

        const facilityCode = facilityInfo[room]?.code || '';

        const title =
            uniquePatientCount <= 1
                ? facilityCode || (facilityInfo[room]?.name || '시설')
                : `${facilityCode || facilityInfo[room]?.name || '시설'} (${uniquePatientCount})`;

        const existing = calendar.getEvents().filter(e => {
            const eDateStr = e.startStr ? e.startStr.split('T')[0] : null;
            const eFacilityNo = parseInt(e.extendedProps.facilityNo, 10);
            const targetFacilityNo = parseInt(facilityNo, 10);

            return eDateStr === dateStr && eFacilityNo === targetFacilityNo;
        });

        if (existing.length === 0) {
            calendar.addEvent({
                title: title,
                start: dateStr,
                backgroundColor: color,
                borderColor: color,
                textColor: '#1f2937',
                extendedProps: {
                    room: room,
                    facilityNo: facilityNo,
                    status: status
                }
            });
        } else {
            const ev = existing[0];
            ev.setProp('title', title);
            ev.setProp('backgroundColor', color);
            ev.setProp('borderColor', color);
            ev.setExtendedProp('status', status);

            if (existing.length > 1) {
                for (let i = 1; i < existing.length; i++) {
                    existing[i].remove();
                }
            }
        }
    }

    // DB 기준으로 해당 날짜+시설 이벤트를 다시 계산해서 반영
    function refreshCalendarForDateFacility(dateStr, facilityNo, roomType) {
        if (!facilityNo) return;

        const params = new URLSearchParams({
            date: dateStr,
            facilityNo: facilityNo
        });

        fetch(`${gContextPath}/api/facilityReservation/date?${params}`)
            .then(response => response.json())
            .then(data => {
                if (!data.success) return;

                const reservations = data.reservations || [];
                const eventsOnDateFacility = calendar.getEvents().filter(e =>
                    e.startStr === dateStr && e.extendedProps.facilityNo == facilityNo
                );

                if (reservations.length === 0) {
                    eventsOnDateFacility.forEach(e => e.remove());
                    return;
                }

                const uniquePatients = new Set(reservations.map(r => r.memberNo));

                const status = uniquePatients.size >= 8 ? 'full' : 'available';

                upsertCalendarEvent(
                    dateStr,
                    facilityNo,
                    uniquePatients.size,
                    status,
                    roomType
                );
            })
            .catch(err => console.error('캘린더 갱신 실패:', err));
    }

    /**
     * ✅ 환자 목록 로드
     */
    function loadPatientList() {
        fetch(`${gContextPath}/api/facilityReservation/patients`)
            .then(response => response.json())
            .then(data => {
                if (data.success && data.patients) {
                    patientSelect.innerHTML = '<option value="">환자를 선택해주세요</option>';
                    data.patients.forEach(patient => {
                        const option = document.createElement('option');
                        option.value = patient.memberNo;
                        option.textContent = `${patient.memberName} (${patient.memberPhone || '-'})`;
                        patientSelect.appendChild(option);
                    });
                }
            })
            .catch(error => {
                console.error('환자 목록 로드 실패:', error);
            });
    }
});