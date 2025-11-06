<%--
  Created by IntelliJ IDEA.
  User: dream
  Date: 25. 11. 6.
  Time: 오전 11:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>오늘 환자</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/medical-today.css">

</head>
<body>

<!-- 메인 컨텐츠 영역 -->
<main class="medical-main">

    <!-- 페이지 제목 -->
    <h1 class="medical-page-title">진료 관리</h1>

    <!-- 카드 -->
    <div class="medical-card">

        <!-- 탭 헤더 -->
        <div class="medical-tabs-header" role="tablist">
            <button
                    class="medical-tab-btn active"
                    role="tab"
                    aria-selected="true"
                    aria-controls="today-panel"
                    data-tab="today"
            >
                오늘의 환자
                <span class="medical-tab-badge">5</span>
            </button>
            <button
                    class="medical-tab-btn"
                    role="tab"
                    aria-selected="false"
                    aria-controls="diagnosis-panel"
                    data-tab="diagnosis"
            >
                진단 내용
            </button>
        </div>

        <!-- 탭 컨텐츠 -->
        <div class="medical-tab-content">

            <!-- 오늘의 환자 탭 -->
            <section
                    class="medical-tab-pane active"
                    id="today-panel"
                    role="tabpanel"
                    aria-labelledby="today-tab"
            >
                <div class="medical-table-wrapper">
                    <table class="medical-table">
                        <thead>
                        <tr>
                            <th>예약 시간</th>
                            <th>환자</th>
                            <th>진료 목적</th>
                            <th>특이사항</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>09:30</td>
                            <td>김민준(P001)</td>
                            <td>재진(처방/결과)</td>
                            <td><span class="patient-badge patient-badge-warning">알레르기(페니실린)</span></td>
                        </tr>
                        <tr>
                            <td>10:00</td>
                            <td>이서윤(P002)</td>
                            <td>초진(흉통)</td>
                            <td><span class="patient-badge patient-badge-vip">VIP(우선진료)</span></td>
                        </tr>
                        <tr>
                            <td>10:30</td>
                            <td>박하준(P003)</td>
                            <td>검사 결과 확인</td>
                            <td><span class="patient-badge patient-badge-normal">일반</span></td>
                        </tr>
                        <tr>
                            <td>11:00</td>
                            <td>최지우(P004)</td>
                            <td>재진(경과)</td>

                            <td><span class="patient-badge patient-badge-normal">일반</span></td>
                        </tr>
                        <tr>
                            <td>11:30</td>
                            <td>정수현(P005)</td>
                            <td>검사 결과 확인</td>

                            <td><span class="patient-badge patient-badge-warning">고혈압 당뇨</span></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- 진단 내용 탭 -->
            <section
                    class="medical-tab-pane"
                    id="diagnosis-panel"
                    role="tabpanel"
                    aria-labelledby="diagnosis-tab"
            >
                <div class="diagnosis-list">
                    <!-- 헤더 -->
                    <div class="diagnosis-header">
                        <div>환자번호</div>
                        <div>진단 날짜</div>
                        <div>진료과</div>
                        <div>진단 내용</div>
                        <div>처방</div>
                    </div>

                    <!-- 진단 항목 1 -->
                    <article class="diagnosis-item">
                        <div data-label="환자번호">P001</div>
                        <div data-label="진단 날짜">2025.10.29</div>
                        <div data-label="진료과">심장외과</div>
                        <div class="diagnosis-text" data-label="진단 내용">주 진단: 대동맥판 협착증 (I35.0)
                            소견: 심장 초음파 상 협착 정도 심함.
                            환자 증상(호흡곤란, 흉통) 악화.
                            약물 치료 효과 제한적이며,
                            수술적 치료(TAVI 또는 AVR) 필요성 고지 및
                            보호자와 상의. 입원 전 관상동맥 CT 오더.</div>
                        <div class="diagnosis-text" data-label="처방">입원 오더 발행 (11/5),
                            관상동맥 CT 조영술 오더,
                            입원 전 정밀 검사 오더</div>
                    </article>

                    <!-- 진단 항목 2 -->
                    <article class="diagnosis-item">
                        <div data-label="환자번호">P002</div>
                        <div data-label="진단 날짜">2025.10.29</div>
                        <div data-label="진료과">심장외과</div>
                        <div class="diagnosis-text" data-label="진단 내용">주 진단: 관상동맥 다혈관 질환 (I25.1)
                            추정 진단: 관상동맥 우회로 이식술(CABG) 후
                            경과 관찰
                            소견: 수술 후 3개월 경과, 흉통
                            증상 호소 없음. 심장 기능 안정적. 이식
                            혈관의 개통성 확인을 위한 심장 CT 예약
                            필요.
                            다음 오더: 심장 CT 검사 후 4주 뒤 외래 재내원.</div>
                        <div class="diagnosis-text" data-label="처방">아스피린 D, 항응고제 E (기존 처방 유지), 심장 CT 오더 (검사 대기)</div>
                    </article>

                    <!-- 진단 항목 3 -->
                    <article class="diagnosis-item">
                        <div data-label="환자번호">P003</div>
                        <div data-label="진단 날짜">2025.10.29</div>
                        <div data-label="진료과">심장외과</div>
                        <div class="diagnosis-text" data-label="진단 내용">주 진단: 상세 불명의 심장 내 혈전 (I51.3)
                            소견: 경식도 초음파(TEE)에서 좌심방 혈전 확인. 혈전 크기가 중재적 시술에는
                            부적합하여 수술적 혈전 제거 고려.
                            응급 상황 대비 입원 필요.
                            검사 요청 사유: 수술 전 혈전 위치 및 주변 조직 관계 확인 목적.</div>
                        <div class="diagnosis-text" data-label="처방">응급 입원 오더, 혈전 생성 억제제 F (용량 조절), 흉부 X-ray</div>
                    </article>
                </div>

                <!-- 페이지네이션 -->
                <nav class="medical-pagination" aria-label="페이지네이션">
                    <button class="medical-page-btn" aria-label="이전 페이지">
                        <svg viewBox="0 0 24 24">
                            <polyline points="15 18 9 12 15 6"/>
                        </svg>
                    </button>
                    <button class="medical-page-btn active" aria-current="page">1</button>
                    <button class="medical-page-btn">2</button>
                    <button class="medical-page-btn">3</button>
                    <button class="medical-page-btn" aria-label="다음 페이지">
                        <svg viewBox="0 0 24 24">
                            <polyline points="9 18 15 12 9 6"/>
                        </svg>
                    </button>
                </nav>
            </section>

        </div>
    </div>

