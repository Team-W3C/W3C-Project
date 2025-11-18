let modalCalendar = null;
let selectedTimes = new Set();

function openAddModal() {
    const addModal = document.getElementById("modalBackdrop");
    if (addModal) {
        addModal.style.display = "flex";

        if (!modalCalendar) {
            initModalCalendar();
        }

        resetForm();
    }
}

function closeAddModal() {
    const addModal = document.getElementById("modalBackdrop");
    if (addModal) {
        addModal.style.display = "none";
    }
}

function resetForm() {
    const searchInput = document.querySelector('.search-input');
    const symptomInput = document.querySelector('.text-input');
    const departmentSelect = document.getElementById('departmentSelect');
    const doctorSelect = document.getElementById('doctorSelect');
    const facilitySelect = document.getElementById('facilitySelect');
    const memoTextarea = document.querySelector('.textarea-input');

    if (searchInput) searchInput.value = '';
    if (symptomInput) symptomInput.value = '';
    if (departmentSelect) departmentSelect.value = '';
    if (doctorSelect) {
        doctorSelect.value = '';
        doctorSelect.disabled = true;
        doctorSelect.classList.add('disabled');
        doctorSelect.innerHTML = '<option value="">담당의 선택</option>';
    }
    if (facilitySelect) facilitySelect.value = '';
    if (memoTextarea) memoTextarea.value = '';

    if (modalCalendar) {
        const modalCalendarEl = document.getElementById("modalCalendar");
        if (modalCalendarEl) {
            delete modalCalendarEl.dataset.selectedDate;
        }
        document.querySelectorAll("#modalCalendar .fc-daygrid-day.selected").forEach(day => {
            day.classList.remove("selected");
        });
    }

    if (window.timeSelectionManager) {
        window.timeSelectionManager.clearSelections();
    }
}

function initModalCalendar() {
    const modalCalendarEl = document.getElementById("modalCalendar");

    if (!modalCalendarEl || typeof FullCalendar === "undefined") {
        console.error("모달 캘린더 초기화 실패: 요소 또는 라이브러리를 찾을 수 없습니다.");
        return;
    }

    modalCalendar = new FullCalendar.Calendar(modalCalendarEl, {
        initialView: "dayGridMonth",
        headerToolbar: {
            left: "prev",
            center: "title",
            right: "next",
        },
        height: "auto",
        dateClick: function (info) {
            document.querySelectorAll("#modalCalendar .fc-daygrid-day.selected").forEach(day => {
                day.classList.remove("selected");
            });

            info.dayEl.classList.add("selected");

            modalCalendarEl.dataset.selectedDate = info.dateStr;
        },
    });

    modalCalendar.render();
}


function initTimeSlotHandler() {
    const timeSlotsContainer = document.getElementById('timeSlots');
    const selectedBadgesContainer = document.getElementById('selectedBadges');
    const selectedCountSpan = document.getElementById('selectedCount');

    if (!timeSlotsContainer || !selectedBadgesContainer || !selectedCountSpan) {
        console.error("시간 선택 요소를 찾을 수 없습니다.");
        return null;
    }

    let selectedTime = null;

    selectedCountSpan.textContent = "";

    timeSlotsContainer.addEventListener('click', function(e) {
        const timeSlot = e.target.closest('.time-slot');
        if (timeSlot) {
            e.preventDefault();
            const time = timeSlot.dataset.time;

            if (selectedTime === time) {
                clearSelection();
                return;
            }

            selectTime(time, timeSlot);
        }
    });

    function selectTime(time, slotElement) {
        clearSelection();

        selectedTime = time;

        if (slotElement) {
            slotElement.classList.add('selected');
        }

        selectedBadgesContainer.innerHTML = `
            <div class="time-badge" data-time="${time}">
                ${time}
                <button class="remove-time" type="button">
                    <svg width="12" height="12" viewBox="0 0 7 7" fill="none">
                        <path d="M6.5 0.5L0.5 6.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M0.5 0.5L6.5 6.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </button>
            </div>
        `;

        selectedBadgesContainer.querySelector('.remove-time').addEventListener('click', function(e){
            e.preventDefault();
            clearSelection();
        });
    }

    function clearSelection() {
        selectedTime = null;

        timeSlotsContainer.querySelectorAll('.time-slot.selected').forEach(el => {
            el.classList.remove('selected');
        });

        selectedBadgesContainer.innerHTML = '';
    }

    return {
        getSelectedTimes: () => selectedTime ? [selectedTime] : [],
        clearSelections: () => clearSelection()
    };
}


function initDepartmentSelectHandler() {
    const departmentSelect = document.getElementById('departmentSelect');

    if (!departmentSelect) {
        console.error("진료과 선택 요소를 찾을 수 없습니다.");
        return;
    }

    departmentSelect.addEventListener('change', function(){
        const departmentName = this.value;

        if(!departmentName){
            updateDoctorList([]);
            return;
        }

        const contextPath = "/erp/erpReservation";

        $.ajax({
            url : contextPath + "/doctors",
            method : 'GET',
            data : {
                departmentName : departmentName
            },
            dataType : "json",
            beforeSend: function() {
                const doctorSelect = document.getElementById('doctorSelect');
                doctorSelect.innerHTML = '<option value="">담당의 정보를 불러오는 중...</option>';
                doctorSelect.disabled = true;
                doctorSelect.classList.add('disabled');
            },
            success: function(data) {
                updateDoctorList(data);
            },
            error: function(xhr, status, error) {
                console.error("의사 목록 조회 실패:", error);
                alert("담당의 정보를 불러오는데 실패했습니다.");
                updateDoctorList([]);
            }
        });
    });
}

