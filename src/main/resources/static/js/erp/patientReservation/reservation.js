// reservation.js - 예약관리 페이지 로직

const reservationsData = {
    waiting: [
        {
            id: 1,
            patientNo: 'P001',
            name: '김민수',
            age: 45,
            gender: '남',
            phone: '010-1234-5678',
            symptom: '허리 통증',
            department: '정형외과',
            doctor: '이준호',
            equipment: 'MRI-01',
            date: '2025-10-28',
            time: '14:00',
            memo: '',
            isVIP: false
        },
        {
            id: 2,
            patientNo: 'P002',
            name: '이영희',
            age: 38,
            gender: '여',
            phone: '010-2345-6789',
            symptom: '복통',
            department: '내과',
            doctor: '김서연',
            equipment: '초음파-01',
            date: '2025-10-28',
            time: '15:00',
            memo: '',
            isVIP: true
        },
        {
            id: 3,
            patientNo: 'P003',
            name: '박철수',
            age: 52,
            gender: '남',
            phone: '010-3456-7890',
            symptom: '두통',
            department: '신경외과',
            doctor: '박민준',
            equipment: 'CT-01',
            date: '2025-10-28',
            time: '15:30',
            memo: '',
            isVIP: false
        },
        {
            id: 4,
            patientNo: 'P004',
            name: '정수연',
            age: 29,
            gender: '여',
            phone: '010-4567-8901',
            symptom: '피부 알레르기',
            department: '피부과',
            doctor: '최수진',
            equipment: null,
            date: '2025-10-28',
            time: '16:00',
            memo: '',
            isVIP: false
        },
        {
            id: 5,
            patientNo: 'P005',
            name: '최동훈',
            age: 55,
            gender: '남',
            phone: '010-5678-9012',
            symptom: '위내시경',
            department: '소화기내과',
            doctor: '김서연',
            equipment: '내시경-01',
            date: '2025-10-28',
            time: '11:00',
            memo: '',
            isVIP: false
        }
    ],
    progress: [
        {
            id: 6,
            patientNo: 'P006',
            name: '한지민',
            age: 41,
            gender: '여',
            phone: '010-6789-0123',
            symptom: '관절염 검사',
            department: '정형외과',
            doctor: '이준호',
            equipment: 'X-Ray-01',
            date: '2025-10-28',
            time: '10:00',
            memo: '',
            isVIP: true
        },
        {
            id: 7,
            patientNo: 'P007',
            name: '오민정',
            age: 33,
            gender: '여',
            phone: '010-7890-1234',
            symptom: '어지럼증',
            department: '이비인후과',
            doctor: '박민준',
            equipment: null,
            date: '2025-10-28',
            time: '11:30',
            memo: '',
            isVIP: false
        }
    ],
    completed: [
        {
            id: 8,
            patientNo: 'P008',
            name: '강태영',
            age: 48,
            gender: '남',
            phone: '010-8901-2345',
            symptom: '건강검진',
            department: '종합검진',
            doctor: '이준호',
            equipment: 'MRI-01',
            date: '2025-10-28',
            time: '09:00',
            memo: '',
            isVIP: true
        },
        {
            id: 9,
            patientNo: 'P009',
            name: '윤서현',
            age: 26,
            gender: '여',
            phone: '010-9012-3456',
            symptom: '감기',
            department: '내과',
            doctor: '김서연',
            equipment: null,
            date: '2025-10-28',
            time: '09:30',
            memo: '',
            isVIP: false
        },
        {
            id: 10,
            patientNo: 'P010',
            name: '임재현',
            age: 37,
            gender: '남',
            phone: '010-0123-4567',
            symptom: '발목 염좌',
            department: '정형외과',
            doctor: '이준호',
            equipment: 'X-Ray-01',
            date: '2025-10-28',
            time: '08:30',
            memo: '',
            isVIP: false
        }
    ]
};

