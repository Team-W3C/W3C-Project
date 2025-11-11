// 공지사항 데이터
const noticeData = {
    1: {
        title: '10월 정기 시스템 점검 안내',
        author: '관리자',
        date: '2025-10-25',
        content: `
          <p class="notice-greeting">안녕하세요, 시설 예약팀입니다.</p>
          
          <p class="notice-text">
            병원 운영 병원 ERP 시스템(구. "시설 예약 MediFlow™") 연장작업 서비스 안정성 제고하고 시스템 성능을 최적화하기 위해 아래와 같이 정기 시스템 점검을 실시할 예정입니다.
          </p>

          <p class="notice-text">
            점검 시간 동안에는 시스템 이용이 일시적으로 중단되오니, 이용에 불편이 없으시도록 미리 양지하여 주시길 바랍니다.
          </p>

          <div class="notice-section">
            <h4 class="section-title">■ 점검 일시</h4>
            <ul class="section-list">
              <li>- 일시: 2025년 10월 30일 (수) 02:00 ~ 06:00 (총 4시간)</li>
              <li>- 대상: MedFlow™ ERP 전체 시스템</li>
            </ul>
          </div>

          <div class="notice-section">
            <h4 class="section-title">╲ 점검 내용</h4>
            <ul class="section-list">
              <li>- 데이터베이스 백업 및 최적화</li>
              <li>- 보안 패치 업데이트</li>
            </ul>
          </div>
        `
    },
    2: {
        title: '신규 MRI 장비 도입 안내',
        author: '시설관리팀',
        date: '2025-10-22',
        content: `
          <p class="notice-greeting">안녕하세요, 시설관리팀입니다.</p>
          
          <p class="notice-text">
            11월부터 최신 MRI 장비가 도입되어 더 나은 서비스를 제공합니다.
          </p>

          <div class="notice-section">
            <h4 class="section-title">■ 도입 장비</h4>
            <ul class="section-list">
              <li>- 장비명: 최신 3.0T MRI 시스템</li>
              <li>- 도입 시기: 2025년 11월 1일</li>
              <li>- 위치: 본관 2층 영상의학과</li>
            </ul>
          </div>

          <div class="notice-section">
            <h4 class="section-title">╲ 주요 특징</h4>
            <ul class="section-list">
              <li>- 고해상도 영상 제공</li>
              <li>- 검사 시간 단축 (기존 대비 30% 감소)</li>
              <li>- 환자 편의성 증대</li>
            </ul>
          </div>
        `
    },
    3: {
        title: '직원 시간 변경 안내 (2차수정내)',
        author: '인사총무팀',
        date: '2025-10-20',
        content: `
          <p class="notice-greeting">안녕하세요, 인사총무팀입니다.</p>
          
          <p class="notice-text">
            명절일의 이슈로 일시적 업무 시간이 변경됩니다. 모든 직원분들께서는 아래 변경된 일정을 확인해 주시기 바랍니다.
          </p>

          <div class="notice-section">
            <h4 class="section-title">■ 변경 내용</h4>
            <ul class="section-list">
              <li>- 기존: 09:00 ~ 18:00</li>
              <li>- 변경: 10:00 ~ 19:00</li>
              <li>- 적용 기간: 2025년 10월 25일 ~ 10월 27일 (3일간)</li>
            </ul>
          </div>

          <div class="notice-section">
            <h4 class="section-title">╲ 참고사항</h4>
            <ul class="section-list">
              <li>- 점심시간은 기존과 동일합니다 (12:00 ~ 13:00)</li>
              <li>- 외래 진료 시간도 동일하게 변경됩니다</li>
              <li>- 응급실은 24시간 정상 운영됩니다</li>
            </ul>
          </div>
        `
    }
};

// DOM 요소
const detailModal = document.getElementById('detailModal');
const createModal = document.getElementById('createModal');
const createNoticeBtn = document.getElementById('createNoticeBtn');
const closeDetailModalBtn = document.getElementById('closeDetailModal');
const closeCreateModalBtn = document.getElementById('closeCreateModal');
const confirmDetailModalBtn = document.getElementById('confirmDetailModal');
const noticeItems = document.querySelectorAll('.notice-item');
const noticeForm = document.getElementById('noticeForm');

// 모달 열기/닫기 함수
function openModal(modal) {
    modal.classList.add('active');
    document.body.style.overflow = 'hidden';
}

function closeModal(modal) {
    modal.classList.remove('active');
    document.body.style.overflow = '';
}

// 상세 모달 열기
function openDetailModal(noticeId) {
    const notice = noticeData[noticeId];

    if (!notice) return;

    document.getElementById('modalTitle').textContent = notice.title;
    document.getElementById('modalAuthor').textContent = notice.author;
    document.getElementById('modalDate').textContent = notice.date;
    document.getElementById('modalContent').innerHTML = notice.content;

    openModal(detailModal);
}

// 공지사항 아이템 클릭 이벤트
noticeItems.forEach(item => {
    item.addEventListener('click', function() {
        const noticeId = this.getAttribute('data-notice-id');
        openDetailModal(noticeId);
    });
});

// 공지사항 작성 버튼 클릭
createNoticeBtn.addEventListener('click', () => {
    openModal(createModal);
});

// 상세 모달 닫기 버튼
closeDetailModalBtn.addEventListener('click', () => {
    closeModal(detailModal);
});

// 상세 모달 확인 버튼
confirmDetailModalBtn.addEventListener('click', () => {
    closeModal(detailModal);
});

// 작성 모달 닫기 버튼
closeCreateModalBtn.addEventListener('click', () => {
    closeModal(createModal);
});

// 공지사항 작성 폼 제출
noticeForm.addEventListener('submit', (e) => {
    e.preventDefault();

    // 여기에 실제 제출 로직 추가
    alert('공지사항이 등록되었습니다.');

    // 폼 초기화 및 모달 닫기
    noticeForm.reset();
    closeModal(createModal);
});

// 오버레이 클릭 시 닫기
detailModal.addEventListener('click', (e) => {
    if (e.target === detailModal) {
        closeModal(detailModal);
    }
});

createModal.addEventListener('click', (e) => {
    if (e.target === createModal) {
        closeModal(createModal);
    }
});

// ESC 키로 닫기
document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
        if (detailModal.classList.contains('active')) {
            closeModal(detailModal);
        }
        if (createModal.classList.contains('active')) {
            closeModal(createModal);
        }
    }
});