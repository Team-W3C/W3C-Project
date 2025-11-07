<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>병원 안내 - MediFlow</title>

    <%-- 공통 CSS 및 이 페이지 전용 CSS --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Detail/detail.css">
    <%--
      사이드바 CSS도 필요할 수 있으므로 추가하는 것을 권장합니다.
      (경로는 실제 파일 위치에 맞게 수정하세요.)
    --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/appointment-sidebar.css">


    <%-- 폰트 --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>

<%-- 1. Header (공통) --%>
<jsp:include page="/WEB-INF/views/common/homePageMember/header_member.jsp" />

<%--
  전체 레이아웃 (사이드바 + 메인 콘텐츠)
  page-wrapper가 사이드바와 메인 콘텐츠를 모두 감싸도록 수정
--%>
<div class="page-wrapper">

    <%--
      2. Sidebar (공통)
    --%>
    <jsp:include page="/WEB-INF/views/common/homePageMember/appointment-sidebar.jsp"/>

    <%-- 3. Main Content (병원 안내 고유 콘텐츠) --%>
    <main class="intro-container">

        <h1 class="intro-title">MediFlow</h1>

        <article class="intro-content">

            <p class="intro-description">
                <strong>MediFlow(메디플로우)</strong>는 병원 내 모든 자원과 시설(초음파, MRI, CT 등)의 운영 및 예약을 하나의 온라인 플랫폼에서 통합 관리하고, 환자와 직원들에게 가장 효율적이고 편리한 의료 서비스 환경을 제공하는 차세대 병원 운영 통합 ERP 시스템입니다.
                <br>"실시간으로, 정확하게, 효율적으로" 특수 시설 예약을 자동화하고, 의료진과 환자의 모든 정보를 연동하여 병원 운영을 혁신하는 스마트 솔루션입니다.
            </p>

            <h2 class="intro-subtitle">핵심 가치와 기능</h2>

            <section class="intro-feature-section">
                <h3 class="intro-feature-title">1. 환자를 위한 편리함 (ON-Patient Service)</h3>
                <ul class="intro-feature-list">
                    <li><strong>실시간 예약:</strong> MRI, CT 등 특수 시설의 실시간 사용 가능 시간과 예약 현황을 자동 연동하여 간호사의 수동 조율 없이 즉시 예약할 수 있습니다.</li>
                    <li><strong>마이 대시보드:</strong> 환자의 예약 현황, 방문 이력, 알림 내역, 진료 기록 등을 한눈에 확인하여 이용 편의성을 극대화합니다.</li>
                    <li><strong>알림 연동:</strong> 예약 확정 및 예약 하루 전 리마인더 알림이 환자에게 자동으로 메시지 발송되어 노쇼(No-Show)를 방지하고 환자 만족도를 높입니다.</li>
                    <li><strong>소통 창구:</strong> 문의 사항이나 개선 요청을 온라인 게시판을 통해 간편하게 접수하고 처리 결과를 투명하게 확인할 수 있습니다.</li>
                </ul>
            </section>

            <section class="intro-feature-section">
                <h3 class="intro-feature-title">2. 효율적인 병원 운영 (ON-Management)</h3>
                <ul class="intro-feature-list">
                    <li><strong>통합 관리:</strong> 특수 시설 예약, 직원(인사 및 근태), 회원(환자), 의사 스케줄, 진료 및 수납 기록을 하나의 시스템에서 통합 관리하여 불필요한 수작업을 획기적으로 개선합니다.</li>
                    <li><strong>스마트 시설 관리:</strong> 장비별 이용률, 가동시간, 점검 일정을 시각화하여 운영 효율을 극대화하며, 장비 사용 가능 시간과 예약 현황을 자동으로 연동합니다.</li>
                    <li><strong>스마트 인사/근태:</strong> 의사별 진료 시간 설정, 직원 휴가 기록, 웹 기반 출퇴근 인증 기능을 통해 인적 자원을 효율적으로 관리합니다.</li>
                    <li><strong>데이터 기반 분석:</strong> 예약 현황, 장비 이용률, 환자 대기 현황 등을 통합 대시보드로 제공하고, 데이터 기반 분석 자료를 통해 합리적인 자원 활용도 및 진료 효율 전략 수립을 지원합니다.</li>
                    <li><strong>진료/수납 연동:</strong> 진료 내용 기록 및 진단명 입력, 진료비 수납 및 영수증 발행, 문서(진단서/소견서) 발급 등의 과정을 통합 관리합니다.</li>
                </ul>
            </section>

        </article>
    </main>

</div> <%-- /.page-wrapper --%>

<%-- 4. Footer (공통) --%>
<jsp:include page="/WEB-INF/views/common/homePageFooter/footer.jsp" />

</body>
</html>