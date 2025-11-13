document.addEventListener('DOMContentLoaded', function() {
    // JSP에서 정의된 contextPath 사용
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
        if (!modal) return;
        // JSP의 CSS가 .modal-overlay.active 일 때 표시되도록 구현되어 있다고 가정
        modal.classList.add('active');
        document.body.style.overflow = 'hidden';
    }

    function closeModal(modal) {
        if (!modal) return;
        modal.classList.remove('active');
        document.body.style.overflow = '';
    }

    // AJAX로 받아온 VO 데이터를 모달의 각 요소에 채워넣음
    function updateModalContent(inquiryData) {
        if (!inquiryData) return;

        // 1. 아바타 (patientName의 첫 글자 사용)
        const patientName = inquiryData.patientName || '';
        document.getElementById('modalUserAvatar').textContent = patientName ? patientName.charAt(0) : '?';

        // 2. 사용자 정보
        document.getElementById('modalUserName').textContent = patientName || '정보 없음';
        document.getElementById('modalUserDept').textContent = `환자번호: #${inquiryData.boardId || '정보 없음'}`;

        // 3. 상태 및 카테고리 배지
        const statusBadge = document.getElementById('modalStatusBadge');
        const categoryBadge = document.getElementById('modalCategoryBadge');
        if (statusBadge) {
            statusBadge.textContent = inquiryData.boardStatus || '대기중';
        }
        if (categoryBadge) {
            categoryBadge.textContent = inquiryData.boardTypeName || '일반';
        }

        // 4. 연락처 정보 (Board VO에 phone, email 필드가 없으므로 기본값 표시)
        document.getElementById('modalPhone').textContent = inquiryData.phone || '정보 없음';
        document.getElementById('modalEmail').textContent = inquiryData.email || '정보 없음';

        // 5. 문의 정보
        document.getElementById('modalDatetime').textContent = inquiryData.questionDate || inquiryData.createDate || '정보 없음';
        document.getElementById('modalSubject').textContent = inquiryData.boardTitle || '제목 없음';
        document.getElementById('modalCategoryText').textContent = inquiryData.boardTypeName || '일반';

        // 6. 문의 내용
        const contentElement = document.getElementById('modalContentText');
        if (inquiryData.questionContent) {
            contentElement.textContent = inquiryData.questionContent;
        } else if (inquiryData.boardContent) {
            contentElement.textContent = inquiryData.boardContent;
        } else {
            contentElement.textContent = '문의 내용이 없습니다.';
        }

        // 7. 답변 처리
        const hasReply = inquiryData.answerContent && inquiryData.answerContent.trim() !== '';
        const replySection = document.getElementById('inquiryReplySection');
        const replyFormSection = document.getElementById('inquiryReplyFormSection');
        const replyTextarea = document.getElementById('replyTextarea');

        if (hasReply) {
            // 답변이 있는 경우: 답변 섹션 표시, 작성 폼 숨김
            replySection.style.display = 'block';
            replyFormSection.style.display = 'none';

            // 답변 내용 채우기
            const staffName = inquiryData.staffName || '관리자';
            document.getElementById('replyAvatar').textContent = staffName.charAt(0);
            document.getElementById('replyUserName').textContent = staffName;
            document.getElementById('replyUserTitle').textContent = '(담당자)';
            document.getElementById('replyDepartment').textContent = inquiryData.departmentName || '-';
            document.getElementById('replyDate').textContent = inquiryData.answerDate || '-';
            document.getElementById('replyContent').textContent = inquiryData.answerContent;
        } else {
            // 답변이 없는 경우: 답변 섹션 숨김, 작성 폼 표시
            replySection.style.display = 'none';
            replyFormSection.style.display = 'block';
            if (replyTextarea) {
                replyTextarea.value = '';
            }
        }
    }

    // 현재 조회 중인 boardNo를 저장할 변수
    let currentBoardNo = null;

    // 문의사항 아이템 클릭 이벤트 AJAX
    inquiryItems.forEach(item => {
        const viewBtn = item.querySelector('.btn-view-inquiry');

        if(viewBtn) {
            viewBtn.addEventListener('click', function(e) {
                e.stopPropagation();

                const boardNo = viewBtn.getAttribute('data-board-no');

                if (!boardNo) {
                    console.error('버튼에 data-board-no 속성이 없습니다.');
                    return;
                }

                // 현재 boardNo 저장
                currentBoardNo = boardNo;

                fetch(`${contextPath}/api/erp/inquiry/${boardNo}`, {
                    method: 'GET',
                    headers: { 'Accept': 'application/json' }
                })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error(`HTTP error! status: ${response.status}`);
                        }
                        return response.json();
                    })
                    .then(data => {
                        if (data) {
                            updateModalContent(data);
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

    // --- 기타 이벤트 리스너 ---

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
            const replyTextarea = document.getElementById('replyTextarea');
            const replyText = replyTextarea ? replyTextarea.value.trim() : '';
            
            if (!replyText) {
                alert('답변 내용을 입력해주세요.');
                return;
            }

            if (!currentBoardNo) {
                alert('문의 번호를 찾을 수 없습니다.');
                return;
            }

            // TODO: 실제 서버에 답변 전송하는 API 호출
            alert('답변이 등록되었습니다.');
            if (replyTextarea) {
                replyTextarea.value = '';
            }
            closeModal(detailModal);
        });
    }

    // 오버레이 클릭 시 닫기
    if (detailModal) {
        detailModal.addEventListener('click', (e) => {
            if (e.target === detailModal) {
                closeModal(detailModal);
            }
        });
    }

    // ESC 키로 닫기
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && detailModal && detailModal.classList.contains('active')) {
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