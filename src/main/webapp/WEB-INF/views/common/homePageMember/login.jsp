<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/login.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/index.css">

    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>

<jsp:include page="header.jsp" />

<main class="main-content">
    <div class="login-title">
        <h1>로그인</h1>
    </div>

    <div class="form-container">

        <c:if test="${not empty errorMsg}">
            <div class="login-error" style="color: red; text-align: center; margin-bottom: 10px; font-weight: bold;">
                    ${errorMsg}
            </div>
        </c:if>

        <form id="loginForm" method="post" action="${pageContext.request.contextPath}/api/member/login">
            <div class="input-group">
                <label for="username">아이디</label>
                <input type="text" id="username" name="memberId" placeholder="아이디를 입력하시오">
            </div>

            <div class="input-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="memberPwd" placeholder="비밀번호">
            </div>

            <button type="submit" class="login-button">로그인</button>
        </form>

        <div class="additional-links">
            <a href="${pageContext.request.contextPath}/member/findPwd">비밀번호 찾기</a>
            <span>|</span>
            <a href="${pageContext.request.contextPath}/member/findId">아이디 찾기</a>
            <span>|</span>
            <a href="${pageContext.request.contextPath}/member/signUpPage">회원가입</a>
        </div>
    </div>
</main>

<jsp:include page="../homePageFooter/footer.jsp" />

<%--    <script src="${pageContext.request.contextPath}/js/index.js"></script>--%>
</body>
</html>