<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
    <link href="https://fonts.googleapis.com/css?family=Arial&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet"/>

    <%-- [!!] 수정: 경로에 ${pageContext.request.contextPath} 추가 --%>
    <link href="${pageContext.request.contextPath}/css/attendance/attendance-dashboard.css" rel="stylesheet"/>

    <title>attendance-dashboard</title>
</head>

<body>
<main class="attendance-status-main">

    <header class="attendance-status-header">
        <h1 class="attendance-status-title">전체 근태 현황</h1>
    </header>

    <section class="attendance-status-toolbar">
        <form class="attendance-status-search-form">
            <div class="search-input-group">
                <input type="text" placeholder="직원명, 직급, 부서명으로 검색...">
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
                <th>작업</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>S001</td>
                <td>
                    <div class="employee-profile">
                        <span class="avatar" data-initial="이"></span>
                        <span class="employee-name">이준호</span>
                    </div>
                </td>
                <td>의사</td>
                <td>정형외과</td>
                <td>junho.lee@hospital.com</td>
                <td>010-1111-2222</td>
                <td>월-금 09:00-18:00</td>
                <td><span class="badge badge-success">정상</span></td>
                <td><a href="#" class="table-link">상세보기</a></td>
            </tr>
            <tr>
                <td>S002</td>
                <td>
                    <div class="employee-profile">
                        <span class="avatar" data-initial="김"></span>
                        <span class="employee-name">김서연</span>
                    </div>
                </td>
                <td>의사</td>
                <td>내과</td>
                <td>seoyeon.kim@hospital.com</td>
                <td>010-2222-3333</td>
                <td>월-토 09:00-17:00</td>
                <td><span class="badge badge-success">정상</span></td>
                <td><a href="#" class="table-link">상세보기</a></td>
            </tr>
            <tr>
                <td>S003</td>
                <td>
                    <div class="employee-profile">
                        <span class="avatar" data-initial="박"></span>
                        <span class="employee-name">박민준</span>
                    </div>
                </td>
                <td>의사</td>
                <td>신경외과</td>
                <td>minjun.park@hospital.com</td>
                <td>010-3333-4444</td>
                <td>화-금 10:00-19:00</td>
                <td><span class="badge badge-warning">지각</span></td>
                <td><a href="#" class="table-link">상세보기</a></td>
            </tr>
            <tr>
                <td>S004</td>
                <td>
                    <div class="employee-profile">
                        <span class="avatar" data-initial="최"></span>
                        <span class="employee-name">최수진</span>
                    </div>
                </td>
                <td>의사</td>
                <td>피부과</td>
                <td>sujin.choi@hospital.com</td>
                <td>010-4444-5555</td>
                <td>월-금 09:00-18:00</td>
                <td><span class="badge badge-success">정상</span></td>
                <td><a href="#" class="table-link">상세보기</a></td>
            </tr>
            <tr>
                <td>S005</td>
                <td>
                    <div class="employee-profile">
                        <span class="avatar" data-initial="정"></span>
                        <span class="employee-name">정은지</span>
                    </div>
                </td>
                <td>간호사</td>
                <td>응급실</td>
                <td>eunji.jung@hospital.com</td>
                <td>010-5555-6666</td>
                <td>3교대 근무</td>
                <td><span class="badge badge-success">정상</span></td>
                <td><a href="#" class="table-link">상세보기</a></td>
            </tr>
            </tbody>
        </table>
    </section>
</main>

</body>

</html>