function createReservationCard(reservation, status) {
    const vipClass = reservation.isVIP ? 'reservation-card--vip' : '';

    let statusBadge = '';
    if (status === 'waiting') {
        statusBadge = `<span class="badge badge--waiting" onclick="openDetailModal(${reservation.id}, '${status}')">예약됨</span>`;
    } else if (status === 'progress') {
        statusBadge = `<span class="badge badge--progress">진행중</span>`;
    } else {
        statusBadge = `<span class="badge badge--complete">완료됨</span>`;
    }

    const vipBadge = reservation.isVIP ? '<span class="badge badge--vip">VIP</span>' : '';

    const equipmentInfo = reservation.equipment ?
        `<p class="reservation-card__equipment">장비: ${reservation.equipment}</p>` : '';

    let actionButtons = '';
    if (status === 'waiting') {
        actionButtons = `
            <div class="reservation-card__actions">
                <button class="btn-action btn-start" onclick="startReservation(${reservation.id})">
                    <svg viewBox="0 0 12 12" fill="none">
                        <path d="M2.5 6H9.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M6 2.5L9.5 6L6 9.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    진행 시작
                </button>
            </div>
        `;
    } else if (status === 'progress') {
        actionButtons = `
            <div class="reservation-card__actions">
                <button class="btn-action btn-revert" onclick="revertReservation(${reservation.id})">
                    <svg viewBox="0 0 12 12" fill="none">
                        <path d="M1.5 6C1.5 6.89002 1.76392 7.76004 2.25839 8.50007C2.75285 9.24009 3.45566 9.81686 4.27792 10.1575C5.10019 10.4981 6.00499 10.5872 6.87791 10.4135C7.75082 10.2399 8.55264 9.81132 9.18198 9.18198C9.81132 8.55264 10.2399 7.75082 10.4135 6.87791C10.5872 6.00499 10.4981 5.10019 10.1575 4.27792C9.81686 3.45566 9.24009 2.75285 8.50007 2.25839C7.76004 1.76392 6.89002 1.5 6 1.5C4.74198 1.50473 3.53448 1.99561 2.63 2.87L1.5 4" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M1.5 1.5V4H4" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </button>
                <button class="btn-action btn-complete" onclick="completeReservation(${reservation.id})">
                    <svg viewBox="0 0 12 12" fill="none">
                        <path d="M10.9005 4.99999C11.1288 6.12064 10.9661 7.28571 10.4394 8.30089C9.91273 9.31608 9.05393 10.12 8.00625 10.5787C6.95856 11.0373 5.7853 11.1229 4.68214 10.8212C3.57897 10.5195 2.61258 9.84869 1.94413 8.92071C1.27567 7.99272 0.94555 6.86361 1.00882 5.72169C1.07209 4.57976 1.52493 3.49404 2.29181 2.64558C3.0587 1.79712 4.09328 1.23721 5.22302 1.05922C6.35276 0.881233 7.50938 1.09592 8.49999 1.66749" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M4.5 5.5L6 7L11 2" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    완료 처리
                </button>
            </div>
        `;
    } else {
        actionButtons = `
            <div class="reservation-card__actions">
                <button class="btn-action btn-revert" onclick="revertToProgress(${reservation.id})">
                    <svg viewBox="0 0 12 12" fill="none">
                        <path d="M1.5 6C1.5 6.89002 1.76392 7.76004 2.25839 8.50007C2.75285 9.24009 3.45566 9.81686 4.27792 10.1575C5.10019 10.4981 6.00499 10.5872 6.87791 10.4135C7.75082 10.2399 8.55264 9.81132 9.18198 9.18198C9.81132 8.55264 10.2399 7.75082 10.4135 6.87791C10.5872 6.00499 10.4981 5.10019 10.1575 4.27792C9.81686 3.45566 9.24009 2.75285 8.50007 2.25839C7.76004 1.76392 6.89002 1.5 6 1.5C4.74198 1.50473 3.53448 1.99561 2.63 2.87L1.5 4" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M1.5 1.5V4H4" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    진행중으로 되돌리기
                </button>
            </div>
        `;
    }

    return `
        <div class="reservation-card ${vipClass}" data-id="${reservation.id}">
            <div class="reservation-card__header">
                <div class="reservation-card__patient">
                    <h4>${reservation.name}</h4>
                    <p>${reservation.age}세 / ${reservation.gender}</p>
                </div>
                <div class="reservation-card__badges">
                    ${statusBadge}
                    ${vipBadge}
                </div>
            </div>
            <div class="reservation-card__content">
                <p class="reservation-card__symptom">${reservation.symptom}</p>
                <p class="reservation-card__department">${reservation.department} · ${reservation.doctor}</p>
                ${equipmentInfo}
            </div>
            <div class="reservation-card__footer">
                <span>${reservation.date}</span>
                <span>${reservation.time}</span>
            </div>
            ${actionButtons}
        </div>
    `;
}

