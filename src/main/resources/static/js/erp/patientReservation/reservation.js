// reservation.js - 예약관리 페이지 로직
const reservationsData = {
  waiting: [
    {
      id: 1,
      patientNo: "P001",
      name: "김민수",
      age: 45,
      gender: "남",
      phone: "010-1234-5678",
      symptom: "허리 통증",
      department: "정형외과",
      doctor: "이준호",
      equipment: "MRI-01",
      date: "2025-10-28",
      time: "14:00",
      memo: "",
      isVIP: false,
    },
    {
      id: 2,
      patientNo: "P002",
      name: "이영희",
      age: 38,
      gender: "여",
      phone: "010-2345-6789",
      symptom: "복통",
      department: "내과",
      doctor: "김서연",
      equipment: "초음파-01",
      date: "2025-10-28",
      time: "15:00",
      memo: "",
      isVIP: true,
    },
    {
      id: 3,
      patientNo: "P003",
      name: "박철수",
      age: 52,
      gender: "남",
      phone: "010-3456-7890",
      symptom: "두통",
      department: "신경외과",
      doctor: "박민준",
      equipment: "CT-01",
      date: "2025-10-28",
      time: "15:30",
      memo: "",
      isVIP: false,
    },
    {
      id: 4,
      patientNo: "P004",
      name: "정수연",
      age: 29,
      gender: "여",
      phone: "010-4567-8901",
      symptom: "피부 알레르기",
      department: "피부과",
      doctor: "최수진",
      equipment: null,
      date: "2025-10-28",
      time: "16:00",
      memo: "",
      isVIP: false,
    },
    {
      id: 5,
      patientNo: "P005",
      name: "최동훈",
      age: 55,
      gender: "남",
      phone: "010-5678-9012",
      symptom: "위내시경",
      department: "소화기내과",
      doctor: "김서연",
      equipment: "내시경-01",
      date: "2025-10-28",
      time: "11:00",
      memo: "",
      isVIP: false,
    },
  ],
  progress: [
    {
      id: 6,
      patientNo: "P006",
      name: "한지민",
      age: 41,
      gender: "여",
      phone: "010-6789-0123",
      symptom: "관절염 검사",
      department: "정형외과",
      doctor: "이준호",
      equipment: "X-Ray-01",
      date: "2025-10-28",
      time: "10:00",
      memo: "",
      isVIP: true,
    },
    {
      id: 7,
      patientNo: "P007",
      name: "오민정",
      age: 33,
      gender: "여",
      phone: "010-7890-1234",
      symptom: "어지럼증",
      department: "이비인후과",
      doctor: "박민준",
      equipment: null,
      date: "2025-10-28",
      time: "11:30",
      memo: "",
      isVIP: false,
    },
  ],
  completed: [
    {
      id: 8,
      patientNo: "P008",
      name: "강태영",
      age: 48,
      gender: "남",
      phone: "010-8901-2345",
      symptom: "건강검진",
      department: "종합검진",
      doctor: "이준호",
      equipment: "MRI-01",
      date: "2025-10-28",
      time: "09:00",
      memo: "",
      isVIP: true,
    },
    {
      id: 9,
      patientNo: "P009",
      name: "윤서현",
      age: 26,
      gender: "여",
      phone: "010-9012-3456",
      symptom: "감기",
      department: "내과",
      doctor: "김서연",
      equipment: null,
      date: "2025-10-28",
      time: "09:30",
      memo: "",
      isVIP: false,
    },
    {
      id: 10,
      patientNo: "P010",
      name: "임재현",
      age: 37,
      gender: "남",
      phone: "010-0123-4567",
      symptom: "발목 염좌",
      department: "정형외과",
      doctor: "이준호",
      equipment: "X-Ray-01",
      date: "2025-10-28",
      time: "08:30",
      memo: "",
      isVIP: false,
    },
  ],
};

