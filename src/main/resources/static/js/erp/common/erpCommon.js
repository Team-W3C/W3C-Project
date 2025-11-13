/**
 * erpCommon.js
 * (모든 페이지에 공통으로 로드됨)
 */

$(document).ready(function() {

    // 사이드바(#sidebar-nav)에서 '직원 관리' 링크(#employee-manage-link)를 "제외한"
    // 모든 <a> 태그에 클릭 이벤트를 연결합니다.
    $('#sidebar-nav a:not(#employee-manage-link)').on('click', function(event) {

        // employeePolling.js에 정의된 'window.employeeStopLongPolling' 함수가
        // 존재하는지 확인하고 호출합니다.
        if (typeof window.employeeStopLongPolling === 'function') {

            window.employeeStopLongPolling();
        }
    });
});