</main>

<script>
    // 탭 전환 기능
    const tabButtons = document.querySelectorAll('.medical-tab-btn');
    const tabPanes = document.querySelectorAll('.medical-tab-pane');

    tabButtons.forEach(button => {
        button.addEventListener('click', () => {
            const tabName = button.getAttribute('data-tab');

            // 모든 탭 버튼과 패널에서 active 제거
            tabButtons.forEach(btn => {
                btn.classList.remove('active');
                btn.setAttribute('aria-selected', 'false');
            });
            tabPanes.forEach(pane => pane.classList.remove('active'));

            // 클릭한 탭 버튼과 해당 패널에 active 추가
            button.classList.add('active');
            button.setAttribute('aria-selected', 'true');
            document.getElementById(tabName + '-panel').classList.add('active');
        });
    });

    // 페이지네이션
    const pageButtons = document.querySelectorAll('.medical-page-btn');
    pageButtons.forEach(button => {
        button.addEventListener('click', () => {
            if (button.textContent.trim().match(/^\d+$/)) {
                pageButtons.forEach(btn => {
                    if (btn.textContent.trim().match(/^\d+$/)) {
                        btn.classList.remove('active');
                        btn.removeAttribute('aria-current');
                    }
                });
                button.classList.add('active');
                button.setAttribute('aria-current', 'page');
            }
        });
    });
</script>

</body>
</html>