function createReservationCard(reservation, status) {
  const vipClass = reservation.isVIP ? "reservation-card--vip" : "";

  let statusBadge = "";
  if (status === "waiting") {
    statusBadge = `<span class="badge badge--waiting" onclick="openDetailModal(${reservation.id}, '${status}')">예약됨</span>`;
  } else if (status === "progress") {
    statusBadge = `<span class="badge badge--progress" onclick="openDetailModal(${reservation.id}, '${status}')">진행중</span>`;
  } else {
    statusBadge = `<span class="badge badge--complete" onclick="openDetailModal(${reservation.id}, '${status}')">완료됨</span>`;
  }

  const vipBadge = reservation.isVIP
    ? '<span class="badge badge--vip">VIP</span>'
    : "";

  const equipmentInfo = reservation.equipment
    ? `<p class="reservation-card__equipment">장비: ${reservation.equipment}</p>`
    : "";

  let actionButtons = "";
  if (status === "waiting") {
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
  } else if (status === "progress") {
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
  const waitingList = document.getElementById("waitingList");
  const progressList = document.getElementById("progressList");
  const completeList = document.getElementById("completeList");

  if (waitingList)
    waitingList.innerHTML = reservationsData.waiting
      .map((r) => createReservationCard(r, "waiting"))
      .join("");
  if (progressList)
    progressList.innerHTML = reservationsData.progress
      .map((r) => createReservationCard(r, "progress"))
      .join("");
  if (completeList)
    completeList.innerHTML = reservationsData.completed
      .map((r) => createReservationCard(r, "completed"))
      .join("");
}

function findReservationById(id) {
  let reservation = reservationsData.waiting.find((r) => r.id === id);
  if (reservation) return reservation;

  reservation = reservationsData.progress.find((r) => r.id === id);
  if (reservation) return reservation;

  reservation = reservationsData.completed.find((r) => r.id === id);
  return reservation;
}

function openDetailModal(reservationId, status) {
  const reservation = findReservationById(reservationId);
  if (!reservation) return;

  const detailModal = document.getElementById("modalOverlay");
  if (!detailModal) return;

  // 환자 정보 채우기
  const infoRows = detailModal.querySelectorAll(
    ".info-section:first-child .info-row"
  );
  if (infoRows.length >= 4) {
    infoRows[0].querySelector(".info-value").textContent = reservation.name;
    infoRows[1].querySelector(".info-value").textContent =
      reservation.patientNo;
    infoRows[2].querySelector(
      ".info-value"
    ).textContent = `${reservation.age}세 / ${reservation.gender}`;
    infoRows[3].querySelector(".info-value").textContent = reservation.phone;
  }

  // 예약 정보 채우기
  const reservationRows = detailModal.querySelectorAll(
    ".info-section.bordered:first-of-type .info-row"
  );
  if (reservationRows.length >= 5) {
    reservationRows[0].querySelector(".info-value").textContent =
      reservation.department;
    reservationRows[1].querySelector(".info-value").textContent =
      reservation.doctor;
    reservationRows[2].querySelector(".info-value").textContent =
      reservation.date;
    reservationRows[3].querySelector(".info-value").textContent =
      reservation.time;
    reservationRows[5].querySelector(".info-value").textContent =
      reservation.symptom;
  }

  // 메모 채우기
  const memoTextarea = detailModal.querySelector(".memo-textarea");
  if (memoTextarea) {
    memoTextarea.value = reservation.memo || "";
  }

  detailModal.style.display = "flex";
  detailModal.dataset.currentId = reservationId;
}

function closeDetailModal() {
  const detailModal = document.getElementById("modalOverlay");
  if (detailModal) {
    detailModal.style.display = "none";
  }
}

function startReservation(id) {
  const index = reservationsData.waiting.findIndex((r) => r.id === id);
  if (index !== -1) {
    const reservation = reservationsData.waiting.splice(index, 1)[0];
    reservationsData.progress.push(reservation);
    renderReservations();
    showNotification("예약이 진행 중으로 변경되었습니다.");
  }
}

function completeReservation(id) {
  const index = reservationsData.progress.findIndex((r) => r.id === id);
  if (index !== -1) {
    const reservation = reservationsData.progress.splice(index, 1)[0];
    reservationsData.completed.push(reservation);
    renderReservations();
    showNotification("예약이 완료되었습니다.");
  }
}

function revertReservation(id) {
  const index = reservationsData.progress.findIndex((r) => r.id === id);
  if (index !== -1) {
    const reservation = reservationsData.progress.splice(index, 1)[0];
    reservationsData.waiting.push(reservation);
    renderReservations();
    showNotification("예약이 대기 상태로 변경되었습니다.");
  }
}

function revertToProgress(id) {
  const index = reservationsData.completed.findIndex((r) => r.id === id);
  if (index !== -1) {
    const reservation = reservationsData.completed.splice(index, 1)[0];
    reservationsData.progress.push(reservation);
    renderReservations();
    showNotification("예약이 진행 중으로 변경되었습니다.");
  }
}

function showNotification(message) {
  const notification = document.createElement("div");
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
    notification.style.animation = "slideOut 0.3s ease-out";
    setTimeout(() => notification.remove(), 300);
  }, 3000);
}

