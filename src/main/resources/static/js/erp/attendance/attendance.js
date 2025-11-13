// src/main/resources/static/js/attendance/attendance.js

document.addEventListener("DOMContentLoaded", () => {
    function updateCurrentTime() {
        const now = new Date();
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        document.getElementById('current-time').textContent = `${hours}:${minutes}`;
    }

    updateCurrentTime();
    setInterval(updateCurrentTime, 1000 * 1); // 1초마다 갱신

// --- 모달 열기/닫기 제어 ---
    const openModalBtn = document.getElementById("open-application-modal-btn");
    const closeModalBtn = document.getElementById("close-application-modal-btn");
    const modal = document.getElementById("application-modal");

    if (openModalBtn && modal) {
        // "신청서 작성" 버튼 클릭 시 모달 열기
        openModalBtn.addEventListener("click", () => {
            modal.classList.add("is-open"); // .is-open 클래스 추가
        });
    }

    if (closeModalBtn && modal) {
        // "X" 버튼 클릭 시 모달 닫기
        closeModalBtn.addEventListener("click", () => {
            modal.classList.remove("is-open"); // .is-open 클래스 제거
        });
    }

    // 모달 바깥 영역 클릭 시 닫기
    if (modal) {
        modal.addEventListener("click", (e) => {
            // modal-content가 아닌 modal-overlay(바깥쪽)를 클릭했는지 확인
            if (e.target === modal) {
                modal.classList.remove("is-open");
            }
        });
    }
    // --- 모달 내부 탭 제어 ---
    const tabs = document.querySelectorAll(".application-tabs a");
    const tabPanes = document.querySelectorAll(".tab-pane");

    // (추가) applicationType을 담을 hidden input
    const applicationTypeInput = document.getElementById("application-type");

    tabs.forEach(tab => {
        tab.addEventListener("click", (e) => {
            e.preventDefault();

            // 클릭한 탭의 data-tab 속성값 (예: "outing")
            const targetTab = e.target.getAttribute("data-tab");

            // (추가) hidden input의 값을 현재 탭으로 변경
            if (applicationTypeInput) {
                applicationTypeInput.value = targetTab;
            }

            // 모든 탭에서 'is-active' 클래스 제거
            tabs.forEach(t => t.classList.remove("is-active"));
            // 클릭한 탭에 'is-active' 클래스 추가
            e.target.classList.add("is-active");

            // 모든 탭 콘텐츠 숨기기
            tabPanes.forEach(pane => {
                pane.classList.remove("is-active");
            });

            // 해당 탭 콘텐츠 보여주기
            document.getElementById(`tab-content-${targetTab}`).classList.add("is-active");
        });
    });
});