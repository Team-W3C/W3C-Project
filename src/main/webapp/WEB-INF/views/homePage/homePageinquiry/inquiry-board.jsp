<%--
  Created by IntelliJ IDEA.
  User: dream
  Date: 25. 11. 5.
  Time: 오전 10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>inquery-board</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homePageinquiry/inquiry-board.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/signUp.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/index.css">
<body>

<!--헤더-->
<jsp:include page="../../common/homePageMember/header.jsp" />

<!-- 메인 컨텐츠 영역 -->
<main class="inquiry-main">

  <!-- 페이지 제목 -->
  <h1 class="inquiry-title">문의사항</h1>

  <!-- 검색 영역 -->
  <section class="inquiry-search-section" aria-label="문의사항 검색">
    <button class="inquiry-category-btn" type="button" aria-label="카테고리 선택">
      전체
    </button>

    <div class="inquiry-search-input-wrapper">
      <label for="inquiry-search" class="visually-hidden">문의사항 검색</label>
      <svg class="inquiry-search-icon" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <circle cx="8.5" cy="8.5" r="6" stroke="currentColor" stroke-width="1.5"/>
        <path d="M13 13L17 17" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
      </svg>
      <input
              type="search"
              id="inquiry-search"
              class="inquiry-search-input"
              placeholder="제목으로 검색하세요"
              aria-label="제목으로 검색하세요"
      >
    </div>
  </section>

  <!-- 문의사항 테이블 -->
  <section class="inquiry-table-section" aria-label="문의사항 목록">
    <div class="inquiry-table-header">
      <h2>문의사항 목록</h2>
    </div>

    <table class="inquiry-table">
      <thead>
      <tr>
        <th scope="col">번호</th>
        <th scope="col">구분</th>
        <th scope="col">제목</th>
        <th scope="col">비밀 여부</th>
        <th scope="col">담당 부서</th>
        <th scope="col">등록일</th>
      </tr>
      </thead>
      <tbody>
      <tr onclick="location.href='${pageContext.request.contextPath}/member/inquiry-detail'">
        <td>15</td>
        <td>진료</td>
        <td>예약된 진료 외에 다른 진료도 당일에 추가로 받을 수 있나요?</td>
        <td><span class="inquiry-privacy-badge public">무</span></td>
        <td>정보시스템팀</td>
        <td><time datetime="2025-01-15">2025-01-15</time></td>
      </tr>
      <tr>
        <td>14</td>
        <td>진료</td>
        <td>진료 전 (검사 때문에) 금식이나 특별히 준비해야 할 사항이 있나요?</td>
        <td><span class="inquiry-privacy-badge private">유</span></td>
        <td>정보시스템팀</td>
        <td><time datetime="2025-01-10">2025-01-10</time></td>
      </tr>
      <tr>
        <td>13</td>
        <td>예약</td>
        <td>예약 없이 급하게 방문하면 진료를 받을 수 있나요?</td>
        <td><span class="inquiry-privacy-badge public">무</span></td>
        <td>진료지원팀</td>
        <td><time datetime="2025-01-05">2025-01-05</time></td>
      </tr>
      <tr>
        <td>12</td>
        <td>결제 및 비용</td>
        <td>진료비는 현장에서 바로 결제해야 하나요?</td>
        <td><span class="inquiry-privacy-badge private">유</span></td>
        <td>원무팀</td>
        <td><time datetime="2024-12-28">2024-12-28</time></td>
      </tr>
      <tr>
        <td>11</td>
        <td>결제 및 비용</td>
        <td>실손 보험금 청구를 위해 필요한 서류는 무엇이며, 어디서 발급받나요?</td>
        <td><span class="inquiry-privacy-badge public">무</span></td>
        <td>원무팀</td>
        <td><time datetime="2024-12-20">2024-12-20</time></td>
      </tr>
      <tr>
        <td>10</td>
        <td>기타</td>
        <td>주차장이 따로 마련되어 있나요?</td>
        <td><span class="inquiry-privacy-badge public">무</span></td>
        <td>원무팀</td>
        <td><time datetime="2024-12-15">2024-12-15</time></td>
      </tr>
      <tr>
        <td>9</td>
        <td>진료</td>
        <td>검사 결과는 언제쯤 나오며, 결과를 어떻게 확인할 수 있나요?</td>
        <td><span class="inquiry-privacy-badge private">유</span></td>
        <td>원무팀</td>
        <td><time datetime="2024-12-10">2024-12-10</time></td>
      </tr>
      <tr>
        <td>8</td>
        <td>결제 및 비용</td>
        <td>진료 기록 사본이나 진단서를 발급받으려면 어떤 절차가 필요하고 비용은 얼마인가요?</td>
        <td><span class="inquiry-privacy-badge public">무</span></td>
        <td>응급의학과</td>
        <td><time datetime="2024-12-01">2024-12-01</time></td>
      </tr>
      <tr>
        <td>7</td>
        <td>예약</td>
        <td>기존에 처방받은 약을 추가로 받거나 재진 예약을 하려면 어떻게 해야 하나요?</td>
        <td><span class="inquiry-privacy-badge private">유</span></td>
        <td>정보시스템팀</td>
        <td><time datetime="2024-11-25">2024-11-25</time></td>
      </tr>
      <tr>
        <td>6</td>
        <td>진료</td>
        <td>병원에 도착해서 가장 먼저 해야 할 접수 절차가 궁금합니다</td>
        <td><span class="inquiry-privacy-badge public">무</span></td>
        <td>정보시스템팀</td>
        <td><time datetime="2024-11-20">2024-11-20</time></td>
      </tr>
      </tbody>
    </table>
  </section>
  <div class="inquiry-form-header">

    <button class="inquiry-form-view-btn" type="button" onclick="location.href='${pageContext.request.contextPath}/member/inquiry-insert'">문의 하기</button>
  </div>
  <!-- 페이지네이션 -->
  <nav class="inquiry-pagination" aria-label="페이지네이션">
    <a href="#" class="prev" aria-label="이전 페이지">
      ← Previous
    </a>
    <a href="#" class="active" aria-label="1페이지" aria-current="page">1</a>
    <a href="#" aria-label="2페이지">2</a>
    <a href="#" class="next" aria-label="다음 페이지">
      Next →
    </a>
  </nav>

  <!-- 총 개수 -->
  <div class="inquiry-count">
    총 15개의 문의사항
  </div>

</main>
<jsp:include page="../../common/homePageFooter/footer.jsp" />
</body>
</html>