const style = document.createElement("style");
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

document.addEventListener("DOMContentLoaded", function () {
  renderReservations();

  // 모달 초기 숨김 처리
  const detailModal = document.getElementById("modalOverlay");
  if (detailModal) detailModal.style.display = "none";

    const today = new Date().toISOString().split('T')[0];
    fetchReservationByDate(today);
  // 예약 상세 모달 이벤트
  if (detailModal) {
    const closeButtons = detailModal.querySelectorAll(
      ".close-button, #closeFooterButton"
    );
    closeButtons.forEach((btn) => {
      btn.addEventListener("click", closeDetailModal);
    });

    const cancelButton = detailModal.querySelector(".btn-primary");
    if (cancelButton) {
        cancelButton.addEventListener("click", function() {
            const reservationNo = detailModal.dataset.currentReservationNo;
            if (reservationNo) {
                cancelReservation(reservationNo);
            }
          });
      }
    // 모달 밖 클릭
    detailModal.addEventListener("click", function (e) {
      if (e.target === detailModal) {
        closeDetailModal();
      }
    });
  }

  // FullCalendar 초기화
  const calendarEl = document.getElementById("calendar");
  const dateValue = document.querySelector(".calendar__selected-value");
  let selectedDate = null;

  // FullCalendar가 로드되었는지 확인
  if (calendarEl) {
    console.log("캘린더 요소 찾음:", calendarEl);
    console.log("FullCalendar 로드 여부:", typeof FullCalendar !== "undefined");

    function initCalendar() {
      if (typeof FullCalendar === "undefined") {
        console.error("FullCalendar가 로드되지 않았습니다.");
        return;
      }

      try {
        const calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: "dayGridMonth",
          headerToolbar: {
            left: "prev",
            center: "title",
            right: "next",
          },
          height: "auto",
          dayCellDidMount: function (info) {
            info.el.classList.add("calendar-day");
            if (info.isPast) {
              info.el.classList.add("disabled");
            } else {
              info.el.classList.add("available");
            }
          },
          dateClick: function (info) {
            if (
              info.dayEl.classList.contains("disabled") ||
              info.dayEl.classList.contains("unavailable-date")
            ) {
              return;
            }

            const prevSelected = document.querySelector(
              ".calendar-day.selected"
            );
            if (prevSelected) {
              prevSelected.classList.remove("selected");
            }
            info.dayEl.classList.add("selected");
            selectedDate = info.dateStr;

            // 선택된 날짜 표시 업데이트
            if (dateValue && selectedDate) {
              const [year, month, day] = selectedDate.split("-");
              const localDate = new Date(year, month - 1, day);
              const options = {
                year: "numeric",
                month: "long",
                day: "numeric",
              };
              dateValue.textContent = localDate.toLocaleDateString(
                "ko-KR",
                options
              );
            }
              fetchReservationByDate(selectedDate);
          },
        });

        calendar.render();
        console.log("캘린더 렌더링 완료");
      } catch (error) {
        console.error("캘린더 초기화 오류:", error);
        calendarEl.innerHTML =
          '<p style="padding: 20px; text-align: center; color: #6B7280;">캘린더 초기화 중 오류가 발생했습니다.</p>';
      }
    }

    // FullCalendar가 로드되었는지 확인하고 초기화
    if (typeof FullCalendar !== "undefined") {
      initCalendar();
    } else {
      // FullCalendar가 아직 로드되지 않았으면 잠시 후 다시 시도
      const checkInterval = setInterval(function () {
        if (typeof FullCalendar !== "undefined") {
          clearInterval(checkInterval);
          initCalendar();
        }
      }, 100);

      // 5초 후에도 로드되지 않으면 포기
      setTimeout(function () {
        clearInterval(checkInterval);
        if (typeof FullCalendar === "undefined") {
          console.error("FullCalendar 라이브러리가 로드되지 않았습니다.");
          if (calendarEl) {
            calendarEl.innerHTML =
              '<p style="padding: 20px; text-align: center; color: #6B7280;">캘린더를 불러오는 중...</p>';
          }
        }
      }, 5000);
    }
  } else {
    console.error("캘린더 요소를 찾을 수 없습니다.");
  }

  // 검색 기능
  const searchInputs = document.querySelectorAll(
    ".header__search-input, .search-bar__input"
  );
  searchInputs.forEach((input) => {
    input.addEventListener("input", function () {
      const searchTerm = this.value.toLowerCase();
      const allCards = document.querySelectorAll(".reservation-card");

      allCards.forEach((card) => {
        const name = card
          .querySelector(".reservation-card__patient h4")
          .textContent.toLowerCase();
        const symptom = card
          .querySelector(".reservation-card__symptom")
          .textContent.toLowerCase();

        if (name.includes(searchTerm) || symptom.includes(searchTerm)) {
          card.style.display = "block";
        } else {
          card.style.display = "none";
        }
      });
    });
  });
});

