
    // ========== 모달 제어 ==========

    // 모달 닫기
document.querySelectorAll(".employee-detail-close-btn, .modal-close").forEach((btn) => {
    btn.addEventListener("click", () => {
        document.getElementById("employeeModal").classList.remove("active");
    });
});

    // 모달 밖 클릭 시 닫기
document.getElementById("employeeModal").addEventListener("click", (e) => {
    if (e.target.classList.contains("modal-overlay")) {
    e.target.classList.remove("active");
}
});

    // ========== 직원 상세 조회 (AJAX) ==========

function detailEmployee(staffNo) {
    console.log("조회할 직원번호:", staffNo);

    $.ajax({
        url: "/api/employeeManagement/detailEmployee",
        type: "GET",
        data: { staffNo: staffNo },
        success: function(data) {
        console.log("조회된 직원 정보:", data);

        // 모달에 데이터 바인딩
        updateModal(data);

        // 모달 열기
        $("#employeeModal").addClass("active");
    },
        error: function(xhr, status, error) {
        console.error("직원 정보 조회 실패:", error);
        alert("직원 정보를 불러올 수 없습니다.");
    }
    });
}

// ========== 모달 데이터 업데이트 ==========

function updateModal(data) {
    // 1. 프로필 헤더
    $("#modal-avatar").text(data.staffName ? data.staffName.substring(0, 1) : "");
    $("#modal-name").text(data.staffName || "-");
    $("#modal-position-dept").text((data.position || "-") + " • " + (data.department || "-"));

    // 2. 상태 배지
    const statusBadge = $("#modal-status");
    if (data.working === 1) {
        statusBadge.text("ON")
            .removeClass("employee-detail-status-inactive")
            .addClass("employee-detail-status-active");
    } else {
        statusBadge.text("OFF")
            .removeClass("employee-detail-status-active")
            .addClass("employee-detail-status-inactive");
    }

    // 3. 기본 정보
    $("#modal-staff-no").text(data.staffNo || "-");
    $("#modal-email").text(data.staffEmail || "-");
    $("#modal-phone").text(data.staffPhone || "-");
    $("#modal-join-date").text(data.joinDate || "-");

    // ✅ 4. 근무 일정 파싱 (요일별로 분리)
    const scheduleHtml = parseSchedule(data.scheduleDetail);
    $("#modal-schedule").html(scheduleHtml);

    // 5. 근태 현황
    $("#modal-attendance-days").text((data.attendanceDayCount || 0) + "일");
    $("#modal-late-count").text((data.lateCount || 0) + "회");
    $("#modal-absent-count").text((data.absentCount || 0) + "일");
    $("#modal-vacation-days").text((data.vacationDayCount || 0) + "일");

    // ✅ 6. 자격증 및 면허 (쉼표로 구분)
    const licenseList = $("#modal-licenses");
    licenseList.empty();

    if (data.licenses) {
        const licenses = data.licenses.split('|');
        licenses.forEach(license => {
            const trimmedLicense = license.trim();
            if (trimmedLicense) {
                licenseList.append(`
                <li class="employee-detail-license-item">
                    <span class="employee-detail-license-dot"></span>
                    ${trimmedLicense}
                </li>
            `);
            }
        });
    } else {
        licenseList.append('<li class="employee-detail-license-item">등록된 자격증이 없습니다.</li>');
    }

    // ✅ 7. 전문 분야 (의사인 경우만)
    $(".employee-detail-section:contains('전문 분야')").remove();

    if (data.specialties) {
        const specialties = data.specialties.split('/');
        let specialtyHtml = `
        <section class="employee-detail-section">
            <h2 class="employee-detail-section-title">전문 분야</h2>
            <ul class="employee-detail-license-list">
    `;

        specialties.forEach(specialty => {
            const trimmedSpecialty = specialty.trim();
            if (trimmedSpecialty) {
                specialtyHtml += `
                <li class="employee-detail-license-item">
                    <span class="employee-detail-license-dot"></span>
                    ${trimmedSpecialty}
                </li>
            `;
            }
        });

        specialtyHtml += '</ul></section>';
        $(".employee-detail-section:contains('자격증 및 면허')").after(specialtyHtml);
    }

    // 8. 연차 정보
    const totalLeave = data.totalAnnualLeave || 0;
    const usedLeave = data.usedAnnualLeave || 0;
    const remainLeave = data.remainingAnnualLeave || 0;
    const usagePercent = totalLeave > 0 ? Math.round((usedLeave * 100 / totalLeave)) : 0;

    $("#modal-vacation-info").text(`총 ${totalLeave}일 중 ${usedLeave}일 사용`);
    $("#modal-vacation-remain").text(`잔여 ${remainLeave}일`);
    $("#modal-vacation-progress").css("width", usagePercent + "%");
}

// ✅ 근무 일정 파싱 함수
function parseSchedule(scheduleDetail) {
    if (!scheduleDetail) return '-';

    // 예시: "월 09:00-18:00, 화 09:00-18:00, 수 09:00-18:00, 목 09:00-18:00, 금 09:00-18:00"
    const schedules = scheduleDetail.split(',');

    let html = '<div class="schedule-list">';

    schedules.forEach(schedule => {
        const trimmed = schedule.trim();
        if (trimmed) {
            // "월 09:00-18:00" 형태를 "월" 과 "09:00-18:00"로 분리
            const parts = trimmed.split(' ');
            const day = parts[0];
            const time = parts.slice(1).join(' ');

            html += `
            <div class="schedule-item">
                <span class="schedule-day">${day}</span>
                <span class="schedule-time">${time}</span>
            </div>
        `;
        }
    });

    html += '</div>';
    return html;
}