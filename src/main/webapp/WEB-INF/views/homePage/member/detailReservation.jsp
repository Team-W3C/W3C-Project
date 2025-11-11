<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>진료예약 - 병원 예약 시스템</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/detailReservation.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/index.css">

    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>

</head>
<body>
<jsp:include page="../../common/homePageMember/header_member.jsp" />

<div class="reservation">
    <main class="reservation-main">
        <jsp:include page="../../common/homePageMember/appointment-sidebar.jsp"/>

        <section class="reservation-content">
            <header class="reservation-header">
                <h1 class="page-title">진료예약</h1>
                <p class="page-subtitle">
                    원하시는 날짜와 시간을 선택하여 진료를 예약하세요.
                </p>
            </header>

            <article class="reservation-card">
                <div class="card-header">
                    <div class="step-badge">
                        <span class="step-number">1</span>
                    </div>
                    <h2 class="card-title">날짜 및 진료과 선택</h2>
                </div>

                <div class="card-body">
                    <div class="selection-section">
                        <h3 class="section-title">날짜 선택</h3>
                        <div id="calendar-wrapper">
                            <div id="calendar"></div>
                        </div>
                    </div>

                    <div class="selection-section department-section">
                        <h3 class="section-title">진료과 선택</h3>

                        <div class="department-grid" id="department-grid">
                        </div>
                    </div>
                </div>
            </article>

            <div class="selection-summary" id="selection-summary" style="display: none;">
                <div class="summary-item">
                    <span class="summary-dot"></span>
                    <span class="summary-label">선택 진료과:</span>
                    <span class="summary-value" id="summary-dept">--</span>
                </div>
                <div class="summary-item">
                    <span class="summary-dot"></span>
                    <span class="summary-label">선택 날짜:</span>
                    <span class="summary-value" id="summary-date">--</span>
                </div>
            </div>

            <article class="reservation-card" id="step2-card" style="display: none;">
                <div class="card-header">
                    <div class="step-badge">
                        <span class="step-number">2</span>
                    </div>
                    <h2 class="card-title">시간 선택</h2>
                    <div class="legend">
                          <span class="legend-item">
                            <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-13.svg" alt="" />
                            예약 가능
                          </span>
                        <span class="legend-item">
                            <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-31.svg" alt="" />
                            예약 마감
                          </span>
                    </div>
                </div>

                <div class="card-body">
                    <div class="timeslot-grid" id="timeslot-grid">
                    </div>
                </div>
            </article>
        </section>
    </main>

    <jsp:include page="../../common/homePageFooter/footer.jsp" />
</div>

