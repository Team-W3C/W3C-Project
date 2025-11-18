<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>병원 ERP 시스템 - 예약관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/erpPatientReservation/erpPatientReservation.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/erpPatientReservation/addPatient.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/erpPatientReservation/reservation_manage.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>

<body>
    <div class="app">
        <!-- Header Include -->
        <jsp:include page="/WEB-INF/views/common/erp/header.jsp"/>

        <!-- sidebar Include -->
        <jsp:include page="/WEB-INF/views/common/erp/sidebar.jsp"/>

        <!-- Main Content -->
        <main class="reservation">
            <div class="reservation__header">
                <h1>예약 관리</h1>
                <button class="btn-primary-add">
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

                    <div class="calendar-wrapper">
                        <div id="calendar"></div>
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

    <!-- 모달 배경 오버레이 -->
    <div class="modal-overlay" id="modalOverlay">
        <!-- 모달 컨테이너 -->
        <div class="modal-container">
            <!-- 헤더 -->
            <div class="modal-header">
                <h3 class="modal-title">예약 상세 정보</h3>
                <button class="close-button" id="closeButton" aria-label="닫기">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <path d="M5 5L15 15" stroke="#6B7280" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M15 5L5 15" stroke="#6B7280" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </button>
            </div>

            <!-- 컨텐츠 -->
            <div class="modal-content">
                <!-- 환자 정보 -->
                <section class="info-section">
                    <h4 class="section-title">환자 정보</h4>
                    <div class="info-grid">
                        <div class="info-row">
                            <div class="info-label">환자명</div>
                            <div class="info-value">김민수</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">환자번호</div>
                            <div class="info-value">P001</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">나이 / 성별</div>
                            <div class="info-value">45세 / 남</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">연락처</div>
                            <div class="info-value">010-1234-5678</div>
                        </div>
                    </div>
                </section>

                <!-- 예약 정보 -->
                <section class="info-section bordered">
                    <h4 class="section-title">예약 정보</h4>
                    <div class="info-grid">
                        <div class="info-row">
                            <div class="info-label">진료과</div>
                            <div class="info-value">정형외과</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">담당의</div>
                            <div class="info-value">이준호</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">예약 날짜</div>
                            <div class="info-value">2025-10-28</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">예약 시간</div>
                            <div class="info-value">14:00</div>
                        </div>
                        <div class="info-row empty"></div>
                        <div class="info-row">
                            <div class="info-label">증상</div>
                            <div class="info-value">허리 통증</div>
                        </div>
                    </div>
                </section>

                <!-- 메모 -->
                <section class="info-section bordered">
                    <h4 class="section-title">메모</h4>
                    <textarea
                            class="memo-textarea"
                            placeholder="예약 관련 메모를 입력하세요..."
                            rows="4"

                    ></textarea>
                </section>
            </div>

            <!-- 버튼 영역 -->
            <div class="modal-footer">
                <button class="btn btn-tertiary" id="closeFooterButton">닫기</button>
                <button class="btn btn-primary">예약 취소</button>
            </div>
        </div>
    </div>

    <!-- Modal Backdrop -->
    <div class="modal-backdrop" id="modalBackdrop">
        <!-- Modal Container -->
        <div class="modal-container">
            <!-- Header -->
            <div class="modal-header">
                <h3 class="modal-title">새 예약 등록</h3>
                <button class="close-button" id="closeButton">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <path d="M15 5L5 15" stroke="#6B7280" stroke-width="1.67" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M5 5L15 15" stroke="#6B7280" stroke-width="1.67" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </button>
            </div>

            <!-- Form Content -->
            <div class="modal-body">
                <!-- 환자 선택 -->
                <div class="form-group">
                    <label class="form-label">
                        환자 선택
                        <span class="required">*</span>
                    </label>
                    <div class="search-input-wrapper">
                        <svg class="search-icon" width="20" height="20" viewBox="0 0 20 20" fill="none">
                            <path d="M17.5 17.5L13.8833 13.8833" stroke="#6B7280" stroke-width="1.67" stroke-linecap="round" stroke-linejoin="round"/>
                            <circle cx="9.16667" cy="9.16667" r="6.66667" stroke="#6B7280" stroke-width="1.67" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <input type="text" class="search-input" placeholder="환자명, 환자번호, 연락처로 검색...">
                    </div>
                </div>

                <!-- 증상 -->
                <div class="form-group">
                    <label class="form-label">
                        증상
                        <span class="required">*</span>
                    </label>
                    <input type="text" class="text-input" placeholder="증상을 입력하세요">
                </div>

                <!-- 진료과 & 담당의 -->
                <div class="form-row">
                    <div class="form-group half">
                        <label class="form-label">
                            진료과
                            <span class="required">*</span>
                        </label>
                        <select class="select-input" id="departmentSelect">
                            <option value="">진료과 선택</option>
                            <option value="정형외과">정형외과</option>
                            <option value="내과">내과</option>
                            <option value="신경외과">신경외과</option>
                            <option value="피부과">피부과</option>
                            <option value="소화기내과">소화기내과</option>
                            <option value="이비인후과">이비인후과</option>
                            <option value="종합검진">종합검진</option>
                        </select>
                    </div>
                    <div class="form-group half">
                        <label class="form-label">
                            담당의
                            <span class="required">*</span>
                        </label>
                        <select class="select-input disabled" id="doctorSelect" disabled>
                            <option value="">담당의 선택</option>
                        </select>
                    </div>
                </div>

                <!-- 예약 날짜 & 예약 시간 -->
                <div class="form-row">
                    <!-- 예약 날짜 -->
                    <div class="form-group half">
                        <label class="form-label">
                            예약 날짜
                            <span class="required">*</span>
                        </label>
                        <div class="calendar-container">
                            <div class="calendar-header">
                            </div>
                            <div id="modalCalendar"></div>
                        </div>
                    </div>

                    <!-- 예약 시간 -->
                    <div class="form-group half">
                        <label class="form-label">
                            예약 시간
                        </label>
                        <div class="time-container">
                            <div class="selected-times">
                                <div class="selected-label">선택된 시간</div>
                                <div class="selected-badges" id="selectedBadges">
                                </div>
                            </div>
                            <div class="form-group half">
                                <label class="form-label">
                                    예약 시간
                                    <span class="required">*</span>
                                    <span class="selected-count" id="selectedCount">(0개 선택됨)</span>
                                </label>
                                <div class="time-container">
                                    <div class="selected-times">
                                        <div class="selected-label">선택된 시간</div>
                                        <div class="selected-badges" id="selectedBadges">
                                        </div>
                                    </div>
                                    <div class="time-slots" id="timeSlots">
                                        <button class="time-slot" data-time="09:00">09:00</button>
                                        <button class="time-slot" data-time="10:00">10:00</button>
                                        <button class="time-slot" data-time="11:00">11:00</button>
                                        <button class="time-slot" data-time="12:00">12:00</button>
                                        <button class="time-slot" data-time="13:00">13:00</button>
                                        <button class="time-slot" data-time="14:00">14:00</button>
                                        <button class="time-slot" data-time="15:00">15:00</button>
                                        <button class="time-slot" data-time="16:00">16:00</button>
                                        <button class="time-slot" data-time="17:00">17:00</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 사용 시설 -->
