<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>나의 차트 - 진단검사결과</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/member-sidebar.css">

    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa;
        }
        .container-fluid.main-layout {
            display: flex;
            min-height: calc(100vh - 100px);
            padding-top: 20px;
        }
        .content-area {
            flex-grow: 1;
            padding: 20px 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.05);
            margin-left: 20px;
        }
        .content-area h2 {
            font-size: 1.8rem;
            font-weight: bold;
            color: #212529;
            margin-bottom: 25px;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 15px;
        }
        .section-title {
            font-size: 1.5rem;
            font-weight: bold;
            color: #343a40;
            margin-top: 40px;
            margin-bottom: 20px;
            padding-left: 10px;
            border-left: 4px solid #0E787C;
        }
        .table thead th {
            background-color: #e9ecef;
            color: #495057;
            font-weight: bold;
            vertical-align: middle;
        }
        .table tbody tr:hover {
            background-color: #f2f2f2;
        }
        .no-records {
            text-align: center;
            padding: 50px;
            color: #6c757d;
            font-size: 1.1rem;
            background-color: #f2f2f2;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .badge-status-waiting { background-color: #ffc107; color: #343a40; } /* Warning (유지) */
        .badge-status-completed { background-color: #34A853; color: #fff; } /* Success (성공) */
        .badge-status-cancelled { background-color: #D64545; color: #fff; } /* Error (경고) */
        .badge-status-etc { background-color: #6c757d; color: #fff; } /* Secondary (유지) */
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/homePageMember/header.jsp" />

<div class="container-fluid main-layout">
    <jsp:include page="/WEB-INF/views/common/homePageMember/member-sidebar.jsp" />

    <main class="content-area">
        <h2 class="mb-4">
            <i class="bi bi-clipboard-data me-2"></i> 나의 진단검사결과
        </h2>
        <p class="text-muted mb-4">진료를 통해 확정된 진단명과 검사 내역을 확인하실 수 있습니다.</p>

        <h3 class="section-title"><i class="bi bi-file-text me-2"></i> 진단 및 처방 내역</h3>
        <c:choose>
            <c:when test="${empty diagnosisList}">
                <div class="no-records">
                    <i class="bi bi-exclamation-circle me-2"></i> 진단 및 처방 내역이 없습니다.
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive mb-5">
                    <table class="table table-bordered table-striped align-middle">
                        <thead>
                        <tr>
                            <th style="width: 15%;">진료일</th>
                            <th style="width: 30%;">진단명</th>
                            <th style="width: 20%;">진단코드</th>
                            <th style="width: 35%;">처방</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="diag" items="${diagnosisList}">
                            <tr>
                                <td><fmt:formatDate value="${diag.TREATMENTDATE}" pattern="yyyy-MM-dd"/></td>
                                <td>${diag.DIAGNOSISNAME}</td>
                                <td>${diag.DIAGNOSISCODE}</td>
                                <td>${diag.PRESCRIPTIONNAME}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>

        <h3 class="section-title"><i class="bi bi-activity me-2"></i> 영상/기기 검사 내역</h3>
        <c:choose>
            <c:when test="${empty testList}">
                <div class="no-records">
                    <i class="bi bi-exclamation-circle me-2"></i> 영상/기기 검사 내역이 없습니다.
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-bordered table-striped align-middle">
                        <thead>
                        <tr>
                            <th style="width: 15%;">검사일</th>
                            <th style="width: 30%;">검사명 (장비/시설)</th>
                            <th style="width: 20%;">분류</th>
                            <th style="width: 20%;">상태</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="test" items="${testList}">
                            <tr>
                                <td><fmt:formatDate value="${test.TESTDATE}" pattern="yyyy-MM-dd HH:mm"/></td>
                                <td>${test.TESTNAME}</td>
                                <td>${test.FACILITYTYPE}</td>
                                <td>
                                    <c:set var="status" value="${test.STATUS}" />
                                    <c:choose>
                                        <c:when test="${status == '확정' || status == '완료'}">
                                            <span class="badge badge-status-completed">완료</span>
                                        </c:when>
                                        <c:when test="${status == '대기' || status == '예약'}">
                                            <span class="badge badge-status-waiting">대기</span>
                                        </c:when>
                                        <c:when test="${status == '취소'}">
                                            <span class="badge badge-status-cancelled">취소</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-status-etc">${status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </main>
</div>

<jsp:include page="/WEB-INF/views/common/homePageFooter/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>