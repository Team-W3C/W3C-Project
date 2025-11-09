<%--
  Created by IntelliJ IDEA.
  User: dream
  Date: 25. 11. 5.
  Time: 오전 10:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문의사항 상세</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homePageinquiry/inquiry-detail.css">
<%--    헤더푸터css--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/index.css">
</head>
<body>
<%--헤더--%>
<jsp:include page="../../common/homePageMember/header_member.jsp" />

<!-- 메인 컨텐츠 영역 -->
<main class="inquiry-detail-main">

    <!-- 페이지 헤더 -->
    <header class="inquiry-detail-header">
        <h1 class="inquiry-detail-title">문의사항</h1>
        <p class="inquiry-detail-subtitle">문의 내용과 답변을 확인하세요</p>
    </header>

    <!-- 목록으로 버튼 -->
    <div class="inquiry-detail-actions">
        <button class="inquiry-detail-back-btn" type="button" aria-label="목록으로 돌아가기"
                onclick="location.href='${pageContext.request.contextPath}/member/inquiry-board'">
            <svg viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M10 12L6 8L10 4" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            목록으로
        </button>
    </div>

    <!-- 문의 카드 -->
    <article class="inquiry-card">
        <header class="inquiry-card-header">
            <div class="inquiry-card-title-section">
                <h2 class="inquiry-card-title">예약된 진료 외에 다른 진료도 당일에 추가로 받을 수 있나요?</h2>
                <span class="inquiry-card-category">진료 전</span>
            </div>
            <div class="inquiry-card-badges">
                <span class="inquiry-badge-complete" aria-label="답변 상태">답변 완료</span>
                <span class="inquiry-badge-privacy" aria-label="비밀글 여부">비밀글: 무</span>
            </div>
        </header>

        <div class="inquiry-card-body">
            <!-- 메타 정보 -->
            <div class="inquiry-meta-info">
                <div class="inquiry-meta-item">
                    <svg viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="3" y="4" width="10" height="9" rx="1" stroke="currentColor" stroke-width="1.5"/>
                        <path d="M3 7H13M8 4V2M11 2H5" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                    </svg>
                    <span>등록일:</span>
                    <time datetime="2025-01-15">2025-01-15</time>
                </div>
                <div class="inquiry-meta-item">
                    <svg viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="8" cy="6" r="2.5" stroke="currentColor" stroke-width="1.5"/>
                        <path d="M3 13C3 10.5 5 9 8 9C11 9 13 10.5 13 13" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                    </svg>
                    <span>담당 부서:</span>
                    <span>정보시스템팀</span>
                </div>
                <div class="inquiry-meta-item">
                    <svg viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M3 8L8 3L13 8M8 3V13" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <span>문의 번호:</span>
                    <span>#15</span>
                </div>
            </div>

            <!-- 문의 내용 -->
            <section class="inquiry-content-section">
                <div class="inquiry-content-heading">
                    <svg viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M4 10L8 6L12 10L16 4" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <h3>문의 내용</h3>
                </div>
                <div class="inquiry-content-text">안녕하세요. 다음주 화요일 오후 2시에 내과의 김철수 교수님께 위 내시경 검사 및 상담으로 예약을 해두었습니다. 최근에 위장 문제 외에도 다른 걱정거리가 생겨서, 혹시 당일에 함께 진료를 받을 수 있을지 문의드립니다.

                    오늘 예약된 위 내시경 진료 외에, 추가로 다른 증상에 대한 진료도 함께 받을 수 있나요?

                    추가로 받고 싶은 진료 내용은 최근 2~3일 전부터 왼쪽 어깨와 목 부위에 뻐근한 통증이 지속되고 있습니다. 단순한 근육통인지 아니면 다른 문제인지 궁금합니다.

                    그래서 저는 오늘 위 내시경 진료를 보면서, 추가로 정형외과 또는 통증의학과 진료도 함께 받고 싶습니다.</div>
            </section>
        </div>
    </article>

    <!-- 답변 카드 (답변이 있을 때) -->
    <!--
    <article class="answer-card">
      <header class="answer-card-header">
        <div class="answer-card-title-section">
          <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="1.5"/>
            <path d="M9 12L11 14L15 10" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
          </svg>
          <h3 class="answer-card-title">답변</h3>
        </div>
      </header>

      <div class="answer-card-body">
        <div class="answer-meta-info">
          <div class="inquiry-meta-item">
            <svg viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
              <rect x="3" y="4" width="10" height="9" rx="1" stroke="currentColor" stroke-width="1.5"/>
              <path d="M3 7H13M8 4V2M11 2H5" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
            </svg>
            <span>답변일:</span>
            <time datetime="2025-01-16">2025-01-16</time>
          </div>
          <div class="inquiry-meta-item">
            <svg viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
              <circle cx="8" cy="6" r="2.5" stroke="currentColor" stroke-width="1.5"/>
              <path d="M3 13C3 10.5 5 9 8 9C11 9 13 10.5 13 13" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
            </svg>
            <span>답변자:</span>
            <span>정보시스템팀</span>
          </div>
        </div>

        <section class="inquiry-content-section">
          <div class="inquiry-content-heading">
            <svg viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M4 10L8 6L12 10L16 4" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            <h3>답변 내용</h3>
          </div>
          <div class="answer-content-text">고객님, 김기현님의 오후 2시 내과 - 위 내시경 예약 건에 대한 문의사항에 답변드립니다.

1. 추가 진료 가능 여부 및 절차 안내
네, 예약된 진료 외에 다른 증상에 대한 진료도 당일에 추가로 요청하실 수 있습니다.
고객님께서는 내과 (위 내시경) 진료와 함께 정형외과 진료를 함께 원하고 계십니다.

▶️ 요청 절차
도착 시 접수: 병원에 도착하시면 접수 데스크에 오셔서 위 내시경 예약 외에 어깨 통증으로 정형외과 진료를 추가하고 싶다고 말씀해 주십시오.
스케줄 확인: 접수 직원이 해당 진료과의 당일 진료 가능 여부 및 의료진 스케줄을 즉시 확인합니다.
추가 접수: 진료가 가능하다면, 어깨/목 통증에 대한 정형외과 추가 접수를 도와드릴 것입니다.</div>
        </section>
      </div>
    </article>
    -->

    <!-- 답변 대기 중 카드 (답변이 없을 때) -->
    <article class="answer-pending-card">
        <header class="answer-pending-header">
            <div class="answer-pending-title-section">
                <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="2"/>
                    <path d="M12 6V12L16 14" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                </svg>
                <h3 class="answer-pending-title">답변 대기 중</h3>
            </div>
        </header>

        <div class="answer-pending-body">
            <p class="answer-pending-message">답변이 아직 등록되지 않았습니다.</p>
            <p class="answer-pending-submessage">담당 부서에서 확인 후 빠른 시일 내에 답변을 드리겠습니다.</p>
        </div>
    </article>

    <!-- 하단 목록으로 버튼 -->
    <button class="inquiry-detail-footer-btn" type="button" onclick="location.href='${pageContext.request.contextPath}/member/inquiry-board'">
        목록으로 돌아가기
    </button>

</main>
<%--푸터--%>
<jsp:include page="../../common/homePageFooter/footer.jsp" />

</body>
</html>