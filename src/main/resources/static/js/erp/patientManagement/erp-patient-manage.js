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

// 1. '신규 환자 등록' 버튼 클릭 시
    $("#openRegisterModalBtn").on("click", function() {
        $("#registerModalOverlay").addClass("active");
        // (선택) 모달이 열릴 때 첫 번째 입력창에 포커스
        $("#patient-name").focus();
    });

    // 2. '닫기' 버튼 (X) 클릭 시
    $("#closeRegisterModalBtn").on("click", function() {
        $("#registerModalOverlay").removeClass("active");
    });

    // 3. 모달 '배경' 클릭 시 닫기
    $("#registerModalOverlay").on("click", function(e) {
        // 클릭한 대상(e.target)이 모달 배경 그 자체인지 확인
        // (모달 폼 내부를 클릭한 것은 무시)
        if (e.target === this) {
            $(this).removeClass("active");
        }
    });
});

//환자 등록 Ajax
$("#registerModalOverlay .patient-form").on("submit", function(e) {

    // 1. 폼의 기본 제출(새로고침) 동작을 막음
    e.preventDefault();

    // 2. 폼 데이터 읽어오기
    const name = $("#patient-name").val();
    const birthDate = $("#birth-date").val(); // "900101"
    const birthSuffix = $("#birth-suffix").val(); // "1234567"
    const phone = $("#phone").val();
    const address = $("#address").val();
    const email = $("#email").val();
    const notes = $("#notes").val(); // 특이사항

    // 3. [데이터 가공] Member VO에 맞게 데이터 조합

    // 3-1. RRN 조합
    const memberRrn = birthDate + birthSuffix;

    // 3-2. 성별 계산
    let gender = "여";
    if (birthSuffix.startsWith('1') || birthSuffix.startsWith('3')) {
        gender = "남";
    }

    // 3-3. (매우 중요!) ID/비밀번호 정책
    // !! 임시 정책: ID는 전화번호, PWD는 생년월일 6자리로 설정
    // !! 실제 운영 시에는 반드시 보안 정책에 맞게 수정해야 합니다.
    const memberId = phone;
    const memberPwd = birthDate;

    // 4. Controller로 전송할 JSON 데이터 (Member VO와 일치)
    const data = {
        memberName: name,
        memberRrn: memberRrn,
        memberGender: gender,
        memberPhone: phone,
        memberAddress: address,
        memberEmail: email,
        memberChronicDisease: notes, // "특이사항"을 만성질환 컬럼에 매핑

        memberId: memberId,     // 임시 ID
        memberPwd: memberPwd    // 임시 PWD
    };

    // 5. AJAX (POST) 요청
    $.ajax({
        type: "POST",
        url: globalContextPath + "/api/erp/patient", // Controller의 @PostMapping URL
        contentType: "application/json; charset=utf-8", // JSON으로 보냄
        data: JSON.stringify(data), // JSON 문자열로 변환

        success: function(response) {
            // 성공 (Controller에서 201 Created 반환 시)
            alert("✅ 환자가 성공적으로 등록되었습니다.");
            $("#registerModalOverlay").removeClass("active"); // 모달 닫기
            location.reload(); // 목록 새로고침
        },
        error: function(xhr, status, error) {
            // 실패 (Controller에서 500 Error 반환 시)
            alert("❌ 등록에 실패했습니다. (오류: " + xhr.responseText + ")");
        }
    });

});
