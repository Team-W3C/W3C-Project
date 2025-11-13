<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>병원 ERP 시스템 - 커뮤니티</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/erpNotice/erp-notice.css">
</head>
<body>
<!-- Header Include -->
<jsp:include page="/WEB-INF/views/common/erp/header.jsp"/>

<!-- sidebar Include -->
<jsp:include page="/WEB-INF/views/common/erp/sidebar.jsp"/>

<!-- 메인 페이지 -->
<main class="community-main">
    <div class="community-header">
        <h1 class="community-title">커뮤니티</h1>
        <button class="btn-primary" id="createNoticeBtn">
            <span class="icon-plus">+</span>
            공지사항 작성
        </button>
    </div>

    <section class="community-stats">
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
            <span class="stat-badge">+3</span>
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
            <span class="stat-badge">+2</span>
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
            <span class="stat-badge">+12</span>
        </div>
    </section>

    <nav class="community-tabs">
        <button class="tab-btn tab-btn-active">공지사항</button>
        <button class="tab-btn" onclick="location.href='${pageContext.request.contextPath}/erp/erpNotice/inquiry?cpage=1'">문의사항</button>
    </nav>

    <div class="community-search">
        <input type="text" class="search-input" placeholder="공지사항 검색...">
        <svg class="search-icon" width="20" height="20" viewBox="0 0 20 20" fill="none">
            <circle cx="8" cy="8" r="6" stroke="currentColor" stroke-width="2"/>
            <path d="m13 13 4 4" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
        </svg>
    </div>

    <section class="notice-list">
        <article class="notice-item" data-notice-id="1">
            <div class="notice-header">
                <span class="notice-badge notice-badge-urgent">중요</span>
                <span class="notice-badge notice-badge-system">시스템</span>
            </div>
            <h3 class="notice-title">10월 정기 시스템 점검 안내</h3>
            <p class="notice-description">10월 30일 02:00 - 06:00 시스템 점검이 진행됩니다.</p>
            <div class="notice-footer">
                <span class="notice-author">관리자</span>
                <span class="notice-date">2025-10-28</span>
            </div>
        </article>

        <article class="notice-item" data-notice-id="2">
            <div class="notice-header">
                <span class="notice-badge notice-badge-general">소식</span>
            </div>
            <h3 class="notice-title">신규 MRI 장비 도입 안내</h3>
            <p class="notice-description">11월부터 최신 MRI 장비가 도입되어 더 나은 서비스를 제공합니다.</p>
            <div class="notice-footer">
                <span class="notice-author">시설관리팀</span>
                <span class="notice-date">2025-10-22</span>
            </div>
        </article>

        <article class="notice-item" data-notice-id="3">
            <div class="notice-header">
                <span class="notice-badge notice-badge-urgent">중요</span>
                <span class="notice-badge notice-badge-event">이벤트</span>
            </div>
            <h3 class="notice-title">직원 시간 변경 안내 (2차수정내)</h3>
            <p class="notice-description">명절일의 이슈로 일시적 업무 시간이 변경됩니다.</p>
            <div class="notice-footer">
                <span class="notice-author">인사총무팀</span>
                <span class="notice-date">2025-10-20</span>
            </div>
        </article>
    </section>
</main>

<!-- 공지사항 상세 모달 -->
<div class="modal-overlay" id="detailModal">
    <div class="notice-detail-modal">
        <div class="modal-header">
            <div class="modal-title-section">
                <svg class="modal-icon" width="20" height="20" viewBox="0 0 20 20" fill="none">
                    <path d="M10 2a8 8 0 1 0 0 16 8 8 0 0 0 0-16Z" stroke="#0E787C" stroke-width="2"/>
                    <path d="M10 6v4M10 14h.01" stroke="#0E787C" stroke-width="2" stroke-linecap="round"/>
                </svg>
                <h2 class="modal-title">공지사항</h2>
            </div>
            <button class="modal-close-btn" id="closeDetailModal">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                    <path d="M18 6 6 18M6 6l12 12" stroke="#757575" stroke-width="2" stroke-linecap="round"/>
                </svg>
            </button>
        </div>

        <div class="modal-content">
            <nav class="modal-tabs">
                <button class="modal-tab">시스템</button>
            </nav>

            <article class="notice-detail">
                <h3 class="notice-detail-title" id="modalTitle"></h3>

                <div class="notice-meta">
                    <div class="meta-item">
                        <span class="meta-label">작성자:</span>
                        <span class="meta-value" id="modalAuthor"></span>
                    </div>
                    <div class="meta-item">
                        <span class="meta-label">등록일:</span>
                        <span class="meta-value" id="modalDate"></span>
                    </div>
                </div>

                <div class="notice-content" id="modalContent"></div>
            </article>
        </div>

        <div class="modal-footer">
            <button class="btn-primary" id="confirmDetailModal">확인</button>
        </div>
    </div>
</div>

<!-- 공지사항 작성 모달 -->
<div class="modal-overlay" id="createModal">
    <div class="notice-create-modal">
        <div class="modal-header">
            <div class="modal-title-section">
                <svg class="modal-icon" width="20" height="20" viewBox="0 0 20 20" fill="none">
                    <path d="M10 2a8 8 0 1 0 0 16 8 8 0 0 0 0-16Z" stroke="#0E787C" stroke-width="2"/>
                    <path d="M10 6v4M10 14h.01" stroke="#0E787C" stroke-width="2" stroke-linecap="round"/>
                </svg>
                <h2 class="modal-title">공지사항 작성</h2>
            </div>
            <button class="modal-close-btn" id="closeCreateModal">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                    <path d="M18 6 6 18M6 6l12 12" stroke="#757575" stroke-width="2" stroke-linecap="round"/>
                </svg>
            </button>
        </div>

        <form class="notice-form" id="noticeForm">
            <div class="form-row">
                <div class="form-group form-group-target">
                    <label class="form-label">
                        <span class="label-text">대상</span>
                    </label>
                    <select class="form-select">
                        <option value="all">전체</option>
                        <option value="patient">환자</option>
                        <option value="employee">직원</option>
                    </select>
                </div>

                <div class="form-group form-group-category">
                    <label class="form-label">
                        <span class="label-text">부서</span>
                    </label>
                    <select class="form-select">
                        <option value="">부서1</option>
                        <option value="">부서2</option>
                        <option value="">부서3</option>
                        <option value="">부서4</option>
                    </select>
                </div>

                <div class="form-group form-group-type">
                    <label class="form-label">
                        <span class="label-text">분류</span>
                    </label>
                    <select class="form-select">
                        <option value="">분류</option>
                        <option value="urgent">긴급</option>
                        <option value="general">일반</option>
                        <option value="info">정보</option>
                    </select>
                </div>
            </div>
            <div class="form-group form-group-title">
                <label class="form-label">
                    <span class="label-text">제목</span>
                </label>
                <input type="text" class="form-input" placeholder="제목을 입력해주세요">
            </div>
            <div class="form-group">
                <label class="form-label">
                    <span class="label-text">내용</span>
                </label>
                <textarea class="form-textarea" placeholder="내용을 입력하세요." rows="8"></textarea>
            </div>
            <button type="submit" class="btn-submit">공지사항 등록</button>
        </form>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/erp/notice/erp-notice.js"></script>
</body>
</html>