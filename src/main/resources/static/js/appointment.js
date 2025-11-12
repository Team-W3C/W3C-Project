document.addEventListener('DOMContentLoaded', function () {

    // --- [모달 1: 비회원 *예약*] ---
    const openGuestReservationModalBtn = document.getElementById('open-guest-modal');
    const guestReservationModal = document.querySelector('.guest-modal-overlay');
    const form = document.getElementById('guestReservationForm'); // 예약 폼

    if (openGuestReservationModalBtn && guestReservationModal) {
        // 모달 1 요소
        const backdrop1 = guestReservationModal.querySelector('.guest-modal-backdrop');
        const closeBtnHeader1 = guestReservationModal.querySelector('.btn-close-header');

        // 모달 1 열기
        function openGuestReservationModal(e) {
            e.preventDefault();
            guestReservationModal.classList.add('is-open');
            document.body.classList.add('modal-open');
        }

        // 모달 1 닫기
        function closeGuestReservationModal() {
            guestReservationModal.classList.remove('is-open');
            document.body.classList.remove('modal-open');
            if (form) {
                form.reset();
            }
        }

        // 모달 1 이벤트 리스너
        openGuestReservationModalBtn.addEventListener('click', openGuestReservationModal);

        if (closeBtnHeader1) {
            closeBtnHeader1.addEventListener('click', closeGuestReservationModal);
        }
        if (backdrop1) {
            backdrop1.addEventListener('click', closeGuestReservationModal);
        }

        // ----------------------------------------------------
        // ★★★ [핵심 수정]: AJAX 폼 제출 로직 ★★★
        // ----------------------------------------------------
        if (form) {
            // 중복된 form.addEventListener('submit') 로직 제거 및 통합
            form.addEventListener('submit', async function (e) {
                e.preventDefault();

                const formData = new FormData(form);
                const payload = {};

                // DTO의 필드명과 일치하도록 데이터 수집 및 조합
                formData.forEach((value, key) => {
                    // JSP 폼에서 name 속성을 birthDate, birthSuffix 등으로 변경했으므로,
                    // Controller가 요구하는 필드명과 일치하게 데이터를 수집합니다.
                    payload[key] = value;
                });

                // JSP에서 분리된 날짜(treatmentDate)와 시간(treatmentTime)을 합쳐서
                // Controller의 VO 필드(treatmentDateString)로 전달할 필요 없이,
                // DTO 필드명에 맞춰서 전송합니다. (Controller에서 조합함)

                // 폼 요소에서 departmentNo가 아닌 departmentName과 treatmentTime이 전달됨을 확인

                // 3. 서버로 데이터 전송 (Fetch API 사용)
                try {
                    const response = await fetch(form.action, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify(payload), // JSON 문자열로 변환하여 전송
                    });

                    // 4. 서버 응답 처리
                    if (response.ok) {
                        const result = await response.json();
                        alert('비회원 예약이 완료되었습니다. 예약 번호: ' + result.reservationNo); // reservationId -> reservationNo로 수정
                        closeGuestReservationModal(); // 성공 시 모달 닫기

                    } else {
                        // 서버 오류 응답 처리 (Controller에서 body에 상세 메시지 포함)
                        const errorText = await response.text();
                        console.error('서버 응답 오류:', errorText);
                        alert('예약 중 오류가 발생했습니다. 상세: ' + errorText);
                    }
                } catch (error) {
                    // 네트워크 오류 또는 기타 예외
                    console.error('예약 제출 오류:', error);
                    alert('네트워크 연결에 문제가 발생했습니다. 다시 시도해 주세요.');
                }
            });
        }
    }

    // --- [모달 2: 비회원 *조회*] ---
    const openGuestCheckModalBtn = document.getElementById('open-guest-check-modal');
    const guestCheckModal = document.querySelector('.guest-check-modal-overlay');

    if (openGuestCheckModalBtn && guestCheckModal) {
        // 모달 2 요소
        const backdrop2 = guestCheckModal.querySelector('.guest-modal-backdrop');
        const closeBtnHeader2 = guestCheckModal.querySelector('.modal-close');
        const cancelBtn2 = guestCheckModal.querySelector('.btn-cancel');
        const patientForm2 = guestCheckModal.querySelector('.reservation-form');

        // 모달 2 열기
        function openGuestCheckModal(e) {
            e.preventDefault();
            guestCheckModal.classList.add('is-open');
            document.body.classList.add('modal-open');
        }

        // 모달 2 닫기
        function closeGuestCheckModal() {
            guestCheckModal.classList.remove('is-open');
            document.body.classList.remove('modal-open');
            if (patientForm2) {
                patientForm2.reset();
            }
        }

        // 모달 2 이벤트 리스너
        openGuestCheckModalBtn.addEventListener('click', openGuestCheckModal);

        if (closeBtnHeader2) {
            closeBtnHeader2.addEventListener('click', closeGuestCheckModal);
        }
        if (backdrop2) {
            backdrop2.addEventListener('click', closeGuestCheckModal);
        }
        if (cancelBtn2) {
            cancelBtn2.addEventListener('click', closeGuestCheckModal);
        }
        if (patientForm2) {
            patientForm2.addEventListener('submit', function (e) {
                e.preventDefault();
                alert('비회원 예약 조회를 요청합니다.');
                // (임시) 조회 로직 수행...
                closeGuestCheckModal();
            });
        }
    }
});