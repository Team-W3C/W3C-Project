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

    <%-- (필요한 CSS 링크들) --%>
    <link rel="stylesheet" href="${contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${contextPath}/css/Find/findId.css"> <%-- 아이디 찾기 CSS 재활용 --%>

    <style>
        /* 비밀번호 불일치 에러 메시지 스타일 */
        #passwordError {
            color: red;
            font-size: 0.9em;
            display: none; /* 기본은 숨김 */
            margin-top: 5px;
            text-align: left;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/homePageMember/header.jsp" />

<main class="form-wrapper">
    <div class="form-container">
        <h1 class="form-title">비밀번호 재설정</h1>
        <p style="text-align: center; margin-bottom: 20px;">
            '${memberId}' 님의 새 비밀번호를 입력해 주세요.
        </p>

        <%-- 2단계: 새 비밀번호 입력 폼 --%>
        <%-- 최종적으로 비밀번호를 변경할 컨트롤러 URL을 action에 입력합니다. --%>
        <form action="${contextPath}/findPwd-update.me" method="post" id="resetPwdForm" onsubmit="return validatePassword();">

            <%--
              컨트롤러에서 Model로 넘겨준 memberId를 숨겨둡니다.
              어떤 회원의 비밀번호를 바꿀지 서버에 알려주기 위해 필수!
            --%>
            <input type="hidden" name="memberId" value="${memberId}">

            <div class="form-group">
                <label for="memberPwd">새 비밀번호</label>
                <input type="password" id="memberPwd" name="memberPwd" placeholder="새 비밀번호를 입력하세요" required>
            </div>

            <div class="form-group">
                <label for="memberPwdConfirm">새 비밀번호 확인</label>
                <input type="password" id="memberPwdConfirm" name="memberPwdConfirm" placeholder="새 비밀번호를 다시 입력하세요" required>
            </div>

            <div id="passwordError">
                <p>비밀번호가 일치하지 않습니다.</p>
            </div>

            <button type="submit" class="form-button">비밀번호 변경</button>
        </form>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/homePageFooter/footer.jsp" />

<%-- 간단한 자바스크립트로 2개 비밀번호가 일치하는지 확인 --%>
<script>
    function validatePassword() {
        var pwd = document.getElementById('memberPwd').value;
        var pwdConfirm = document.getElementById('memberPwdConfirm').value;
        var errorDiv = document.getElementById('passwordError');

        if (pwd !== pwdConfirm) {
            errorDiv.style.display = 'block'; // 에러 메시지 보이기
            return false; // 폼 제출(submit)을 막음
        }

        errorDiv.style.display = 'none'; // 에러 메시지 숨기기
        return true; // 폼 제출(submit)을 허용
    }
</script>

</body>
</html>