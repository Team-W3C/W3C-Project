<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 진료절차 페이지 - Main Content -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>진료절차 - MediFlow</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/diagnosis/procedure.css">
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
<jsp:include page="/WEB-INF/views/common/homePageMember/header_member.jsp" />
<div class="procedure-wrapper">

    <!-- 메인 콘텐츠 -->
    <main class="procedure-main">
        <!-- 페이지 헤더 -->
        <header class="procedure-header">
            <h1 class="page-title">진료절차</h1>
        </header>

        <!-- 탭 메뉴 -->
        <nav class="procedure-tabs">
            <button class="tab-button active">진료안내</button>
            <button class="tab-button">외래예약/안내</button>
            <button class="tab-button">치료 및 입원(입원)</button>
            <button class="tab-button">퇴원/원무 업무</button>
        </nav>

        <!-- 진료시간 안내 -->
        <section class="schedule-section">
            <h2 class="section-title">외래 예약 및 진료시간</h2>

            <div class="schedule-table">
                <table>
                    <tr>
                        <th>외래예약(수납창구) 시간</th>
                        <th>진료시간</th>
                    </tr>
                    <tr>
                        <td>평일 : 08:30~17:30</td>
                        <td>평일 : 09:00~17:00 (단, 공휴일은 응급진료만 가능)</td>
                    </tr>
                </table>
                <p>* 진료시간은 의사별로 상이 할 수 있으니, 예약된 진료시간을 준수하여 주시기 바랍니다.</p>
            </div>
        </section>

        <!-- 예약방법 -->
        <section class="reservation-section">
            <h2 class="section-title">예약방법</h2>

            <!-- 방문예약 -->
            <article class="reservation-method">
                <h3 class="method-title">방문예약</h3>
                <p class="method-time">예약시간 : 평일 08:30~17:30 / 토 : 08:30~12:30</p>

                <div class="process-steps">
                    <div class="process-step">
                        <div class="step-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <circle cx="12" cy="12" r="10" stroke="#FFA500" stroke-width="2"/>
                            </svg>
                        </div>
                        <p class="step-text">원무팀 수납 창구 방문</p>
                        <div class="step-connector">→</div>
                    </div>

                    <div class="process-step">
                        <div class="step-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <circle cx="12" cy="12" r="10" stroke="#FFA500" stroke-width="2"/>
                            </svg>
                        </div>
                        <p class="step-text">진료신청</p>
                        <div class="step-connector">→</div>
                    </div>

                    <div class="process-step">
                        <div class="step-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <circle cx="12" cy="12" r="10" stroke="#FFA500" stroke-width="2"/>
                            </svg>
                        </div>
                        <p class="step-text">진료예약</p>
                        <div class="step-connector">→</div>
                    </div>

                    <div class="process-step completed">
                        <div class="step-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <circle cx="12" cy="12" r="10" stroke="#0E787C" stroke-width="2"/>
                            </svg>
                        </div>
                        <p class="step-text">예약일에 진료과 방문</p>
                    </div>
                </div>
            </article>

            <!-- 전화예약 -->
            <article class="reservation-method">
                <h3 class="method-title">전화 예약</h3>
                <p class="method-time">예약시간 : 평일 08:00~18:00 / 토·일·공휴일 : 08:30~17:30</p>

                <div class="process-steps">
                    <div class="process-step">
                        <div class="step-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <circle cx="12" cy="12" r="10" stroke="#FFA500" stroke-width="2"/>
                            </svg>
                        </div>
                        <div class="step-content">
                            <p class="step-text">전화신청</p>
                            <p class="step-detail">1111-1111 ARS 1번</p>
                        </div>
                        <div class="step-connector">→</div>
                    </div>

                    <div class="process-step">
                        <div class="step-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <circle cx="12" cy="12" r="10" stroke="#FFA500" stroke-width="2"/>
                            </svg>
                        </div>
                        <p class="step-text">전화예약실 상담원 연결</p>
                        <div class="step-connector">→</div>
                    </div>

                    <div class="process-step">
                        <div class="step-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <circle cx="12" cy="12" r="10" stroke="#FFA500" stroke-width="2"/>
                            </svg>
                        </div>
                        <p class="step-text">진료 상담 후 예약</p>
                        <div class="step-connector">→</div>
                    </div>

                    <div class="process-step completed">
                        <div class="step-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <circle cx="12" cy="12" r="10" stroke="#0E787C" stroke-width="2"/>
                            </svg>
                        </div>
                        <p class="step-text">예약일에 진료과 방문</p>
                    </div>
                </div>

                <div class="info-notice">
                    <p>1,2차 의료기관에서 요양급여의뢰서(진료의뢰서)를 발급받으신 신환, 초진 환자분은 진료협력센터에서 예약 가능합니다.</p>
                    <p class="notice-contact">전화 : 02-3010-7769 , 평일 : 08:30 ~ 17:30</p>
                </div>
            </article>

            <!-- 인터넷예약 -->
            <article class="reservation-method">
                <h3 class="method-title">인터넷예약</h3>
                <p class="method-time">예약시간 : 24시간 가능</p>

                <div class="process-steps">
                    <div class="process-step">
                        <div class="step-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <circle cx="12" cy="12" r="10" stroke="#FFA500" stroke-width="2"/>
                            </svg>
                        </div>
                        <p class="step-text">MediFlow 홈페이지 접속</p>
                        <div class="step-connector">→</div>
                    </div>

                    <div class="process-step">
                        <div class="step-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <circle cx="12" cy="12" r="10" stroke="#FFA500" stroke-width="2"/>
                            </svg>
                        </div>
                        <p class="step-text">진료예약 클릭</p>
                        <div class="step-connector">→</div>
                    </div>

                    <div class="process-step">
                        <div class="step-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <circle cx="12" cy="12" r="10" stroke="#FFA500" stroke-width="2"/>
                            </svg>
                        </div>
                        <p class="step-text">안내에 따라 정보 입력 후 예약</p>
                        <div class="step-connector">→</div>
                    </div>

                    <div class="process-step completed">
                        <div class="step-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <circle cx="12" cy="12" r="10" stroke="#0E787C" stroke-width="2"/>

                            </svg>
                        </div>
                        <p class="step-text">예약일에 진료과 방문</p>
                    </div>
                </div>
            </article>

            <!-- 모바일APP예약 -->
            <article class="reservation-method">
                <h3 class="method-title">모바일 APP 예약</h3>
                <p class="method-time">예약시간 : 24시간 가능</p>

                <div class="process-steps">
                    <div class="process-step">
                        <div class="step-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <circle cx="12" cy="12" r="10" stroke="#FFA500" stroke-width="2"/>
                            </svg>
                        </div>
                        <p class="step-text">MediFlow 앱 접속</p>
                        <div class="step-connector">→</div>
                    </div>

                    <div class="process-step">
                        <div class="step-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <circle cx="12" cy="12" r="10" stroke="#FFA500" stroke-width="2"/>
                            </svg>
                        </div>
                        <p class="step-text">진료예약 클릭</p>
                        <div class="step-connector">→</div>
                    </div>

                    <div class="process-step">
                        <div class="step-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <circle cx="12" cy="12" r="10" stroke="#FFA500" stroke-width="2"/>
                            </svg>
                        </div>
                        <p class="step-text">진료과 등 검색 후 예약</p>
                        <div class="step-connector">→</div>
                    </div>

                    <div class="process-step completed">
                        <div class="step-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <circle cx="12" cy="12" r="10" stroke="#0E787C" stroke-width="2"/>
                            </svg>
                        </div>
                        <p class="step-text">예약일에 진료과 방문</p>
                    </div>
                </div>
            </article>
        </section>

        <!-- 의료전달체계 안내 -->
        <section class="medical-system-section">
            <h2 class="section-title">의료전달체계 안내</h2>

            <div class="system-info-box">
                <li>서울아산병원은 국민건강보험법에 의거, 1-2차 병·의원에서 발급한 요양급여의뢰서를 제출해야만 보험 급여 혜택이 가능합니다. 요양급여의뢰서 없이도 진료는 가능하지만 보험혜택은 못 받으시며, 차후 제출하시면 그날부터 보험 혜택을 받을 수 있습니다.<br>
                    단, 가정의학과, 치과는 요양급여의뢰서 없이도 건강보험 혜택이 가능합니다.</li>
                <li>의료급여는 모든 진료과에 대하여 병원급 의료급여의뢰서 필요 (의원, 보건소 불가)<br>
                    2종 대상자 중 '장애인 복지카드' 소지 환자는 창구에 장애인등록을 신청하십시오. (의료비 경감 혜택)</li>
            </div>
        </section>
    </main>
</div>
<!-- Footer include-->
<jsp:include page="/WEB-INF/views/common/homePageFooter/footer.jsp" />
</body>
</html>