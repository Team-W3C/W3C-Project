<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>병원 ERP 시스템 - 커뮤니티</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/erpNotice/erp-notice.css">
    <script>
        window.contextPath = "${pageContext.request.contextPath}";
    </script>
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
                <span class="stat-label">문의사항</span>
                <span class="stat-count">${stats.total}건</span>
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
                <span class="stat-count">${stats.waiting}건</span>
            </div>
<%--            <span class="stat-badge">+2</span>--%>
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
                <span class="stat-count">${stats.completed}건</span>
            </div>
<%--            <span class="stat-badge">+12</span>--%>
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
        <c:forEach var="notice" items="${result}">
            <article class="notice-item" data-notice-id=${notice.notificationNo}>
                <div class="notice-header">
                    <!-- 대상(직원/환자) 뱃지 -->
                    <c:choose>
                        <c:when test="${notice.notifiedTypeName eq '직원 공지'}">
                            <span class="notice-badge notice-badge-urgent">직원</span>
                        </c:when>
                        <c:otherwise>
                            <span class="notice-badge notice-badge-general">환자</span>
                        </c:otherwise>
                    </c:choose>

                    <!-- 분류(시스템/운영/진료 등) 뱃지 -->
                    <c:choose>
                        <c:when test="${notice.notificationTypeName eq '시스템'}">
                            <span class="notice-badge notice-badge-system">${notice.notificationTypeName}</span>
                        </c:when>
                        <c:when test="${notice.notificationTypeName eq '운영'}">
                            <span class="notice-badge notice-badge-event">${notice.notificationTypeName}</span>
                        </c:when>
                        <c:when test="${notice.notificationTypeName eq '진료'}">
                            <span class="notice-badge notice-badge-check">${notice.notificationTypeName}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="notice-badge">${notice.notificationTypeName}</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 제목 -->
                <h3 class="notice-title">${notice.notificationTitle}</h3>

                <!-- 내용 (null 방지용) -->
                <p class="notice-description">
                    <c:choose>
                        <c:when test="${not empty notice.notificationContent}">
                            <c:choose>
                                <c:when test="${fn:length(notice.notificationContent) > 30}">
                                    ${fn:substring(notice.notificationContent, 0, 30)}...
                                </c:when>
                                <c:otherwise>
                                    ${notice.notificationContent}
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            내용이 없습니다.
                        </c:otherwise>
                    </c:choose>
                </p>

                <!-- 하단부 -->
                <div class="notice-footer">
                    <span class="notice-author">${notice.departmentName}</span>
                    <span class="notice-date">${notice.notificationDate}</span>

                    </span>
                </div>
            </article>
        </c:forEach>
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
                <h2 class="modal-title">문의사항</h2>
            </div>
            <button class="modal-close-btn" id="closeDetailModal">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                    <path d="M18 6 6 18M6 6l12 12" stroke="#757575" stroke-width="2" stroke-linecap="round"/>
                </svg>
            </button>
        </div>

        <div class="modal-content">
            <nav class="modal-tabs">
                <div id="modalBadges" class="modal-badge-group"></div>
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
                    <select class="form-select" id="notifiedType" name="notifiedType" required>
                        <option value="all">전체</option>
                        <option value="patient">환자</option>
                        <option value="employee">직원</option>
                    </select>
                </div>

                <div class="form-group form-group-category">
                    <label class="form-label">
                        <span class="label-text">부서</span>
                    </label>
                    <select class="form-select" id="departmentNo" name="departmentNo" required>
                        <option value="">부서를 선택하세요</option>
                    </select>
                </div>

                <div class="form-group form-group-type">
                    <label class="form-label">
                        <span class="label-text">분류</span>
                    </label>
                    <select class="form-select" id="notificationType" name="notificationType" required>
                        <option value="system">시스템</option>
                        <option value="operate">운영</option>
                        <option value="medical">진료</option>
                    </select>
                </div>
            </div>
            <div class="form-group form-group-title">
                <label class="form-label">
                    <span class="label-text">제목</span>
                </label>
                <input type="text" class="form-input" id="notificationTitle" name="notificationTitle" placeholder="제목을 입력해주세요" required>
            </div>
            <div class="form-group">
                <label class="form-label">
                    <span class="label-text">내용</span>
                </label>
                <textarea class="form-textarea" id="notificationContent" name="notificationContent" placeholder="내용을 입력하세요." rows="8" required></textarea>
            </div>
            <button type="submit" class="btn-submit">공지사항 등록</button>
        </form>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/erp/notice/erp-notice.js"></script>
</body>
</html>