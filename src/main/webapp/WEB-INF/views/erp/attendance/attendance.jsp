<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<%--
    탭 제어:
    - ?tab=status (기본값) : 나의 근태 현황
    - ?tab=list           : 나의 신청 내역
    - ?tab=admin          : 승인 관리 (관리자 전용)
--%>
<c:set var="currentTab"
       value="${empty param.tab ? 'status' : param.tab}"/>

<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Arial&display=swap"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap"
          rel="stylesheet"/>
    <link
            href="${pageContext.request.contextPath}/css/attendance/attendance-modal.css"
            rel="stylesheet"/>
    <link
            href="${pageContext.request.contextPath}/css/dashBoard/erpDashBoard.css"
            rel="stylesheet"/>
    <link
            href="${pageContext.request.contextPath}/css/attendance/attendance.css"
            rel="stylesheet"/>
    <link
            href="${pageContext.request.contextPath}/css/attendance/attendance-admin-detail.css"
            rel="stylesheet"/>

    <title>근태 관리</title>
</head>
<div>
    <c:import url="/WEB-INF/views/common/erp/header.jsp"/>
    <c:import url="/WEB-INF/views/common/erp/sidebar.jsp"/>

    <main class="dashboard-main attendance-container">

        <div class="page-header">
            <h1>근태 관리</h1>
            <div class="page-actions">
                <a
                        href="${pageContext.request.contextPath}/erp/attendance/dashboard"
                        class="btn btn-secondary"> <span>전체 근태 현황</span>
                </a>

                <%-- ======================================================= --%>
                <%--출/퇴근 버튼 로직 --%>
                <%-- ======================================================= --%>

                <c:choose>
                    <%-- 1. 출근 전 (오늘 기록이 없거나, 출근 시간이 없음) --%>
                    <c:when
                            test="${empty todayRecord or empty todayRecord.absenceStartTime}">
                        <form
                                action="${pageContext.request.contextPath}/erp/attendance/clock-in"
                                method="post" style="display: inline;">

                            <button type="submit" class="btn btn-primary">
                                <span>출근하기</span>
                            </button>
                        </form>
                    </c:when>

                    <%-- 2. 출근 후, 퇴근 전 (출근 시간은 있으나, 퇴근 시간이 없음) --%>
                    <c:when
                            test="${not empty todayRecord.absenceStartTime and empty todayRecord.absenceEndTime}">

                        <form
                                action="${pageContext.request.contextPath}/erp/attendance/clock-out"
                                method="post" style="display: inline;">
                            <input type="hidden" name="absenceNo"
                                   value="${todayRecord.absenceNo}">
                            <button type="submit" class="btn btn-secondary">

                                <span>퇴근하기</span>
                            </button>
                        </form>
                    </c:when>

                    <%-- 3. 퇴근 완료 (출근/퇴근 시간 모두 있음) --%>
                    <c:otherwise>
                        <button type="button" class="btn btn-secondary" disabled>
                            <span>근무 완료</span>

                        </button>
                    </c:otherwise>
                </c:choose>

                <button type="button" class="btn btn-outline"
                        id="open-application-modal-btn">

                    <span>신청서 작성</span>
                </button>
            </div>
        </div>

        <%-- ======================================================= --%>
        <%-- 상단 위젯 (todayRecord 사용) --%>
        <%-- ======================================================= --%>
        <section class="attendance-widget">
            <ul class="widget-stats-list">

                <li><span class="label">현재 시각</span> <strong class="value"
                                                             id="current-time"></strong></li>

                <li><span class="label">출근 시각</span> <strong class="value">
                    ${not empty todayRecord.absenceStartTime ? todayRecord.absenceStartTime : '-'}

                </strong></li>
                <li><span class="label">퇴근 시각</span> <strong class="value">
                    ${not empty todayRecord.absenceEndTime ? todayRecord.absenceEndTime : '-'}

                </strong></li>
                <li><span class="label">근무 시간</span> <strong class="value">${not empty todayRecord.workHours ?
                        todayRecord.workHours : '-'}시간</strong>
                </li>
            </ul>
            <c:choose>
                <c:when test="${todayRecord.absenceStatus == 1}">
                    <span class="badge status-normal">정상</span>
                </c:when>

                <c:when test="${todayRecord.absenceStatus == 2}">
                    <span class="badge status-late">지각</span>
                </c:when>
                <c:when test="${todayRecord.absenceStatus == 3}">
                    <span class="badge status-leave-early">조퇴</span>

                </c:when>
                <c:when
                        test="${empty todayRecord or todayRecord.absenceStatus == 0}">
                    <span class="badge badge-etc">출근 전</span>

                </c:when>
                <c:otherwise>
                    <span class="badge badge-etc">N/A</span>
                </c:otherwise>
            </c:choose>
        </section>

        <div class="tab-container">

            <nav class="tab-nav">

                <ul>
                    <li class="${currentTab == 'status' ? 'active' : ''}"><a
                            href="?tab=status">나의 근태 현황</a></li>

                    <li class="${currentTab == 'list' ? 'active' : ''}"><a
                            href="?tab=list">나의 신청 내역</a></li>
                    <c:if test="${isAdmin}">
                        <li class="${currentTab == 'admin' ? 'active' : ''}"><a
                                href="?tab=admin"> 승인 관리 <c:if test="${pendingCount > 0}">

                            <span class="badge count">${pendingCount}</span>
                        </c:if>
                        </a></li>
                    </c:if>
                </ul>
            </nav>

            <c:if test="${currentTab == 'status'}">

            <div class="tab-panel">
                <div class="table-wrapper">

                    <table class="attendance-history-table">
                        <thead>
                        <tr>
                            <th>날짜</th>
                            <th>출근</th>
                            <th>퇴근</th>
                            <th>근무 시간</th>
                            <th>상태</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="item" items="${historyList}">
                        <tr>
                            <td class="text-primary">${item.absenceDate}</td>

                            <td>${item.absenceStartTime}</td>
                            <td><c:if test="${not empty item.absenceEndTime}">
                                    ${item.absenceEndTime}
                                </c:if>
                                <c:if test="${empty item.absenceEndTime}">-</c:if>


                            </td>
                            <td>${not empty item.workHours ? item.workHours : '-'}시간
                            </td>
                            <td><c:choose>
                                <c:when test="${item.absenceStatus == 1}">

                                    <span class="badge status-normal">정상</span>
                                </c:when>
                                <c:when test="${item.absenceStatus == 2}">

                                    <span class="badge status-late">지각</span>
                                </c:when>
                                <c:when test="${item.absenceStatus == 3}">

                                    <span class="badge status-leave-early">조퇴</span>
                                </c:when>

                                <c:otherwise>
                                    <span class="badge badge-etc">결근</span>

                                </c:otherwise>
                            </c:choose></td>
                        </tr>

                        </c:forEach>
                        <c:if test="${empty historyList}">
                            <tr>
                                <td colspan="5">근태 기록이 없습니다.</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            </c:if>

            <%-- ======================================================= --%>
            <%--                    [탭 2] 나의 신청 내역 --%>
            <%-- ======================================================= --%>

            <c:if test="${currentTab == 'list'}">
                <div class="tab-panel">
                    <div class="application-list">

                        <c:forEach var="app" items="${applicationList}">
                            <article class="application-card">

                                <header class="card-header">
                                    <c:choose>

                                        <c:when test="${app.absenceType == 1}">
                                            <span class="badge badge-info">외출</span>
                                        </c:when>

                                        <c:when test="${app.absenceType == 2}">
                                            <span class="badge badge-info">휴가</span>

                                        </c:when>
                                        <c:when test="${app.absenceType == 3}">

                                            <span class="badge badge-info">외박</span>
                                        </c:when>
                                        <c:otherwise>

                                            <%-- 기타/알수없음 --%>
                                            <span class="badge badge-info">기타</span>

                                        </c:otherwise>
                                    </c:choose>

                                        <%-- isApproved: 'F'(대기), 'T'(승인), 'R'(반려) --%>
                                    <c:choose>
                                        <c:when test="${app.isApproved == 'F'}">

                                            <span class="badge badge-warning">대기</span>
                                        </c:when>

                                        <c:when test="${app.isApproved == 'T'}">
                                            <span class="badge badge-success">승인</span>
                                        </c:when>

                                        <c:when test="${app.isApproved == 'R'}">
                                            <span class="badge badge-danger">반려</span>

                                        </c:when>
                                    </c:choose>
                                </header>


                                <div class="card-body">

                                        <%-- (c:choose로 분기) --%>


                                    <c:choose>
                                        <%-- 1. 외출(Type 1)일 경우: | 로 분리하여 기간/사유 출력 --%>
                                        <c:when test="${app.absenceType == 1}">
                                            <c:set var="reasonParts"
                                                   value="${fn:split(app.detailedReason, '|')}"/>

                                            <dl>
                                                <dt>기간</dt>
                                                <dd>
                                                        ${app.absenceStartDate} <br/> ${reasonParts[0]}
                                                </dd>
                                            </dl>
                                            <dl>
                                                <dt>사유</dt>
                                                <dd>${reasonParts[1]}</dd>
                                            </dl>
                                        </c:when>

                                        <c:otherwise>
                                            <dl>
                                                <dt>기간</dt>
                                                <dd>${app.absenceStartDate}~${app.absenceEndDate}</dd>
                                            </dl>
                                            <dl>
                                                <dt>사유</dt>
                                                <dd>${app.detailedReason}</dd>
                                            </dl>
                                        </c:otherwise>
                                    </c:choose>

                                </div>

                            </article>
                        </c:forEach>

                        <c:if test="${empty applicationList}">
                            <p>신청 내역이 없습니다.</p>

                        </c:if>
                    </div>
                </div>
            </c:if>

            <%-- ======================================================= --%>
            <%-- [수정] [탭 3] 승인 관리 (pendingList, completedList 사용) --%>
            <%-- ======================================================= --%>
            <c:if test="${currentTab == 'admin'}">
                <div class="tab-panel">

                    <section class="request-section">
                        <div class="section-header">

                            <h2>승인 대기 중인 신청</h2>
                            <span class="total-count">${pendingCount}건</span>
                        </div>

                        <ul class="request-card-list">

                            <c:forEach var="item" items="${pendingList}">

                                <li class="request-card">
                                    <div class="card-content">

                                        <div class="card-header">

                                            <div class="user-info">

                                                <div class="user-avatar">${item.employeeName.substring(0, 1)}</div>

                                                <div class="user-details">

                                                    <span class="name">${item.employeeName}</span> <span
                                                        class="dept">${item.departmentName} ·
                                                        ${item.staffNo}</span>

                                                </div>

                                            </div>

                                            <c:choose>

                                                <c:when test="${item.absenceType == 1}">

                                                    <span class="badge status-vacation">외출</span>

                                                </c:when>

                                                <c:when test="${item.absenceType == 2}">

                                                    <span class="badge status-vacation">휴가</span>

                                                </c:when>

                                                <c:when test="${item.absenceType == 3}">

                                                    <span class="badge status-vacation">외박</span>

                                                </c:when>

                                                <c:otherwise>

                                                    <span class="badge status-vacation">기타</span>

                                                </c:otherwise>

                                            </c:choose>
                                        </div>

                                        <div class="card-body">

                                                <%-- 관리자 탭 (c:choose로 분기) --%>
                                            <c:choose>

                                                <%-- 1. 외출(Type 1)일 경우 --%>
                                                <c:when test="${item.absenceType == 1}">

                                                    <c:set var="reasonParts"
                                                           value="${fn:split(item.detailedReason, '|')}"/>

                                                    <dl>
                                                        <dt>기간</dt>
                                                        <dd>
                                                                ${item.absenceStartDate} <br/> ${reasonParts[0]}
                                                        </dd>
                                                    </dl>

                                                    <dl>
                                                        <dt>신청 일시</dt>
                                                        <dd>${item.absenceStartDate}</dd>
                                                    </dl>

                                                    <dl class="full-width">
                                                        <dt>사유</dt>
                                                        <dd>${reasonParts[1]}</dd>
                                                    </dl>
                                                </c:when>

                                                <c:otherwise>

                                                    <dl>
                                                        <dt>기간</dt>
                                                        <dd>${item.absenceStartDate}~${item.absenceEndDate}</dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>신청 일시</dt>
                                                        <dd>${item.absenceApplicationDate}</dd>
                                                    </dl>
                                                    <dl class="full-width">

                                                        <dt>사유</dt>
                                                        <dd>${item.detailedReason}</dd>
                                                    </dl>

                                                </c:otherwise>

                                            </c:choose>

                                        </div>

                                    </div>

                                    <div class="card-actions">

                                        <form
                                                action="${pageContext.request.contextPath}/erp/attendance/admin/updateStatus"
                                                method="post" style="display: inline;">
                                            <input type="hidden" name="addNo" value="${item.addNo}">
                                            <input type="hidden" name="status" value="T">
                                                <%-- T: 승인 --%>

                                            <button type="submit" class="btn btn-approve">✓ 승인</button>

                                        </form>

                                        <form
                                                action="${pageContext.request.contextPath}/erp/attendance/admin/updateStatus"
                                                method="post" style="display: inline;">
                                            <input type="hidden" name="addNo" value="${item.addNo}">

                                            <input type="hidden" name="status" value="R">
                                                <%-- R: 반려(거절) --%>

                                            <button type="submit" class="btn btn-reject">X 반려</button>
                                        </form>

                                    </div>

                                </li>

                            </c:forEach>

                            <c:if test="${empty pendingList}">

                                <li>승인 대기 중인 신청이 없습니다.</li>
                            </c:if>
                        </ul>
                    </section>

                    <section class="request-section">

                        <div class="section-header">
                            <h2>처리 완료 내역</h2>
                        </div>

                        <ul class="request-card-list">
                            <c:forEach var="item" items="${completedList}">
                                <li class="request-card request-card--completed">

                                    <div class="card-content">

                                        <div class="card-header">

                                            <div class="user-info">

                                                <div class="user-avatar user-avatar--gray">${item.employeeName.substring(0, 1)}</div>

                                                <div class="user-details">

                                                    <span class="name">${item.employeeName}</span> <span
                                                        class="dept">${item.departmentName}</span>

                                                </div>

                                            </div>

                                            <c:choose>

                                                <c:when test="${item.absenceType == 1}">

                                                    <span class="badge status-vacation">외출</span>

                                                </c:when>

                                                <c:when test="${item.absenceType == 2}">

                                                    <span class="badge status-vacation">휴가</span>

                                                </c:when>

                                                <c:when test="${item.absenceType == 3}">

                                                    <span class="badge status-vacation">외박</span>
                                                </c:when>

                                                <c:otherwise>

                                                    <span class="badge status-vacation">기타</span>

                                                </c:otherwise>

                                            </c:choose>

                                        </div>


                                        <div class="card-body">
                                                <%-- 관리자 탭(완료) (c:choose로 분기) --%>

                                            <c:choose>
                                                <%-- 1. 외출(Type 1)일 경우 --%>

                                                <c:when test="${item.absenceType == 1}">
                                                    <c:set var="reasonParts"
                                                           value="${fn:split(item.detailedReason, '|')}"/>

                                                    <dl>
                                                        <dt>기간</dt>
                                                        <dd>
                                                                ${item.absenceStartDate} <br/> ${reasonParts[0]}
                                                        </dd>

                                                    </dl>

                                                    <dl>
                                                        <dt>사유</dt>
                                                        <dd>${reasonParts[1]}</dd>
                                                    </dl>

                                                </c:when>

                                                <c:otherwise>

                                                    <dl>
                                                        <dt>기간</dt>
                                                        <dd>${item.absenceStartDate}~${item.absenceEndDate}</dd>
                                                    </dl>

                                                    <dl>
                                                        <dt>사유</dt>
                                                        <dd>${item.detailedReason}</dd>
                                                    </dl>

                                                </c:otherwise>

                                            </c:choose>

                                        </div>

                                    </div>
                                    <c:choose>

                                        <c:when test="${item.isApproved == 'T'}">

                                            <span class="badge status-approved">승인</span>

                                        </c:when>

                                        <c:when test="${item.isApproved == 'R'}">
                                            <span class="badge status-rejected">반려</span>

                                        </c:when>
                                    </c:choose>
                                </li>


                            </c:forEach>
                            <c:if test="${empty completedList}">
                                <li>처리 완료 내역이 없습니다.</li>

                            </c:if>

                        </ul>
                    </section>
                </div>
            </c:if>
        </div>

    </main>
