<%--
  Created by IntelliJ IDEA.
  User: dream
  Date: 25. 11. 6.
  Time: 오후 12:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>공지사항 - 병원 관리 시스템</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homePageNotice/notice-member.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/index.css">
</head>
<body>
<!-- Header Include -->
<jsp:include page="/WEB-INF/views/common/homePageMember/header.jsp" />
<!-- 메인 컨텐츠 영역 -->
<main class="notice-main">

  <!-- 페이지 제목 -->
  <h1 class="notice-title">공지사항</h1>

  <!-- 검색 영역 -->
  <section class="notice-search-section" aria-label="공지사항 검색">
    <button class="notice-category-btn" type="button" aria-label="카테고리 선택">
      전체
    </button>

    <div class="notice-search-input-wrapper">
      <label for="notice-search" class="visually-hidden">공지사항 검색</label>
      <svg class="notice-search-icon" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <circle cx="8.5" cy="8.5" r="6" stroke="currentColor" stroke-width="1.5"/>
        <path d="M13 13L17 17" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
      </svg>
      <input
              type="search"
              id="notice-search"
              class="notice-search-input"
              placeholder="제목으로 검색하세요"
              aria-label="제목으로 검색하세요"
      >
    </div>
  </section>

  <!-- 공지사항 테이블 -->
  <section class="notice-table-section" aria-label="공지사항 목록">
    <div class="notice-table-header">
      <h2>공지사항 목록</h2>
    </div>

    <table class="notice-table">
      <thead>
      <tr>
        <th scope="col">번호</th>
        <th scope="col">구분</th>
        <th scope="col">제목</th>
        <th scope="col">작성부서</th>
        <th scope="col">등록일</th>
      </tr>
      </thead>
      <tbody>

      <tr onclick="location.href='${pageContext.request.contextPath}/member/notice-detail'">
        <td>15</td>
        <td>시스템</td>
        <td><a href="#">EMR 시스템 정기 점검 안내 (2025년 1월)</a></td>
        <td>정보시스템팀</td>
        <td><time datetime="2025-01-15">2025-01-15</time></td>
      </tr>
      <tr>
        <td>14</td>
        <td>시스템</td>
        <td><a href="#">처방전달시스템(OCS) 업데이트 완료</a></td>
        <td>정보시스템팀</td>
        <td><time datetime="2025-01-10">2025-01-10</time></td>
      </tr>
      <tr>
        <td>13</td>
        <td>진료</td>
        <td><a href="#">내과 외래진료 시간 변경 안내</a></td>
        <td>진료지원팀</td>
        <td><time datetime="2025-01-05">2025-01-05</time></td>
      </tr>
      <tr>
        <td>12</td>
        <td>행정</td>
        <td><a href="#">의료보험 청구 기준 변경 공지</a></td>
        <td>원무팀</td>
        <td><time datetime="2024-12-28">2024-12-28</time></td>
      </tr>
      <tr>
        <td>11</td>
        <td>안전</td>
        <td><a href="#">겨울철 감염관리 지침 강화</a></td>
        <td>의료안전팀</td>
        <td><time datetime="2024-12-20">2024-12-20</time></td>
      </tr>
      <tr>
        <td>10</td>
        <td>교육</td>
        <td><a href="#">신규 의료장비 도입 및 사용 교육 일정</a></td>
        <td>의공학팀</td>
        <td><time datetime="2024-12-15">2024-12-15</time></td>
      </tr>
      <tr>
        <td>9</td>
        <td>교육</td>
        <td><a href="#">개인정보보호법 준수사항 교육 필수 참석</a></td>
        <td>인사팀</td>
        <td><time datetime="2024-12-10">2024-12-10</time></td>
      </tr>
      <tr>
        <td>8</td>
        <td>진료</td>
        <td><a href="#">응급실 트리아지 시스템 개선</a></td>
        <td>응급의학과</td>
        <td><time datetime="2024-12-01">2024-12-01</time></td>
      </tr>
      <tr>
        <td>7</td>
        <td>시스템</td>
        <td><a href="#">전자의무기록(EMR) 백업 시스템 점검 완료</a></td>
        <td>정보시스템팀</td>
        <td><time datetime="2024-11-25">2024-11-25</time></td>
      </tr>
      <tr>
        <td>6</td>
        <td>시스템</td>
        <td><a href="#">외래 예약 시스템 기능 추가</a></td>
        <td>정보시스템팀</td>
        <td><time datetime="2024-11-20">2024-11-20</time></td>
      </tr>
      </tbody>
    </table>
  </section>

  <!-- 페이지네이션 -->
  <nav class="notice-pagination" aria-label="페이지네이션">
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
  <div class="notice-count">
    총 15개의 공지사항
  </div>

</main>
<!-- Footer include-->
<jsp:include page="/WEB-INF/views/common/homePageFooter/footer.jsp" />
</body>
</html>
