<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기 - MediFlow</title>

    <%-- 폰트 --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

    <%-- 공통 CSS --%>
    <link rel="stylesheet" href="${contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${contextPath}/css/Find/find.css">

    <script>
        // Controller에서 전달된 메시지가 있으면 알림창 띄우기
        window.onload = function() {
            var message = "${message}";
            var error = "${error}";

            if(message) {
                alert(message);
                location.href = "${contextPath}/member/loginPage"; // 찾기 성공 시 로그인 페이지로 이동
            }
            if(error) {
                alert(error);
            }
        }
    </script>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/homePageMember/header.jsp" />

<main class="form-wrapper">
    <div class="form-container">
        <h1 class="form-title">아이디 찾기</h1>

        <%-- action 경로 수정: /member/findId.me --%>
        <form action="${contextPath}/member/findId.me" method="post" id="findIdForm">

            <div class="form-group">
                <label for="memberName">이름</label>
                <input type="text" id="memberName" name="memberName" placeholder="가입 시 등록한 이름을 입력하세요" required>
            </div>

            <div class="form-group">
                <label for="memberPhone">연락처</label>
                <input type="text" id="memberPhone" name="memberPhone" placeholder="'-' (하이픈) 없이 숫자만 입력하세요" required>
            </div>

            <button type="submit" class="form-button">아이디 찾기</button>

        </form>

        <div class="form-links">
            <a href="${contextPath}/member/findPwd">비밀번호 찾기</a>
            <span>|</span>
            <a href="${contextPath}/member/loginPage">로그인</a>
        </div>

    </div>
</main>

<jsp:include page="/WEB-INF/views/common/homePageFooter/footer.jsp" />

</body>
</html>