function fetchReservationByDate(selectedDate){
    console.log("날짜선택: ", selectedDate);
    console.log("AJAX 요청");

    const contextPath = "/erp/erpReservation";
    console.log("Context Path:", contextPath);

    $.ajax({
        url: contextPath + "/getReservations",
        method: "GET",
        data: { selectedDate: selectedDate },
        dataType: "json",
        success: function(data){
            console.log('조회 결과:', data);
            displayReservations(data);
        },
        error: function(xhr, status, error){
            console.error('Error:', error);
            alert('예약 정보를 불러오는데 실패했습니다.');
        }
    });
}

function displayReservations(data) {
    if (data.waiting && data.waiting.length > 0) {
        console.log('대기 첫번째 항목:', data.waiting[0]);
        console.log('예약번호:', data.waiting[0].reservationNo);
    }

    displayWaitingList(data.waiting || []);
    displayProgressList(data.inProgress || []);
    displayCompleteList(data.completed || []);
    updateStatistics(data);

    console.log('data.waiting:', data.waiting);
    console.log('data.inProgress:', data.inProgress);
    console.log('data.completed:', data.completed);
}

function displayWaitingList(waitingList) {
    const container = document.getElementById('waitingList');

    if (!container) return;

    if (waitingList.length === 0) {
        container.innerHTML = `
            <div style="padding: 20px; text-align: center; color: #6B7280;">
                <p>예약 대기 중인 환자가 없습니다.</p>
            </div>
        `;
        return;
    }

    container.innerHTML = waitingList.map(item => {
        const resNo = item.reservationNo || '';
        console.log('처리 중인 예약 항목 (item):', item);
        console.log('item.reservationTime 값:', item.reservationTime);

        return `
        <div class="reservation-card ${item.isVip ? 'reservation-card--vip' : ''}" data-reservation-id="${resNo}" onclick="openReservationDetail('${resNo}')">
            <div class="reservation-card__header">
                <div class="reservation-card__patient">
                    <h4>${item.patientName}</h4>
                    <p>${item.age} / ${item.gender}</p>
                </div>
                <div class="reservation-card__badges">
                    ${item.isVip ? '<span class="badge badge--vip">VIP</span>' : ''}
                    <span class="badge badge--waiting">대기</span>
                </div>
            </div>
            <div class="reservation-card__content">
                <p class="reservation-card__symptom">${item.symptoms}</p>
                <p class="reservation-card__department">${item.memo || ''}</p>
                <p class="reservation-card__equipment">진료과: ${item.departmentName || ''}</p>
            </div>
            <div class="reservation-card__footer">
                <span>${item.reservationDate || ''}</span>
                <span>${item.reservationTime || ''}</span>
            </div>
            <div class="reservation-card__actions" onclick="event.stopPropagation()">
                <button class="btn-action btn-start" onclick="startReservation('${resNo}')">
                    <svg width="12" height="12" viewBox="0 0 12 12" fill="none">
                        <path d="M4 2L8 6L4 10" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    진행 시작
                </button>
            </div>
        </div>
    `;
    }).join('');
}