<script>
    // --- 1. 전역 변수: 사용자의 선택 값 저장 ---
    let selectedDate = null;
    let selectedDeptId = null;
    let selectedDeptName = null;
    let calendar = null;

    // --- 아이콘 임시 맵 (DB에 icon_url 컬럼이 있다면 VO/Mapper 수정) ---
    const deptIconMap = {
        "내과": "https://c.animaapp.com/mhjva9g3rpbRQm/img/container.svg",
        "외과": "https://c.animaapp.com/mhjva9g3rpbRQm/img/container-7.svg",
        "정형외과": "https://c.animaapp.com/mhjva9g3rpbRQm/img/container-6.svg",
        "소아과": "https://c.animaapp.com/mhjva9g3rpbRQm/img/container-2.svg",
        "피부과": "https://c.animaapp.com/mhjva9g3rpbRQm/img/container-3.svg",
        "안과": "https://c.animaapp.com/mhjva9g3rpbRQm/img/container-1.svg",
        "치과": "https://c.animaapp.com/mhjva9g3rpbRQm/img/container-4.svg",
        "심장내과": "https://c.animaapp.com/mhjva9g3rpbRQm/img/container-5.svg"
    };
    const defaultIcon = "https://c.animaapp.com/mhjva9g3rpbRQm/img/container.svg";

    // --- DOM 요소 ---
    const calendarEl = document.getElementById('calendar');
    const deptGrid = document.getElementById('department-grid');
    const timeslotGrid = document.getElementById('timeslot-grid');
    const summary = document.getElementById('selection-summary');
    const summaryDate = document.getElementById('summary-date');
    const summaryDept = document.getElementById('summary-dept');
    const step2Card = document.getElementById('step2-card');

    // --- 2. 페이지 로드 시 실행 ---
    document.addEventListener('DOMContentLoaded', function() {
        initCalendar();
        loadDepartments(); // [추가] 진료과 목록 동적 로딩
    });

    // --- 3. FullCalendar 초기화 ---
    function initCalendar() {
        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'ko',
            headerToolbar: { left: 'prev', center: 'title', right: 'next' },
            events: '${pageContext.request.contextPath}/member/reservation/available-dates',
            validRange: { start: new Date() }, // 'sysdate' (오늘)부터

            dateClick: function(info) {
                // [수정] 'unavailable-date'(휴무일) 클래스가 *있으면* 클릭을 막습니다.
                if (info.dayEl.classList.contains('unavailable-date')) {
                    alert("휴무일은 선택하실 수 없습니다.");
                    return;
                }

                selectedDate = info.dateStr;
                summaryDate.textContent = selectedDate;
                checkAndLoadTimes(); // [핵심] 로직 호출
            },

            eventClassNames: function(arg) {
                return arg.event.extendedProps.className || '';
            }
        });
        calendar.render();
    }

    // --- 4. [신규] 진료과 목록 동적 로딩 ---
    function loadDepartments() {
        fetch('${pageContext.request.contextPath}/member/reservation/departments')
            .then(response => response.json())
            .then(departments => {
                let html = '';
                for (const dept of departments) {
                    const iconSrc = deptIconMap[dept.departmentName] || defaultIcon;
                    html += `
                        <button type="button" class="department-btn" data-dept-id="${dept.departmentNo}" data-dept-name="${dept.departmentName}">
                            <img src="${iconSrc}" alt="" class="department-icon"/>
                            <span>${dept.departmentName}</span>
                            <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-1.svg" alt="선택됨" class="check-icon" style="display: none;">
                        </button>
                        `;
                }
                deptGrid.innerHTML = html;
            })
            .catch(error => {
                console.error('Error fetching departments:', error);
                deptGrid.innerHTML = '<p>진료과 목록을 불러오는 데 실패했습니다.</p>';
            });
    }

    // --- 5. [수정] 진료과 버튼 클릭 이벤트 (이벤트 위임) ---
    deptGrid.addEventListener('click', function(e) {
        const button = e.target.closest('.department-btn');
        if (!button) return;

        deptGrid.querySelectorAll('.department-btn').forEach(btn => {
            btn.classList.remove('selected');
            btn.querySelector('.check-icon').style.display = 'none';
        });

        button.classList.add('selected');
        button.querySelector('.check-icon').style.display = 'block';

        selectedDeptId = button.dataset.deptId;
        selectedDeptName = button.dataset.deptName;

        summaryDept.textContent = selectedDeptName;
        checkAndLoadTimes(); // [핵심] 로직 호출
    });

    // --- 6. [수정] 시간표 AJAX 로딩 (400 에러 해결) ---
    function checkAndLoadTimes() {
        summary.style.display = 'flex';
        step2Card.style.display = 'block';

        // [핵심] 날짜와 진료과가 *모두* 선택되지 않으면 AJAX 요청을 보내지 않음 (400 에러 방지)
        if (!selectedDate || !selectedDeptId) {
            timeslotGrid.innerHTML = '<p>날짜와 진료과를 모두 선택해주세요.</p>';
            return; // ★★★ 중요 ★★★
        }

        console.log(`Loading times for Dept: ${selectedDeptId}, Date: ${selectedDate}`);
        timeslotGrid.innerHTML = '<p>시간표를 불러오는 중...</p>';

        const url = `${pageContext.request.contextPath}/member/reservation/available-times?date=${selectedDate}&departmentId=${selectedDeptId}`;

        fetch(url)
            .then(response => {
                if (!response.ok) {
                    // [수정] 500 에러가 아닌 실제 에러 코드를 표시
                    throw new Error(`서버 응답 오류 (${response.status})`);
                }
                return response.json();
            })
            .then(timeslots => {
                renderTimeslots(timeslots);
            })
            .catch(error => {
                console.error('Error fetching timeslots:', error);
                timeslotGrid.innerHTML = '<p>시간표를 불러오는 중 오류가 발생했습니다.</p>';
            });
    }

    // --- 7. 시간표 HTML 렌더링 함수 ---
    function renderTimeslots(timeslots) {
        timeslotGrid.innerHTML = '';

        if (!timeslots || timeslots.length === 0) {
            timeslotGrid.innerHTML = '<p>선택하신 날짜에 예약 가능한 시간이 없습니다.</p>';
            return;
        }

        let html = '';
        for (const slot of timeslots) {
            // (TODO: DB에서 slot.status를 받아와서 'available'/'unavailable' 클래스 분기)
            const isAvailable = true; // (임시)
            const statusClass = isAvailable ? "available" : "unavailable";
            const statusIcon = isAvailable
                ? "https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-8.svg"
                : "https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-11.svg";

            html += `
                <button type="button" class="timeslot-card ${statusClass}">
                  <div class="timeslot-header">
                    <div class="timeslot-time">
                      <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-4.svg" alt="" />
                      <span>${slot.time}</span>
                    </div>
                    <img src="${statusIcon}" alt="상태" class="status-icon" />
                  </div>
                  <div class="timeslot-info">
                    <p class="doctor-info">
                      <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-2.svg" alt="" />
                      <span>${slot.doctorName}</span>
                    </p>
                    <p class="location-info">
                      <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-7.svg" alt="" />
                      <span>${slot.location}</span>
                    </p>
                  </div>
                  ${!isAvailable ? '<span class="unavailable-badge">예약 마감</span>' : ''}
                </button>
                `;
        }
        timeslotGrid.innerHTML = html;
    }
</script>
</body>
</html>