<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>직원 관리 - 병원 ERP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/erpEmployee/employeeManage.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/erpEmployee/employeeDetail.css" />
    <link href="${pageContext.request.contextPath}/css/dashBoard/erpDashBoard.css" rel="stylesheet"/>
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/erp/sidebar.jsp" />
    <jsp:include page="/WEB-INF/views/common/erp/header.jsp" />

    <main class="employee-main">

        <%-- 1. 페이지 헤더 --%>
        <section class="employee-header">
            <h1 class="employee-title">직원 관리</h1>
            <div class="employee-header-buttons">
<%--                <button class="employee-btn-secondary">--%>
<%--                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none">--%>
<%--                        <path d="M8 3.33337V12.6667M3.33333 8H12.6667" stroke="#0e787c" stroke-width="1.5" stroke-linecap="round"/>--%>
<%--                    </svg>--%>
<%--                    부재 관리--%>
<%--                </button>--%>
                <button class="employee-btn-add">
                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                        <path d="M8 3.33337V12.6667M3.33333 8H12.6667" stroke="white" stroke-width="1.5" stroke-linecap="round"/>
                    </svg>
                    직원 추가
                </button>
            </div>
        </section>

        <%-- 2. 통계 카드 --%>
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

        <%-- 3. 검색 영역 --%>
        <section class="employee-search-section">
            <form class="employee-search-wrapper" action="${pageContext.request.contextPath}/api/employeeManagement/listEmployee">
                <%-- 필터 선택 --%>
                <div class="employee-filter-group">
                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                        <path d="M2 4H14M4 8H12M6 12H10" stroke="#6B7280" stroke-width="1.5" stroke-linecap="round"/>
                    </svg>
                    <select name="condition" class="employee-filter-select">
                        <option value="name" ${condition == 'name' ? 'selected' : ''}>이름</option>
                        <option value="position" ${condition == 'position' ? 'selected' : ''}>직급</option>
                        <option value="department" ${condition == 'department' ? 'selected' : ''}>부서</option>
                    </select>
                </div>

                <%-- 검색 입력 --%>
                <div class="employee-search-box">
                    <svg class="employee-search-icon" width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <circle cx="9" cy="9" r="5.5" stroke="#9CA3AF" stroke-width="1.5"/>
                        <path d="M13 13L16 16" stroke="#9CA3AF" stroke-width="1.5" stroke-linecap="round"/>
                    </svg>
                    <input type="text"
                           class="employee-search-input"
                           name="keyword"
                           value="${keyword}"
                           placeholder="검색어를 입력하세요..." />
                </div>

                <%-- 검색 버튼 --%>
                <button class="employee-btn-search" type="submit">
                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                        <circle cx="8" cy="8" r="5.5" stroke="white" stroke-width="1.5"/>
                        <path d="M12 12L14 14" stroke="white" stroke-width="1.5" stroke-linecap="round"/>
                    </svg>
                    검색
                </button>
            </form>
        </section>

        <%-- 4. 직원 목록 테이블 --%>
        <section class="employee-table-section">
            <div class="employee-table-wrapper">
                <table class="employee-table">
                    <thead>
                    <tr>
                        <th>직원번호</th>
                        <th class="th-name">이름</th>
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

                    <c:choose>
                        <c:when test="${empty list}">
                            <tr>
                                <td colspan="9" style="text-align: center; padding: 40px;">
                                    등록된 직원이 없습니다.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="emp" items="${list}">
                                <tr>
                                    <td>${emp.staffNo}</td>
                                    <td class="employee-name-cell"><div class="employee-avatar">${emp.staffName.charAt(0)}</div>${emp.staffName}</td>
                                    <td>${emp.staffPosition}</td>
                                    <td>${emp.department}</td>
                                    <td>${emp.staffEmail}</td>
                                    <td>${emp.staffPhone}</td>
                                    <td>${emp.scheduleDay}</td>
                                    <td>
                                        <span class="status-badge ${emp.staffStatus == 'Working' ? 'status-active' : 'status-inactive'}">
                                                ${emp.staffStatus == 'Working' ? '재직중' : '휴직중'}
                                        </span>
                                    </td>
                                    <td>
                                        <button class="employee-btn-detail" onclick="detailEmployee(${emp.staffNo})">
                                            상세보기
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>

            <%-- 페이지네이션 --%>
            <div class="employee-pagination">
                <%-- Controller에서 넘겨준 값 사용 --%>
                <p class="employee-pagination-info">
                    총 ${pi.listCount}명 중 ${currentListSize}명 표시
                </p>
                <div class="employee-pagination-buttons">
                    <c:choose>
                        <%-- 일반 목록 조회 (검색 조건 없음) --%>
                        <c:when test="${empty condition}">
                            <%-- 이전 버튼 --%>
                            <c:if test="${pi.currentPage > 1}">
                                <button class="employee-page-btn"
                                        onclick="location.href='${pageContext.request.contextPath}/api/employeeManagement/listEmployee?page=${pi.currentPage - 1}'">
                                    &lt; 이전
                                </button>
                            </c:if>

                            <%-- 페이지 번호 --%>
                            <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
                                <c:choose>
                                    <c:when test="${i == pi.currentPage}">
                                        <button class="employee-page-btn employee-page-active" disabled>
                                                ${i}
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="employee-page-btn"
                                                onclick="location.href='${pageContext.request.contextPath}/api/employeeManagement/listEmployee?page=${i}'">
                                                ${i}
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <%-- 다음 버튼 --%>
                            <c:if test="${pi.currentPage < pi.maxPage}">
                                <button class="employee-page-btn"
                                        onclick="location.href='${pageContext.request.contextPath}/api/employeeManagement/listEmployee?page=${pi.currentPage + 1}'">
                                    다음 &gt;
                                </button>
                            </c:if>
                        </c:when>

                        <%-- 검색 결과 조회 (검색 조건 있음) --%>
                        <c:otherwise>
                            <%-- 이전 버튼 --%>
                            <c:if test="${pi.currentPage > 1}">
                                <button class="employee-page-btn"
                                        onclick="location.href='${pageContext.request.contextPath}/api/employeeManagement/listEmployee?page=${pi.currentPage - 1}&condition=${condition}&keyword=${keyword}'">
                                    &lt; 이전
                                </button>
                            </c:if>

                            <%-- 페이지 번호 --%>
                            <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
                                <c:choose>
                                    <c:when test="${i == pi.currentPage}">
                                        <button class="employee-page-btn employee-page-active" disabled>
                                                ${i}
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="employee-page-btn"
                                                onclick="location.href='${pageContext.request.contextPath}/api/employeeManagement/listEmployee?page=${i}&condition=${condition}&keyword=${keyword}'">
                                                ${i}
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <%-- 다음 버튼 --%>
                            <c:if test="${pi.currentPage < pi.maxPage}">
                                <button class="employee-page-btn"
                                        onclick="location.href='${pageContext.request.contextPath}/api/employeeManagement/listEmployee?page=${pi.currentPage + 1}&condition=${condition}&keyword=${keyword}'">
                                    다음 &gt;
                                </button>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </section>

        <%-- 5. 이번 주 근무표 영역 --%>
        <section class="employee-schedule-section">
            <div class="employee-schedule-header">
                <h2 class="employee-schedule-title">이번 주 근무표</h2>
