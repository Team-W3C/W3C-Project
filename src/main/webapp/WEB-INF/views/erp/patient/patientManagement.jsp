<%-- Created by IntelliJ IDEA. User: suk Date: 2025-11-07 Time: 오전 10:00 To
change this template use File | Settings | File Templates. --%> <%@ page
contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Title</title>
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/css/erpPatient/patientDetail.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/css/erpPatient/patientManage.css"
    />
  </head>
  <body>
    <!-- 환자 관리 메인 콘텐츠 -->
    <main class="patient-main">
      <!-- 페이지 헤더 -->
      <section class="patient-header">
        <h1 class="patient-title">환자 관리</h1>
        <button class="patient-btn-add">
          <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
            <path
              d="M8 3.33337V12.6667M3.33333 8H12.6667"
              stroke="white"
              stroke-width="1.5"
              stroke-linecap="round"
            />
          </svg>
          신규 환자 등록
        </button>
      </section>
      <!-- 통계 카드 -->
      <section class="patient-stats">
        <div class="patient-stat-card">
          <p class="patient-stat-label">전체 환자</p>
          <p class="patient-stat-value">1,248명</p>
        </div>
        <div class="patient-stat-card">
          <p class="patient-stat-label">오늘 방문</p>
          <p class="patient-stat-value">32명</p>
        </div>
        <div class="patient-stat-card">
          <p class="patient-stat-label">신규 환자 (이번 달)</p>
          <p class="patient-stat-value">48명</p>
        </div>
        <div class="patient-stat-card">
          <p class="patient-stat-label">VIP 환자</p>
          <p class="patient-stat-value">187명</p>
        </div>
      </section>
      <!-- 검색 및 필터 -->
      <section class="patient-search-section">
        <div class="patient-search-wrapper">
          <div class="patient-search-box">
            <svg
              class="patient-search-icon"
              width="20"
              height="20"
              viewBox="0 0 20 20"
              fill="none"
            >
              <circle
                cx="9"
                cy="9"
                r="5.5"
                stroke="#9CA3AF"
                stroke-width="1.5"
              />
              <path
                d="M13 13L16 16"
                stroke="#9CA3AF"
                stroke-width="1.5"
                stroke-linecap="round"
              />
            </svg>
            <input
              type="text"
              class="patient-search-input"
              placeholder="환자명, 환자번호, 연락처로 검색..."
            />
          </div>

          <div class="patient-filter-group">
            <select class="patient-select">
              <option>모든 등급</option>
              <option>일반</option>
              <option>우선예약</option>
              <option>VIP</option>
            </select>
            <button class="patient-btn-filter">
              <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                <path
                  d="M2 4H14M4 8H12M6 12H10"
                  stroke="#6B7280"
                  stroke-width="1.5"
                  stroke-linecap="round"
                />
              </svg>
              필터
            </button>
          </div>

          <button class="patient-btn-search">검색</button>
        </div>
      </section>

      <!-- 환자 목록 테이블 -->
      <section class="patient-table-section">
        <div class="patient-table-wrapper">
          <table class="patient-table">
            <thead>
              <tr>
                <th>환자번호</th>
                <th>이름</th>
                <th>나이/성별</th>
                <th>연락처</th>
                <th>마지막 방문</th>
                <th>방문 횟수</th>
                <th>등급</th>
                <th>작업</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>P001</td>
                <td>
                  <div class="patient-name-cell">
                    <div class="patient-avatar">김</div>
                    <span>김민수</span>
                  </div>
                </td>
                <td>45세 / 남</td>
                <td>010-1234-5678</td>
                <td>2025-10-25</td>
                <td>12회</td>
                <td>
                  <span class="patient-badge patient-badge-normal">일반</span>
                </td>
                <td>
                  <button class="patient-btn-detail">상세보기</button>
                </td>
              </tr>
              <tr>
                <td>P002</td>
                <td>
                  <div class="patient-name-cell">
                    <div class="patient-avatar">이</div>
                    <span>이영희</span>
                  </div>
                </td>
                <td>38세 / 여</td>
                <td>010-2345-6789</td>
                <td>2025-10-27</td>
                <td>8회</td>
                <td>
                  <span class="patient-badge patient-badge-priority"
                    >우선예약</span
                  >
                </td>
                <td>
                  <button class="patient-btn-detail">상세보기</button>
                </td>
              </tr>
              <tr>
                <td>P003</td>
                <td>
                  <div class="patient-name-cell">
                    <div class="patient-avatar">박</div>
                    <span>박철수</span>
                  </div>
                </td>
                <td>52세 / 남</td>
                <td>010-3456-7890</td>
                <td>2025-10-20</td>
                <td>24회</td>
                <td>
                  <span class="patient-badge patient-badge-vip">VIP</span>
                </td>
                <td>
                  <button class="patient-btn-detail">상세보기</button>
                </td>
              </tr>
              <tr>
                <td>P004</td>
                <td>
                  <div class="patient-name-cell">
                    <div class="patient-avatar">정</div>
                    <span>정수연</span>
                  </div>
                </td>
                <td>29세 / 여</td>
                <td>010-4567-8901</td>
                <td>2025-10-28</td>
                <td>5회</td>
                <td>
                  <span class="patient-badge patient-badge-normal">일반</span>
                </td>
                <td>
                  <button class="patient-btn-detail">상세보기</button>
                </td>
              </tr>
              <tr>
                <td>P005</td>
                <td>
                  <div class="patient-name-cell">
                    <div class="patient-avatar">한</div>
                    <span>한지민</span>
                  </div>
                </td>
                <td>41세 / 여</td>
                <td>010-5678-9012</td>
                <td>2025-10-22</td>
                <td>15회</td>
                <td>
                  <span class="patient-badge patient-badge-priority"
                    >우선예약</span
                  >
                </td>
                <td>
                  <button class="patient-btn-detail">상세보기</button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- 페이지네이션 -->
        <div class="patient-pagination">
          <p class="patient-pagination-info">총 1,248명 중 1-5명 표시</p>
          <div class="patient-pagination-buttons">
            <button class="patient-page-btn">이전</button>
            <button class="patient-page-btn patient-page-active">1</button>
            <button class="patient-page-btn">2</button>
            <button class="patient-page-btn">3</button>
            <button class="patient-page-btn">다음</button>
          </div>
        </div>
      </section>
    </main>
    <div class="modal-patient-detail">
      <div class="modal-overlay">
        <!-- 모달 헤더 -->
        <header class="modal-patient-header">
          <div class="modal-profile">
            <div class="modal-avatar">김</div>
            <div class="modal-info">
              <div class="modal-title-wrapper">
                <h1 class="modal-name">김민수</h1>
                <span class="modal-badge">일반</span>
              </div>
              <div class="modal-meta">
                <span class="modal-age">45세 • 남</span>
                <span class="modal-number">환자번호: P001</span>
              </div>
            </div>
          </div>
          <button class="modal-btn-menu" aria-label="메뉴">
            <svg width="20" height="20" viewBox="0 0 20 20">
              <path
                d="M10 6a2 2 0 110-4 2 2 0 010 4zm0 6a2 2 0 110-4 2 2 0 010 4zm0 6a2 2 0 110-4 2 2 0 010 4z"
                fill="currentColor"
              />
            </svg>
          </button>
        </header>

        <!-- 모달 콘텐츠 -->
        <div class="modal-content">
          <!-- 기본 정보 -->
          <section class="modal-section">
            <h2 class="modal-section-title">
              <svg
                width="16"
                height="16"
                viewBox="0 0 16 16"
                class="modal-section-icon"
              >
                <rect x="3" y="10" width="10" height="4" fill="currentColor" />
                <circle cx="8" cy="5" r="3" fill="currentColor" />
              </svg>
              기본 정보
            </h2>
            <div class="modal-info-grid">
              <div class="modal-info-item">
                <span class="modal-info-label">생년월일</span>
                <span class="modal-info-value">1980.03.15</span>
              </div>
              <div class="modal-info-item">
                <span class="modal-info-label">혈액형</span>
                <span class="modal-info-value">A+</span>
              </div>
              <div class="modal-info-item">
                <span class="modal-info-label">등록일</span>
                <span class="modal-info-value">2024.01.10</span>
              </div>
              <div class="modal-info-item">
                <span class="modal-info-label">연락처</span>
                <span class="modal-info-value">010-1234-5678</span>
              </div>
              <div class="modal-info-item modal-info-full">
                <span class="modal-info-label">
                  <svg
                    width="12"
                    height="12"
                    viewBox="0 0 12 12"
                    class="modal-label-icon"
                  >
                    <path
                      d="M6 0C3.243 0 1 2.243 1 5c0 3.188 4.5 7 5 7s5-3.812 5-7c0-2.757-2.243-5-5-5zm0 7a2 2 0 110-4 2 2 0 010 4z"
                      fill="currentColor"
                    />
                  </svg>
                  주소
                </span>
                <span class="modal-info-value">서울시 강남구 테헤란로 123</span>
              </div>
            </div>
          </section>

          <!-- 의료 정보 -->
          <section class="modal-section">
            <h2 class="modal-section-title">
              <svg
                width="16"
                height="16"
                viewBox="0 0 16 16"
                class="modal-section-icon"
              >
                <path
                  d="M13.5 2.5h-11A1.5 1.5 0 001 4v9.5A1.5 1.5 0 002.5 15h11a1.5 1.5 0 001.5-1.5V4a1.5 1.5 0 00-1.5-1.5z"
                  fill="currentColor"
                />
              </svg>
              의료 정보
            </h2>
            <div class="modal-medical-grid">
              <div class="modal-medical-item modal-medical-chronic">
                <span class="modal-medical-label">만성질환</span>
                <span class="modal-medical-value">천식</span>
              </div>
              <div class="modal-medical-item modal-medical-allergy">
                <span class="modal-medical-label">알러지</span>
                <span class="modal-medical-value">망고 알레르기</span>
              </div>
            </div>
          </section>

          <!-- 방문 통계 -->
          <section class="modal-section">
            <h2 class="modal-section-title">방문 통계</h2>
            <div class="modal-stats-grid">
              <div class="modal-stat-item modal-stat-primary">
                <span class="modal-stat-label">총 방문 횟수</span>
                <span class="modal-stat-value">12회</span>
              </div>
              <div class="modal-stat-item modal-stat-blue">
                <span class="modal-stat-label">10월 방문</span>
                <span class="modal-stat-value">3회</span>
              </div>
              <div class="modal-stat-item modal-stat-green">
                <span class="modal-stat-label">마지막 방문</span>
                <span class="modal-stat-value">2025-10-25</span>
              </div>
            </div>
          </section>

          <!-- 10월 진료 기록 -->
          <section class="modal-section">
            <h2 class="modal-section-title">
              <svg
                width="16"
                height="16"
                viewBox="0 0 16 16"
                class="modal-section-icon"
              >
                <path
                  d="M14 2h-2V1a1 1 0 00-2 0v1H6V1a1 1 0 00-2 0v1H2a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V4a2 2 0 00-2-2zM2 6h12v8H2V6z"
                  fill="currentColor"
                />
              </svg>
              10월 진료 기록
            </h2>
            <div class="modal-record-list">
              <article class="modal-record-card">
                <div class="modal-record-header">
                  <div class="modal-record-info">
                    <span class="modal-record-date">2025-10-25</span>
                    <span class="modal-record-dept modal-dept-ortho"
                      >정형외과</span
                    >
                  </div>
                  <span class="modal-record-status">완료</span>
                </div>
                <div class="modal-record-details">
                  <span class="modal-record-detail">담당의: 이준호</span>
                  <span class="modal-record-separator">•</span>
                  <span class="modal-record-detail">진단: 요통</span>
                </div>
              </article>
              <article class="modal-record-card">
                <div class="modal-record-header">
                  <div class="modal-record-info">
                    <span class="modal-record-date">2025-10-10</span>
                    <span class="modal-record-dept modal-dept-ortho"
                      >정형외과</span
                    >
                  </div>
                  <span class="modal-record-status">완료</span>
                </div>
                <div class="modal-record-details">
                  <span class="modal-record-detail">담당의: 이준호</span>
                  <span class="modal-record-separator">•</span>
                  <span class="modal-record-detail">진단: 정기검진</span>
                </div>
              </article>

              <article class="modal-record-card">
                <div class="modal-record-header">
                  <div class="modal-record-info">
                    <span class="modal-record-date">2025-10-05</span>
                    <span class="modal-record-dept modal-dept-internal"
                      >내과</span
                    >
                  </div>
                  <span class="modal-record-status">완료</span>
                </div>
                <div class="modal-record-details">
                  <span class="modal-record-detail">담당의: 김서연</span>
                  <span class="modal-record-separator">•</span>
                  <span class="modal-record-detail">진단: 감기</span>
                </div>
              </article>
            </div>
          </section>

          <!-- 예정된 예약 -->
          <section class="modal-section">
            <h2 class="modal-section-title">
              <svg
                width="16"
                height="16"
                viewBox="0 0 16 16"
                class="modal-section-icon"
              >
                <path
                  d="M8 0a8 8 0 100 16A8 8 0 008 0zm1 9H7V4h2v5z"
                  fill="currentColor"
                />
              </svg>
              예정된 예약
            </h2>
            <article class="modal-appointment-card">
              <div class="modal-appointment-header">
                <div class="modal-appointment-info">
                  <span class="modal-appointment-datetime"
                    >2025-11-05 14:00</span
                  >
                  <span class="modal-appointment-dept">정형외과</span>
                </div>
                <span class="modal-appointment-type">정기검진</span>
              </div>
              <div class="modal-appointment-doctor">담당의: 이준호</div>
            </article>
          </section>
        </div>
        <!-- 모달 푸터 -->
        <footer class="modal-footer">
          <button class="modal-btn modal-btn-secondary">닫기</button>
          <div class="modal-actions">
            <button class="modal-btn modal-btn-outline">정보 수정</button>
            <button class="modal-btn modal-btn-primary">예약 추가</button>
          </div>
        </footer>
      </div>
    </div>
    <script>
      // 상세보기 버튼 클릭 → 모달 열기
      document.querySelectorAll(".patient-btn-detail").forEach((btn) => {
        btn.addEventListener("click", () => {
          document.querySelector(".modal-overlay").classList.add("active");
          document
            .querySelector(".modal-patient-detail")
            .classList.add("active");
        });
      });

      // 닫기 버튼 or 오버레이 클릭 → 모달 닫기
      document
        .querySelectorAll(".modal-btn-secondary, .modal-overlay")
        .forEach((btn) => {
          btn.addEventListener("click", (e) => {
            if (
              e.target.classList.contains("modal-overlay") ||
              e.target.classList.contains("modal-btn-secondary")
            ) {
              document
                .querySelector(".modal-overlay")
                .classList.remove("active");
              document
                .querySelector(".modal-patient-detail")
                .classList.remove("active");
            }
          });
        });
    </script>
  </body>
</html>