function renderReservations() {
    const waitingList = document.getElementById('waitingList');
    const progressList = document.getElementById('progressList');
    const completeList = document.getElementById('completeList');

    if (waitingList) waitingList.innerHTML = reservationsData.waiting.map(r => createReservationCard(r, 'waiting')).join('');
    if (progressList) progressList.innerHTML = reservationsData.progress.map(r => createReservationCard(r, 'progress')).join('');
    if (completeList) completeList.innerHTML = reservationsData.completed.map(r => createReservationCard(r, 'completed')).join('');
}

function findReservationById(id) {
    let reservation = reservationsData.waiting.find(r => r.id === id);
    if (reservation) return reservation;

    reservation = reservationsData.progress.find(r => r.id === id);
    if (reservation) return reservation;

    reservation = reservationsData.completed.find(r => r.id === id);
    return reservation;
}

function openDetailModal(reservationId, status) {
    const reservation = findReservationById(reservationId);
    if (!reservation) return;

    const detailModal = document.getElementById('modalOverlay');
    if (!detailModal) return;

    // 환자 정보 채우기
    const infoRows = detailModal.querySelectorAll('.info-section:first-child .info-row');
    if (infoRows.length >= 4) {
        infoRows[0].querySelector('.info-value').textContent = reservation.name;
        infoRows[1].querySelector('.info-value').textContent = reservation.patientNo;
        infoRows[2].querySelector('.info-value').textContent = `${reservation.age}세 / ${reservation.gender}`;
        infoRows[3].querySelector('.info-value').textContent = reservation.phone;
    }

    // 예약 정보 채우기
    const reservationRows = detailModal.querySelectorAll('.info-section.bordered:first-of-type .info-row');
    if (reservationRows.length >= 5) {
        reservationRows[0].querySelector('.info-value').textContent = reservation.department;
        reservationRows[1].querySelector('.info-value').textContent = reservation.doctor;
        reservationRows[2].querySelector('.info-value').textContent = reservation.date;
        reservationRows[3].querySelector('.info-value').textContent = reservation.time;
        reservationRows[5].querySelector('.info-value').textContent = reservation.symptom;
    }

    // 메모 채우기
    const memoTextarea = detailModal.querySelector('.memo-textarea');
    if (memoTextarea) {
        memoTextarea.value = reservation.memo || '';
    }

    detailModal.style.display = 'flex';
    detailModal.dataset.currentId = reservationId;
}

function closeDetailModal() {
    const detailModal = document.getElementById('modalOverlay');
    if (detailModal) {
        detailModal.style.display = 'none';
    }
}

function openAddModal() {
    const addModal = document.getElementById('modalBackdrop');
    if (addModal) {
        addModal.style.display = 'flex';
    }
}

function closeAddModal() {
    const addModal = document.getElementById('modalBackdrop');
    if (addModal) {
        addModal.style.display = 'none';
    }
}

function startReservation(id) {
    const index = reservationsData.waiting.findIndex(r => r.id === id);
    if (index !== -1) {
        const reservation = reservationsData.waiting.splice(index, 1)[0];
        reservationsData.progress.push(reservation);
        renderReservations();
        showNotification('예약이 진행 중으로 변경되었습니다.');
    }
}

function completeReservation(id) {
    const index = reservationsData.progress.findIndex(r => r.id === id);
    if (index !== -1) {
        const reservation = reservationsData.progress.splice(index, 1)[0];
        reservationsData.completed.push(reservation);
        renderReservations();
        showNotification('예약이 완료되었습니다.');
    }
}

