<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약 상세 정보</title>
    <link rel="stylesheet" href="/ERP 예약 상세 관리/reservation_manage.css">
</head>
<body>
    <!-- 모달 배경 오버레이 -->
    <div class="modal-overlay" id="modalOverlay">
        <!-- 모달 컨테이너 -->
        <div class="modal-container">
            <!-- 헤더 -->
            <div class="modal-header">
                <h3 class="modal-title">예약 상세 정보</h3>
                <button class="close-button" id="closeButton" aria-label="닫기">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <path d="M5 5L15 15" stroke="#6B7280" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M15 5L5 15" stroke="#6B7280" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </button>
            </div>

            <!-- 컨텐츠 -->
            <div class="modal-content">
                <!-- 환자 정보 -->
                <section class="info-section">
                    <h4 class="section-title">환자 정보</h4>
                    <div class="info-grid">
                        <div class="info-row">
                            <div class="info-label">환자명</div>
                            <div class="info-value">김민수</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">환자번호</div>
                            <div class="info-value">P001</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">나이 / 성별</div>
                            <div class="info-value">45세 / 남</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">연락처</div>
                            <div class="info-value">010-1234-5678</div>
                        </div>
                    </div>
                </section>

                <!-- 예약 정보 -->
                <section class="info-section bordered">
                    <h4 class="section-title">예약 정보</h4>
                    <div class="info-grid">
                        <div class="info-row">
                            <div class="info-label">진료과</div>
                            <div class="info-value">정형외과</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">담당의</div>
                            <div class="info-value">이준호</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">예약 날짜</div>
                            <div class="info-value">2025-10-28</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">예약 시간</div>
                            <div class="info-value">14:00</div>
                        </div>
                        <div class="info-row empty"></div>
                        <div class="info-row">
                            <div class="info-label">증상</div>
                            <div class="info-value">허리 통증</div>
                        </div>
                    </div>
                </section>

                <!-- 메모 -->
                <section class="info-section bordered">
                    <h4 class="section-title">메모</h4>
                    <textarea 
                        class="memo-textarea" 
                        placeholder="예약 관련 메모를 입력하세요..."
                        rows="4"
                        
                    ></textarea>
                </section>
            </div>

            <!-- 버튼 영역 -->
            <div class="modal-footer">
                <button class="btn btn-primary">예약 수정</button>
                <button class="btn btn-secondary">예약 취소</button>
                <button class="btn btn-tertiary" id="closeFooterButton">닫기</button>
            </div>
        </div>
    </div>

    <script src="modal.js"></script>
</body>
</html>
