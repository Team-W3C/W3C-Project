<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>병원 ERP 시스템 - 커뮤니티</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/erpNotice/erp-inquiry.css">
</head>
<body>
<%-- 수정: 헤더 및 사이드바 include 활성화 --%>
<c:import url="/WEB-INF/views/common/erp/header.jsp"/>
<c:import url="/WEB-INF/views/common/erp/sidebar.jsp"/>

<!-- 병원 ERP 시스템 > 커뮤니티 문의사항 페이지 -->
<main class="inquiry-main">
    <div class="inquiry-header">
        <h1 class="community-title">커뮤니티</h1>
        <button class="btn-primary inquiry-create-btn">
            <span class="icon-plus">+</span>
            문의사항 등록
        </button>
    </div>

    <!-- 통계 카드 섹션 -->
    <section class="inquiry-stats">
        <div class="stat-card">
            <div class="stat-icon stat-icon-notification">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                    <path d="M18 8A6 6 0 1 0 6 8c0 7-3 9-3 9h18s-3-2-3-9Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M13.73 21a2 2 0 0 1-3.46 0" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            <div class="stat-content">
                <span class="stat-label">공지사항</span>
                <span class="stat-count">12건</span>
            </div>
            <span class="stat-badge stat-badge-increase">+3</span>
        </div>

        <div class="stat-card">
            <div class="stat-icon stat-icon-folder">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                    <path d="M3 7v10a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2h-9l-2-2H5a2 2 0 0 0-2 2Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            <div class="stat-content">
                <span class="stat-label">대기 중 문의</span>
                <span class="stat-count">8건</span>
            </div>
            <span class="stat-badge stat-badge-increase">+2</span>
        </div>

        <div class="stat-card">
            <div class="stat-icon stat-icon-check">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                    <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="2"/>
                    <path d="m9 12 2 2 4-4" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            <div class="stat-content">
                <span class="stat-label">처리 완료</span>
                <span class="stat-count">45건</span>
            </div>
            <span class="stat-badge stat-badge-increase">+12</span>
        </div>
    </section>

    <!-- 탭 네비게이션 -->
    <nav class="inquiry-tabs">
        <button class="tab-btn" onclick="location.href='${pageContext.request.contextPath}/erpNotice/notice.erp'">공지사항</button>
        <button class="tab-btn tab-btn-active">문의사항</button>
    </nav>

    <!-- 필터 탭 -->
    <nav class="inquiry-filter-tabs">
        <button class="filter-tab filter-tab-active">전체</button>
        <button class="filter-tab">신청</button>
        <button class="filter-tab">반려</button>
    </nav>

    <!-- 문의사항 목록 -->
    <section class="inquiry-list">
        <!-- 문의사항 아이템 1 -->
        <article class="inquiry-item">
            <div class="inquiry-header">
                <div class="inquiry-badges">
                    <span class="inquiry-badge inquiry-badge-status">대기중</span>
                    <span class="inquiry-badge inquiry-badge-category">시설</span>
                    <span class="inquiry-badge inquiry-badge-urgent">긴급</span>
                </div>
                <span class="inquiry-date">2025-10-28 09:30</span>
            </div>

            <div class="inquiry-user">
                <div class="user-avatar">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <circle cx="10" cy="10" r="8" fill="#e0e0e0"/>
                        <circle cx="10" cy="8" r="3" fill="#757575"/>
                        <path d="M4 16c0-3 2.5-5 6-5s6 2 6 5" fill="#757575"/>
                    </svg>
                </div>
                <div class="user-info">
                    <span class="user-name">김은수</span>
                    <span class="user-id">ID#12</span>
                </div>
            </div>

            <h3 class="inquiry-title">MRI 예약 변경 문의</h3>
            <p class="inquiry-description">10월 30일 예약된 MRI 검사 시간을 변경하고 싶습니다.</p>

            <button class="btn-view-inquiry">상세보기</button>
        </article>

        <!-- 문의사항 아이템 2 -->
        <article class="inquiry-item">
            <div class="inquiry-header">
                <div class="inquiry-badges">
                    <span class="inquiry-badge inquiry-badge-status-progress">진행중</span>
                    <span class="inquiry-badge inquiry-badge-category">시설</span>
                    <span class="inquiry-badge inquiry-badge-normal">일반</span>
                </div>
                <span class="inquiry-date">2025-10-27 14:22</span>
            </div>

            <div class="inquiry-user">
                <div class="user-avatar">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <circle cx="10" cy="10" r="8" fill="#e0e0e0"/>
                        <circle cx="10" cy="8" r="3" fill="#757575"/>
                        <path d="M4 16c0-3 2.5-5 6-5s6 2 6 5" fill="#757575"/>
                    </svg>
                </div>
                <div class="user-info">
                    <span class="user-name">이현희</span>
                    <span class="user-id">ID#47</span>
                </div>
            </div>

            <h3 class="inquiry-title">수술 예약승인 문의</h3>
            <p class="inquiry-description">10월 30일 요청한 수술 예약승인을 확인하고 싶습니다.</p>

            <button class="btn-view-inquiry">상세보기</button>
        </article>

        <!-- 문의사항 아이템 3 -->
        <article class="inquiry-item">
            <div class="inquiry-header">
                <div class="inquiry-badges">
                    <span class="inquiry-badge inquiry-badge-status-reject">반려</span>
                    <span class="inquiry-badge inquiry-badge-category-general">일반</span>
                    <span class="inquiry-badge inquiry-badge-normal">일반</span>
                </div>
                <span class="inquiry-date">2025-10-26 11:13</span>
            </div>

            <div class="inquiry-user">
                <div class="user-avatar">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <circle cx="10" cy="10" r="8" fill="#e0e0e0"/>
                        <circle cx="10" cy="8" r="3" fill="#757575"/>
                        <path d="M4 16c0-3 2.5-5 6-5s6 2 6 5" fill="#757575"/>
                    </svg>
                </div>
                <div class="user-info">
                    <span class="user-name">박동수</span>
                    <span class="user-id">ID#09</span>
                </div>
            </div>

            <h3 class="inquiry-title">진료 기록 복사 신청</h3>
            <p class="inquiry-description">지난 6개월간 진료 기록을 복사하려 합니다.</p>

            <button class="btn-view-inquiry">상세보기</button>
        </article>

        <!-- 문의사항 아이템 4 -->
        <article class="inquiry-item">
            <div class="inquiry-header">
                <div class="inquiry-badges">
                    <span class="inquiry-badge inquiry-badge-status">대기중</span>
                    <span class="inquiry-badge inquiry-badge-category">시설</span>
                    <span class="inquiry-badge inquiry-badge-normal">일반</span>
                </div>
                <span class="inquiry-date">2025-10-24 06:45</span>
            </div>

            <div class="inquiry-user">
                <div class="user-avatar">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <circle cx="10" cy="10" r="8" fill="#e0e0e0"/>
                        <circle cx="10" cy="8" r="3" fill="#757575"/>
                        <path d="M4 16c0-3 2.5-5 6-5s6 2 6 5" fill="#757575"/>
                    </svg>
                </div>
                <div class="user-info">
                    <span class="user-name">최하윤</span>
                    <span class="user-id">ID#83</span>
                </div>
            </div>

            <h3 class="inquiry-title">주차 공간 문의 신청</h3>
            <p class="inquiry-description">앞으로 주차공간 현황을 알고싶어 문의합니다.</p>

            <button class="btn-view-inquiry">상세보기</button>
        </article>

        <!-- 문의사항 아이템 5 -->
        <article class="inquiry-item">
            <div class="inquiry-header">
                <div class="inquiry-badges">
                    <span class="inquiry-badge inquiry-badge-status-complete">완료</span>
                    <span class="inquiry-badge inquiry-badge-category-system">시스템</span>
                </div>
                <span class="inquiry-date">2025-10-27 16:50</span>
            </div>

            <div class="inquiry-user">
                <div class="user-avatar">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <circle cx="10" cy="10" r="8" fill="#e0e0e0"/>
                        <circle cx="10" cy="8" r="3" fill="#757575"/>
                        <path d="M4 16c0-3 2.5-5 6-5s6 2 6 5" fill="#757575"/>
                    </svg>
                </div>
                <div class="user-info">
                    <span class="user-name">안정민</span>
                    <span class="user-id">ID#96</span>
                </div>
            </div>

            <h3 class="inquiry-title">대기 시간 개선 신청</h3>
            <p class="inquiry-description">예약 시스템 대기 시간이 너무 길어 신청합니다.</p>

            <button class="btn-view-inquiry">상세보기</button>
        </article>
    </section>
</main>
<script src="${pageContext.request.contextPath}/js/erp/notice/erp-inquiry.js"></script>
</body>
</html>