function displayProgressList(progressList) {
    const container = document.getElementById('progressList');

    if (!container) return;

    if (progressList.length === 0) {
        container.innerHTML = `
            <div style="padding: 20px; text-align: center; color: #6B7280;">
                <p>진행 중인 예약이 없습니다.</p>
            </div>
        `;
        return;
    }

    container.innerHTML = progressList.map(item => {
        const resNo = item.reservationNo || '';

        return `
        <div class="reservation-card ${item.isVip ? 'reservation-card--vip' : ''}" data-reservation-id="${resNo}" onclick="openReservationDetail('${resNo}')">
            <div class="reservation-card__header">
                <div class="reservation-card__patient">
                    <h4>${item.patientName}</h4>
                    <p>${item.age} / ${item.gender}</p>
                </div>
                <div class="reservation-card__badges">
                    ${item.isVip ? '<span class="badge badge--vip">VIP</span>' : ''}
                    <span class="badge badge--progress">진행중</span>
                </div>
            </div>
            <div class="reservation-card__content">
                <p class="reservation-card__symptom">${item.symptoms}</p>
                <p class="reservation-card__department">${item.memo || ''}</p>
                <p class="reservation-card__equipment">진료과: ${item.departmentName || ''}</p>
            </div>
            <div class="reservation-card__footer">
                <span>${item.reservationDate || ''}</span>
                <span>${item.reservationTime || ''}</span>
            </div>
            <div class="reservation-card__actions" onclick="event.stopPropagation()">
                <button class="btn-action btn-revert" onclick="revertReservation('${resNo}')">
                    <svg width="12" height="12" viewBox="0 0 12 12" fill="none">
                        <path d="M2 6H10M2 6L5 3M2 6L5 9" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </button>
                <button class="btn-action btn-complete" onclick="completeReservation('${resNo}')">
                    <svg width="12" height="12" viewBox="0 0 12 12" fill="none">
                        <path d="M10 3L4.5 8.5L2 6" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    완료 처리
                </button>
            </div>
        </div>
    `;
    }).join('');
}

function displayCompleteList(completeList) {
    const container = document.getElementById('completeList');

    if (!container) return;

    if (completeList.length === 0) {
        container.innerHTML = `
            <div style="padding: 20px; text-align: center; color: #6B7280;">
                <p>완료된 예약이 없습니다.</p>
            </div>
        `;
        return;
    }

    container.innerHTML = completeList.map(item => {
        const resNo = item.reservationNo || '';

        return `
        <div class="reservation-card ${item.isVip ? 'reservation-card--vip' : ''}" data-reservation-id="${resNo}" onclick="openReservationDetail('${resNo}')">
            <div class="reservation-card__header">
                <div class="reservation-card__patient">
                    <h4>${item.patientName}</h4>
                    <p>${item.age} / ${item.gender}</p>
                </div>
                <div class="reservation-card__badges">
                    ${item.isVip ? '<span class="badge badge--vip">VIP</span>' : ''}
                    <span class="badge badge--complete">완료됨</span>
                </div>
            </div>
            <div class="reservation-card__content">
                <p class="reservation-card__symptom">${item.symptoms}</p>
                <p class="reservation-card__department">${item.memo || ''}</p>
                <p class="reservation-card__equipment">진료과: ${item.departmentName || ''}</p>
            </div>
            <div class="reservation-card__footer">
                <span>${item.reservationDate || ''}</span>
                <span>${item.reservationTime || ''}</span>
            </div>
            <div class="reservation-card__actions" onclick="event.stopPropagation()">
                <button class="btn-action btn-revert" onclick="revertToProgress('${resNo}')">
                    <svg width="12" height="12" viewBox="0 0 12 12" fill="none">
                        <path d="M8 2L4 6L8 10" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    진행중으로 되돌리기
                </button>
            </div>
        </div>
    `;
    }).join('');
}


