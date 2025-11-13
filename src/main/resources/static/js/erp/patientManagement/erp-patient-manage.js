$(document).ready(function() {
//검색 필터에 따른 검색
$("#searchBtn").on("click", function() {
    // 1. 검색어와 등급 값을 가져옴
    const keyword = $("#searchKeyword").val();
    const grade = $("#searchGrade").val();

    // 2. 검색 파라미터를 포함하여 1페이지로 이동
    // cpage=1 : 검색 시 무조건 1페이지부터 조회
    location.href = globalContextPath + "/api/erp/patientList"
        + "?cpage=1"
        + "&keyword=" + keyword
        + "&grade=" + grade;
});

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
});