document.addEventListener('DOMContentLoaded', function() {
    // JSP <head> 태그에 <script> const contextPath = "${contextPath}"; </script>가 정의되어 있어야 합니다.
    const contextPath = window.contextPath || '';

    // --- DOM 요소
    const detailModal = document.getElementById('inquiryDetailModal');

    // JSP의 등록 버튼 클래스(.inquiry-create-btn)에 맞게 수정
    const createInquiryBtn = document.querySelector('.inquiry-create-btn');

    const closeDetailModalBtn = document.getElementById('closeDetailModal');
    const cancelDetailModalBtn = document.getElementById('cancelDetailModal');
    const answerInquiryBtn = document.getElementById('answerInquiry');

    // JSP의 각 <article class="inquiry-item">을 선택
    const inquiryItems = document.querySelectorAll('.inquiry-item');

    // --- 모달 열기/닫기 함수
    function openModal(modal) {
        // JSP의 CSS가 .modal-overlay.active 일 때 표시되도록 구현되어 있다고 가정
        modal.classList.add('active');
        document.body.style.overflow = 'hidden';
    }

    function closeModal(modal) {
        modal.classList.remove('active');
        document.body.style.overflow = '';
    }

    // --- [수정] 모달 내용 업데이트 함수 ---
    // AJAX로 받아온 VO 데이터를 모달의 각 요소에 채워넣습니다.
    function updateModalContent(inquiryData) {
        if (!inquiryData) return;

        // JSP 모달의 ID와 VO의 필드명을 매핑합니다.

        // 1. 아바타 (userName의 첫 글자 사용)
        document.getElementById('modalUserAvatar').textContent = inquiryData.userName ? inquiryData.userName.charAt(0) : '?';

        // 2. 사용자 정보
        document.getElementById('modalUserName').textContent = inquiryData.userName;
        document.getElementById('modalUserDept').textContent = inquiryData.userDept;

        // 3. 연락처 정보
        document.getElementById('modalPhone').textContent = inquiryData.phone;
        document.getElementById('modalEmail').textContent = inquiryData.email;

        // 4. 문의 정보
        document.getElementById('modalDatetime').textContent = inquiryData.createDate; // VO의 createDate 필드 사용
        document.getElementById('modalSubject').textContent = inquiryData.boardTitle; // VO의 boardTitle 필드 사용

        // 5. 문의 내용 (<pre> 태그에 삽입하여 줄바꿈 유지)
        // (JSP의 modalContentText 요소가 <pre> 태그라고 가정)
        document.getElementById('modalContentText').textContent = inquiryData.boardContent; // VO의 boardContent 필드 사용
    }

    // 문의사항 아이템 클릭 이벤트 AJAX
    inquiryItems.forEach(item => {
        const viewBtn = item.querySelector('.btn-view-inquiry');

        if(viewBtn) {
            viewBtn.addEventListener('click', function(e) {
                e.stopPropagation(); // 이벤트 버블링 방지

                // [중요] JSP의 버튼에 data-board-no 속성이 있어야 합니다.
                // 예: <button class="btn-view-inquiry" data-board-no="1">상세보기</button>
                const boardNo = viewBtn.getAttribute('data-board-no');

                if (!boardNo) {
                    console.error('버튼에 data-board-no 속성이 없습니다.');
                    return;
                }

                // --- [핵심] AJAX(fetch) 요청 (요청하신 URL 사용) ---
                fetch(`${contextPath}/api/erp/inquiry/${boardNo}`, {
                    method: 'GET',
                    headers: { 'Accept': 'application/json' }
                })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error(`HTTP error! status: ${response.status}`);
                        }
                        return response.json(); // Controller가 반환한 VO 객체를 JSON으로 파싱
                    })
                    .then(data => {
                        // AJAX 성공 시
                        if (data) {
                            // 1. 모달 내용 업데이트
                            updateModalContent(data);
                            // 2. 모달 열기
                            openModal(detailModal);
                        } else {
                            alert('문의 내역을 찾을 수 없습니다.');
                        }
                    })
                    .catch(error => {
                        console.error('AJAX 에러:', error);
                        alert('상세 정보를 불러오는 중 오류가 발생했습니다.');
                    });
            });
        }
    });

    // --- 기타 이벤트 리스너 (요청하신 구조) ---

    // 문의사항 등록 버튼
    if (createInquiryBtn) {
        createInquiryBtn.addEventListener('click', () => {
            alert('문의사항 등록 기능은 추후 구현 예정입니다.');
        });
    }

    // 상세 모달 닫기 버튼 (X)
    if (closeDetailModalBtn) {
        closeDetailModalBtn.addEventListener('click', () => {
            closeModal(detailModal);
        });
    }

    // 취소 버튼
    if (cancelDetailModalBtn) {
        cancelDetailModalBtn.addEventListener('click', () => {
            closeModal(detailModal);
        });
    }

    // 답변 등록 버튼
    if (answerInquiryBtn) {
        answerInquiryBtn.addEventListener('click', () => {
            alert('답변이 등록되었습니다.'); // (스텁)
            closeModal(detailModal);
        });
    }

    // 오버레이 클릭 시 닫기
    detailModal.addEventListener('click', (e) => {
        if (e.target === detailModal) {
            closeModal(detailModal);
        }
    });

    // ESC 키로 닫기
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && detailModal.classList.contains('active')) {
            closeModal(detailModal);
        }
    });

    // 필터 탭 기능
    const filterTabs = document.querySelectorAll('.filter-tab');
    filterTabs.forEach(tab => {
        tab.addEventListener('click', function() {
            filterTabs.forEach(t => t.classList.remove('filter-tab-active'));
            this.classList.add('filter-tab-active');

            const filterType = this.textContent;
            console.log('필터 적용:', filterType);
            // (필터링 로직 구현)
        });
    });


});