</div>

<%-- ======================================================= --%>
<%-- 신청서 작성 모달 --%>
<%-- ======================================================= --%>
<div id="application-modal" class="modal-overlay">
    <%-- 모달 콘텐츠 --%>
    <div class="modal-content application-page">

        <%-- 모달 헤더 --%>
        <div class="modal-header">
            <h1 class="application-title">신청서 작성</h1>
            <button type="button" id="close-application-modal-btn"
                    class="modal-close-btn">&times;
            </button>
        </div>

        <%-- 신청서 폼 --%>

        <form class="application-form"
              action="${pageContext.request.contextPath}/erp/attendance/apply"
              method="post">
            <input type="hidden" id="application-type" name="applicationType"
                   value="outing">

            <%-- 1. 신청자 정보 --%>
            <section class="application-form-header">
                <div class="form-group">

                    <label for="applicant-name" class="form-label">신청자</label> <input
                        type="text" id="applicant-name" class="form-control"
                        value="${loginUser.memberName}" readonly>
                </div>
                <div class="form-group">
                    <label for="applicant-dept" class="form-label">소속</label> <input
                        type="text" id="applicant-dept" class="form-control"
                        value="${loginUser.departmentName}" readonly>

                </div>
                <div class="form-group">
                    <label for="applicant-position" class="form-label">직위</label> <input
                        type="text" id="applicant-position" class="form-control"
                        value="${loginUser.positionName}" readonly>

                </div>

            </section>

            <%-- 2. 신청 내용 (탭) --%>
            <section class="application-form-body">

                <%-- 탭 메뉴 --%>
                <nav class="application-tabs">

                    <ul>

                        <li><a href="#" class="is-active" data-tab="outing">외출</a></li>
                        <li><a href="#" data-tab="leave">휴가</a></li>
                        <li><a href="#" data-tab="overnight">외박</a></li>

                    </ul>

                </nav>

                <%-- 탭 콘텐츠 래퍼 --%>
                <div class="tab-content-container">

                    <%-- (1) 외출 탭 --%>

                    <div id="tab-content-outing" class="tab-pane is-active">


                        <div class="form-group">
                            <label for="outing-start-time" class="form-label">외출 시간</label>
                            <div class="form-inline">


                                <input type="time" id="outing-start-time" name="outingStartTime"
                                       class="form-control" value="14:00"> <span>~</span> <input
                                    type="time" id="outing-end-time" name="outingEndTime"
                                    class="form-control" value="16:00">


                            </div>
                        </div>
                        <div class="form-group">

                            <label for="outing-reason" class="form-label">사유</label>

                            <textarea id="outing-reason" name="outingReason"
                                      class="form-control" rows="5" placeholder="사유를 입력하세요"></textarea>
                        </div>
                    </div>


                    <%-- (2) 휴가 탭 --%>

                    <div id="tab-content-leave" class="tab-pane">

                        <div class="form-group">
                            <label for="leave-start-date" class="form-label">기간</label>

                            <div class="form-inline">

                                <input type="date" id="leave-start-date" name="leaveStartDate"
                                       class="form-control"> <span>~</span> <input type="date"
                                                                                   id="leave-end-date"
                                                                                   name="leaveEndDate"
                                                                                   class="form-control">

                            </div>
                        </div>


                        <div class="form-group">


                            <label for="leave-reason" class="form-label">사유</label>
                            <textarea id="leave-reason" name="leaveReason"
                                      class="form-control" rows="5" placeholder="사유를 입력하세요"></textarea>
                        </div>

                    </div>


                    <%-- (3) 외박 탭 --%>
                    <div id="tab-content-overnight" class="tab-pane">

                        <div class="form-group">

                            <label for="overnight-start-date" class="form-label">기간</label>

                            <div class="form-inline">
                                <input type="date" id="overnight-start-date"
                                       name="overnightStartDate" class="form-control"> <span>~</span>

                                <input type="date" id="overnight-end-date"
                                       name="overnightEndDate" class="form-control">
                            </div>
                        </div>


                        <div class="form-group">

                            <label for="overnight-reason" class="form-label">사유</label>
                            <textarea id="overnight-reason" name="overnightReason"
                                      class="form-control" rows="5" placeholder="사유를 입력하세요"></textarea>

                        </div>

                    </div>
                </div>
            </section>

            <%-- 3. 결재 버튼 --%>
            <footer class="application-form-actions">

                <button type="button" class="btn btn-secondary">취소</button>
                <button type="submit" class="btn btn-primary">결재요청</button>
            </footer>
        </form>
    </div>
</div>
<script
        src="${pageContext.request.contextPath}/js/erp/attendance/attendance.js"
        defer></script>
</body>
</html>