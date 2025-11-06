<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>병원 ERP 시스템 - 예약관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/erpPatientReservation/common.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="app">
        <!-- Header Include -->
        <jsp:include page="/WEB-INF/views/common/erp/header.jsp" />

        <!-- sidebar Include -->
        <jsp:include page="/WEB-INF/views/common/erp/sidebar.jsp" />

        <!-- Main Content -->
        <main class="reservation">
            <div class="reservation__header">
                <h1>예약 관리</h1>
                <button class="btn-primary">
                    <svg viewBox="0 0 16 16" fill="none">
                        <path d="M3.33333 8H12.6667" stroke="white" stroke-width="1.33333" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M8 3.33333V12.6667" stroke="white" stroke-width="1.33333" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    예약 등록
                </button>
            </div>

            <div class="reservation__grid">
                <!-- Calendar Section -->
                <section class="calendar-card">
                    <div class="card-header">
                        <svg class="card-header__icon" viewBox="0 0 20 20" fill="none">
                            <path d="M6.66667 1.66667V5" stroke="#0E787C" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M13.3333 1.66667V5" stroke="#0E787C" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M15.8333 3.33333H4.16667C3.24619 3.33333 2.5 4.07953 2.5 5V16.6667C2.5 17.5871 3.24619 18.3333 4.16667 18.3333H15.8333C16.7538 18.3333 17.5 17.5871 17.5 16.6667V5C17.5 4.07953 16.7538 3.33333 15.8333 3.33333Z" stroke="#0E787C" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M2.5 8.33333H17.5" stroke="#0E787C" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <h3>날짜 선택</h3>
                    </div>

                    <div class="calendar">
                        <div class="calendar__header">
                            <button class="calendar__nav">‹</button>
                            <span class="calendar__month">October 2025</span>
                            <button class="calendar__nav">›</button>
                        </div>
                        
                        <div class="calendar__grid">
                            <div class="calendar__day-label">Su</div>
                            <div class="calendar__day-label">Mo</div>
                            <div class="calendar__day-label">Tu</div>
                            <div class="calendar__day-label">We</div>
                            <div class="calendar__day-label">Th</div>
                            <div class="calendar__day-label">Fr</div>
                            <div class="calendar__day-label">Sa</div>
                            
                            <button class="calendar__day calendar__day--inactive">28</button>
                            <button class="calendar__day calendar__day--inactive">29</button>
                            <button class="calendar__day calendar__day--inactive">30</button>
                            <button class="calendar__day">1</button>
                            <button class="calendar__day">2</button>
                            <button class="calendar__day">3</button>
                            <button class="calendar__day">4</button>
                            <button class="calendar__day">5</button>
                            <button class="calendar__day">6</button>
                            <button class="calendar__day">7</button>
                            <button class="calendar__day">8</button>
                            <button class="calendar__day">9</button>
                            <button class="calendar__day">10</button>
                            <button class="calendar__day">11</button>
                            <button class="calendar__day">12</button>
                            <button class="calendar__day">13</button>
                            <button class="calendar__day">14</button>
                            <button class="calendar__day">15</button>
                            <button class="calendar__day">16</button>
                            <button class="calendar__day">17</button>
                            <button class="calendar__day">18</button>
                            <button class="calendar__day">19</button>
                            <button class="calendar__day">20</button>
                            <button class="calendar__day">21</button>
                            <button class="calendar__day">22</button>
                            <button class="calendar__day">23</button>
                            <button class="calendar__day">24</button>
                            <button class="calendar__day">25</button>
                            <button class="calendar__day">26</button>
                            <button class="calendar__day">27</button>
                            <button class="calendar__day calendar__day--active">28</button>
                            <button class="calendar__day calendar__day--today">29</button>
                            <button class="calendar__day">30</button>
                            <button class="calendar__day">31</button>
                            <button class="calendar__day calendar__day--inactive">1</button>
                        </div>
                    </div>

                    <div class="calendar__selected">
                        <p class="calendar__selected-label">선택된 날짜</p>
                        <p class="calendar__selected-value">2025년 10월 28일</p>
                    </div>
                </section>

                <!-- Search and Stats Section -->
                <section class="search-stats-card">
                    <div class="search-bar">
                        <svg class="search-bar__icon" viewBox="0 0 20 20" fill="none">
                            <path d="M17.5 17.5L13.8833 13.8833" stroke="#6B7280" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M9.16667 15.8333C12.8486 15.8333 15.8333 12.8486 15.8333 9.16667C15.8333 5.48477 12.8486 2.5 9.16667 2.5C5.48477 2.5 2.5 5.48477 2.5 9.16667C2.5 12.8486 5.48477 15.8333 9.16667 15.8333Z" stroke="#6B7280" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <input type="text" placeholder="환자명 또는 환자번호로 검색..." class="search-bar__input">
                    </div>

                    <div class="filter-row">
                        <select class="filter-select">
                            <option>전체 진료과</option>
                        </select>
                        <select class="filter-select">
                            <option>전체 상태</option>
                        </select>
                    </div>

                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-card__header">
                                <div class="stat-card__icon stat-card__icon--waiting">
                                    <svg viewBox="0 0 20 20" fill="none">
                                        <path d="M10 5V10L13.3333 11.6667" stroke="#0E787C" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                                        <path d="M10 18.3333C14.6024 18.3333 18.3333 14.6024 18.3333 10C18.3333 5.39763 14.6024 1.66667 10 1.66667C5.39763 1.66667 1.66667 5.39763 1.66667 10C1.66667 14.6024 5.39763 18.3333 10 18.3333Z" stroke="#0E787C" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                </div>
                                <span>예약 대기</span>
                            </div>
                            <div class="stat-card__number">
                                <span class="stat-card__value">4</span>
                                <span class="stat-card__unit">건</span>
                            </div>
                        </div>

                        <div class="stat-card">
                            <div class="stat-card__header">
                                <div class="stat-card__icon stat-card__icon--progress">
                                    <svg viewBox="0 0 20 20" fill="none">
                                        <path d="M4.16667 10H15.8333" stroke="#0E787C" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                                        <path d="M10 4.16667L15.8333 10L10 15.8333" stroke="#0E787C" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                </div>
                                <span>진행 중</span>
                            </div>
                            <div class="stat-card__number">
                                <span class="stat-card__value">3</span>
                                <span class="stat-card__unit">건</span>
                            </div>
                        </div>

                        <div class="stat-card">
                            <div class="stat-card__header">
                                <div class="stat-card__icon stat-card__icon--complete">
                                    <svg viewBox="0 0 20 20" fill="none">
                                        <path d="M18.1675 8.33332C18.5481 10.2011 18.2768 12.1428 17.399 13.8348C16.5212 15.5268 15.0899 16.8667 13.3437 17.6311C11.5976 18.3955 9.64217 18.5381 7.80356 18.0353C5.96496 17.5325 4.35431 16.4145 3.24021 14.8678C2.12612 13.3212 1.57592 11.4394 1.68137 9.53615C1.78682 7.63294 2.54155 5.8234 3.81969 4.4093C5.09783 2.9952 6.82213 2.06202 8.70504 1.76537C10.5879 1.46872 12.5156 1.82654 14.1666 2.77916" stroke="#0E787C" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                                        <path d="M7.5 9.16667L10 11.6667L18.3333 3.33333" stroke="#0E787C" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                </div>
                                <span>완료</span>
                            </div>
                            <div class="stat-card__number">
                                <span class="stat-card__value">3</span>
                                <span class="stat-card__unit">건</span>
                            </div>
                        </div>
                    </div>
                </section>
            </div>

            <!-- Reservation Lists -->
            <div class="reservation__columns">
                <!-- Waiting List -->
                <div class="reservation-column">
                    <div class="reservation-column__header reservation-column__header--waiting">
                        <h3>예약 대기</h3>
                        <span class="count-badge">5</span>
                    </div>
                    <div class="reservation-column__list" id="waitingList"></div>
                </div>

                <!-- In Progress List -->
                <div class="reservation-column">
                    <div class="reservation-column__header reservation-column__header--progress">
                        <h3>진행 중</h3>
                        <span class="count-badge count-badge--progress">2</span>
                    </div>
                    <div class="reservation-column__list" id="progressList"></div>
                </div>

                <!-- Completed List -->
                <div class="reservation-column">
                    <div class="reservation-column__header reservation-column__header--complete">
                        <h3>완료</h3>
                        <span class="count-badge count-badge--complete">3</span>
                    </div>
                    <div class="reservation-column__list" id="completeList"></div>
                </div>
            </div>
        </main>
    </div>
    <script src="${pageContext.request.contextPath}/js/erp/patientReservation/reservation.js"></script>
</body>
</html>