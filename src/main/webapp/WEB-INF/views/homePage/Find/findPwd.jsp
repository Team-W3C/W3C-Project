<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기 (1/2) - MediFlow</title>

    <%-- (필요한 CSS 링크들) --%>
    <link rel="stylesheet" href="${contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${contextPath}/css/Find/find.css"> <%-- 아이디 찾기 CSS 재활용 --%>

    <style>
        /* 컨트롤러에서 보낸 에러 메시지 스타일 */
        .error-message {
            color: red;
            font-size: 0.9em;
            margin-top: 5px;
            text-align: left;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/homePageMember/header.jsp" />

<main class="form-wrapper">
    <div class="form-container">
        <h1 class="form-title">비밀번호 찾기</h1>
        <p style="text-align: center; margin-bottom: 20px;">가입 시 사용한 아이디를 입력해 주세요.</p>

        <%-- 1단계: 아이디 확인 폼 --%>
        <%-- 아이디 확인을 처리할 컨트롤러 URL을 action에 입력합니다. --%>
        <form action="${contextPath}/findPwd-checkId.me" method="post" id="findPwdCheckForm">

            <div class="form-group">
                <label for="memberId">아이디</label>
                <input type="text" id="memberId" name="memberId" placeholder="아이디를 입력하세요" required>
            </div>

            <%--
              만약 컨트롤러에서 아이디가 없다고 판단하면,
              이 페이지로 다시 돌아오면서 에러 메시지를 표시합니다.
            --%>
            <c:if test="${not empty errorMessage}">
                <div class="error-message">
                    <p>${errorMessage}</p>
                </div>
            </c:if>

            <button type="submit" class="form-button">다음</button>
        </form>

        <div class="form-links">
            <a href="${contextPath}/member/findId">아이디 찾기</a>
            <span>|</span>
            <a href="${contextPath}/member/loginPage">로그인</a>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/homePageFooter/footer.jsp" />

</body>
</html>