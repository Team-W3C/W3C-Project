<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>새 예약 등록</title>
    <link rel="stylesheet" href="/ERP 새 환자 등록/addPatient.css" />
  </head>
  <body>
    <!-- Modal Backdrop -->
    <div class="modal-backdrop" id="modalBackdrop">
      <!-- Modal Container -->
      <div class="modal-container">
        <!-- Header -->
        <div class="modal-header">
          <h3 class="modal-title">새 예약 등록</h3>
          <button class="close-button" id="closeButton">
            <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
              <path
                d="M15 5L5 15"
                stroke="#6B7280"
                stroke-width="1.67"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
              <path
                d="M5 5L15 15"
                stroke="#6B7280"
                stroke-width="1.67"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
            </svg>
          </button>
        </div>

        <!-- Form Content -->
        <div class="modal-body">
          <!-- 환자 선택 -->
          <div class="form-group">
            <label class="form-label">
              환자 선택
              <span class="required">*</span>
            </label>
            <div class="search-input-wrapper">
              <svg
                class="search-icon"
                width="20"
                height="20"
                viewBox="0 0 20 20"
                fill="none"
              >
                <path
                  d="M17.5 17.5L13.8833 13.8833"
                  stroke="#6B7280"
                  stroke-width="1.67"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
                <circle
                  cx="9.16667"
                  cy="9.16667"
                  r="6.66667"
                  stroke="#6B7280"
                  stroke-width="1.67"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>
              <input
                type="text"
                class="search-input"
                placeholder="환자명, 환자번호, 연락처로 검색..."
              />
            </div>
          </div>

          <!-- 증상 -->
          <div class="form-group">
            <label class="form-label">
              증상
              <span class="required">*</span>
            </label>
            <input
              type="text"
              class="text-input"
              placeholder="증상을 입력하세요"
            />
          </div>

          <!-- 진료과 & 담당의 -->
          <div class="form-row">
            <div class="form-group half">
              <label class="form-label">
                진료과
                <span class="required">*</span>
              </label>
              <select class="select-input" id="departmentSelect">
                <option value="">진료과 선택</option>
                <option value="정형외과">정형외과</option>
                <option value="내과">내과</option>
                <option value="신경외과">신경외과</option>
                <option value="피부과">피부과</option>
                <option value="소화기내과">소화기내과</option>
                <option value="이비인후과">이비인후과</option>
                <option value="종합검진">종합검진</option>
              </select>
            </div>
            <div class="form-group half">
              <label class="form-label">
                담당의
                <span class="required">*</span>
              </label>
              <select class="select-input disabled" id="doctorSelect" disabled>
                <option value="">담당의 선택</option>
              </select>
            </div>
          </div>

          <!-- 예약 날짜 & 예약 시간 -->
          <div class="form-row">
            <!-- 예약 날짜 -->
            <div class="form-group half">
              <label class="form-label">
                예약 날짜
                <span class="required">*</span>
              </label>
              <div class="calendar-container">
                <div class="calendar-header">
                  <button class="calendar-nav" id="prevMonth">
                    <svg width="16" height="16" viewBox="0 0 6 10" fill="none">
                      <path
                        d="M4.66667 8.66667L0.666667 4.66667L4.66667 0.666667"
                        stroke="#6B7280"
                        stroke-width="1.33"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </button>
                  <span class="calendar-month" id="calendarMonth"
                    >October 2025</span
                  >
                  <button class="calendar-nav" id="nextMonth">
                    <svg width="16" height="16" viewBox="0 0 6 10" fill="none">
                      <path
                        d="M0.666667 8.66667L4.66667 4.66667L0.666667 0.666667"
                        stroke="#6B7280"
                        stroke-width="1.33"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </button>
                </div>
                <div class="calendar-grid">
                  <div class="calendar-weekdays">
                    <div class="weekday">Su</div>
                    <div class="weekday">Mo</div>
                    <div class="weekday">Tu</div>
                    <div class="weekday">We</div>
                    <div class="weekday">Th</div>
                    <div class="weekday">Fr</div>
                    <div class="weekday">Sa</div>
                  </div>
                  <div class="calendar-days" id="calendarDays">
                    <!-- Calendar days will be generated by JavaScript -->
                  </div>
                </div>
              </div>
            </div>

            <!-- 예약 시간 -->
            <div class="form-group half">
              <label class="form-label">
                예약 시간
                <span class="required">*</span>
                <span class="selected-count" id="selectedCount"
                  >(2개 선택됨)</span
                >
              </label>
              <div class="time-container">
                <div class="selected-times">
                  <div class="selected-label">선택된 시간</div>
                  <div class="selected-badges" id="selectedBadges">
                    <div class="time-badge" data-time="09:00">
                      09:00
                      <button class="remove-time">
                        <svg
                          width="12"
                          height="12"
                          viewBox="0 0 7 7"
                          fill="none"
                        >
                          <path
                            d="M6.5 0.5L0.5 6.5"
                            stroke="white"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          />
                          <path
                            d="M0.5 0.5L6.5 6.5"
                            stroke="white"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          />
                        </svg>
                      </button>
                    </div>
                    <div class="time-badge" data-time="09:30">
                      09:30
                      <button class="remove-time">
                        <svg
                          width="12"
                          height="12"
                          viewBox="0 0 7 7"
                          fill="none"
                        >
                          <path
                            d="M6.5 0.5L0.5 6.5"
                            stroke="white"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          />
                          <path
                            d="M0.5 0.5L6.5 6.5"
                            stroke="white"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          />
                        </svg>
                      </button>
                    </div>
                  </div>
                </div>
                <div class="time-slots" id="timeSlots">
                  <button class="time-slot selected" data-time="09:00">
                    09:00
                  </button>
                  <button class="time-slot selected" data-time="09:30">
                    09:30
                  </button>
                  <button class="time-slot" data-time="10:00">10:00</button>
                  <button class="time-slot" data-time="10:30">10:30</button>
                  <button class="time-slot" data-time="11:00">11:00</button>
                  <button class="time-slot" data-time="11:30">11:30</button>
                  <button class="time-slot" data-time="12:00">12:00</button>
                  <button class="time-slot" data-time="12:30">12:30</button>
                  <button class="time-slot" data-time="13:00">13:00</button>
                  <button class="time-slot" data-time="13:30">13:30</button>
                  <button class="time-slot" data-time="14:00">14:00</button>
                  <button class="time-slot" data-time="14:30">14:30</button>
                  <button class="time-slot" data-time="15:00">15:00</button>
                  <button class="time-slot" data-time="15:30">15:30</button>
                  <button class="time-slot" data-time="16:00">16:00</button>
                  <button class="time-slot" data-time="16:30">16:30</button>
                  <button class="time-slot" data-time="17:00">17:00</button>
                  <button class="time-slot" data-time="17:30">17:30</button>
                </div>
              </div>
            </div>
          </div>
          <!-- 사용 시설 -->
          <!-- <%--                <div class="form-group">--%>
