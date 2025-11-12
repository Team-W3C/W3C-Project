<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>직원 관리 - 병원 ERP</title>
    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/erpEmployee/employeeManage.css"
    />
    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/erpEmployee/employeeDetail.css"
    />
    <link href="${pageContext.request.contextPath}/css/dashBoard/erpDashBoard.css" rel="stylesheet"/>
</head>
<body>

    <%-- ERP 공통 컴포넌트 --%>
    <jsp:include page="/WEB-INF/views/common/erp/sidebar.jsp" />
    <jsp:include page="/WEB-INF/views/common/erp/header.jsp" />

    <main class="employee-main">

        <%-- 1. 페이지 헤더 및 버튼 영역 --%>
        <section class="employee-header">
            <h1 class="employee-title">직원 관리</h1>
            <div class="employee-header-buttons">
                <button class="employee-btn-secondary">
                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                        <path
                                d="M8 3.33337V12.6667M3.33333 8H12.6667"
                                stroke="#0e787c"
                                stroke-width="1.5"
                                stroke-linecap="round"
                        />
                    </svg>
                    부재 관리
                </button>
                <button class="employee-btn-add">
                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                        <path
                                d="M8 3.33337V12.6667M3.33333 8H12.6667"
                                stroke="white"
                                stroke-width="1.5"
                                stroke-linecap="round"
                        />
                    </svg>
                    직원 추가
                </button>
            </div>
        </section>

        <%-- 2. 통계 카드 영역 --%>
            <section class="employee-stats">
                <div class="employee-stat-card">
                    <p class="employee-stat-label">전체 직원</p>
                    <p class="employee-stat-value" id="total-count-display">${totalCount}명</p>
                </div>
                <div class="employee-stat-card">
                    <p class="employee-stat-label">근무 중</p>
                    <p class="employee-stat-value" id="work-count-display">${workCount}명</p>
                </div>
                <div class="employee-stat-card">
                    <p class="employee-stat-label">휴가 중</p>
                    <p class="employee-stat-value" id="vacation-count-display">${vacationCount}명</p>
                </div>
                <div class="employee-stat-card">
                    <p class="employee-stat-label">퇴사</p>
                    <p class="employee-stat-value" id="resign-count-display">${resignCount}명</p>
                </div>
            </section>

        <%-- 3. 검색 및 필터 영역 --%>
        <section class="employee-search-section">
            <div class="employee-search-wrapper">
                <div class="employee-search-box">
                    <svg
                            class="employee-search-icon"
                            width="20"
                            height="20"
                            viewBox="0 0 20 20"
                            fill="none"
                    >
                        <circle
                                cx="9"
                                cy="9"
                                r="5.5"
                                stroke="#9CA3AF"
                                stroke-width="1.5"
                        />
                        <path
                                d="M13 13L16 16"
                                stroke="#9CA3AF"
                                stroke-width="1.5"
                                stroke-linecap="round"
                        />
                    </svg>
                    <input
                            type="text"
                            class="employee-search-input"
                            placeholder="직원명, 직급, 부서명으로 검색..."
                    />
                </div>

                <button class="employee-btn-search" onclick="searchStaff()">검색</button>
                <button class="employee-btn-filter">
                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                        <path
                                d="M2 4H14M4 8H12M6 12H10"
                                stroke="#6B7280"
                                stroke-width="1.5"
                                stroke-linecap="round"
                        />
                    </svg>
                    필터
                </button>
            </div>
        </section>

        <%-- 4. 직원 목록 테이블 영역 --%>
        <section class="employee-table-section">
            <div class="employee-table-wrapper">
                <table class="employee-table">
                    <thead>
                    <tr>
                        <th>직원번호</th>
                        <th>이름</th>
                        <th>직급</th>
                        <th>부서</th>
                        <th>이메일</th>
                        <th>연락처</th>
                        <th>근무 일정</th>
                        <th>상태</th>
                        <th>작업</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%-- 직원 데이터 행 1~5 (동적 생성 필요) --%>
                    <tr>
                        <td>S001</td>
                        <td>
                            <div class="employee-name-cell">
                                <div class="employee-avatar">이</div>
                                <span>이은호</span>
                            </div>
                        </td>
                        <td>역사</td>
                        <td>안경원과</td>
                        <td>junho.lee@hospital.com</td>
                        <td>010-1111-2222</td>
                        <td>월~금<br />09:00-18:00</td>
                        <td>
                            <span class="employee-badge employee-badge-working">근무 중</span>
                        </td>
                        <td>
                            <button class="employee-btn-detail">상세보기</button>
                        </td>
                    </tr>
                    <tr>
                        <td>S002</td>
                        <td>
                            <div class="employee-name-cell">
                                <div class="employee-avatar">김</div>
                                <span>김서연</span>
                            </div>
                        </td>
                        <td>역사</td>
                        <td>내과</td>
                        <td>seoyeon.kim@hospital.com</td>
                        <td>010-2222-3333</td>
                        <td>월~토<br />09:00-17:00</td>
                        <td>
                            <span class="employee-badge employee-badge-working">근무 중</span>
                        </td>
                        <td>
                            <button class="employee-btn-detail">상세보기</button>
                        </td>
                    </tr>
                    <tr>
                        <td>S003</td>
                        <td>
                            <div class="employee-name-cell">
                                <div class="employee-avatar">박</div>
                                <span>박민준</span>
                            </div>
                        </td>
                        <td>역사</td>
                        <td>안경원과</td>
                        <td>minjun.park@hospital.com</td>
                        <td>010-3333-4444</td>
                        <td>화~금<br />10:00-19:00</td>
                        <td>
                            <span class="employee-badge employee-badge-vacation">휴가 중</span>
                        </td>
                        <td>
                            <button class="employee-btn-detail">상세보기</button>
                        </td>
                    </tr>
                    <tr>
                        <td>S004</td>
                        <td>
                            <div class="employee-name-cell">
                                <div class="employee-avatar">최</div>
                                <span>최수진</span>
                            </div>
                        </td>
                        <td>역사</td>
                        <td>피부과</td>
                        <td>sujin.choi@hospital.com</td>
                        <td>010-4444-5555</td>
                        <td>월~금<br />09:00-18:00</td>
                        <td>
                            <span class="employee-badge employee-badge-working">근무 중</span>
                        </td>
                        <td>
                            <button class="employee-btn-detail">상세보기</button>
                        </td>
                    </tr>
                    <tr>
                        <td>S005</td>
                        <td>
                            <div class="employee-name-cell">
                                <div class="employee-avatar">정</div>
                                <span>정은지</span>
                            </div>
                        </td>
                        <td>간호사</td>
                        <td>응급실</td>
                        <td>eunji.jung@hospital.com</td>
                        <td>010-5555-6666</td>
                        <td>3교대 근무</td>
                        <td>
                            <span class="employee-badge employee-badge-working">근무 중</span>
                        </td>
                        <td>
                            <button class="employee-btn-detail">상세보기</button>
                        </td>
                    </tr>
                    <%-- // 직원 데이터 행 끝 --%>
                    </tbody>
                </table>
            </div>

            <%-- 페이지네이션 --%>
            <div class="employee-pagination">
                <p class="employee-pagination-info">총 ${totalCount}명 중 5명 표시</p>
                <div class="employee-pagination-buttons">
                    <button class="employee-page-btn">이전</button>
                    <button class="employee-page-btn employee-page-active">1</button>
                    <button class="employee-page-btn">2</button>
                    <button class="employee-page-btn">3</button>
                    <button class="employee-page-btn">다음</button>
                </div>
            </div>
        </section>

        <%-- 5. 이번 주 근무표 영역 --%>
        <section class="employee-schedule-section">
            <div class="employee-schedule-header">
                <h2 class="employee-schedule-title">이번 주 근무표</h2>
                <button class="employee-btn-schedule">
                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                        <rect
                                x="3"
                                y="4"
                                width="10"
                                height="9"
                                rx="1"
                                stroke="#6B7280"
                                stroke-width="1.5"
                        />
                        <path
                                d="M3 7H13M6 3V5M10 3V5"
                                stroke="#6B7280"
                                stroke-width="1.5"
                                stroke-linecap="round"
                        />
                    </svg>
                    근무표 관리
                </button>
            </div>

            <div class="employee-schedule-grid">
                <div class="employee-schedule-card">
                    <div class="employee-schedule-day">월<br />26일</div>
                    <div class="employee-schedule-info">
                        <p>주간: 12명</p>
                        <p>야간: 8명</p>
                    </div>
                </div>
                <div class="employee-schedule-card">
                    <div class="employee-schedule-day">화<br />27일</div>
                    <div class="employee-schedule-info">
                        <p>주간: 12명</p>
                        <p>야간: 8명</p>
                    </div>
                </div>
                <div class="employee-schedule-card">
                    <div class="employee-schedule-day">수<br />28일</div>
                    <div class="employee-schedule-info">
                        <p>주간: 12명</p>
                        <p>야간: 8명</p>
                    </div>
                </div>
                <div class="employee-schedule-card">
                    <div class="employee-schedule-day">목<br />29일</div>
                    <div class="employee-schedule-info">
                        <p>주간: 12명</p>
                        <p>야간: 8명</p>
                    </div>
                </div>
                <div class="employee-schedule-card">
                    <div class="employee-schedule-day">금<br />30일</div>
                    <div class="employee-schedule-info">
                        <p>주간: 10명</p>
                        <p>야간: 8명</p>
                    </div>
                </div>
                <div class="employee-schedule-card">
                    <div class="employee-schedule-day">토<br />25일</div>
                    <div class="employee-schedule-info">
                        <p>주간: 12명</p>
                        <p>야간: 8명</p>
                    </div>
                </div>
                <div class="employee-schedule-card">
                    <div class="employee-schedule-day">일<br />26일</div>
                    <div class="employee-schedule-info">
                        <p>주간: 12명</p>
                        <p>야간: 8명</p>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <%-- 6. 직원 관리 상세 모달 영역 --%>
    <div id="employeeModal" class="modal-overlay">
        <div class="modal-content">
            <main class="employee-detail">
                <header class="employee-detail-header">
                    <div class="employee-detail-profile">
                        <div class="employee-detail-avatar">이</div>
                        <div class="employee-detail-info">
                            <h1 class="employee-detail-name">이준호</h1>
                            <div class="employee-detail-meta">
                                <span class="employee-detail-position">의사 • 정형외과</span>
                                <span
                                        class="employee-detail-status employee-detail-status-active"
                                >근무 중</span
                                >
                            </div>
                        </div>
                    </div>
                    <button class="employee-detail-close-btn" aria-label="닫기">
                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                            <path
                                    d="M15 5L5 15M5 5L15 15"
                                    stroke="currentColor"
                                    stroke-width="2"
                                    stroke-linecap="round"
                            />
                        </svg>
                    </button>
                </header>

                <%-- 모달 콘텐츠 --%>
                <div class="employee-detail-content">
                    <section class="employee-detail-section">
                        <h2 class="employee-detail-section-title">기본 정보</h2>
                        <div class="employee-detail-grid employee-detail-grid-basic">
                            <div class="employee-detail-field">
                                <label>직원번호</label>
                                <span>S001</span>
                            </div>
                            <div class="employee-detail-field">
                                <label>이메일</label>
                                <span>junho.lee@hospital.com</span>
                            </div>
                            <div class="employee-detail-field">
                                <label>연락처</label>
                                <span>010-1111-2222</span>
                            </div>
                            <div class="employee-detail-field">
                                <label>입사일</label>
                                <span>2018.03.15</span>
                            </div>
                            <div class="employee-detail-field employee-detail-field-wide">
                                <label>근무 일정</label>
                                <span>월-금 09:00-18:00</span>
                            </div>
                        </div>
                    </section>

                    <section class="employee-detail-section">
                        <h2 class="employee-detail-section-title">10월 근태 현황</h2>
                        <div class="employee-detail-grid employee-detail-grid-attendance">
                            <div
                                    class="employee-detail-stat employee-detail-stat-attendance"
                            >
                                <label>출근일</label><strong>22일</strong>
                            </div>
                            <div class="employee-detail-stat employee-detail-stat-late">
                                <label>지각</label><strong>0회</strong>
                            </div>
                            <div class="employee-detail-stat employee-detail-stat-absent">
                                <label>결근</label><strong>0일</strong>
                            </div>
                            <div class="employee-detail-stat employee-detail-stat-vacation">
                                <label>휴가</label><strong>1일</strong>
                            </div>
                        </div>
                    </section>
                    <section class="employee-detail-section">
                        <h2 class="employe-detail-section-title">자격증 및 면허</h2>
                        <ul class="employee-detail-license-list">
                            <li class="employee-detail-license-item">
                                <span class="employee-detail-license-dot"></span>
                                의사면허
                            </li>
                            <li class="employee-detail-license-item">
                                <span class="employee-detail-license-dot"></span>
                                정형외과 전문의
                            </li>
                            <li class="employee-detail-license-item">
                                <span class="employee-detail-license-dot"></span>
                                척추 전문의
                            </li>
                        </ul>
                    </section>

                    <section class="employe-detail-section">
                        <h2 class="title">연차 정보</h2>
                        <div class="employee-detail-vacation">
                            <div class="employee-detail-vacation-info">
                    <span class="employee-detail-vacation-used"
                    >총 15일 중 3일 사용</span
                    >
                                <span class="employee-detail-vacation-remain">잔여 12일</span>
                            </div>
                            <div class="employee-detail-vacation-bar">
                                <div
                                        class="employee-detail-vacation-progress"
                                        style="width: 20%"
                                ></div>
                            </div>
                        </div>
                    </section>
                </div>

                <%-- 모달 푸터 --%>
                <footer class="employee-detail-footer">
                    <button
                            class="employee-detail-btn employee-detail-btn-secondary modal-close"
                    >
                        닫기
                    </button>
                    <div class="employee-detail-actions">
                        <button class="employee-detail-btn employee-detail-btn-outline">
                            정보 수정
                        </button>
                        <button class="employee-detail-btn employee-detail-btn-primary">
                            근무표 확인
                        </button>
                    </div>
                </footer>
            </main>
        </div>
    </div>

    <%-- 7. JavaScript (모달 제어) --%>
    <script>
        // 모달 열기 함수
        document.querySelectorAll(".employee-btn-detail").forEach((btn) => {
            btn.addEventListener("click", () => {
                document.getElementById("employeeModal").classList.add("active");
            });
        });

        // 모달 닫기 함수 (X 버튼, 닫기 버튼)
        document
            .querySelectorAll(".employee-detail-close-btn, .modal-close")
            .forEach((btn) => {
                btn.addEventListener("click", () => {
                    document.getElementById("employeeModal").classList.remove("active");
                });
            });

        // 모달 밖 (오버레이) 클릭 시 닫기
        document
            .getElementById("employeeModal")
            .addEventListener("click", (e) => {
                // 클릭된 요소가 정확히 오버레이 클래스를 포함할 때만 닫기
                if (e.target.classList.contains("modal-overlay")) {
                    e.target.classList.remove("active");
                }
            });

    </script>

    <!-- script -->
    <script src="${pageContext.request.contextPath}/js/erp/employee/erpEmployeePolling.js"></script>

</body>
</html>