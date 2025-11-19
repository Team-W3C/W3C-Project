<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 재설정 (2/2) - MediFlow</title>

    <link rel="stylesheet" href="${contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${contextPath}/css/Find/find.css">

    <style>
        /* 에러 메시지 스타일 추가 */
        .error-message {
            color: #ff4d4d;
            font-size: 0.9em;
            margin-top: 10px;
            text-align: left;
            font-weight: 500;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/homePageMember/header.jsp" />

<main class="form-wrapper">
    <div class="form-container">
        <h1 class="form-title">비밀번호 재설정</h1>
        <p style="text-align: center; margin-bottom: 20px; color: #666;">
            새로운 비밀번호를 입력해 주세요.
        </p>

        <form action="${contextPath}/member/findPwd-update.me" method="post">
            <%-- Controller에서 넘겨받은 memberId 유지 --%>
            <input type="hidden" name="memberId" value="${memberId}">

            <div class="form-group">
                <label for="memberPwd">새 비밀번호</label>
                <input type="password" id="memberPwd" name="memberPwd" placeholder="새 비밀번호 입력" required>
            </div>

            <%-- [추가] 에러 메시지 표시 영역 --%>
            <c:if test="${not empty errorMessage}">
                <div class="error-message">
                    * ${errorMessage}
                </div>
            </c:if>

            <button type="submit" class="form-button">변경하기</button>
        </form>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/homePageFooter/footer.jsp" />

</body>
</html>