<%--                    <label class="form-label">사용 시설 (선택사항)</label>--%>
<%--                    <select class="select-input" id="facilitySelect">--%>
<%--                        <option value="">시설 선택 안 함</option>--%>
<%--                        <option value="MRI-01">MRI-01</option>--%>
<%--                        <option value="MRI-02">MRI-02</option>--%>
<%--                        <option value="CT-01">CT-01</option>--%>
<%--                        <option value="CT-02">CT-02</option>--%>
<%--                        <option value="X-Ray-01">X-Ray-01</option>--%>
<%--                        <option value="X-Ray-02">X-Ray-02</option>--%>
<%--                        <option value="초음파-01">초음파-01</option>--%>
<%--                        <option value="초음파-02">초음파-02</option>--%>
<%--                        <option value="내시경-01">내시경-01</option>--%>
<%--                        <option value="내시경-02">내시경-02</option>--%>
<%--                    </select>--%>
<%--                </div>--%> -->

          <!-- 메모 -->
<%--          <div class="form-group">--%>
<%--            <label class="form-label">메모</label>--%>
<%--            <textarea--%>
<%--              class="textarea-input"--%>
<%--              placeholder="예약 관련 메모를 입력하세요..."--%>
<%--              rows="4"--%>
<%--            ></textarea>--%>
<%--          </div>--%>
        </div>

        <!-- Footer -->
        <div class="modal-footer">
          <button class="button button-secondary" id="cancelButton">
            취소
          </button>
          <button class="button button-primary" id="submitButton">
            예약 등록
          </button>
        </div>
      </div>
    </div>

    <script src="/ERP 새 환자 등록/addPatient.js"></script>
  </body>
</html>
