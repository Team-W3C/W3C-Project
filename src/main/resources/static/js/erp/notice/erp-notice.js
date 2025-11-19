document.addEventListener("DOMContentLoaded", () => {
    const contextPath = window.contextPath || '';

    // DOM 요소
    const detailModal = document.getElementById('detailModal');
    const createModal = document.getElementById('createModal');
    const createNoticeBtn = document.getElementById('createNoticeBtn');
    const closeDetailModalBtn = document.getElementById('closeDetailModal');
    const closeCreateModalBtn = document.getElementById('closeCreateModal');
    const confirmDetailModalBtn = document.getElementById('confirmDetailModal');
    const noticeItems = document.querySelectorAll('.notice-item');
    const noticeForm = document.getElementById('noticeForm');
    const departmentSelect = document.getElementById('departmentNo');
    const noticeSearchInput = document.getElementById('noticeSearchInput');
    const noticeSearchBtn = document.getElementById('noticeSearchBtn');

    // 검색 기능
    function performSearch() {
        const keyword = noticeSearchInput ? noticeSearchInput.value.trim() : '';
        const url = `${contextPath}/erp/erpNotice/notice?cpage=1&keyword=${encodeURIComponent(keyword)}`;
        location.href = url;
    }

    if (noticeSearchBtn) {
        noticeSearchBtn.addEventListener('click', performSearch);
    }

    if (noticeSearchInput) {
        noticeSearchInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                performSearch();
            }
        });
    }

    // 부서 목록 로드
    async function loadDepartments() {
        if (!departmentSelect) return;
        
        try {
            const response = await fetch(`${contextPath}/member/reservation/departments`);
            if (!response.ok) throw new Error('부서 목록 로드 실패');
            
            const departments = await response.json();
            departmentSelect.innerHTML = '<option value="">부서를 선택하세요</option>';
            
            departments.forEach(dept => {
                const option = document.createElement('option');
                option.value = dept.departmentNo;
                option.textContent = dept.departmentName;
                departmentSelect.appendChild(option);
            });
        } catch (error) {
            console.error('부서 목록 로드 오류:', error);
            departmentSelect.innerHTML = '<option value="">부서 목록을 불러올 수 없습니다</option>';
        }
    }

    // 모달 열기/닫기 함수
    function openModal(modal) {
        if (!modal) return;
        modal.classList.add('active');
        document.body.style.overflow = 'hidden';
    }

    function closeModal(modal) {
        if (!modal) return;
        modal.classList.remove('active');
        document.body.style.overflow = '';
    }

    // 모달 내용 업데이트 함수
    function updateModalContent(notificationData) {
        if (!notificationData) return;

        document.getElementById('modalTitle').textContent = notificationData.notificationTitle || '제목 없음';
        document.getElementById('modalAuthor').textContent = notificationData.departmentName || '정보 없음';
        document.getElementById('modalDate').textContent = notificationData.notificationDate || '정보 없음';

        const contentElement = document.getElementById('modalContent');
        if (notificationData.notificationContent) {
            contentElement.innerHTML = notificationData.notificationContent.replace(/\n/g, '<br>');
        } else {
            contentElement.textContent = '내용이 없습니다.';
        }

        const badgeContainer = document.getElementById('modalBadges');
        badgeContainer.innerHTML = '';

        const notifiedBadge = document.createElement('span');
        if (notificationData.notifiedTypeName === '직원 공지') {
            notifiedBadge.className = 'notice-badge notice-badge-urgent';
            notifiedBadge.textContent = '직원';
        } else {
            notifiedBadge.className = 'notice-badge notice-badge-general';
            notifiedBadge.textContent = '환자';
        }

        const typeBadge = document.createElement('span');
        switch (notificationData.notificationTypeName) {
            case '시스템':
                typeBadge.className = 'notice-badge notice-badge-system';
                break;
            case '운영':
                typeBadge.className = 'notice-badge notice-badge-event';
                break;
            case '진료':
                typeBadge.className = 'notice-badge notice-badge-check';
                break;
            default:
                typeBadge.className = 'notice-badge';
        }
        typeBadge.textContent = notificationData.notificationTypeName || '공지';

        badgeContainer.appendChild(notifiedBadge);
        badgeContainer.appendChild(document.createTextNode(' '));
        badgeContainer.appendChild(typeBadge);
    }

    // 공지사항 아이템 클릭 이벤트
    noticeItems.forEach(item => {
        item.addEventListener('click', function() {
            const noticeNo = this.getAttribute('data-notice-id');

            if (!noticeNo) {
                console.error('data-notice-id 속성이 없습니다.');
                return;
            }

            fetch(`${contextPath}/api/erp/notice/detail/${noticeNo}`, {
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
                        alert('공지사항을 찾을 수 없습니다.');
                    }
                })
                .catch(error => {
                    console.error('AJAX 에러:', error);
                    alert('상세 정보를 불러오는 중 오류가 발생했습니다.');
                });
        });
    });

    // 공지사항 작성 버튼 클릭
    if (createNoticeBtn) {
        createNoticeBtn.addEventListener('click', () => {
            loadDepartments();
            openModal(createModal);
        });
    }

    // 상세 모달 닫기 버튼
    if (closeDetailModalBtn) {
        closeDetailModalBtn.addEventListener('click', () => {
            closeModal(detailModal);
        });
    }

    // 상세 모달 확인 버튼
    if (confirmDetailModalBtn) {
        confirmDetailModalBtn.addEventListener('click', () => {
            closeModal(detailModal);
        });
    }

    // 작성 모달 닫기 버튼
    if (closeCreateModalBtn) {
        closeCreateModalBtn.addEventListener('click', () => {
            closeModal(createModal);
            if (noticeForm) noticeForm.reset();
        });
    }

    // 공지사항 작성 폼 제출
    if (noticeForm) {
        noticeForm.addEventListener('submit', (e) => {
            e.preventDefault();

            const formData = {
                notificationTitle: document.getElementById('notificationTitle').value,
                notificationContent: document.getElementById('notificationContent').value,
                departmentNo: parseInt(document.getElementById('departmentNo').value),
                notifiedType: document.getElementById('notifiedType').value,
                notificationType: document.getElementById('notificationType').value
            };

            if (!formData.departmentNo) {
                alert('부서를 선택하세요.');
                return;
            }

            fetch(`${contextPath}/api/erp/notice/create`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData)
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert(data.message);
                        noticeForm.reset();
                        closeModal(createModal);
                        location.reload();
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('공지사항 등록 오류:', error);
                    alert('공지사항 등록 중 오류가 발생했습니다.');
                });
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

    if (createModal) {
        createModal.addEventListener('click', (e) => {
            if (e.target === createModal) {
                closeModal(createModal);
                if (noticeForm) noticeForm.reset();
            }
        });
    }

    // ESC 키로 닫기
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
            if (detailModal && detailModal.classList.contains('active')) {
                closeModal(detailModal);
            }
            if (createModal && createModal.classList.contains('active')) {
                closeModal(createModal);
                if (noticeForm) noticeForm.reset();
            }
        }
    });
});