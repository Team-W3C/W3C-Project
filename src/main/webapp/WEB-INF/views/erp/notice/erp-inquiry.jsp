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
    <script>
        window.contextPath = "${pageContext.request.contextPath}";
    </script>
    <script src="${pageContext.request.contextPath}/js/erp/notice/erp-inquiry.js"></script>

</head>
<body>
<!-- Header Include -->
<jsp:include page="/WEB-INF/views/common/erp/header.jsp"/>

<!-- sidebar Include -->
<jsp:include page="/WEB-INF/views/common/erp/sidebar.jsp"/>

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
        <button class="tab-btn" onclick="location.href='${pageContext.request.contextPath}/erp/erpNotice/notice'">공지사항</button>
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
        <c:forEach var="b" items="${list}">
            <!-- 문의사항 아이템 -->
            <article class="inquiry-item">
                <div class="inquiry-header">
                    <div class="inquiry-badges">
                            <%-- boardStatus에 따른 CSS 클래스 적용 --%>
                        <c:choose>
                            <c:when test="${b.boardStatus == '진행중'}">
                                <span class="inquiry-badge inquiry-badge-normal">진행중</span>
                            </c:when>
                            <c:when test="${b.boardStatus == '완료'}">
                                <span class="inquiry-badge inquiry-badge-status">완료</span>
                            </c:when>
                            <c:otherwise>
                                <span class="inquiry-badge inquiry-badge-status-progress">대기중</span>
                            </c:otherwise>
                        </c:choose>

                            <%-- boardTypeName에 따른 CSS 클래스 적용 --%>
                        <c:choose>
                            <c:when test="${b.boardTypeName == '결제'}">
                                <span class="inquiry-badge inquiry-badge-category-general">${b.boardTypeName}</span>
                            </c:when>
                            <c:when test="${b.boardTypeName == '진료'}">
                                <span class="inquiry-badge inquiry-badge-category">${b.boardTypeName}</span>
                            </c:when>
                            <c:when test="${b.boardTypeName == '기타'}">
                                <span class="inquiry-badge inquiry-badge-category-system">${b.boardTypeName}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="inquiry-badge inquiry-badge-category">${b.boardTypeName}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <span class="inquiry-date">${b.questionDate}</span>
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
                        <span class="user-name">${b.patientName}</span>
                        <span class="user-id">ID#${b.boardId}</span>
                    </div>
                </div>

                <h3 class="inquiry-title">${b.boardTitle}</h3>
                <p class="inquiry-description">${b.questionContent != null ? b.questionContent : '문의 내용이 없습니다.'}</p>

                <button class="btn-view-inquiry" data-board-no="${b.boardId}">상세보기</button>
            </article>
        </c:forEach>
    </section>
</main>
<!-- 문의사항 상세보기 모달 -->
<div class="modal-overlay" id="inquiryDetailModal">
    <div class="inquiry-detail-modal">
        <div class="modal-header">
            <div class="modal-title-section">
                <svg class="modal-icon" width="20" height="20" viewBox="0 0 20 20" fill="none">
                    <rect x="3" y="4" width="14" height="12" rx="2" stroke="#00897b" stroke-width="2"/>
                    <path d="M3 8h14M7 4v4M13 4v4" stroke="#00897b" stroke-width="2"/>
                </svg>
                <h2 class="modal-title">문의사항 상세</h2>
            </div>
            <button class="modal-close-btn" id="closeDetailModal">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                    <path d="M18 6 6 18M6 6l12 12" stroke="#757575" stroke-width="2" stroke-linecap="round"/>
                </svg>
            </button>
        </div>

        <div class="modal-content">
            <!-- 문의자 정보 섹션 -->
            <section class="inquiry-user-info-section">
                <div class="user-profile-card">
                    <div class="user-profile-header">
                        <div class="user-profile-main">
                            <div class="user-avatar-large" id="modalUserAvatar">이</div>
                            <div class="user-details">
                                <h3 class="user-name-large" id="modalUserName">이영희</h3>
                                <span class="user-id-text" id="modalUserDept">환자번호: #0002</span>
                            </div>
                        </div>
                        <div class="user-badges" id="modalUserBadges">
                            <span class="badge badge-status" id="modalStatusBadge">대기중</span>
                            <span class="badge badge-category" id="modalCategoryBadge">진료</span>
                        </div>
                    </div>
                    <div class="user-contact-info" id="modalContactInfo">
                        <div class="contact-item">
                            <span class="contact-label">연락처:</span>
                            <span class="contact-value" id="modalPhone">010-2345-6789</span>
                        </div>
                        <div class="contact-item">
                            <span class="contact-label">이메일:</span>
                            <span class="contact-value" id="modalEmail">yhlee@email.com</span>
                        </div>
                    </div>
                </div>
            </section>

            <!-- 문의 내용 섹션 -->
            <section class="inquiry-content-main">
                <div class="inquiry-meta">
                    <span class="inquiry-category-badge" id="modalCategoryText">진료</span>
                    <span class="inquiry-date-text" id="modalDatetime">2025-10-27 14:20</span>
                </div>
                <h3 class="inquiry-subject" id="modalSubject">수술 예약승인 재발급 요청</h3>

                <div class="inquiry-content-wrapper">
                    <h4 class="content-label">문의 내용</h4>
                    <div class="inquiry-content" id="modalContentText">
                        <p>안녕하세요.</p>
                        <p>지난 10월 20일에 발급한 예약 건을 분실하여 수술승인을 재발급 요청합니다.</p>
                    </div>
                </div>
            </section>

            <!-- 답변 내용 섹션 (답변이 있을 경우) -->
            <section class="inquiry-reply-section" id="inquiryReplySection" style="display: none;">
                <div class="reply-card">
                    <div class="reply-header">
                        <div class="reply-user-info">
                            <div class="reply-avatar" id="replyAvatar">관</div>
                            <div class="reply-user-details">
                                <div class="reply-user-name-row">
                                    <span class="reply-user-name" id="replyUserName">관리자</span>
                                    <span class="reply-user-title" id="replyUserTitle">(담당자)</span>
                                </div>
                                <div class="reply-meta-info">
                                    <span>처리 부서: <span id="replyDepartment">-</span></span>
                                    <span>처리 일시: <span id="replyDate">-</span></span>
                                </div>
                            </div>
                        </div>
                        <span class="reply-status-badge">답변 완료</span>
                    </div>
                    <div class="reply-content-wrapper">
                        <h4 class="content-label">문의 답변</h4>
                        <div class="reply-content" id="replyContent">
                            답변 내용이 여기에 표시됩니다.
                        </div>
                    </div>
                </div>
            </section>

            <!-- 답변 작성 섹션 (답변이 없을 경우) -->
            <section class="inquiry-reply-form-section" id="inquiryReplyFormSection">
                <div class="reply-form-wrapper">
                    <h4 class="content-label">답변 작성</h4>
                    <textarea
                            id="replyTextarea"
                            class="reply-textarea"
                            placeholder="답변 내용을 입력하세요..."
                            rows="6"
                    ></textarea>
                </div>
            </section>
        </div>

        <div class="modal-footer">
            <button class="btn-secondary" id="cancelDetailModal">취소</button>
            <button class="btn-primary" id="answerInquiry">답변 등록</button>
        </div>
    </div>
</div>
</body>
</html>