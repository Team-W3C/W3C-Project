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

    <%-- 공통 CSS (헤더, 푸터) --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">

    <%-- 이 페이지 전용 CSS (로그인, 회원가입 등과 공유 가능) --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Find/find.css">
</head>
<body>

<%--
  '아이디 찾기' 페이지에 맞는 헤더를 include 합니다.
  (예: 로그아웃 상태의 헤더)
  경로는 프로젝트 구조에 맞게 수정하세요.
--%>
<jsp:include page="/WEB-INF/views/common/homePageMember/header.jsp" />

<%-- 메인 콘텐츠: 아이디 찾기 폼 --%>
<main class="form-wrapper">
    <div class="form-container">
        <h1 class="form-title">아이디 찾기</h1>

        <%--
          아이디 찾기 결과를 처리할 Controller URL을 action에 입력합니다.
          (예: /findIdResult.me)
        --%>
        <form action="${contextPath}/findId.me" method="post" id="findIdForm">

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
            <%-- 비밀번호 찾기 페이지로 이동하는 링크 --%>
            <a href="${contextPath}/member/findPwd">비밀번호 찾기</a>
            <span>|</span>
            <%-- 로그인 페이지로 이동하는 링크 --%>
            <a href="${pageContext.request.contextPath}/member/loginPage">로그인</a>
        </div>

    </div>
</main>

<%-- 공통 푸터 --%>
<jsp:include page="/WEB-INF/views/common/homePageFooter/footer.jsp" />

</body>
</html>