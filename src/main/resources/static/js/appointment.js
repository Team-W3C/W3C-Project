document.addEventListener('DOMContentLoaded', function () {

    // --- [모달 1: 비회원 *예약*] ---
    const openGuestReservationModalBtn = document.getElementById('open-guest-modal');
    const guestReservationModal = document.querySelector('.guest-modal-overlay');

    if (openGuestReservationModalBtn && guestReservationModal) {
        // 모달 1 요소
        const backdrop1 = guestReservationModal.querySelector('.guest-modal-backdrop');
        const closeBtnHeader1 = guestReservationModal.querySelector('.btn-close-header');
        const patientForm1 = guestReservationModal.querySelector('.patient-form');

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
            if (patientForm1) {
                patientForm1.reset();
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
        if (patientForm1) {
            patientForm1.addEventListener('submit', function (e) {
                e.preventDefault();
                alert('비회원 예약이 요청되었습니다.');
                closeGuestReservationModal();
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