<%--                <button class="employee-btn-schedule">--%>
<%--                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none">--%>
<%--                        <rect--%>
<%--                                x="3"--%>
<%--                                y="4"--%>
<%--                                width="10"--%>
<%--                                height="9"--%>
<%--                                rx="1"--%>
<%--                                stroke="#6B7280"--%>
<%--                                stroke-width="1.5"--%>
<%--                        />--%>
<%--                        <path--%>
<%--                                d="M3 7H13M6 3V5M10 3V5"--%>
<%--                                stroke="#6B7280"--%>
<%--                                stroke-width="1.5"--%>
<%--                                stroke-linecap="round"--%>
<%--                        />--%>
<%--                    </svg>--%>
<%--                    근무표 관리--%>
<%--                </button>--%>
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
                        <div class="employee-detail-avatar" id="modal-avatar">-</div>
                        <div class="employee-detail-info">
                            <h1 class="employee-detail-name" id="modal-name">직원명</h1>
                            <div class="employee-detail-meta">
                                <span class="employee-detail-position" id="modal-position-dept">직급 • 부서</span>
                                <span class="employee-detail-status employee-detail-status-active" id="modal-status">근무 중</span>
                            </div>
                        </div>
                    </div>
                    <button class="employee-detail-close-btn" aria-label="닫기">
                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                            <path d="M15 5L5 15M5 5L15 15" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                        </svg>
                    </button>
                </header>

                <div class="employee-detail-content">
                    <%-- 기본 정보 --%>
                    <section class="employee-detail-section">
                        <h2 class="employee-detail-section-title">기본 정보</h2>
                        <div class="employee-detail-grid employee-detail-grid-basic">
                            <div class="employee-detail-field">
                                <label>직원번호</label>
                                <span id="modal-staff-no">-</span>
                            </div>
                            <div class="employee-detail-field">
                                <label>이메일</label>
                                <span id="modal-email">-</span>
                            </div>
                            <div class="employee-detail-field">
                                <label>연락처</label>
                                <span id="modal-phone">-</span>
                            </div>
                            <div class="employee-detail-field">
                                <label>입사일</label>
                                <span id="modal-join-date">-</span>
                            </div>
                            <div class="employee-detail-field" style="grid-column: 1 / -1;">
                                <label>근무 일정</label>
                                <div id="modal-schedule" style="margin-top: 12px;">
                                    <%-- JavaScript로 동적 생성 --%>
                                </div>
                            </div>
                        </div>
                    </section>

                    <%-- 근태 현황 --%>
                    <section class="employee-detail-section">
                        <h2 class="employee-detail-section-title">10월 근태 현황</h2>
                        <div class="employee-detail-grid employee-detail-grid-attendance">
                            <div class="employee-detail-stat employee-detail-stat-attendance">
                                <label>출근일</label>
                                <strong id="modal-attendance-days">0일</strong>
                            </div>
                            <div class="employee-detail-stat employee-detail-stat-late">
                                <label>지각</label>
                                <strong id="modal-late-count">0회</strong>
                            </div>
                            <div class="employee-detail-stat employee-detail-stat-absent">
                                <label>결근</label>
                                <strong id="modal-absent-count">0일</strong>
                            </div>
                            <div class="employee-detail-stat employee-detail-stat-vacation">
                                <label>휴가</label>
                                <strong id="modal-vacation-days">0일</strong>
                            </div>
                        </div>
                    </section>

                    <%-- 자격증 및 면허 --%>
                    <section class="employee-detail-section">
                        <h2 class="employee-detail-section-title">자격증 및 면허</h2>
                        <ul class="employee-detail-license-list" id="modal-licenses">
                            <li class="employee-detail-license-item">자격증 정보 없음</li>
                        </ul>
                    </section>

                    <%-- 연차 정보 --%>
                    <section class="employee-detail-section">
                        <h2 class="employee-detail-section-title">연차 정보</h2>
                        <div class="employee-detail-vacation">
                            <div class="employee-detail-vacation-info">
                                <span class="employee-detail-vacation-used" id="modal-vacation-info">총 0일 중 0일 사용</span>
                                <span class="employee-detail-vacation-remain" id="modal-vacation-remain">잔여 0일</span>
                            </div>
                            <div class="employee-detail-vacation-bar">
                                <div class="employee-detail-vacation-progress" id="modal-vacation-progress" style="width: 0%"></div>
                            </div>
                        </div>
                    </section>
                </div>

                <footer class="employee-detail-footer">
                    <button class="employee-detail-btn employee-detail-btn-secondary modal-close">닫기</button>
                    <div class="employee-detail-actions">
                        <button class="employee-detail-btn employee-detail-btn-outline">정보 수정</button>
                    </div>
                </footer>
            </main>
        </div>
    </div>
    <script>
      document.querySelectorAll(".employee-btn-detail").forEach((btn) => {
        btn.addEventListener("click", () => {
          document.getElementById("employeeModal").classList.add("active");
        });
      });
    </script>

    <script src="${pageContext.request.contextPath}/js/erp/employee/erpEmployeePolling.js"></script>
    <script src="${pageContext.request.contextPath}/js/erp/employee/erpEmployeeDetail.js"></script>

</body>
</html>
