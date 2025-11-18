<%--
  Created by IntelliJ IDEA.
  User: dream
  Date: 25. 11. 5.
  Time: 오전 10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>문의사항</title>
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
    <select class="inquiry-category-btn" id="inquiryCategorySelect" aria-label="카테고리 선택">
      <option value="">전체</option>
      <option value="1" <c:if test="${category == '1'}">selected</c:if>>결제</option>
      <option value="2" <c:if test="${category == '2'}">selected</c:if>>진료</option>
      <option value="3" <c:if test="${category == '3'}">selected</c:if>>기타</option>
      <option value="4" <c:if test="${category == '4'}">selected</c:if>>시스템</option>
      <option value="5" <c:if test="${category == '5'}">selected</c:if>>예약</option>
    </select>

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
              value="${keyword}"
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
        <th scope="col">처리 현황</th>
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
          <c:forEach var="b" items="${list}">
            <tr onclick="location.href='${pageContext.request.contextPath}/member/inquiry-detail?bno=${b.boardId}'">
              <td>${b.boardId}</td>
              <td>${b.boardTypeName}</td>
              <td>${b.boardTitle}</td>
              <c:if test="${b.boardSecretTypeName =='비밀'}">
              <td><span class="inquiry-privacy-badge private">${b.boardSecretTypeName}</span></td>
              </c:if>
              <c:if test="${b.boardSecretTypeName =='공개'}">
                <td><span class="inquiry-privacy-badge public">${b.boardSecretTypeName}</span></td>
              </c:if>

              <td>${b.boardStatus}</td>
              <td><time datetime="${b.questionDate}">${b.questionDate}</time></td>
            </tr>
          </c:forEach>
        </c:otherwise>
      </c:choose>
      </tbody>
    </table>
  </section>
  <div class="inquiry-form-header">
      <c:if test="${not empty loginMember}">

        <button class="inquiry-form-view-btn" type="button" onclick="location.href='${pageContext.request.contextPath}/member/inquiry-insert'">문의 하기</button>
    </c:if>
    <c:if test="${ empty loginMember}">
      문의 하시려면 로그인을 하시거나 고객센터에 전화주세요.
    </c:if>
   </div>
  <nav class="inquiry-pagination" aria-label="페이지네이션">
    <c:choose>
      <c:when test="${empty keyword and empty category}">
        <c:if test="${pi.currentPage > 1}">
          <a href="${pageContext.request.contextPath}/member/inquiry-board?cpage=${pi.currentPage - 1}" class="prev" aria-label="이전 페이지">
            ← Previous
          </a>
        </c:if>

        <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
          <c:choose>
            <c:when test="${i == pi.currentPage}">
              <a href="#" class="active" aria-label="${i}페이지" aria-current="page">${i}</a>
            </c:when>
            <c:otherwise>
              <a href="${pageContext.request.contextPath}/member/inquiry-board?cpage=${i}" aria-label="${i}페이지">${i}</a>
            </c:otherwise>
          </c:choose>
        </c:forEach>

        <c:if test="${pi.currentPage < pi.maxPage}">
          <a href="${pageContext.request.contextPath}/member/inquiry-board?cpage=${pi.currentPage + 1}" class="next" aria-label="다음 페이지">
            Next →
          </a>
        </c:if>
      </c:when>
      <c:otherwise>
        <c:if test="${pi.currentPage > 1}">
          <a href="${pageContext.request.contextPath}/member/inquiry-board?cpage=${pi.currentPage - 1}&keyword=${keyword}&category=${category}" class="prev" aria-label="이전 페이지">
            ← Previous
          </a>
        </c:if>

        <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
          <c:choose>
            <c:when test="${i == pi.currentPage}">
              <a href="#" class="active" aria-label="${i}페이지" aria-current="page">${i}</a>
            </c:when>
            <c:otherwise>
              <a href="${pageContext.request.contextPath}/member/inquiry-board?cpage=${i}&keyword=${keyword}&category=${category}" aria-label="${i}페이지">${i}</a>
            </c:otherwise>
          </c:choose>
        </c:forEach>

        <c:if test="${pi.currentPage < pi.maxPage}">
          <a href="${pageContext.request.contextPath}/member/inquiry-board?cpage=${pi.currentPage + 1}&keyword=${keyword}&category=${category}" class="next" aria-label="다음 페이지">
            Next →
          </a>
        </c:if>
      </c:otherwise>
    </c:choose>
  </nav>
</main>
    <c:if test="${pi!= null}">
  <!-- 총 개수 -->
  <div class="inquiry-count">
    총 ${pi.listCount}개의 문의사항
  </div>
    </c:if>

</main>
<jsp:include page="../../common/homePageFooter/footer.jsp" />
<script>
  document.addEventListener("DOMContentLoaded", function() {
    const searchInput = document.getElementById("inquiry-search");
    const categorySelect = document.getElementById("inquiryCategorySelect");

    // 카테고리 선택 시 검색
    categorySelect.addEventListener("change", function() {
      performSearch();
    });

    // 검색 함수
    function performSearch() {
      const keyword = searchInput.value || "";
      const category = categorySelect.value || "";
      const url = "${pageContext.request.contextPath}/member/inquiry-board?cpage=1&keyword=" + encodeURIComponent(keyword) + "&category=" + encodeURIComponent(category);
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
