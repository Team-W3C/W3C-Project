<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>진료예약 - 병원 예약 시스템</title>
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/css/detailReservation.css"
    />
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/main.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/index.css">
  </head>
  <body>
    <!-- Top Navigation -->
    <jsp:include page="../../common/homePageMember/header_member.jsp" />
    <div class="reservation">
    <main class="reservation-main">
      <!-- Sidebar Navigation -->
      <aside class="reservation-sidebar">
        <div class="sidebar-header">
          <h2>진료예약/안내</h2>
        </div>

        <nav class="sidebar-nav">
          <ul class="nav-list">
            <li class="nav-item">
              <a href="#" class="link">병원안내</a>
            </li>
            <li class="nav-item active">
              <a href="#" class="link">외래진료안내</a>
              <ul class="nav-sublist">
                <li class="nav-subitem active">
                  <a href="#" class="nav-sublink">진료예약</a>
                </li>
                <li class="nav-subitem">
                  <a href="#" class="nav-sublink">진료절차</a>
                </li>
                <li class="nav-subitem">
                  <a href="#" class="nav-sublink">진료안내</a>
                </li>
              </ul>
            </li>
          </ul>
        </nav>

        <div class="sidebar-contact">
          <p class="contact-label">예약문의</p>
          <p class="contact-number">1111-1111</p>
        </div>
      </aside>

      <!-- Main Content Area -->
      <section class="reservation-content">
        <!-- Page Header -->
        <header class="reservation-header">
          <h1 class="page-title">진료예약</h1>
          <p class="page-subtitle">
            원하시는 날짜와 시간을 선택하여 진료를 예약하세요.
          </p>
        </header>

        <!-- Step 1: 날짜 및 진료과 선택 -->
        <article class="reservation-card">
          <div class="card-header">
            <div class="step-badge">
              <span class="step-number">1</span>
            </div>
            <h2 class="card-title">날짜 및 진료과 선택</h2>
          </div>

          <div class="card-body">
            <!-- 날짜 선택 -->
            <div class="selection-section">
              <h3 class="section-title">날짜 선택</h3>
              <div class="calendar-wrapper">
                <div class="calendar-header">
                  <button
                    type="button"
                    class="calendar-nav-btn"
                    aria-label="이전 달"
                  >
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-10.svg"
                      alt=""
                    />
                  </button>
                  <span class="calendar-month">2025년 10월</span>
                  <button
                    type="button"
                    class="calendar-nav-btn"
                    aria-label="다음 달"
                  >
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-12.svg"
                      alt=""
                    />
                  </button>
                </div>

                <div class="calendar">
                  <div class="calendar-weekdays">
                    <span>일</span>
                    <span>월</span>
                    <span>화</span>
                    <span>수</span>
                    <span>목</span>
                    <span>금</span>
                    <span>토</span>
                  </div>

                  <div class="calendar-days">
                    <button type="button" class="calendar-day disabled">
                      27
                    </button>
                    <button type="button" class="calendar-day disabled">
                      28
                    </button>
                    <button type="button" class="calendar-day disabled">
                      29
                    </button>
                    <button type="button" class="calendar-day disabled">
                      30
                    </button>
                    <button type="button" class="calendar-day disabled">
                      31
                    </button>
                    <button type="button" class="calendar-day available">
                      1
                    </button>
                    <button type="button" class="calendar-day available">
                      2
                    </button>
                    <button type="button" class="calendar-day available">
                      3
                    </button>
                    <button type="button" class="calendar-day available">
                      4
                    </button>
                    <button type="button" class="calendar-day available">
                      5
                    </button>
                    <button type="button" class="calendar-day available">
                      6
                    </button>
                    <button type="button" class="calendar-day available">
                      7
                    </button>
                    <button type="button" class="calendar-day available">
                      8
                    </button>
                    <button type="button" class="calendar-day available">
                      9
                    </button>
                    <button type="button" class="calendar-day available">
                      10
                    </button>
                    <button type="button" class="calendar-day available">
                      11
                    </button>
                    <button type="button" class="calendar-day available">
                      12
                    </button>
                    <button type="button" class="calendar-day available">
                      13
                    </button>
                    <button type="button" class="calendar-day available">
                      14
                    </button>
                    <button type="button" class="calendar-day available">
                      15
                    </button>
                    <button type="button" class="calendar-day available">
                      16
                    </button>
                    <button type="button" class="calendar-day available">
                      17
                    </button>
                    <button type="button" class="calendar-day available">
                      18
                    </button>
                    <button type="button" class="calendar-day available">
                      19
                    </button>
                    <button type="button" class="calendar-day available">
                      20
                    </button>
                    <button type="button" class="calendar-day available">
                      21
                    </button>
                    <button type="button" class="calendar-day available">
                      22
                    </button>
                    <button type="button" class="calendar-day available">
                      23
                    </button>
                    <button type="button" class="calendar-day available">
                      24
                    </button>
                    <button type="button" class="calendar-day available">
                      25
                    </button>
                    <button type="button" class="calendar-day available">
                      26
                    </button>
                    <button type="button" class="calendar-day available">
                      27
                    </button>
                    <button type="button" class="calendar-day available">
                      28
                    </button>
                    <button type="button" class="calendar-day selected">
                      29
                    </button>
                    <button type="button" class="calendar-day available">
                      30
                    </button>
                    <button type="button" class="calendar-day available">
                      31
                    </button>
                  </div>
                </div>
              </div>
            </div>

            <!-- 진료과 선택 -->
            <div class="selection-section department-section">
              <h3 class="section-title">진료과 선택</h3>

              <div class="department-grid">
                <button type="button" class="department-btn">
                  <img
                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/container.svg"
                    alt=""
                    class="department-icon"
                  />
                  <span>내과</span>
                </button>
                <button type="button" class="department-btn">
                  <img
                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/container-7.svg"
                    alt=""
                    class="department-icon"
                  />
                  <span>외과</span>
                </button>
                <button type="button" class="department-btn">
                  <img
                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/container-6.svg"
                    alt=""
                    class="department-icon"
                  />
                  <span>정형외과</span>
                </button>
                <button type="button" class="department-btn">
                  <img
                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/container-2.svg"
                    alt=""
                    class="department-icon"
                  />
                  <span>소아과</span>
                </button>
                <button type="button" class="department-btn">
                  <img
                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/container-3.svg"
                    alt=""
                    class="department-icon"
                  />
                  <span>피부과</span>
                </button>
                <button type="button" class="department-btn selected">
                  <img
                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/container-1.svg"
                    alt=""
                    class="department-icon"
                  />
                  <span>안과</span>
                  <img
                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-1.svg"
                    alt="선택됨"
                    class="check-icon"
                  />
                </button>
                <button type="button" class="department-btn">
                  <img
                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/container-4.svg"
                    alt=""
                    class="department-icon"
                  />
                  <span>치과</span>
                </button>
                <button type="button" class="department-btn">
                  <img
                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/container-5.svg"
                    alt=""
                    class="department-icon"
                  />
                  <span>심장내과</span>
                </button>
              </div>
            </div>
          </div>
        </article>

        <!-- 선택 요약 -->
        <div class="selection-summary">
          <div class="summary-item">
            <span class="summary-dot"></span>
            <span class="summary-label">선택 진료과:</span>
            <span class="summary-value">내과</span>
          </div>
          <div class="summary-item">
            <span class="summary-dot"></span>
            <span class="summary-label">선택 날짜:</span>
            <span class="summary-value">2025년 10월 29일 수</span>
          </div>
        </div>

        <!-- Step 2: 시간 선택 -->
        <article class="reservation-card">
          <div class="card-header">
            <div class="step-badge">
              <span class="step-number">2</span>
            </div>
            <h2 class="card-title">시간 선택</h2>
            <div class="legend">
              <span class="legend-item">
                <img
                  src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-13.svg"
                  alt=""
                />
                예약 가능
              </span>
              <span class="legend-item">
                <img
                  src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-31.svg"
                  alt=""
                />
                예약 마감
              </span>
            </div>
          </div>

          <div class="card-body">
            <div class="timeslot-grid">
              <!-- 예약 가능 슬롯 -->
              <button type="button" class="timeslot-card available">
                <div class="timeslot-header">
                  <div class="timeslot-time">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-4.svg"
                      alt=""
                    />
                    <span>09:00~10:00</span>
                  </div>
                  <img
                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-8.svg"
                    alt="예약 가능"
                    class="status-icon"
                  />
                </div>
                <div class="timeslot-info">
                  <p class="doctor-info">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-2.svg"
                      alt=""
                    />
                    <span>정수민 교수</span>
                  </p>
                  <p class="location-info">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-7.svg"
                      alt=""
                    />
                    <span>본관 2층 205호</span>
                  </p>
                </div>
              </button>

              <button type="button" class="timeslot-card available">
                <div class="timeslot-header">
                  <div class="timeslot-time">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-9.svg"
                      alt=""
                    />
                    <span>10:00~11:00</span>
                  </div>
                  <img
                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-8.svg"
                    alt="예약 가능"
                    class="status-icon"
                  />
                </div>
                <div class="timeslot-info">
                  <p class="doctor-info">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-2.svg"
                      alt=""
                    />
                    <span>이영희 교수</span>
                  </p>
                  <p class="location-info">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-7.svg"
                      alt=""
                    />
                    <span>본관 2층 205호</span>
                  </p>
                </div>
              </button>

              <button type="button" class="timeslot-card available">
                <div class="timeslot-header">
                  <div class="timeslot-time">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-9.svg"
                      alt=""
                    />
                    <span>11:00~12:00</span>
                  </div>
                  <img
                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-1.svg"
                    alt="선택됨"
                    class="status-icon"
                  />
                </div>
                <div class="timeslot-info">
                  <p class="doctor-info">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-2.svg"
                      alt=""
                    />
                    <span>정수민 교수</span>
                  </p>
                  <p class="location-info">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon.svg"
                      alt=""
                    />
                    <span>본관 3층 301호</span>
                  </p>
                </div>
              </button>

              <button type="button" class="timeslot-card available">
                <div class="timeslot-header">
                  <div class="timeslot-time">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-9.svg"
                      alt=""
                    />
                    <span>12:00~13:00</span>
                  </div>
                  <img
                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-1.svg"
                    alt="선택됨"
                    class="status-icon"
                  />
                </div>
                <div class="timeslot-info">
                  <p class="doctor-info">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-2.svg"
                      alt=""
                    />
                    <span>이영희 교수</span>
                  </p>
                  <p class="location-info">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon.svg"
                      alt=""
                    />
                    <span>별관 1층 102호</span>
                  </p>
                </div>
              </button>

              <button type="button" class="timeslot-card available">
                <div class="timeslot-header">
                  <div class="timeslot-time">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-4.svg"
                      alt=""
                    />
                    <span>13:00~14:00</span>
                  </div>
                  <img
                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-8.svg"
                    alt="예약 가능"
                    class="status-icon"
                  />
                </div>
                <div class="timeslot-info">
                  <p class="doctor-info">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-2.svg"
                      alt=""
                    />
                    <span>이영희 교수</span>
                  </p>
                  <p class="location-info">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-7.svg"
                      alt=""
                    />
                    <span>본관 3층 301호</span>
                  </p>
                </div>
              </button>

              <!-- 예약 마감 슬롯 -->
              <div class="timeslot-card unavailable">
                <div class="timeslot-header">
                  <div class="timeslot-time">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-9.svg"
                      alt=""
                    />
                    <span>14:00~15:00</span>
                  </div>
                  <img
                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-11.svg"
                    alt="예약 마감"
                    class="status-icon"
                  />
                </div>
                <span class="unavailable-badge">예약 마감</span>
              </div>

              <div class="timeslot-card unavailable">
                <div class="timeslot-header">
                  <div class="timeslot-time">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-9.svg"
                      alt=""
                    />
                    <span>15:00~16:00</span>
                  </div>
                  <img
                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-33.svg"
                    alt="예약 마감"
                    class="status-icon"
                  />
                </div>
                <span class="unavailable-badge">예약 마감</span>
              </div>

              <button type="button" class="timeslot-card available">
                <div class="timeslot-header">
                  <div class="timeslot-time">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-9.svg"
                      alt=""
                    />
                    <span>16:00~17:00</span>
                  </div>
                  <img
                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-1.svg"
                    alt="선택됨"
                    class="status-icon"
                  />
                </div>
                <div class="timeslot-info">
                  <p class="doctor-info">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-2.svg"
                      alt=""
                    />
                    <span>정수민 교수</span>
                  </p>
                  <p class="location-info">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon.svg"
                      alt=""
                    />
                    <span>별관 1층 102호</span>
                  </p>
                </div>
              </button>

              <button type="button" class="timeslot-card available">
                <div class="timeslot-header">
                  <div class="timeslot-time">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-4.svg"
                      alt=""
                    />
                    <span>17:00~18:00</span>
                  </div>
                  <img
                    src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-8.svg"
                    alt="예약 가능"
                    class="status-icon"
                  />
                </div>
                <div class="timeslot-info">
                  <p class="doctor-info">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon-2.svg"
                      alt=""
                    />
                    <span>김철수 교수</span>
                  </p>
                  <p class="location-info">
                    <img
                      src="https://c.animaapp.com/mhjva9g3rpbRQm/img/icon.svg"
                      alt=""
                    />
                    <span>본관 2층 205호</span>
                  </p>
                </div>
              </button>
            </div>
          </div>
        </article>
      </section>
    </main>
        <jsp:include page="../../common/homePageFooter/footer.jsp" />
  </body>
</html>