<%--                <div class="form-group">--%>
<%--                    <label class="form-label">사용 시설 (선택사항)</label>--%>
<%--                    <select class="select-input" id="facilitySelect">--%>
<%--                        <option value="">시설 선택 안 함</option>--%>
<%--                        <option value="MRI-01">MRI-01</option>--%>
<%--                        <option value="MRI-02">MRI-02</option>--%>
<%--                        <option value="CT-01">CT-01</option>--%>
<%--                        <option value="CT-02">CT-02</option>--%>
<%--                        <option value="X-Ray-01">X-Ray-01</option>--%>
<%--                        <option value="X-Ray-02">X-Ray-02</option>--%>
<%--                        <option value="초음파-01">초음파-01</option>--%>
<%--                        <option value="초음파-02">초음파-02</option>--%>
<%--                        <option value="내시경-01">내시경-01</option>--%>
<%--                        <option value="내시경-02">내시경-02</option>--%>
<%--                    </select>--%>
<%--                </div>--%>

                <!-- 메모 -->
<%--                <div class="form-group">--%>
<%--                    <label class="form-label">메모</label>--%>
<%--                    <textarea class="textarea-input" placeholder="예약 관련 메모를 입력하세요..." rows="4"></textarea>--%>
<%--                </div>--%>
            </div>

            <!-- Footer -->
            <div class="modal-footer">
                <button class="button button-secondary" id="cancelButton">취소</button>
                <button class="button button-primary" id="submitButton">예약 등록</button>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/js/index.global.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/erp/patientReservation/reservation.js"></script>
    <script src="${pageContext.request.contextPath}/js/erp/patientReservation/addReservation.js"></script>
</body>
</html>