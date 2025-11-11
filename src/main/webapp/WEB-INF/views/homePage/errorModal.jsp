<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%--
  [재사용 가능한 공통 에러 모달]
  컨트롤러에서 3개의 값을 Model에 담아서 이 페이지로 전달해야 합니다.

  1. modalTitle   : 모달 창의 제목 (예: "로그인 실패")
  2. modalMessage : 모달 창의 본문 (예: "아이디가 존재하지 않습니다.")
  3. redirectUrl  : '확인' 버튼 클릭 시 돌아갈 페이지 주소 (예: "/login.me")
--%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <%-- 1. 컨트롤러에서 받은 제목으로 <title> 설정 --%>
    <title>${modalTitle} - MediFlow</title>

    <%--
      폰트 (사이트 공통 CSS에 이미 있다면 생략 가능)
      <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    --%>

    <%-- 2. 위에서 만든 modal.css 파일을 링크합니다. --%>
    <link rel="stylesheet" href="${contextPath}/css/error/errorModal.css">

</head>
<body class="modal-open"> <%-- 스크롤 방지용 클래스 추가 (선택 사항) --%>


<div class="modal-overlay">
    <div class="modal-container">

        <div class="modal-header">
            <%-- 3. 컨트롤러에서 받은 제목 표시 --%>
            <h2>${modalTitle}</h2>
        </div>

        <div class="modal-body">
            <%-- 4. 컨트롤러에서 받은 메시지 표시 --%>
            <p>${modalMessage}</p>
        </div>

        <div class="modal-footer">
            <%-- 5. 컨트롤러에서 받은 주소로 이동하는 '확인' 버튼 --%>
            <button type="button" class="modal-button" onclick="goToRedirectUrl()">
                확인
            </button>
        </div>
    </div>
</div>

<script>
    function goToRedirectUrl() {
        // 6. 컨트롤러에서 받은 redirectUrl로 페이지 이동
        window.location.href = "${redirectUrl}";
    }
</script>

</body>
</html>