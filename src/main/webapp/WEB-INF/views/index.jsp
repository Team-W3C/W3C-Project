<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediFlow - 병원 운영 통합 ERP 시스템</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/index.css">
    <!--
        <link rel="stylesheet" href="/mainView/header/header.css">
        <link rel="stylesheet" href="/mainView/main/main.css">
        <link rel="stylesheet" href="/mainView/footer/footer.css">
        <link rel="stylesheet" href="/mainView/index.css">
    -->
</head>
<body>
    <!-- Header Include -->
    <jsp:include page="common/homePageAdmin/header_admin.jsp" />

    <!-- Main Content -->
    <main class="main">
        <div class="container">
            <section class="hero">
                <h1 class="hero-title">MediFlow</h1>
                <p class="hero-description">
                    MediFlow(메디플로우)는 병원 내 모든 자원과 시설(초음파, MRI, CT 등)의 운영 및<br>
                    예약을 하나의 온라인 플랫폼에서 통합 관리하고, 환자의 직접예약에 가장 효율적인<br>
                    멀티와 의료 서비스 환경을 제공하는 차세대 병원 운영 통합 ERP 시스템입니다.
                </p>
                <button class="cta-button">자세히 보기</button>
            </section>

            <section class="services">
                <h2 class="services-title">주요 서비스</h2>
                <div class="services-grid">
                    <article class="service-card">
                        <div class="service-icon">
                            <svg width="80" height="80" viewBox="0 0 80 80">
                                <rect x="20" y="20" width="40" height="40" rx="3" fill="none" stroke="#0e787c" stroke-width="2.5"/>
                                <line x1="20" y1="32" x2="60" y2="32" stroke="#0e787c" stroke-width="2.5"/>
                                <circle cx="32" cy="44" r="6" fill="#0e787c"/>
                            </svg>
                        </div>
                        <h3 class="service-name">진료과 찾기</h3>
                    </article>

                    <article class="service-card">
                        <a href="${pageContext.request.contextPath}/member/reservation/main.re">
                            <div class="service-icon">
                                <svg width="80" height="80" viewBox="0 0 80 80">
                                    <circle cx="40" cy="35" r="12" fill="none" stroke="#0e787c" stroke-width="2.5"/>
                                    <path d="M40 47 Q25 55 25 70" fill="none" stroke="#0e787c" stroke-width="2.5"/>
                                    <path d="M40 47 Q55 55 55 70" fill="none" stroke="#0e787c" stroke-width="2.5"/>
                                </svg>
                            </div>
                            <h3 class="service-name">진료예약</h3>
                        </a>
                    </article>

                    <article class="service-card">
                        <div class="service-icon">
                            <svg width="80" height="80" viewBox="0 0 80 80">
                                <circle cx="40" cy="32" r="14" fill="none" stroke="#0e787c" stroke-width="2.5"/>
                                <path d="M20 65 Q20 48 40 48 Q60 48 60 65" fill="none" stroke="#0e787c" stroke-width="2.5"/>
                            </svg>
                        </div>
                        <h3 class="service-name">첫방문 고객 예약 상담</h3>
                    </article>

                    <article class="service-card">
                        <a href="${pageContext.request.contextPath}/member/mychart.me">
                            <div class="service-icon">
                                <svg width="80" height="80" viewBox="0 0 80 80">
                                    <rect x="22" y="18" width="36" height="44" rx="2" fill="none" stroke="#0e787c" stroke-width="2.5"/>
                                    <line x1="30" y1="30" x2="50" y2="30" stroke="#0e787c" stroke-width="2"/>
                                    <line x1="30" y1="40" x2="50" y2="40" stroke="#0e787c" stroke-width="2"/>
                                    <line x1="30" y1="50" x2="45" y2="50" stroke="#0e787c" stroke-width="2"/>
                                </svg>
                            </div>
                            <h3 class="service-name">나의차트</h3>
                        </a>
                    </article>
                </div>
            </section>

            <section class="announcements">
                <h2 class="announcements-title">공지</h2>
                <ul class="announcements-list">
                    <li class="announcement-item">
                        <span class="announcement-text">메디플로우 주치료 충족공지 안내</span>
                        <span class="announcement-date">2025.09.19</span>
                    </li>
                    <li class="announcement-item">
                        <span class="announcement-text">메디플로우 관리자 2024년 신년 인사</span>
                        <span class="announcement-date">2025.01.18</span>
                    </li>
                    <li class="announcement-item">
                        <span class="announcement-text">제공약 항목 추수료 변경 안내</span>
                        <span class="announcement-date">2025.01.28</span>
                    </li>
                </ul>
            </section>
        </div>
    </main>

    <!-- Footer Include -->
    <jsp:include page="common/homePageFooter/footer.jsp" />

    <!-- script -->
    <script src="${pageContext.request.contextPath}/js/index.js"></script>
</body>
</html>