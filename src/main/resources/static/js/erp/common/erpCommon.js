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