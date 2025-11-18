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
    <select class="notice-category-btn" id="noticeCategorySelect" aria-label="카테고리 선택">
      <option value="">전체</option>
      <option value="1" <c:if test="${category == '1'}">selected</c:if>>시스템</option>
      <option value="2" <c:if test="${category == '2'}">selected</c:if>>운영</option>
      <option value="3" <c:if test="${category == '3'}">selected</c:if>>진료</option>
    </select>

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
              value="${keyword}"
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
      <c:choose>
        <c:when test="${empty list}">
          <tr>
            <td colspan="5" style="text-align: center; padding: 40px 0; color: #666;">
              결과가 없습니다
            </td>
          </tr>
        </c:when>
        <c:otherwise>
          <c:forEach var="notice" items="${list}">
            <tr onclick="location.href='${pageContext.request.contextPath}/member/notice-detail?nNo=${notice.notificationNo}'">
              <td>${notice.notificationNo}</td>
              <td>${notice.notificationTypeName}</td>
              <td><a href="#">${notice.notificationTitle}</a></td>
              <td>${notice.departmentName}</td>
              <td><time datetime="${notice.notificationDate}">${notice.notificationDate}</time></td>
            </tr>
          </c:forEach>
        </c:otherwise>
      </c:choose>

      </tbody>
    </table>
  </section>

  <!-- 페이지네이션 -->
  <nav class="notice-pagination" aria-label="페이지네이션">
    <c:choose>
      <c:when test="${empty keyword and empty category}">
        <c:if test="${pi.currentPage > 1}">
          <a href="${pageContext.request.contextPath}/member/notice?cpage=${pi.currentPage - 1}" class="prev" aria-label="이전 페이지">
            ← Previous
          </a>
        </c:if>

        <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
          <c:choose>
            <c:when test="${i == pi.currentPage}">
              <a href="#" class="active" aria-label="${i}페이지" aria-current="page">${i}</a>
            </c:when>
            <c:otherwise>
              <a href="${pageContext.request.contextPath}/member/notice?cpage=${i}" aria-label="${i}페이지">${i}</a>
            </c:otherwise>
          </c:choose>
        </c:forEach>

        <c:if test="${pi.currentPage < pi.maxPage}">
          <a href="${pageContext.request.contextPath}/member/notice?cpage=${pi.currentPage + 1}" class="next" aria-label="다음 페이지">
            Next →
          </a>
        </c:if>
      </c:when>
      <c:otherwise>
        <c:if test="${pi.currentPage > 1}">
          <a href="${pageContext.request.contextPath}/member/notice?cpage=${pi.currentPage - 1}&keyword=${keyword}&category=${category}" class="prev" aria-label="이전 페이지">
            ← Previous
          </a>
        </c:if>

        <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
          <c:choose>
            <c:when test="${i == pi.currentPage}">
              <a href="#" class="active" aria-label="${i}페이지" aria-current="page">${i}</a>
            </c:when>
            <c:otherwise>
              <a href="${pageContext.request.contextPath}/member/notice?cpage=${i}&keyword=${keyword}&category=${category}" aria-label="${i}페이지">${i}</a>
            </c:otherwise>
          </c:choose>
        </c:forEach>

        <c:if test="${pi.currentPage < pi.maxPage}">
          <a href="${pageContext.request.contextPath}/member/notice?cpage=${pi.currentPage + 1}&keyword=${keyword}&category=${category}" class="next" aria-label="다음 페이지">
            Next →
          </a>
        </c:if>
      </c:otherwise>
    </c:choose>
  </nav>
  <!-- 총 개수 -->
  <div class="notice-count">
    총 ${pi.listCount}개의 공지사항
  </div>

</main>

<!-- Footer include-->
<jsp:include page="/WEB-INF/views/common/homePageFooter/footer.jsp" />
<script>
  document.addEventListener("DOMContentLoaded", function() {
    const searchInput = document.getElementById("notice-search");
    const categorySelect = document.getElementById("noticeCategorySelect");

    // 카테고리 선택 시 검색
    categorySelect.addEventListener("change", function() {
      performSearch();
    });

    // 검색 함수
    function performSearch() {
      const keyword = searchInput.value || "";
      const category = categorySelect.value || "";
      const url = "${pageContext.request.contextPath}/member/notice?cpage=1&keyword=" + encodeURIComponent(keyword) + "&category=" + encodeURIComponent(category);
      location.href = url;
    }

    // 엔터키 검색
    searchInput.addEventListener("keypress", function(e) {
      if (e.key === "Enter") {
        e.preventDefault();
        performSearch();
      }
    });
  });
</script>
</body>
</html>
