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

    <!--
        <link rel="stylesheet" href="/메인화면/header/header.css">
        <link rel="stylesheet" href="/메인화면/footer/footer.css">
        <link rel="stylesheet" href="/메인화면/index.css">
    -->
</head>
<body>

    <c:choose>
        <c:when test="${empty sessionScope.loginMember}">
            <!-- Not Login Member Header Include -->
            <jsp:include page="header.jsp" />
        </c:when>
        <c:when test="${not empty sessionScope.loginMember}">
            <c:choose>
                <c:when test="${sessionScope.loginMember.memberId.equals('root')}">
                    <!-- Login Admin Header Include -->
                    <jsp:include page="../homePageAdmin/header_admin.jsp" />
                </c:when>
                <c:otherwise>
                    <!-- Login Member Header Include -->
                    <jsp:include page="header.jsp" />
                </c:otherwise>
            </c:choose>
        </c:when>
    </c:choose>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Login Title -->
        <div class="login-title">
            <h1>로그인</h1>
        </div>

        <!-- Login Form -->
        <div class="form-container">
            <form id="loginForm" method="post" action="${pageContext.request.contextPath}/api/member/login">
                <!-- Username Input -->
                <div class="input-group">
                    <label for="username">아이디</label>
                    <input type="text" id="username" name="memberId" placeholder="아이디를 입력하시오">
                </div>

                <!-- Password Input -->
                <div class="input-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="memberPwd" placeholder="비밀번호">
                </div>

                <!-- Login Button -->
                <button type="submit" class="login-button">로그인</button>
            </form>

            <!-- Additional Links -->
            <div class="additional-links">
                <p class="links"><a href="${pageContext.request.contextPath}/member/findPwd">비밀번호 찾기</a></p> |
                <p class="links"><a href="${pageContext.request.contextPath}/member/findId">아이디 찾기</a></p> |
                <p class="links"><a href="${pageContext.request.contextPath}/member/signUpPage">회원가입</a></p>
            </div>
        </div>
    </main>

    <!-- Footer Include -->
    <jsp:include page="../homePageFooter/footer.jsp" />

    <!-- script -->
<%--    <script src="${pageContext.request.contextPath}/js/index.js"></script>--%>
</body>
</html>