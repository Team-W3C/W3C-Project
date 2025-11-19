/**
 * erpCommon.js
 * (모든 페이지에 공통으로 로드됨)
 */

$(document).ready(function() {

    const isErpPage = window.location.pathname.includes('/erp/');

    if (isErpPage) {
        // ERP 페이지에 있을 때의 로직
        const currentPath = window.location.pathname;
        let activeMenuHref = null;

        // 1. 현재 URL과 일치하는 사이드바 링크를 찾습니다.
        const $exactMatchLink = $(`.sidebar__link[href="${currentPath}"]`);

        if ($exactMatchLink.length > 0) {
            // 현재 URL과 정확히 일치하는 링크가 있으면 해당 링크를 활성화 대상으로 설정합니다.
            activeMenuHref = currentPath;
        } else {
            // 정확히 일치하는 링크가 없을 경우(예: 상세 페이지), 세션에 저장된 값을 사용합니다.
            // 세션에도 값이 없으면 대시보드를 기본값으로 사용합니다.
            activeMenuHref = sessionStorage.getItem('activeMenu') || '/erp/dashboard';
        }
        
        // 2. 모든 사이드바 링크의 활성 상태를 초기화합니다.
        $('.sidebar__link').removeClass('sidebar__link--active');

        // 3. 결정된 링크를 활성화하고 세션에 저장합니다.
        $(`.sidebar__link[href="${activeMenuHref}"]`).addClass('sidebar__link--active');
        sessionStorage.setItem('activeMenu', activeMenuHref);


        // 4. 사이드바 링크 클릭 이벤트 핸들러
        $('.sidebar__link').on('click', function(event) {
            const href = $(this).attr('href');
            
            $('.sidebar__link').removeClass('sidebar__link--active');
            $(this).addClass('sidebar__link--active');

            sessionStorage.setItem('activeMenu', href);
            
            //롱폴링 중지 함수
            if (!$(this).is('#employee-manage-polling')) {
                if (typeof window.employeeStopLongPolling === 'function') {
                    window.employeeStopLongPolling();
                }
            }
        });

    } else {
        // ERP 페이지가 아닐 경우, 저장된 메뉴 상태를 제거합니다.
        sessionStorage.removeItem('activeMenu');
    }
});
