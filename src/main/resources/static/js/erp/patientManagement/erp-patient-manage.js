function showPatientDetail(buttonElement) {

    console.log("--- 상세보기 버튼 클릭됨 (onclick) ---");

    // 'buttonElement'(this)를 jQuery 객체로 변환
    const $button = $(buttonElement);

    // 1. 버튼에서 환자 번호(memberNo) 및 '방문 통계' 데이터 가져오기
    const memberNo = $button.data("member-no");
    const visitCount = $button.data("visit-count");
    const lastVisit = $button.data("last-visit");

    console.log("선택된 환자 번호:", memberNo);

    // 2. 모달 "로딩 중..." 상태로 띄우기
    const $detailModal = $(".modal-patient-detail");
    $detailModal.addClass("active");

    // (모든 텍스트 필드를 '로딩중'으로 초기화)
    $detailModal.find(".modal-info-value").text("...");
    $detailModal.find(".modal-medical-value").text("...");
    $detailModal.find(".modal-stat-value").text("...");
    $detailModal.find("#modal-name").text("로딩 중...");
    $detailModal.find("#modal-record-list").html("");
    $detailModal.find("#modal-reservation-list").html("");

    // 3. AJAX ($.ajax) 호출
    $.ajax({
        type: "GET",
        url: globalContextPath + "/api/erp/patientDetail/" + memberNo,
        dataType: "json",

        // 4. 성공 시 (데이터 도착)
        success: function(response) {
            // response: { member: {...}, records: [...], reservations: [...] }
            const member = response.member;
            const records = response.records;
            const reservations = response.reservations;

            // (날짜 포맷팅을 위한 간단한 헬퍼 함수)
            const formatDate = (dateString) => {
                if (!dateString) return "N/A";

                return new Date(dateString).toLocaleDateString('sv-SE');
            };
            const formatDateTime = (dateString) => {
                if (!dateString) return "정보 없음";
                return new Date(dateString).toLocaleString('sv-SE'); // 'YYYY-MM-DD HH:MM'
            };

            // --- 5. 모달 전체 데이터 채우기 ---

            // A. 헤더 정보
            $detailModal.find(".modal-avatar").text(member.memberName.substring(0, 1));
            $detailModal.find(".modal-name").text(member.memberName);
            $detailModal.find(".modal-number").text("환자번호: " + member.memberNo);
            // (참고: 나이 계산 로직은 RRN을 기반으로 JS에서 추가 구현 필요)
            $detailModal.find(".modal-age").text(member.memberGender);

            // B. 기본 정보
            $detailModal.find("#modal-birthdate").text(member.memberRrn.substring(0, 6));
            $detailModal.find("#modal-bloodtype").text(member.memberBloodType || "정보 없음");
            $detailModal.find("#modal-joindate").text(formatDate(member.memberJoinDate));
            $detailModal.find("#modal-phone").text(member.memberPhone);
            $detailModal.find("#modal-address").text(member.memberAddress || "정보 없음");

            // C. 의료 정보
            $detailModal.find("#modal-chronic").text(member.memberChronicDisease || "정보 없음");
            $detailModal.find("#modal-allergy").text(member.memberAllergy || "정보 없음");

            // D. 방문 통계 (버튼에서 읽어온 값)
            $detailModal.find("#modal-visit-total").text(visitCount + "회");
            $detailModal.find("#modal-visit-month").text("N/A"); // (이 값은 현재 로직에 없음)
            $detailModal.find("#modal-visit-last").text(formatDate(lastVisit));

            // E. 진료 기록 (records)
            const $recordList = $detailModal.find("#modal-record-list");
            $recordList.empty();
            if (records && records.length > 0) {
                records.forEach(function(record) {
                    const recordHtml = `
                    <article class="modal-record-card">
                        <div class="modal-record-header">
                          <div class="modal-record-info">
                            <span class="modal-record-date">${formatDate(record.visitDate)}</span>
                            <span class="modal-record-dept">${record.departmentName || "진료과 없음"}</span>
                          </div>
                          <span class="modal-record-status">${record.status || "상태 없음"}</span>
                        </div>
                        <div class="modal-record-details">
                          <span class="modal-record-detail">담당의: ${record.doctorName || "정보 없음"}</span>
                          <span class="modal-record-separator">•</span>
                          <span class="modal-record-detail">진단: ${record.diagnosis || "없음"}</span>
                        </div>
                    </article>`;
                    $recordList.append(recordHtml);
                });
            } else {
                $recordList.append("<p style='padding:10px;'>과거 진료 기록이 없습니다.</p>");
            }

            // F. 예정된 예약 (reservations)
            const $reservationList = $detailModal.find("#modal-reservation-list");
            $reservationList.empty();
            if (reservations && reservations.length > 0) {
                reservations.forEach(function(rsv) {
                    const rsvHtml = `
                    <article class="modal-appointment-card">
                      <div class="modal-appointment-header">
                        <div class="modal-appointment-info">
                          <span class="modal-appointment-datetime">${formatDateTime(rsv.reservationDate)}</span>
                          <span class="modal-appointment-dept">${rsv.departmentName || "진료과 없음"}</span>
                        </div>
                        <span class="modal-appointment-type">${rsv.reservationType || "정보 없음"}</span>
                      </div>
                      <div class="modal-appointment-doctor">담당의: ${rsv.doctorName || "정보 없음"}</div>
                    </article>`;
                    $reservationList.append(rsvHtml);
                });
            } else {
                $reservationList.append("<p style='padding:10px;'>예정된 예약이 없습니다.</p>");
            }
        },
        // 7. 실패 시
        error: function(xhr, status, error) {
            console.error("AJAX Error:", status, error);
            console.error("Response Text:", xhr.responseText);
            alert("상세 정보를 불러오는데 실패했습니다. (서버 오류)");
            $detailModal.removeClass("active"); // 오류 시 모달 닫기
        }
    });
}


