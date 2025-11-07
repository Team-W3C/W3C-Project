// src/main/resources/static/js/attendance/attendance.js

document.addEventListener("DOMContentLoaded", () => {

    // --- 모달 열기/닫기 제어 ---
    const modal = document.getElementById("application-modal");
    const openBtn = document.getElementById("open-application-modal-btn");
    const closeBtn = document.getElementById("close-application-modal-btn");

    if (modal && openBtn && closeBtn) {
        // "신청서 작성" 버튼 클릭 시
        openBtn.addEventListener("click", () => {
            modal.classList.add("is-open");
        });

        // "X" 닫기 버튼 클릭 시
        closeBtn.addEventListener("click", () => {
            modal.classList.remove("is-open");
        });

        // 모달 바깥쪽(오버레이) 클릭 시
        modal.addEventListener("click", (event) => {
            // event.target이 modal-overlay 자신일 때만 닫힘
            if (event.target === modal) {
                modal.classList.remove("is-open");
            }
        });
    }

    // --- 모달 내부 탭 제어 ---
    const tabs = document.querySelectorAll(".application-tabs a");
    const tabPanes = document.querySelectorAll(".tab-pane");

    tabs.forEach(tab => {
        tab.addEventListener("click", (e) => {
            e.preventDefault(); // a 태그 기본 동작(페이지 이동) 방지

            // 클릭한 탭의 data-tab 속성값 (예: "outing")
            const targetTab = e.target.getAttribute("data-tab");

            // 모든 탭에서 'is-active' 클래스 제거
            tabs.forEach(t => t.classList.remove("is-active"));
            // 클릭한 탭에 'is-active' 클래스 추가
            e.target.classList.add("is-active");

            // 모든 탭 콘텐츠 숨기기
            tabPanes.forEach(pane => {
                pane.classList.remove("is-active");
            });

            // 해당 탭 콘텐츠 보여주기 (예: #tab-content-outing)
            document.getElementById(`tab-content-${targetTab}`).classList.add("is-active");
        });
    });
});