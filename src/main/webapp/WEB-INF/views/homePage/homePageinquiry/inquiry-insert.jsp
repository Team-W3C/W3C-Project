<%--
  Created by IntelliJ IDEA.
  User: dream
  Date: 25. 11. 5.
  Time: 오전 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FAQ</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homePageinquiry/inquiry-insert.css">
<%--    헤더푸터 css--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/index.css">
</head>
<body>
<%--헤더--%>
<jsp:include page="../../common/homePageMember/header_member.jsp" />

<!-- 메인 컨텐츠 영역 -->
<main class="faq-main">


  <!-- 왼쪽 영역 (FAQ + 문의폼) -->
  <div class="faq-left-section">

    <!-- FAQ 헤더 -->
    <header class="faq-header">
      <h1>FAQ</h1>
      <p>문의사항 남겨주시면 빠른 시일 내로 응답해드리겠습니다.</p>
    </header>

    <!-- FAQ 질문 목록 -->
    <section class="faq-list" aria-label="자주 묻는 질문">
      <article class="faq-item">
        <h3 class="faq-item-question">Q1. 예약 후 확정 메시지를 받을 수 있나요?</h3>
        <p class="faq-item-answer">
          A1. 네, 예약이 확정되는 즉시 환자분께 자동 알림 메시지(SMS/카카오톡)가 발송됩니다. 예약 내역은 [마이 대시보드]에서도 언제든지 확인하실 수 있습니다.
        </p>
      </article>

      <article class="faq-item">
        <h3 class="faq-item-question">Q2. 예약 시간을 변경하거나 취소하려면 어떻게 해야 하나요?</h3>
        <p class="faq-item-answer">
          A2. [마이 대시보드]의 [예약 현황] 메뉴에서 예약 건을 선택하시면 변경 및 취소가 가능합니다. 단, 취소 시 패널티가 발생할 수 있는 규정이 있다면 사전에 확인해 주십시오.
        </p>
      </article>

      <article class="faq-item">
        <h3 class="faq-item-question">Q3. 예약 당일 잊지 않도록 알림을 받을 수 있나요?</h3>
        <p class="faq-item-answer">
          A3. 네, 예약하신 날짜 하루 전에 리마인더 알림 메시지가 자동으로 발송됩니다. 알림 설정은 [마이 대시보드]에서 관리하실 수 있습니다.
        </p>
      </article>
    </section>

    <!-- 문의사항 폼 -->
    <section class="inquiry-form-section" aria-label="문의사항 작성">

      <h2>문의사항</h2>
      <br><br>
      <form class="inquiry-form" method="post" action="#">

        <!-- 성함 -->
        <div class="inquiry-form-group half-width">
          <label for="inquiry-name" class="inquiry-form-label">성함</label>
          <input
                  type="text"
                  id="inquiry-name"
                  name="name"
                  class="inquiry-form-input"
                  placeholder="홍길동"
                  required
                  aria-required="true"
          >
        </div>

        <!-- 비밀 여부 -->
        <div class="inquiry-form-group small-width">
          <label for="inquiry-privacy" class="inquiry-form-label">비밀 여부</label>
          <select
                  id="inquiry-privacy"
                  name="privacy"
                  class="inquiry-form-select"
                  required
                  aria-required="true"
          >
            <option value="">선택</option>
            <option value="public">공개</option>
            <option value="private">비공개</option>
          </select>
        </div>

        <!-- 구분 -->
        <div class="inquiry-form-group small-width">
          <label for="inquiry-category" class="inquiry-form-label">구분</label>
          <select
                  id="inquiry-category"
                  name="category"
                  class="inquiry-form-select"
                  required
                  aria-required="true"
          >
            <option value="">선택</option>
            <option value="reservation">예약</option>
            <option value="system">시스템</option>
            <option value="medical">진료</option>
            <option value="etc">기타</option>
          </select>
        </div>

        <!-- 이메일 주소 -->
        <div class="inquiry-form-group full-width">
          <label for="inquiry-email" class="inquiry-form-label">이메일 주소</label>
          <input
                  type="email"
                  id="inquiry-email"
                  name="email"
                  class="inquiry-form-input"
                  placeholder="email@janesfakedomain.net"
                  required
                  aria-required="true"
          >
        </div>

        <!-- 메시지 -->
        <div class="inquiry-form-group full-width">
          <label for="inquiry-message" class="inquiry-form-label">메시지</label>
          <textarea
                  id="inquiry-message"
                  name="message"
                  class="inquiry-form-textarea"
                  placeholder="질문이나 메시지를 입력하세요"
                  required
                  aria-required="true"
          ></textarea>
        </div>

        <!-- 제출 버튼 -->
        <button type="submit" class="inquiry-form-submit">문의 사항 제출</button>
      </form>
    </section>
    <button class="inquiry-detail-back-btn" type="button" aria-label="목록으로 돌아가기"
            onclick="location.href='${pageContext.request.contextPath}/member/inquiry-board'">
      <svg viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M10 12L6 8L10 4" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>
      <p>목록으로</p>
    </button>
  </div>



  <!-- 오른쪽 영역 (이미지) -->
  <aside class="faq-right-section" aria-label="시스템 이미지">
    <p>이미지 영역 (508x657px)</p>
  </aside>

</main>
<%--푸터--%>
<jsp:include page="../../common/homePageFooter/footer.jsp" />

</body>
</html>