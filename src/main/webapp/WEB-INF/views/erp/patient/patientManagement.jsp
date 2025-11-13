<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>환자관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/erpPatient/patientDetail.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/erpPatient/patientManage.css"/>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/erpPatient/patientRegistration.css"/>
    <link href="${pageContext.request.contextPath}/css/dashBoard/erpDashBoard.css" rel="stylesheet"/>

      <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
  <jsp:include page="/WEB-INF/views/common/erp/sidebar.jsp" />
  <jsp:include page="/WEB-INF/views/common/erp/header.jsp" />
    <main class="patient-main">
      <!-- 페이지 헤더 -->
      <section class="patient-header">
        <h1 class="patient-title">환자 관리</h1>
        <button class="patient-btn-add" id="openRegisterModalBtn">
          <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
            <path d="M8 3.33337V12.6667M3.33333 8H12.6667" stroke="white" stroke-width="1.5" stroke-linecap="round"/>
          </svg>
          신규 환자 등록
        </button>
      </section>
      <!-- 통계 카드 -->
      <section class="patient-stats">
        <div class="patient-stat-card">
          <p class="patient-stat-label">전체 환자</p>
          <p class="patient-stat-value">${stats.totalCount}명</p>
        </div>
        <div class="patient-stat-card">
          <p class="patient-stat-label">오늘 방문</p>
          <p class="patient-stat-value">${stats.todayCount}명</p>
        </div>
        <div class="patient-stat-card">
          <p class="patient-stat-label">신규 환자 (이번 달)</p>
          <p class="patient-stat-value">${stats.newCount}명</p>
        </div>
        <div class="patient-stat-card">
          <p class="patient-stat-label">VIP 환자</p>
          <p class="patient-stat-value">${stats.vipCount}명</p>
        </div>
      </section>
      <!-- 검색 및 필터 -->
      <section class="patient-search-section">
        <div class="patient-search-wrapper">
          <div class="patient-search-box">
            <svg
              class="patient-search-icon"
              width="20"
              height="20"
              viewBox="0 0 20 20"
              fill="none"
            >
              <circle cx="9" cy="9" r="5.5" stroke="#9CA3AF" stroke-width="1.5"/>
              <path d="M13 13L16 16" stroke="#9CA3AF" stroke-width="1.5" stroke-linecap="round"/>
            </svg>
            <input type="text" class="patient-search-input" id="searchKeyword" placeholder="환자명, 환자번호, 연락처로 검색..." value="${keyword}"/>
          </div>

          <div class="patient-filter-group">
              <select class="patient-select" id="searchGrade"> <%-- [id 추가] --%>
                  <%-- [c:if를 이용해 컨트롤러에서 받은 grade 값으로 'selected' 처리] --%>
                  <option value="" <c:if test="${empty grade}">selected</c:if>>모든 등급</option>
                  <option value="일반" <c:if test="${grade == '일반'}">selected</c:if>>일반</option>
                  <option value="우선예약" <c:if test="${grade == '우선예약'}">selected</c:if>>우선예약</option>
                  <option value="VIP" <c:if test="${grade == 'VIP'}">selected</c:if>>VIP</option>
              </select>
          </div>

          <button class="patient-btn-search" id="searchBtn">검색</button>
        </div>
      </section>

      <!-- 환자 목록 테이블 -->
      <section class="patient-table-section">
        <div class="patient-table-wrapper">
          <table class="patient-table">
            <thead>
              <tr>
                <th>환자번호</th>
                <th>이름</th>
                <th>나이/성별</th>
                <th>연락처</th>
                <th>마지막 방문</th>
                <th>방문 횟수</th>
                <th>등급</th>
                <th>작업</th>
              </tr>
            </thead>
            <tbody>
            <c:forEach var="p" items="${list}">
                <tr>
                <td>${p.memberNo}</td>
                <td>${p.memberName}</td>
                <td>${p.age} /
                    <c:choose>
                    <c:when test="${p.memberGender == 'M'}">
                        남
                    </c:when>
                    <c:when test="${p.memberGender == 'F'}">
                        여
                    </c:when>
                    </c:choose>
                        </td>
                <td>${p.memberPhone}</td>
                <td>${p.lastVisitDate}</td>
                <td>${p.visitCount}</td>
                <td>
                    <c:choose>
                        <c:when test="${p.grade == 'VIP'}">
                            <span class="patient-badge patient-badge-vip">VIP</span>
                        </c:when>
                        <c:when test="${p.grade == '우선예약'}">
                            <span class="patient-badge patient-badge-priority">우선예약</span>
                        </c:when>
                        <c:when test="${p.grade == '일반'}">
                            <span class="patient-badge patient-badge-normal">일반</span>
                        </c:when>
                        <c:otherwise>
                            <span class="patient-badge patient-badge-normal">등급없음</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                  <button class="patient-btn-detail">상세보기</button>
                </td>
              </tr>
            </c:forEach>
            <%-- 만약 리스트가 비어있을 경우 --%>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="6">조회된 환자 정보가 없습니다.</td>
                </tr>
            </c:if>
            </tbody>
          </table>
        </div>

          <!-- 페이지네이션 -->
          <div class="patient-pagination">
              <div class="patient-pagination-buttons">
                  <%--
          컨트롤러에서 받은 keyword와 grade를 사용
          test 조건: 검색어(keyword)와 등급(grade)이 모두 비어있는가?
        --%>
                  <c:choose>
                      <%-- 1. 검색어가 없는 경우 (기본 목록) --%>
                      <c:when test="${empty keyword and empty grade}">
                          <%-- '이전' --%>
                          <c:if test="${pi.currentPage > 1}">
                              <button class="patient-page-btn"
                                      onclick="location.href='${pageContext.request.contextPath}/api/erp/patientList?cpage=${pi.currentPage - 1}'">
                                  이전
                              </button>
                          </c:if>
                          <%-- 페이지 번호 --%>
                          <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
                              <c:choose>
                                  <c:when test="${i == pi.currentPage}">
                                      <button class="patient-page-btn patient-page-active" disabled>${i}</button>
                                  </c:when>
                                  <c:otherwise>
                                      <button class="patient-page-btn"
                                              onclick="location.href='${pageContext.request.contextPath}/api/erp/patientList?cpage=${i}'">
                                              ${i}
                                      </button>
                                  </c:otherwise>
                              </c:choose>
                          </c:forEach>
                          <%-- '다음' --%>
                          <c:if test="${pi.currentPage < pi.maxPage}">
                              <button class="patient-page-btn"
                                      onclick="location.href='${pageContext.request.contextPath}/api/erp/patientList?cpage=${pi.currentPage + 1}'">
                                  다음
                              </button>
                          </c:if>
                      </c:when>

                      <%-- 2. 검색어가 있는 경우 (검색 결과 목록) --%>
                      <c:otherwise>
                          <%-- '이전' (keyword와 grade 파라미터 포함) --%>
                          <c:if test="${pi.currentPage > 1}">
                              <button class="patient-page-btn"
                                      onclick="location.href='${pageContext.request.contextPath}/api/erp/patientList?cpage=${pi.currentPage - 1}&keyword=${keyword}&grade=${grade}'">
                                  이전
                              </button>
                          </c:if>
                          <%-- 페이지 번호 (keyword와 grade 파라미터 포함) --%>
                          <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
                              <c:choose>
                                  <c:when test="${i == pi.currentPage}">
                                      <button class="patient-page-btn patient-page-active" disabled>${i}</button>
                                  </c:when>
                                  <c:otherwise>
                                      <button class="patient-page-btn"
                                              onclick="location.href='${pageContext.request.contextPath}/api/erp/patientList?cpage=${i}&keyword=${keyword}&grade=${grade}'">
                                              ${i}
                                      </button>
                                  </c:otherwise>
                              </c:choose>
                          </c:forEach>
                          <%-- '다음' (keyword와 grade 파라미터 포함) --%>
                          <c:if test="${pi.currentPage < pi.maxPage}">
                              <button class="patient-page-btn"
                                      onclick="location.href='${pageContext.request.contextPath}/api/erp/patientList?cpage=${pi.currentPage + 1}&keyword=${keyword}&grade=${grade}'">
                                  다음
                              </button>
                          </c:if>
                      </c:otherwise>
                  </c:choose>
              </div>
          </div>
      </section>
    </main>

    <div class="modal-patient-detail">
      <div class="modal-overlay">
        <!-- 모달 헤더 -->
        <header class="modal-patient-header">
          <div class="modal-profile">
            <div class="modal-avatar">김</div>
            <div class="modal-info">
              <div class="modal-title-wrapper">
                <h1 class="modal-name">김민수</h1>
                <span class="modal-badge">일반</span>
              </div>
              <div class="modal-meta">
                <span class="modal-age">45세 • 남</span>
                <span class="modal-number">환자번호: P001</span>
              </div>
            </div>
          </div>
          <button class="modal-btn-menu" aria-label="메뉴">
            <svg width="20" height="20" viewBox="0 0 20 20">
              <path d="M10 6a2 2 0 110-4 2 2 0 010 4zm0 6a2 2 0 110-4 2 2 0 010 4zm0 6a2 2 0 110-4 2 2 0 010 4z" fill="currentColor"/>
            </svg>
          </button>
        </header>

        <!-- 모달 콘텐츠 -->
        <div class="modal-content">
          <!-- 기본 정보 -->
          <section class="modal-section">
            <h2 class="modal-section-title">
              <svg width="16" height="16" viewBox="0 0 16 16" class="modal-section-icon">
                <rect x="3" y="10" width="10" height="4" fill="currentColor" />
                <circle cx="8" cy="5" r="3" fill="currentColor" />
              </svg>
              기본 정보
            </h2>
            <div class="modal-info-grid">
              <div class="modal-info-item">
                <span class="modal-info-label">생년월일</span>
                <span class="modal-info-value">1980.03.15</span>
              </div>
              <div class="modal-info-item">
                <span class="modal-info-label">혈액형</span>
                <span class="modal-info-value">A+</span>
              </div>
              <div class="modal-info-item">
                <span class="modal-info-label">등록일</span>
                <span class="modal-info-value">2024.01.10</span>
              </div>
              <div class="modal-info-item">
                <span class="modal-info-label">연락처</span>
                <span class="modal-info-value">010-1234-5678</span>
              </div>
              <div class="modal-info-item modal-info-full">
                <span class="modal-info-label">
                  <svg
                    width="12"
                    height="12"
                    viewBox="0 0 12 12"
                    class="modal-label-icon"
                  >
                    <path d="M6 0C3.243 0 1 2.243 1 5c0 3.188 4.5 7 5 7s5-3.812 5-7c0-2.757-2.243-5-5-5zm0 7a2 2 0 110-4 2 2 0 010 4z" fill="currentColor"/>
                  </svg>
                  주소
                </span>
                <span class="modal-info-value">서울시 강남구 테헤란로 123</span>
              </div>
            </div>
          </section>

          <!-- 의료 정보 -->
          <section class="modal-section">
            <h2 class="modal-section-title">
              <svg
                width="16"
                height="16"
                viewBox="0 0 16 16"
                class="modal-section-icon"
              >
                <path d="M13.5 2.5h-11A1.5 1.5 0 001 4v9.5A1.5 1.5 0 002.5 15h11a1.5 1.5 0 001.5-1.5V4a1.5 1.5 0 00-1.5-1.5z" fill="currentColor"/>
              </svg>
              의료 정보
            </h2>
            <div class="modal-medical-grid">
              <div class="modal-medical-item modal-medical-chronic">
                <span class="modal-medical-label">만성질환</span>
                <span class="modal-medical-value">천식</span>
              </div>
              <div class="modal-medical-item modal-medical-allergy">
                <span class="modal-medical-label">알러지</span>
                <span class="modal-medical-value">망고 알레르기</span>
              </div>
            </div>
          </section>

          <!-- 방문 통계 -->
          <section class="modal-section">
            <h2 class="modal-section-title">방문 통계</h2>
            <div class="modal-stats-grid">
              <div class="modal-stat-item modal-stat-primary">
                <span class="modal-stat-label">총 방문 횟수</span>
                <span class="modal-stat-value">12회</span>
              </div>
              <div class="modal-stat-item modal-stat-blue">
                <span class="modal-stat-label">10월 방문</span>
                <span class="modal-stat-value">3회</span>
              </div>
              <div class="modal-stat-item modal-stat-green">
                <span class="modal-stat-label">마지막 방문</span>
                <span class="modal-stat-value">2025-10-25</span>
              </div>
            </div>
          </section>

          <!-- 10월 진료 기록 -->
          <section class="modal-section">
            <h2 class="modal-section-title">
              <svg width="16" height="16" viewBox="0 0 16 16" class="modal-section-icon">
                <path d="M14 2h-2V1a1 1 0 00-2 0v1H6V1a1 1 0 00-2 0v1H2a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V4a2 2 0 00-2-2zM2 6h12v8H2V6z" fill="currentColor"/>
              </svg>
              10월 진료 기록
            </h2>
            <div class="modal-record-list">
              <article class="modal-record-card">
                <div class="modal-record-header">
                  <div class="modal-record-info">
                    <span class="modal-record-date">2025-10-25</span>
                    <span class="modal-record-dept modal-dept-ortho"
                      >정형외과</span
                    >
                  </div>
                  <span class="modal-record-status">완료</span>
                </div>
                <div class="modal-record-details">
                  <span class="modal-record-detail">담당의: 이준호</span>
                  <span class="modal-record-separator">•</span>
                  <span class="modal-record-detail">진단: 요통</span>
                </div>
              </article>
              <article class="modal-record-card">
                <div class="modal-record-header">
                  <div class="modal-record-info">
                    <span class="modal-record-date">2025-10-10</span>
                    <span class="modal-record-dept modal-dept-ortho"
                      >정형외과</span
                    >
                  </div>
                  <span class="modal-record-status">완료</span>
                </div>
                <div class="modal-record-details">
                  <span class="modal-record-detail">담당의: 이준호</span>
                  <span class="modal-record-separator">•</span>
                  <span class="modal-record-detail">진단: 정기검진</span>
                </div>
              </article>

              <article class="modal-record-card">
                <div class="modal-record-header">
                  <div class="modal-record-info">
                    <span class="modal-record-date">2025-10-05</span>
                    <span class="modal-record-dept modal-dept-internal"
                      >내과</span
                    >
                  </div>
                  <span class="modal-record-status">완료</span>
                </div>
                <div class="modal-record-details">
                  <span class="modal-record-detail">담당의: 김서연</span>
                  <span class="modal-record-separator">•</span>
                  <span class="modal-record-detail">진단: 감기</span>
                </div>
              </article>
            </div>
          </section>

          <!-- 예정된 예약 -->
          <section class="modal-section">
            <h2 class="modal-section-title">
              <svg width="16" height="16" viewBox="0 0 16 16" class="modal-section-icon">
                <path d="M8 0a8 8 0 100 16A8 8 0 008 0zm1 9H7V4h2v5z" fill="currentColor"/>
              </svg>
              예정된 예약
            </h2>
            <article class="modal-appointment-card">
              <div class="modal-appointment-header">
                <div class="modal-appointment-info">
                  <span class="modal-appointment-datetime"
                    >2025-11-05 14:00</span
                  >
                  <span class="modal-appointment-dept">정형외과</span>
                </div>
                <span class="modal-appointment-type">정기검진</span>
              </div>
              <div class="modal-appointment-doctor">담당의: 이준호</div>
            </article>
          </section>
        </div>
        <!-- 모달 푸터 -->
        <footer class="modal-footer">
          <button class="modal-btn modal-btn-secondary">닫기</button>
          <div class="modal-actions">
            <button class="modal-btn modal-btn-outline">정보 수정</button>
            <button class="modal-btn modal-btn-primary">예약 추가</button>
          </div>
        </footer>
      </div>
    </div>

  <div class="patient-modal-overlay" id="registerModalOverlay">
      <div class="patient-modal">
      <header class="patient-header">
          <div class="header-content">
              <div class="header-title">
                  <svg class="icon-user" width="15" height="15" viewBox="0 0 15 15">
                      <circle cx="7.5" cy="4.5" r="2.5" stroke="#0E787C" stroke-width="1.33" fill="none" />
                      <path d="M3.5 11.5C3.5 9 5 7.5 7.5 7.5C10 7.5 11.5 9 11.5 11.5" stroke="#0E787C"
                            stroke-width="1.33" fill="none" />
                  </svg>
                  <h1>신규 환자 등록</h1>
              </div>
              <button type="button" class="btn-close-header" id="closeRegisterModalBtn" aria-label="닫기">
                  <svg width="19" height="19" viewBox="0 0 19 19">
                      <path d="M5 5L14 14M14 5L5 14" stroke="#6B7280" stroke-width="1.66" stroke-linecap="round" />
                  </svg>
              </button>
          </div>
      </header>

      <div class="patient-content">
          <form class="patient-form">
              <div class="form-field">
                  <label for="patient-name">성함</label>
                  <input type="text" id="patient-name" name="name" placeholder="성함" required />
              </div>

              <div class="form-row">
                  <div class="form-field">
                      <label for="birth-date">주민등록번호</label>
                      <input type="text" id="birth-date" name="birth-date" placeholder="생년월일 6자리" maxlength="6"
                             required />
                  </div>
                  <div class="form-field">
                      <label for="birth-suffix">뒷자리</label>
                      <input type="password" id="birth-suffix" name="birth-suffix" placeholder="뒷자리" maxlength="7"
                             required />
                  </div>
              </div>

              <div class="form-field">
                  <label for="phone">전화번호</label>
                  <input type="tel" id="phone" name="phone" placeholder="전화번호" required />
              </div>

              <div class="form-field">
                  <label for="address">주소</label>
                  <input type="text" id="address" name="address" placeholder="주소" />
              </div>

              <div class="form-field">
                  <label for="email">이메일</label>
                  <input type="email" id="email" name="email" placeholder="이메일" />
              </div>

              <div class="form-field">
                  <label for="notes">특이사항(기저질환, 알레르기)</label>
                  <input type="text" id="notes" name="notes" placeholder="특이사항" />
              </div>

              <button type="submit" class="btn-submit">예약하기</button>
          </form>
      </div>
      </div>
  </div>
          <script>
              const globalContextPath = "${pageContext.request.contextPath}";
          </script>
    <script src="${pageContext.request.contextPath}/js/erp/patientManagement/erp-patient-manage.js"></script>
  </body>
</html>