function updateStatistics(data) {
    const waitingCount = (data.waiting || []).length;
    const progressCount = (data.inProgress || []).length;
    const completeCount = (data.completed || []).length;

    const statCards = document.querySelectorAll('.stat-card__value');
    if (statCards.length >= 3) {
        statCards[0].textContent = waitingCount;
        statCards[1].textContent = progressCount;
        statCards[2].textContent = completeCount;
    }

    const countBadges = document.querySelectorAll('.count-badge');
    if (countBadges.length >= 3) {
        countBadges[0].textContent = waitingCount;
        countBadges[1].textContent = progressCount;
        countBadges[2].textContent = completeCount;
    }
}


// openReservationDetail 함수 수정
// 예약 상세 조회 및 모달 표시
function openReservationDetail(reservationNo) {
    const contextPath = "/erp/erpReservation";

    $.ajax({
        url: contextPath + "/detail/" + reservationNo,
        method: "GET",
        dataType: "json",
        success: function(data) {
            const modal = document.getElementById('modalOverlay');
            if (!modal) return;

            // 환자 정보
            const patientRows = modal.querySelectorAll('.info-section:first-child .info-row');
            if (patientRows.length >= 4) {
                patientRows[0].querySelector('.info-value').textContent = data.patientName || '-';
                patientRows[1].querySelector('.info-value').textContent = data.patientCode || '-';
                patientRows[2].querySelector('.info-value').textContent = data.age + ' / ' + data.gender;
                patientRows[3].querySelector('.info-value').textContent = data.phone || '-';
            }

            // 예약 정보
            const reservationRows = modal.querySelectorAll('.info-section:nth-of-type(2) .info-row');
            if (reservationRows.length >= 6) {
                reservationRows[0].querySelector('.info-value').textContent = data.departmentName || '-';
                reservationRows[1].querySelector('.info-value').textContent = data.doctorName || '-';
                reservationRows[2].querySelector('.info-value').textContent = data.reservationDate || '-';
                reservationRows[3].querySelector('.info-value').textContent = data.reservationTime || '-';
                // reservationRows[4]는 장비
                reservationRows[5].querySelector('.info-value').textContent = data.symptoms || '-';
            }

            // 메모
            const memoTextarea = modal.querySelector('.memo-textarea');
            if (memoTextarea) {
                memoTextarea.value = data.memo || '';
            }

            // 모달 열기
            modal.style.display = 'flex';
            modal.dataset.currentReservationNo = reservationNo;
        },
        error: function(xhr, status, error) {
            console.error('예약 정보 조회 실패:', error);
            alert('예약 정보를 불러올 수 없습니다.');
        }
    });
}

function startReservation(reservationNo) {
    console.log('진행 시작:', reservationNo);
    updateReservationStatus(reservationNo, '진행중');
}

function completeReservation(reservationNo) {
    updateReservationStatus(reservationNo, '완료');
}

function revertReservation(reservationNo) {
    updateReservationStatus(reservationNo, '대기');
}

function revertToProgress(reservationNo) {
    updateReservationStatus(reservationNo, '진행중');
}

function cancelReservation(reservationNo) {
    if (!confirm('정말로 이 예약을 취소하시겠습니까?')) {
        return;
    }
    console.log('예약 취소:', reservationNo);
    updateReservationStatus(reservationNo, '취소');
}

function updateReservationStatus(reservationNo, newStatus) {
    const contextPath = "/erp/erpReservation";

    $.ajax({
        url: contextPath + "/updateStatus",
        method: "POST",
        data: {
            reservationNo: reservationNo,
            status: newStatus
        },
        dataType: "json",
        success: function(response){
            console.log('상태 업데이트 성공:', response);

            if (typeof closeDetailModal === 'function') {
                closeDetailModal();
            }

            const selectedDateElem = document.querySelector('.calendar-day.selected');
            const selectedDate = selectedDateElem
                ? selectedDateElem.dataset.date
                : new Date().toISOString().split('T')[0];

            fetchReservationByDate(selectedDate);
        },
        error: function(xhr, status, error){
            console.error('상태 업데이트 실패:', error);
            alert('상태 변경에 실패했습니다.');
        }
    });
}
