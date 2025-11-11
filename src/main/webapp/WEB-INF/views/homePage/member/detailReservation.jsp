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
                            <button type="button" class="department-btn" data-dept-id="1" data-dept-name="정형외과">
                                <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/container-6.svg" alt="" class="department-icon"/>
                                <span>정형외과</span>
                                <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-1.svg" alt="선택됨" class="check-icon" style="display: none;">
                            </button>
                            <button type="button" class="department-btn" data-dept-id="2" data-dept-name="내과">
                                <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/container.svg" alt="" class="department-icon"/>
                                <span>내과</span>
                                <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-1.svg" alt="선택됨" class="check-icon" style="display: none;">
                            </button>
                            <button type="button" class="department-btn" data-dept-id="3" data-dept-name="피부과">
                                <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/container-3.svg" alt="" class="department-icon"/>
                                <span>피부과</span>
                                <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-1.svg" alt="선택됨" class="check-icon" style="display: none;">
                            </button>
                            <button type="button" class="department-btn" data-dept-id="5" data-dept-name="안과">
                                <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/container-1.svg" alt="" class="department-icon"/>
                                <span>안과</span>
                                <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-1.svg" alt="선택됨" class="check-icon" style="display: none;">
                            </button>
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
    let calendar = null; // 캘린더 객체

    // --- DOM 요소 ---
    const calendarEl = document.getElementById('calendar');
    const deptGrid = document.getElementById('department-grid');
    const timeslotGrid = document.getElementById('timeslot-grid');
    const summary = document.getElementById('selection-summary');
    const summaryDate = document.getElementById('summary-date');
    const summaryDept = document.getElementById('summary-dept');
    const step2Card = document.getElementById('step2-card');

    // --- 2. FullCalendar 초기화 ---
    document.addEventListener('DOMContentLoaded', function() {
        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'ko',
            headerToolbar: { left: 'prev', center: 'title', right: 'next' },
            events: '${pageContext.request.contextPath}/member/reservation/available-dates',
            validRange: { start: new Date() }, // 'sysdate' (오늘)부터

            // --- ▼▼▼ [수정된 부분] ▼▼▼ ---
            dateClick: function(info) {

                // [수정] 'unavailable-date'(휴무일) 클래스가 *있으면* 클릭을 막습니다.
                if (info.dayEl.classList.contains('unavailable-date')) {
                    alert("휴무일은 선택하실 수 없습니다.");
                    return; // 함수 종료
                }

                // [수정] 'available-date'(근무일)이 아니더라도 (즉, 하얀 날) 클릭을 허용합니다.

                // (1) 날짜 저장
                selectedDate = info.dateStr;
                console.log("Selected Date:", selectedDate);

                // (2) 요약 창 업데이트
                summaryDate.textContent = selectedDate;

                // (3) 로직 실행
                checkAndLoadTimes();
            },
            // --- ▲▲▲ [수정된 부분] ▲▲▲ ---

            eventClassNames: function(arg) {
                return arg.event.extendedProps.className || '';
            }
        });
        calendar.render();
    });

    // --- 3. 진료과 버튼 클릭 이벤트 ---
    deptGrid.addEventListener('click', function(e) {
        const button = e.target.closest('.department-btn');
        if (!button) return;

        // (1) 모든 버튼 'selected' 클래스 제거
        deptGrid.querySelectorAll('.department-btn').forEach(btn => {
            btn.classList.remove('selected');
            btn.querySelector('.check-icon').style.display = 'none';
        });

        // (2) 클릭한 버튼에 'selected' 클래스 추가
        button.classList.add('selected');
        button.querySelector('.check-icon').style.display = 'block';

        // (3) 진료과 ID와 이름 저장
        selectedDeptId = button.dataset.deptId;
        selectedDeptName = button.dataset.deptName;
        console.log("Selected Dept ID:", selectedDeptId);

        // (4) 요약 창 업데이트
        summaryDept.textContent = selectedDeptName;

        // (5) 로직 실행
        checkAndLoadTimes();
    });

    // --- 4. [핵심] 날짜/진료과 모두 선택 시, 시간표 AJAX 로딩 ---
    function checkAndLoadTimes() {
        // (1) 요약창과 Step 2 보이기
        summary.style.display = 'flex';
        step2Card.style.display = 'block';

        // (2) 두 값이 모두 선택되었는지 확인
        if (!selectedDate || !selectedDeptId) {
            timeslotGrid.innerHTML = '<p>날짜와 진료과를 모두 선택해주세요.</p>';
            return;
        }

        console.log(`Loading times for Dept: ${selectedDeptId}, Date: ${selectedDate}`);
        timeslotGrid.innerHTML = '<p>시간표를 불러오는 중...</p>';

        // (3) AJAX (fetch)로 서버에 시간표 요청
        const url = `${pageContext.request.contextPath}/member/reservation/available-times?date=${selectedDate}&departmentId=${selectedDeptId}`;

        fetch(url)
            .then(response => {
                if (!response.ok) {
                    throw new Error('서버 응답 오류 (500)');
                }
                return response.json();
            })
            .then(timeslots => {
                // (4) 시간표 HTML 동적 생성
                renderTimeslots(timeslots);
            })
            .catch(error => {
                console.error('Error fetching timeslots:', error);
                timeslotGrid.innerHTML = '<p>시간표를 불러오는 중 오류가 발생했습니다.</p>';
            });
    }

    // --- 5. 시간표 HTML 렌더링 함수 ---
    function renderTimeslots(timeslots) {
        // (1) 기존 내용 비우기
        timeslotGrid.innerHTML = '';

        // (2) 데이터가 없는 경우
        if (!timeslots || timeslots.length === 0) {
            timeslotGrid.innerHTML = '<p>선택하신 날짜에 예약 가능한 시간이 없습니다.</p>';
            return;
        }

        // (3) 데이터가 있는 경우: HTML 생성
        let html = '';
        for (const slot of timeslots) {
            // (TODO: slot.status 값에 따라 'available'/'unavailable' 클래스 분기)

            html += `
                <button type="button" class="timeslot-card available">
                  <div class="timeslot-header">
                    <div class="timeslot-time">
                      <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-4.svg" alt="" />
                      <span>${slot.time}</span>
                    </div>
                    <img src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-8.svg" alt="예약 가능" class="status-icon" />
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
                </button>
                `;
        }
        timeslotGrid.innerHTML = html;
    }
</script>
</body>
</html>