<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Arial&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/css/dashBoard/erpDashBoard.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/css/attendance/attendance-dashboard.css" rel="stylesheet"/>
    <title>attendance-dashboard</title>
</head>
<body>
<c:import url="/WEB-INF/views/common/erp/header.jsp"/>
<c:import url="/WEB-INF/views/common/erp/sidebar.jsp"/>

<main class="dashboard-main attendance-status-main">

    <header class="attendance-status-header">
        <h1 class="attendance-status-title">전체 근태 현황</h1>
    </header>

    <section class="attendance-status-toolbar">
        <form class="attendance-status-search-form" method="get"
              action="${pageContext.request.contextPath}/erp/attendance/dashboard">
            <div class="search-input-group">
                <input type="text" name="searchTerm" placeholder="직원명, 부서명으로 검색..." value="${param.searchTerm}">
            </div>
            <div class="toolbar-actions">
                <button type="submit" class="btn btn-primary">검색</button>
                <button type="button" class="btn btn-secondary">
                    <span>필터</span>
                </button>
            </div>
        </form>
    </section>

    <section class="attendance-status-content">
        <table class="attendance-status-table">
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
            </tr>
            </thead>
            <%-- ======================================================= --%>
            <%-- <tbody> (employeeList 사용) --%>
            <%-- ======================================================= --%>
            <tbody>
            <c:forEach var="emp" items="${employeeList}">
                <tr>
                    <td>${emp.staffNo}</td>
                    <td>
                        <div class="employee-profile">
                            <span class="avatar" data-initial="${emp.employeeName.substring(0, 1)}"></span>
                            <span class="employee-name">${emp.employeeName}</span>
                        </div>
                    </td>
                    <td>${emp.position}</td>
                    <td>${emp.departmentName}</td>
                    <td>${emp.email}</td>
                    <td>${emp.phone}</td>
                    <td>${emp.workSchedule}</td>
                    <td>
                        <c:choose>
                            <c:when test="${emp.absenceStatus == 1}">
                                <span class="badge badge-success">정상</span>
                            </c:when>
                            <c:when test="${emp.absenceStatus == 2}">
                                <span class="badge badge-warning">지각</span>
                            </c:when>
                            <c:when test="${emp.absenceStatus == 3}">
                                <span class="badge badge-info">조퇴</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-etc">휴가/결근</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>

            <c:if test="${empty employeeList}">
                <tr>
                    <td colspan="9">조회된 직원이 없습니다.</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </section>
</main>
</body>
</html>