/**
 * erpCommon.js
 * (모든 페이지에 공통으로 로드됨)
 */

$(document).ready(function() {

    // 사이드바 링크 클릭 시 active 상태 전환
    $('.sidebar__link').on('click', function(event) {
        // 모든 링크에서 active 클래스 제거
        $('.sidebar__link').removeClass('sidebar__link--active');

        // 클릭된 링크에 active 클래스 추가
        $(this).addClass('sidebar__link--active');

        // localStorage에 현재 active 링크 저장 (페이지 새로고침 대응)
        const href = $(this).attr('href');
        localStorage.setItem('activeMenu', href);

        // employeePolling.js 관련 처리
        if (!$(this).is('#employee-manage-polling')) {
            if (typeof window.employeeStopLongPolling === 'function') {
                window.employeeStopLongPolling();
            }
        }
    });

    // 페이지 로드 시 저장된 active 메뉴 복원
    const savedMenu = localStorage.getItem('activeMenu');
    if (savedMenu) {
        $('.sidebar__link').removeClass('sidebar__link--active');
        $(`.sidebar__link[href="${savedMenu}"]`).addClass('sidebar__link--active');
    }
});

//헤더 알림창 js
document.addEventListener("DOMContentLoaded", function() {
    const notificationBtn = document.getElementById('notificationBtn');
    const notificationDropdown = document.getElementById('notificationDropdown');

    // 1. 알림 버튼 클릭 시 토글
    notificationBtn.addEventListener('click', function(e) {
        e.stopPropagation(); // 이벤트 버블링 방지
        notificationDropdown.classList.toggle('active');
    });

    // 2. 화면의 다른 곳을 클릭하면 알림창 닫기
    document.addEventListener('click', function(e) {
        if (!notificationDropdown.contains(e.target) && !notificationBtn.contains(e.target)) {
            notificationDropdown.classList.remove('active');
        }
    });
});

//회원 클릭 시 뜨는 모달
document.addEventListener("DOMContentLoaded", function() {
    const userBtn = document.getElementById('userProfileBtn');
    const userDropdown = document.getElementById('userDropdown');

    // 1. 사용자 프로필 클릭 시 토글
    userBtn.addEventListener('click', function(e) {
        e.stopPropagation(); // 이벤트 전파 방지
        userDropdown.classList.toggle('active');

        // 알림 모달이 열려있다면 닫기 (선택 사항)
        const notiDropdown = document.getElementById('notificationDropdown');
        if (notiDropdown && notiDropdown.classList.contains('active')) {
            notiDropdown.classList.remove('active');
        }
    });

    // 2. 외부 클릭 시 닫기
    document.addEventListener('click', function(e) {
        if (!userDropdown.contains(e.target) && !userBtn.contains(e.target)) {
            userDropdown.classList.remove('active');
        }
    });
});