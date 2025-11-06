<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--
    탭 제어:
    - ?tab=status (기본값) : 나의 근태 현황
    - ?tab=list           : 나의 신청 내역
    - ?tab=admin          : 승인 관리 (관리자 전용)
--%>
<c:set var="currentTab" value="${empty param.tab ? 'status' : param.tab}"/>

<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Arial&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashBoard/erpDashBoard.css">

    <%-- 기존 근태관리 CSS --%>
    <link href="${pageContext.request.contextPath}/css/attendance/attendance.css" rel="stylesheet"/>

    <%-- [!!] 추가: 관리자 승인 탭 전용 CSS (이 파일이 CSS 폴더 내에 있어야 함) --%>
    <link href="${pageContext.request.contextPath}/css/attendance/attendance-admin-detail.css" rel="stylesheet"/>

    <title>근태 관리</title>
</head>
<body>
<!-- Header Include -->
<jsp:include page="/WEB-INF/views/common/erp/header.jsp"/>

<!-- sidebar Include -->
<jsp:include page="/WEB-INF/views/common/erp/sidebar.jsp"/>
<main class="attendance-container">

    <div class="page-header">
        <h1>근태 관리</h1>
        <div class="page-actions">
            <button type="button" class="btn btn-secondary">
                <span>퇴근하기</span>
            </button>
            <button type="button" class="btn btn-outline">
                <span>신청서 작성</span>
            </button>
        </div>
    </div>

    <section class="attendance-widget">
        <ul class="widget-stats-list">
            <li>
                <span class="label">현재 시각</span>
                <strong class="value">오후 03:27</strong>
            </li>
            <li>
                <span class="label">출근 시각</span>
                <strong class="value">08:45</strong>
            </li>
            <li>
                <span class="label">퇴근 시각</span>
                <strong class="value">18:05</strong>
            </li>
            <li>
                <span class="label">근무 시간</span>
                <strong class="value">8.3h</strong>
            </li>
        </ul>
        <span class="badge status-normal">정상</span>
    </section>

    <div class="tab-container">
        <nav class="tab-nav">
            <ul>
                <li class="${currentTab == 'status' ? 'active' : ''}">
                    <a href="?tab=status">나의 근태 현황</a>
                </li>
                <li class="${currentTab == 'list' ? 'active' : ''}">
                    <a href="?tab=list">나의 신청 내역</a>
                </li>

                <%-- [!!] 추가: 관리자 전용 '승인 관리' 탭 --%>
                <%-- [!!] test="" 안의 조건은 실제 관리자 확인 로직으로 변경해주세요 --%>
                <%--                <c:if test="${loginUser.auth == 'ADMIN'}">--%>
                <li class="${currentTab == 'admin' ? 'active' : ''}">
                    <a href="?tab=admin">
                        승인 관리
                        <%-- TODO: 이 숫자는 동적으로 받아와야 합니다 --%>
                        <span class="badge count">3</span>
                    </a>
                </li>
                <%--                </c:if>--%>
            </ul>
        </nav>

        <%-- ======================================================= --%>
        <%-- [탭 1] 나의 근태 현황 (기존) --%>
        <%-- ======================================================= --%>
        <c:if test="${currentTab == 'status'}">
            <div class="tab-panel">
                <div class="table-wrapper">
                    <table class="attendance-history-table">
                        <thead>
                        <tr>
                            <th>날짜</th>
                            <th>출근</th>
                            <th>퇴근</th>
                            <th>근무시간</th>
                            <th>상태</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="text-primary">2025-11-05</td>
                            <td>08:45</td>
                            <td>18:05</td>
                            <td>8.3h</td>
                            <td><span class="badge status-normal">정상</span></td>
                        </tr>
                        <tr>
                            <td class="text-primary">2025-11-04</td>
                            <td>09:15</td>
                            <td>18:10</td>
                            <td>8.0h</td>
                            <td><span class="badge status-late">지각</span></td>
                        </tr>
                        <tr>
                            <td class="text-primary">2025-11-03</td>
                            <td>08:50</td>
                            <td>17:30</td>
                            <td>7.7h</td>
                            <td><span class="badge status-leave-early">조퇴</span></td>
                        </tr>
                        <tr>
                            <td class="text-primary">2025-11-02</td>
                            <td>-</td>
                            <td>-</td>
                            <td>-</td>
                            <td><span class="badge badge-etc">결근</span></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>

        <%-- ======================================================= --%>
        <%-- [탭 2] 나의 신청 내역 (기존) --%>
        <%-- ======================================================= --%>
        <c:if test="${currentTab == 'list'}">
            <div class="tab-panel">
                <div class="application-list">
                    <article class="application-card">
                        <header class="card-header">
                            <span class="badge badge-info">휴가</span>
                            <span class="badge badge-warning">대기</span>
                        </header>
                        <div class="card-body">
                            <dl>
                                <dt>기간</dt>
                                <dd>2025-11-10 ~ 2025-11-11</dd>
                            </dl>
                            <dl>
                                <dt>사유</dt>
                                <dd>개인 사유</dd>
                            </dl>
                        </div>
                    </article>
                    <article class="application-card">
                        <header class="card-header">
                            <span class="badge badge-etc">외출</span>
                            <span class="badge badge-success">승인</span>
                        </header>
                        <div class="card-body">
                            <dl>
                                <dt>기간</dt>
                                <dd>2025-11-04 ~ 2025-11-04</dd>
                            </dl>
                            <dl>
                                <dt>사유</dt>
                                <dd>병원 방문 (14:00~16:00)</dd>
                            </dl>
                        </div>
                    </article>
                    <article class="application-card">
                        <header class="card-header">
                            <span class="badge badge-info">휴가</span>
                            <span class="badge badge-danger">반려</span>
                        </header>
                        <div class="card-body">
                            <dl>
                                <dt>기간</dt>
                                <dd>2025-11-01 ~ 2025-11-01</dd>
                            </dl>
                            <dl>
                                <dt>사유</dt>
                                <dd>요청 반려 (사유: 당일 인력 부족)</dd>
                            </dl>
                        </div>
                    </article>
                </div>
            </div>
        </c:if>

        <%-- ======================================================= --%>
        <%-- [!!] 추가: [탭 3] 승인 관리 (관리자 전용) --%>
        <%-- ======================================================= --%>
        <%-- [!!] test="" 안의 조건은 실제 관리자 확인 로직으로 변경해주세요 --%>
        <c:if test="${currentTab == 'admin'}">
            <%--            && loginUser.auth == 'ADMIN'}">--%>
            <div class="tab-panel">
                    <%--
                      - 아래 내용은 attendance-admin-detail.html 의 tab-panel 내부를 그대로 가져온 것입니다.
                      - TODO: JSTL과 c:forEach 등을 사용하여 이 섹션을 동적으로 구현해야 합니다.
                    --%>

                <section class="request-section">
                    <div class="section-header">
                        <h2>승인 대기 중인 신청</h2>
                        <span class="total-count">3건</span>
                    </div>

                    <ul class="request-card-list">
                        <li class="request-card">
                            <div class="card-content">
                                <div class="card-header">
                                    <div class="user-info">
                                        <div class="user-avatar">김</div>
                                        <div class="user-details">
                                            <span class="name">김민수</span>
                                            <span class="dept">간호부 · S001</span>
                                        </div>
                                    </div>
                                    <span class="badge status-vacation">휴가</span>
                                </div>
                                <div class="card-body">
                                    <dl>
                                        <dt>기간</dt>
                                        <dd>2025-11-01 ~ 2025-11-03</dd>
                                    </dl>
                                    <dl>
                                        <dt>신청 일시</dt>
                                        <dd>2025-10-25</dd>
                                    </dl>
                                    <dl class="full-width">
                                        <dt>사유</dt>
                                        <dd>개인 사유</dd>
                                    </dl>
                                </div>
                            </div>
                            <div class="card-actions">
                                <button type="button" class="btn btn-approve">✓ 승인</button>
                                <button type="button" class="btn btn-reject">X 반려</button>
                            </div>
                        </li>

                        <li class="request-card">
                            <div class="card-content">
                                <div class="card-header">
                                    <div class="user-info">
                                        <div class="user-avatar">이</div>
                                        <div class="user-details">
                                            <span class="name">이영희</span>
                                            <span class="dept">행정팀 · S002</span>
                                        </div>
                                    </div>
                                    <span class="badge status-go-out">외출</span>
                                </div>
                                <div class="card-body">
                                    <dl>
                                        <dt>기간</dt>
                                        <dd>2025-10-30 ~ 2025-10-30</dd>
                                        <dd class="time">14:00 ~ 18:00</dd>
                                    </dl>
                                    <dl>
                                        <dt>신청 일시</dt>
                                        <dd>2025-10-27</dd>
                                    </dl>
                                    <dl class="full-width">
                                        <dt>사유</dt>
                                        <dd>병원 방문</dd>
                                    </dl>
                                </div>
                            </div>
                            <div class="card-actions">
                                <button type="button" class="btn btn-approve">✓ 승인</button>
                                <button type="button" class="btn btn-reject">X 반려</button>
                            </div>
                        </li>

                        <li class="request-card">
                            <div class="card-content">
                                <div class="card-header">
                                    <div class="user-info">
                                        <div class="user-avatar">박</div>
                                        <div class="user-details">
                                            <span class="name">박철수</span>
                                            <span class="dept">영상의학과 · S003</span>
                                        </div>
                                    </div>
                                    <span class="badge status-stay-out">외박</span>
                                </div>
                                <div class="card-body">
                                    <dl>
                                        <dt>기간</dt>
                                        <dd>2025-11-05 ~ 2025-11-06</dd>
                                    </dl>
                                    <dl>
                                        <dt>신청 일시</dt>
                                        <dd>2025-10-26</dd>
                                    </dl>
                                    <dl class="full-width">
                                        <dt>사유</dt>
                                        <dd>출장</dd>
                                    </dl>
                                </div>
                            </div>
                            <div class="card-actions">
                                <button type="button" class="btn btn-approve">✓ 승인</button>
                                <button type="button" class="btn btn-reject">X 반려</button>
                            </div>
                        </li>
                    </ul>
                </section>

                <section class="request-section">
                    <div class="section-header">
                        <h2>처리 완료 내역</h2>
                    </div>
                    <ul class="request-card-list">
                        <li class="request-card request-card--completed">
                            <div class="card-content">
                                <div class="card-header">
                                    <div class="user-info">
                                        <div class="user-avatar user-avatar--gray">정</div>
                                        <div class="user-details">
                                            <span class="name">정수연</span>
                                            <span class="dept">내과</span>
                                        </div>
                                    </div>
                                    <span class="badge status-vacation">휴가</span>
                                </div>
                                <div class="card-body">
                                    <dl>
                                        <dt>기간</dt>
                                        <dd>2025-10-20 ~ 2025-10-22</dd>
                                    </dl>
                                    <dl>
                                        <dt>사유</dt>
                                        <dd>가족 여행</dd>
                                    </dl>
                                </div>
                            </div>
                            <span class="badge status-approved">승인</span>
                        </li>

                        <li class="request-card request-card--completed">
                            <div class="card-content">
                                <div class="card-header">
                                    <div class="user-info">
                                        <div class="user-avatar user-avatar--gray">한</div>
                                        <div class="user-details">
                                            <span class="name">한지민</span>
                                            <span class="dept">원무행정</span>
                                        </div>
                                    </div>
                                    <span class="badge status-go-out">외출</span>
                                </div>
                                <div class="card-body">
                                    <dl>
                                        <dt>기간</dt>
                                        <dd>2025-10-18 ~ 2025-10-18</dd>
                                        <dd class="time">15:00 ~ 17:00</dd>
                                    </dl>
                                    <dl>
                                        <dt>사유</dt>
                                        <dd>은행 업무</dd>
                                    </dl>
                                </div>
                            </div>
                            <span class="badge status-rejected">반려</span>
                        </li>
                    </ul>
                </section>
            </div>
        </c:if>

    </div>
</main>

<%--
    <c:import url="/WEB-INF/views/common/footer.jsp" />
--%>
</body>
</html>