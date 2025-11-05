<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>진료안내 - MediFlow</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/guide/guide.css">
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

<main class="guide-main">
    <!-- 메인 콘텐츠 -->
    <section class="guide-content">
        <!-- 페이지 헤더 -->
        <header class="guide-header">
            <h1>진료안내</h1>
        </header>

        <!-- 진료 단계 목록 -->
        <div class="guide-steps">

            <!-- 01 접수방법 -->
            <article class="guide-step">
                <div class="step-icon">
                    <img src="${pageContext.request.contextPath}/img/guide/guide1.PNG">
                </div>
                <div class="step-content">
                    <h2 class="step-number">01 접수방법</h2>
                    <p class="step-description">
                        병원에 도착하시면 꼭 접수를 해주셔야 진료가 진행됩니다.<br>
                        진료과 접수 직원에게 접수할 수 있습니다.<br>
                        무인 접수대에 병원등록번호 또는 주민등록 번호를 입력하거나 바코드를 스캔하여 접수할 수 있습니다.<br>
                        병원에 처음 오신 분은 처음 오신 분 창구에서 등록 후 진료과에 접수하시기 바랍니다.<br>
                    </p>
                </div>
            </article>

            <!-- 02 진찰사항 -->
            <article class="guide-step">
                <div class="step-icon">
                    <img src="${pageContext.request.contextPath}/img/guide/guide2.PNG">
                </div>
                <div class="step-content">
                    <h2 class="step-number">02 진행사항</h2>
                    <p class="step-description">
                        동일 예약시간 환자 중 접수한 순서대로 전광판에 성명이 보입니다.<br>
                        "예약시간"은 현재 진료중인 환자의 진료예약시간입니다.
                    </p>
                </div>
            </article>

            <!-- 03 진료 -->
            <article class="guide-step">
                <div class="step-icon">
                    <img src="${pageContext.request.contextPath}/img/guide/guide3.PNG">
                </div>
                <div class="step-content">
                    <h2 class="step-number">03 진료</h2>
                    <p class="step-description">
                        담당직원의 안내에 따라 진료실에 들어가 의료진과 진료를 봅니다.<br>
                        진료실 안에서 진료 준비를 위해 대기하는 시간이 있을 수 있습니다.<br>
                        제증명, 의무기록사본이 필요한 경우 담당직원에게 미리 요청하시기 바랍니다.<br>
                        필요 시 신체검진을 할 수 있으므로 위아래가 분리된 옷을 입으시면 진료에 도움이 됩니다.<br>
                    </p>
                </div>
            </article>

            <!-- 04 진료 후 안내 -->
            <article class="guide-step">
                <div class="step-icon">
                    <img src="${pageContext.request.contextPath}/img/guide/guide4.PNG">
                </div>
                <div class="step-content">
                    <h2 class="step-number">04 진료 후 안내</h2>
                    <p class="step-description">
                        진료가 끝나면 의료진의 처방에 따라 담당직원이 안내해 드립니다.<br>
                        검사 및 시술이 예정된 분은 준비사항을 안내받으실 수 있습니다.
                    </p>
                </div>
            </article>

            <!-- 05 수납 -->
            <article class="guide-step">
                <div class="step-icon">
                    <img src="${pageContext.request.contextPath}/img/guide/guide5.PNG">
                </div>
                <div class="step-content">
                    <h2 class="step-number">05 수납</h2>
                    <p class="step-description">
                        진료비계산서(영수증)에 귀하가 가실 곳을 확인하시기 바랍니다.<br>
                        수납 창구 직원에게 외래에서 받으신 안내문을 전달하거나 병원등록번호를 알려주시면 수납이 가능하며<br>
                        하이패스가 등록되어 있는 경우 빠른 결제가 가능합니다.<br>
                        자동수납기에서 수납이 가능하나 자동 수납 도중 창구 방문이 필요한 경우가 있을 수 있습니다.<br>
                        (타과의뢰, 입원예약 등)
                    </p>
                </div>
            </article>

            <!-- 06 약제발급/약국/귀가 -->
            <article class="guide-step">
                <div class="step-icon">
                    <img src="${pageContext.request.contextPath}/img/guide/guide6.PNG">
                </div>
                <div class="step-content">
                    <h2 class="step-number">06 약제발급/약국/귀가</h2>
                    <p class="step-description">
                        안녕히 가십시오. 다음 진료일에 뵙겠습니다.<br>
                        담당의사로부터 입원이 결정된 분은 입원창구로 가셔서 예약 또는 입원수속을 하십시오.<br>
                        원외 처방전을 가지고 원하시는 (외부)약국에 가셔서 약을 받아 귀가하십시오.<br>
                    </p>
                </div>
            </article>

        </div>
    </section>
</main>

<!-- Footer include-->
<jsp:include page="/WEB-INF/views/common/homePageFooter/footer.jsp" />
</body>
</html>