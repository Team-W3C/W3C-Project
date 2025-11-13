/**
 * employeePolling.js
 * 직원 관리 페이지 롱 폴링 전용 스크립트
 */

// 1. 현재 진행 중인 Ajax 요청 객체를 저장할 변수
// (window 객체에 저장하여 erpCommon.js에서도 접근 가능하도록 함)
window.longPollingRequest = null;

/**
 * 2. 롱 폴링 시작 함수 (핵심 로직)
 */
function startLongPolling() {

    // 이전 요청이 있다면 중복 방지를 위해 중단 (안전장치)
    if (window.longPollingRequest && window.longPollingRequest.readyState !== 4) {
        window.longPollingRequest.abort();
    }

    // GET 방식으로 서버 롱 폴링 엔드포인트에 요청 전송
    window.longPollingRequest = $.ajax({
        url: '/api/employeeManagement/longPolling', // 예시 URL (서버 컨트롤러 경로와 일치해야 함)
        method: 'GET',
        dataType: 'json', // 서버가 JSON을 반환한다고 가정
        timeout: 30100,   // 클라이언트가 서버로부터 어떠한 응답을 받지 못했을 경우.
        // 5분 + 1분 타임아웃 (서버의 DeferredResult 타임아웃과 맞춤)

        success: function(data) {
            // 2-1. 성공 시 (서버가 데이터 변동을 감지하고 응답을 보냄)
            console.log('롱 폴링 데이터 수신:', data);

            // TODO: 수신한 데이터(data)로 HTML 화면을 갱신하는 로직
            // 예: $('#staff-count-display').text(data.currentCount);

            // 2-2. 성공 응답을 받았으므로, 즉시 다음 롱 폴링 요청을 시작 (재귀)
            startLongPolling();
        },

        error: function(xhr, status, error) {
            // 2-3. 오류 발생 시
            if (status === 'abort') {
                // 사용자가 의도적으로 중단한 경우 (다른 메뉴 클릭, 페이지 이탈)
                console.log('롱 폴링이 중단되었습니다.');
                return; // 재귀 호출 중단
            }

            // 2-4. 타임아웃 또는 서버 오류 시
            console.error('롱 폴링 오류:', status, error);

            // 5초 후 재시도 (재귀)
            setTimeout(startLongPolling, 5000);
        }
    });
}

/**
 * 3. 롱 폴링 중단 함수 (erpCommon.js에서 호출할 수 있도록 window 객체에 정의)
 */
function employeeStopLongPolling() {

    if (window.longPollingRequest && window.longPollingRequest.readyState !== 4) {
        //readyState의 값이 4가 아닌지 판단. 4일경우 요청이 완료(성공하든 실패하든 응답을 받은 상태)
        //반대로 4가 아닐경우 여전히 요청 진행중(1: 로딩, 2: 헤더 수신, 3: 데이터 수신)
        window.longPollingRequest.abort(); //진행 중인 HTTP 요청을 즉시 중단하고 취소
        window.longPollingRequest = null; //요청 메모리 할당 해제, 논리적인 상태 초기화하여 버그 방지
        console.log('다른 메뉴 클릭 감지: 롱 폴링 중단 완료.');
    }
}

/**
 * 4. 최초 실행 (페이지 로드 완료 시)
 */
$(document).ready(function() {

    // 4-1. 페이지가 로드되면 롱 폴링을 최초로 시작합니다.
    startLongPolling();

    // 4-2. 브라우저 탭을 닫거나 URL을 직접 변경할 때 중단 이벤트를 등록합니다.
    window.addEventListener('beforeunload', window.employeeStopLongPolling);
});