<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>오늘 환자</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/medical-today.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/erp/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/erp/sidebar.jsp"/>

<main class="medical-main">
    <h1 class="medical-page-title">진료 관리</h1>
    <div class="medical-card">
        <div class="medical-tabs-header" role="tablist">
            <button class="medical-tab-btn active" role="tab" aria-selected="true"
                    aria-controls="today-panel" data-tab="today">
                오늘의 환자
                <span class="medical-tab-badge">
                    <c:out value="${fn:length(patients)}"/>
                </span>
            </button>
            <button class="medical-tab-btn" role="tab" aria-selected="false"
                    aria-controls="diagnosis-panel" data-tab="diagnosis">
                진단 내용
            </button>
        </div>

        <div class="medical-tab-content">
            <section class="medical-tab-pane active" id="today-panel" role="tabpanel">
                <div class="medical-table-wrapper">
                    <table class="medical-table">
                        <thead>
                        <tr>
                            <th>예약 시간</th>
                            <th>환자</th>
                            <th>진료 목적</th>
                            <th>진료 상태</th>
                            <th>특이사항</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty patients}">
                                <c:forEach var="patient" items="${patients}">
                                    <tr>
                                        <td><c:out value="${patient.reservationTime}"/></td>
                                        <td>
                                            <c:out value="${patient.patientName}"/>
                                            (<c:out value="${patient.patientCode}"/>)
                                        </td>
                                        <td><c:out value="${patient.reservationPurpose}"/></td>
                                        <td>
                                            <c:out value="${patient.reservationStatus}"/>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty patient.allergy and patient.allergy ne '없음'}">
                                                    <span class="patient-badge patient-badge-warning">
                                                        알레르기 (<c:out value="${patient.allergy}"/>)
                                                    </span>
                                                </c:when>
                                                <c:when test="${not empty patient.chronicDisease and patient.chronicDisease ne '특이사항 없음'}">
                                                    <span class="patient-badge patient-badge-warning">
                                                        <c:out value="${patient.chronicDisease}"/>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="patient-badge patient-badge-normal">일반</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" style="text-align:center; color:gray;">
                                        오늘 예약된 환자가 없습니다.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </section>

            <section class="medical-tab-pane" id="diagnosis-panel" role="tabpanel">
                <div class="diagnosis-list">
                    <c:choose>
                        <c:when test="${not empty treatments}">
                            <div class="medical-table-wrapper">
                                <table class="medical-table">
                                    <thead>
                                    <tr>
                                        <th>환자번호</th>
                                        <th>진달 날짜</th>
                                        <th>진료과</th>
                                        <th>진단내용</th>
                                        <th>처방</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="treatment" items="${treatments}">
                                        <tr>
                                            <td><c:out value="${treatment.patientCode}"/></td>
                                            <td><c:out value="${treatment.recordDate}"/></td>
                                            <td><c:out value="${treatment.departmentName}"/></td>
                                            <td><c:out value="${treatment.diagnosisContent}"/></td>
                                            <td><c:out value="${treatment.prescription}"/></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p style="text-align:center; color:gray;">진단 내용 데이터가 없습니다.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>

        </div>
    </div>
</main>

<script>
    const tabButtons = document.querySelectorAll('.medical-tab-btn');
    const tabPanes = document.querySelectorAll('.medical-tab-pane');

    tabButtons.forEach(button => {
        button.addEventListener('click', () => {
            const tabName = button.getAttribute('data-tab');
            tabButtons.forEach(btn => {
                btn.classList.remove('active');
                btn.setAttribute('aria-selected', 'false');
            });
            tabPanes.forEach(pane => pane.classList.remove('active'));

            button.classList.add('active');
            button.setAttribute('aria-selected', 'true');
            document.getElementById(tabName + '-panel').classList.add('active');
        });
    });
</script>
</body>
</html>