// --- 2. $(document).ready() ---
// 여기서는 '검색', '상세보기 닫기', '신규 등록' 관련 이벤트만 처리합니다.
$(document).ready(function() {

    console.log("--- patientManage.js 파일 로드 시작 ---");
    console.log("--- Document Ready! (jQuery 준비 완료) ---");

    // --- 1. 검색 로직 ---
    $("#searchBtn").on("click", function() {
        const keyword = $("#searchKeyword").val() || "";
        const grade = $("#searchGrade").val() || "";

        location.href = globalContextPath + "/api/erp/patientList"
            + "?cpage=1"
            + "&keyword=" + keyword
            + "&grade=" + grade;
    });

    // --- 2. 상세보기 모달 '닫기' ---
    // (JSP의 <button ... id="modal-btn-close">)
    $(document).on("click", "#modal-btn-close", function() {
        $(".modal-patient-detail").removeClass("active");
    });

    // (참고: 상세보기 모달 '배경' 닫기 로직은 아직 없습니다. 필요시 추가)
    $(document).on("click", ".modal-patient-detail", function(e) {
        // 클릭한 대상이 .modal-overlay(내용물)가 아닌 .modal-patient-detail(배경) 자신일 때
        if (e.target === this) {
            $(this).removeClass("active");
        }
    });


    // --- 3. 신규 등록 모달 '열기' ---
    $(document).on("click", "#openRegisterModalBtn", function() {
        $(".register-modal-overlay").addClass("active");
        $(".register-modal #patient-name").focus(); // 신규 모달의 이름 입력창
    });

    // --- 4. 신규 등록 모달 '닫기' (X 버튼) ---
    // (JSP의 <button ... id="closeRegisterModalBtn">)
    $(document).on("click", "#closeRegisterModalBtn", function() {
        $(".register-modal-overlay").removeClass("active");
    });

    // --- 5. 신규 등록 모달 '배경' 클릭 시 닫기 ---
    $(document).on("click", ".register-modal-overlay", function(e) {
        if (e.target === this) {
            $(this).removeClass("active");
        }
    });

    // --- 6. 신규 등록 '폼 제출' (AJAX) ---
    $(document).on("submit", ".register-modal .patient-form", function(e) {
        e.preventDefault();

        // (폼 데이터 가공)
        const name = $(".register-modal #patient-name").val();
        const birthDate = $(".register-modal #birth-date").val();
        const birthSuffix = $(".register-modal #birth-suffix").val();
        const phone = $(".register-modal #phone").val();
        const address = $(".register-modal #address").val();
        const email = $(".register-modal #email").val();
        const bloodType = $(".register-modal #blood-type").val();
        const allergy = $(".register-modal #allergy").val();
        const chronicDisease = $(".register-modal #chronicDisease").val();

        const memberRrn = birthDate + birthSuffix;
        let gender = "F";
        if (birthSuffix.startsWith('1') || birthSuffix.startsWith('3')) {
            gender = "M";
        }
        const memberId = phone;
        const memberPwd = birthDate;

        const data = {
            memberName: name,
            memberRrn: memberRrn,
            memberGender: gender,
            memberPhone: phone,
            memberAddress: address,
            memberEmail: email,
            memberBloodType: bloodType,
            memberChronicDisease: chronicDisease,
            memberAllergy: allergy,
            memberId: memberId,
            memberPwd: memberPwd
        };

        // (AJAX 전송)
        $.ajax({
            type: "POST",
            url: globalContextPath + "/api/erp/patient",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(data),
            success: function(response) {
                alert("✅ 환자가 성공적으로 등록되었습니다.");
                $(".register-modal-overlay").removeClass("active");
                location.reload();
            },
            error: function(xhr, status, error) {
                alert("❌ 등록에 실패했습니다. (오류: " + xhr.responseText + ")");
            }
        });
    }); // <-- 신규 등록 .on("submit") 끝

});