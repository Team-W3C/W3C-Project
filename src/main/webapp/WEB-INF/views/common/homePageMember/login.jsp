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
    <!-- Header Include -->
    <jsp:include page="header_member.jsp" />

    <!-- Main Content -->
    <main class="main-content">
        <!-- Login Title -->
        <div class="login-title">
            <h1>로그인</h1>
        </div>

        <!-- Login Form -->
        <div class="form-container">
            <form id="loginForm" method="post" action="${pageContext.request.contextPath}/member/login.me">
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
                <p class="links"><a href="">비밀번호 찾기</a></p> |
                <p class="links"><a href="">아이디 찾기</a></p> |
                <p class="links"><a href="${pageContext.request.contextPath}/member/signUpPage.me">회원가입</a></p>
            </div>
        </div>
    </main>

    <!-- Footer Include -->
    <jsp:include page="../homePageFooter/footer.jsp" />

    <!-- script -->
    <script src="${pageContext.request.contextPath}/js/index.js"></script>
</body>
</html>
