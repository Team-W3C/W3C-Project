<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>나의 차트 - 진료내역</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/member-sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ConfirmPasswordModal.css">

    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa; /* 연한 배경색 */
        }
        .container-fluid.main-layout {
            display: flex;
            min-height: calc(100vh - 100px); /* 헤더/푸터 제외 최소 높이 */
            padding-top: 20px;
        }
        .content-area {
            flex-grow: 1;
            padding: 20px 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.05);
            margin-left: 20px; /* 사이드바와의 간격 */
        }
        .content-area h2 {
            font-size: 1.8rem;
            font-weight: bold;
            color: #212529;
            margin-bottom: 25px;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 15px;
        }
        .medical-history-card {
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            transition: all 0.2s ease-in-out;
        }
        .medical-history-card:hover {
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transform: translateY(-3px);
        }
        .medical-history-card .date {
            font-size: 1.1rem;
            font-weight: bold;
            color: #0E787C; /* [수정] Primary 기본색 적용 */
            margin-bottom: 10px;
        }
        .medical-history-card .department {
            font-size: 1rem;
            color: #6c757d;
            margin-bottom: 5px;
        }
        .medical-history-card .complaint {
            font-size: 0.95rem;
            color: #495057;
            line-height: 1.5;
        }
        .no-records {
            text-align: center;
            padding: 50px;
            color: #6c757d;
            font-size: 1.1rem;
            background-color: #f2f2f2;
            border-radius: 8px;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/homePageMember/header.jsp" />

<div class="container-fluid main-layout">
    <jsp:include page="/WEB-INF/views/common/homePageMember/member-sidebar.jsp" />

    <main class="content-area">
        <h2 class="mb-4">
            <i class="bi bi-file-earmark-medical me-2"></i> 나의 진료내역
        </h2>
        <p class="text-muted mb-4">지금까지 병원에 방문하여 진료를 받으신 이력을 확인하실 수 있습니다.</p>

        <c:choose>
            <c:when test="${empty historyList}">
                <div class="no-records">
                    <i class="bi bi-exclamation-circle me-2"></i> 진료 내역이 없습니다.
                </div>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <c:forEach var="history" items="${historyList}">
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="medical-history-card">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <div class="date"><fmt:formatDate value="${history.VISITDATE}" pattern="yyyy년 MM월 dd일"/></div>

                                    <span class="badge" style="background-color: #0E787C; color: #fff;">
                                            ${history.DEPARTMENTNAME}
                                    </span>

                                </div>
                                <p class="department mb-2"><i class="bi bi-hospital me-2"></i> ${history.DEPARTMENTNAME}</p>
                                <p class="complaint"><i class="bi bi-stickies me-2"></i> 주요 증상: ${history.CHIEFCOMPLAINT}</p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </main>
</div>

<jsp:include page="/WEB-INF/views/common/homePageFooter/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>