function revertReservation(id) {
    const index = reservationsData.progress.findIndex(r => r.id === id);
    if (index !== -1) {
        const reservation = reservationsData.progress.splice(index, 1)[0];
        reservationsData.waiting.push(reservation);
        renderReservations();
        showNotification('예약이 대기 상태로 변경되었습니다.');
    }
}

function revertToProgress(id) {
    const index = reservationsData.completed.findIndex(r => r.id === id);
    if (index !== -1) {
        const reservation = reservationsData.completed.splice(index, 1)[0];
        reservationsData.progress.push(reservation);
        renderReservations();
        showNotification('예약이 진행 중으로 변경되었습니다.');
    }
}

function showNotification(message) {
    const notification = document.createElement('div');
    notification.style.cssText = `
        position: fixed;
        top: 80px;
        right: 32px;
        background: #0E787C;
        color: white;
        padding: 16px 24px;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        z-index: 1000;
        animation: slideIn 0.3s ease-out;
    `;
    notification.textContent = message;
    document.body.appendChild(notification);

    setTimeout(() => {
        notification.style.animation = 'slideOut 0.3s ease-out';
        setTimeout(() => notification.remove(), 300);
    }, 3000);
}

const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
        from { transform: translateX(400px); opacity: 0; }
        to { transform: translateX(0); opacity: 1; }
    }
    @keyframes slideOut {
        from { transform: translateX(0); opacity: 1; }
        to { transform: translateX(400px); opacity: 0; }
    }
`;
document.head.appendChild(style);

document.addEventListener('DOMContentLoaded', function() {
    renderReservations();

    // 모달 초기 숨김 처리
    const detailModal = document.getElementById('modalOverlay');
    const addModal = document.getElementById('modalBackdrop');
    if (detailModal) detailModal.style.display = 'none';
    if (addModal) addModal.style.display = 'none';

    // 예약 상세 모달 이벤트
    if (detailModal) {
        // X 버튼 클릭
        const closeButtons = detailModal.querySelectorAll('.close-button, #closeFooterButton');
        closeButtons.forEach(btn => {
            btn.addEventListener('click', closeDetailModal);
        });

        // 모달 밖 클릭
        detailModal.addEventListener('click', function(e) {
            if (e.target === detailModal) {
                closeDetailModal();
            }
        });
    }

    // 예약 등록 모달 이벤트
    if (addModal) {
        // X 버튼, 취소 버튼 클릭
        const closeButtons = addModal.querySelectorAll('.close-button, #cancelButton');
        closeButtons.forEach(btn => {
            btn.addEventListener('click', closeAddModal);
        });

        // 모달 밖 클릭
        addModal.addEventListener('click', function(e) {
            if (e.target === addModal) {
                closeAddModal();
            }
        });
    }

    // 예약 등록 버튼 클릭
    const addButton = document.querySelector('.btn-primary-add');
    if (addButton) {
        addButton.addEventListener('click', function(e) {
            e.preventDefault();
            openAddModal();
        });
    }

    // 캘린더 날짜 선택
    const calendarDays = document.querySelectorAll('.calendar__day:not(.calendar__day--inactive)');
    calendarDays.forEach(day => {
        day.addEventListener('click', function() {
            calendarDays.forEach(d => d.classList.remove('calendar__day--active'));
            this.classList.add('calendar__day--active');

            const selectedDay = this.textContent;
            const dateValue = document.querySelector('.calendar__selected-value');
            if (dateValue) {
                dateValue.textContent = `2025년 10월 ${selectedDay}일`;
            }
        });
    });

    // 검색 기능
    const searchInputs = document.querySelectorAll('.header__search-input, .search-bar__input');
    searchInputs.forEach(input => {
        input.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const allCards = document.querySelectorAll('.reservation-card');

            allCards.forEach(card => {
                const name = card.querySelector('.reservation-card__patient h4').textContent.toLowerCase();
                const symptom = card.querySelector('.reservation-card__symptom').textContent.toLowerCase();

                if (name.includes(searchTerm) || symptom.includes(searchTerm)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    });
});