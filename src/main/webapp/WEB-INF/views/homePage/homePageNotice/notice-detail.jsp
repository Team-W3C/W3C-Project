<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 상세 - MediFlow</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homePageNotice/notice-detail.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/index.css">
</head>
<body>
<!-- Header Include -->
<jsp:include page="/WEB-INF/views/common/homePageMember/header.jsp" />
<main class="notice-detail-main">
    <div class="notice-detail-container">

        <!-- 페이지 제목 -->
        <header class="notice-detail-header">
            <h1 class="page-title">공지사항</h1>
        </header>

        <!-- 공지사항 상세 -->
        <article class="notice-article">
            <!-- 공지 제목 영역 -->
            <div class="notice-title-section">
                <h2 class="notice-title">MediFlow 도입 공지</h2>
                <div class="notice-meta">
                    <span class="notice-date">등록일: 2025.10.27</span>
                </div>
            </div>

            <!-- 공지 내용 -->
            <div class="notice-content">
                <p class="content-paragraph">
                    존경하는 환자 및 내원객 여러분, 그리고 병원 임직원 여러분께,<br>
                    본원에서는 보다 효율적이고 편리한 의료 서비스 환경을 제공하기 위해 차세대 병원 운영 통합 ERP 시스템인 ‘메디플로우(MediFlow)’를 2025년 11월 1일부로 전면 도입하게 되었음을 알려드립니다.<br>
                    '메디플로우'는 수동으로 이루어지던 특수 장비 예약 과정을 혁신적으로 자동화하고, 모든 병원 운영 <br>
                    정보를 통합 관리하여 환자 대기 시간을 줄이고 의료진의 업무 효율을 극대화할 것입니다.
                </p>

                <!-- 주요 변경 사항 -->
                <section class="content-section">
                    <h3 class="section-title">1. 환자 및 내원객 대상 주요 변경 사항</h3>

                    <table class="notice-table">
                        <thead>
                        <tr>
                            <th class="table-col-category">항목</th>
                            <th class="table-col-before">기존 부서</th>
                            <th class="table-col-after">메디플로우 도입 후 (개선 사항)</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="table-cell-label">특수 장비 예약<br>(MRI, CT 등)</td>
                            <td class="table-cell">
                                간호사에게 유선 문의 후 수동으로 시간 조율 및 확정
                            </td>
                            <td class="table-cell">
                                실시간 온라인 예약 가능: 시스템에서 장비별 사용 가능 시간을
                                확인하고 즉시 예약 확정. (간호사 중재 최소화)
                            </td>
                        </tr>
                        <tr>
                            <td class="table-cell-label">예약 알림</td>
                            <td class="table-cell">
                                예약 직후 문자 발송 (리마인더는 수동 관리)
                            </td>
                            <td class="table-cell">
                                예약 확정 즉시 자동 발송, 예약 하루 전 자동 리마인더 메시지 발송으로 <br>
                                노쇼(No-Show) 방지 및 편의 증진
                            </td>
                        </tr>
                        <tr>
                            <td class="table-cell-label">개인 정보 확인</td>
                            <td class="table-cell">
                                원내 키오스크 또는 창구 문의
                            </td>
                            <td class="table-cell">
                                [마이 대시보드] 통합 제공: 예약 현황, 방문 이력, 알림 내역 등을 <br>
                                온라인에서 한눈에 확인 가능
                            </td>
                        </tr>
                        <tr>
                            <td class="table-cell-label">문의/피드백</td>
                            <td class="table-cell">
                                고객센터 전화 또는 종이 건의함 이용
                            </td>
                            <td class="table-cell">
                                온라인 커뮤니티 채널 신설: 문의 및 건의 사항을 시스템에 직접 등록, <br>
                                처리 과정을 투명하게 공개
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </section>
            </div>
        </article>

    </div>
</main>
<!-- Footer include-->
<jsp:include page="/WEB-INF/views/common/homePageFooter/footer.jsp" />
</body>
</html>