function updateDoctorList(doctors) {
    console.log("배열 데이터:", doctors);
    const doctorSelect = document.getElementById('doctorSelect');

    if (!doctorSelect) {
        console.error("담당의 선택 요소를 찾을 수 없습니다.");
        return;
    }

    doctorSelect.innerHTML = '';

    const defaultOption = document.createElement('option');
    defaultOption.value = "";
    defaultOption.textContent = "담당의 선택";
    doctorSelect.appendChild(defaultOption);

    if (!Array.isArray(doctors)) {
        doctors = [];
    }

    doctors.forEach(doctor => {
        const option = document.createElement('option');
        option.value = doctor.doctorName;
        option.textContent = doctor.doctorName;
        doctorSelect.appendChild(option);
        console.log('객체 데이터:',doctor);
    });

    if (doctors.length > 0) {
        doctorSelect.disabled = false;
        doctorSelect.classList.remove('disabled');
    } else {
        doctorSelect.disabled = true;
        doctorSelect.classList.add('disabled');
    }
}

function validateReservationForm() {
    const patientName = document.querySelector('.search-input')?.value.trim();
    const symptom = document.querySelector('.text-input')?.value.trim();
    const department = document.getElementById('departmentSelect')?.value;
    const doctor = document.getElementById('doctorSelect')?.value;
    const modalCalendarEl = document.getElementById('modalCalendar');
    const reservationDate = modalCalendarEl?.dataset.selectedDate;
    const timeSelection = window.timeSelectionManager?.getSelectedTimes() || [];

    const errors = [];

    if (!patientName) {
        errors.push("환자 선택은 필수입니다.");
    }

    if (!symptom) {
        errors.push("증상은 필수입니다.");
    }

    if (!department) {
        errors.push("진료과 선택은 필수입니다.");
    }

    if (!doctor) {
        errors.push("담당의 선택은 필수입니다.");
    }

    if (!reservationDate) {
        errors.push("예약 날짜 선택은 필수입니다.");
    }

    if (timeSelection.length === 0) {
        errors.push("예약 시간을 최소 1개 이상 선택해주세요.");
    }

    return {
        isValid: errors.length === 0,
        errors: errors
    };
}

function submitReservation() {
    const validation = validateReservationForm();

    if (!validation.isValid) {
        alert("입력 정보를 확인해주세요:\n\n" + validation.errors.join("\n"));
        return;
    }

    const patientName = document.querySelector('.search-input').value.trim();
    const symptom = document.querySelector('.text-input').value.trim();
    const department = document.getElementById('departmentSelect').value;
    const doctor = document.getElementById('doctorSelect').value;
    const modalCalendarEl = document.getElementById('modalCalendar');
    const reservationDate = modalCalendarEl.dataset.selectedDate;
    const selectedTime = window.timeSelectionManager.getSelectedTimes()[0];

    const reservationData = {
        patientName: patientName,
        symptom: symptom,
        department: department,
        doctor: doctor,
        date: reservationDate,
        time: selectedTime
    };

    console.log("예약 데이터:", reservationData);

    const contextPath = "/erp/erpReservation";

    $.ajax({
        url: contextPath + "/add",
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(reservationData),
        dataType: 'json',
        beforeSend: function() {
            const submitButton = document.getElementById('submitButton');
            if (submitButton) {
                submitButton.disabled = true;
                submitButton.textContent = '등록 중...';
            }
        },
        success: function(response) {
            console.log("예약 등록 성공:", response);
            alert("예약이 성공적으로 등록되었습니다.");
            closeAddModal();

            if (typeof window.mainCalendar !== 'undefined' && window.mainCalendar) {
                window.mainCalendar.refetchEvents();
            }

            const selectedDateElem = document.querySelector('.calendar-day.selected');
            const selectedDate = selectedDateElem
                ? selectedDateElem.dataset.date
                : new Date().toISOString().split('T')[0];

            if (typeof fetchReservationByDate === 'function') {
                fetchReservationByDate(selectedDate);
            }
        },
        error: function(xhr, status, error) {
            console.error("예약 등록 실패:", error);
        },
        complete: function() {
            const submitButton = document.getElementById('submitButton');
            if (submitButton) {
                submitButton.disabled = false;
                submitButton.textContent = '예약 등록';
            }
        }
    });
}

document.addEventListener("DOMContentLoaded", function () {
    const addModal = document.getElementById("modalBackdrop");

    if (addModal) {
        addModal.style.display = "none";

        const closeButtons = addModal.querySelectorAll(".close-button, #cancelButton");
        closeButtons.forEach((btn) => {
            btn.addEventListener("click", function(e) {
                e.preventDefault();
                closeAddModal();
            });
        });

        addModal.addEventListener("click", function (e) {
            if (e.target === addModal) {
                closeAddModal();
            }
        });
    }

    const addButton = document.querySelector(".btn-primary-add");
    if (addButton) {
        addButton.addEventListener("click", function (e) {
            e.preventDefault();
            openAddModal();
        });
    }

    const submitButton = document.getElementById('submitButton');
    if (submitButton) {
        submitButton.addEventListener("click", function(e) {
            e.preventDefault();
            submitReservation();
        });
    }

    window.timeSelectionManager = initTimeSlotHandler();
    initDepartmentSelectHandler();
});