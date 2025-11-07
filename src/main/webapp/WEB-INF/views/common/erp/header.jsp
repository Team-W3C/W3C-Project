<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/erpCommon/erpHeader.css">

</head>
<body>
<!-- 헤더 -->
    <header class="header">
        <div class="header__search">
            <input type="text" class="header__search-input" placeholder="환자, 예약, 직원 검색...">
            <svg class="header__search-icon" width="20" height="20" fill="none" viewBox="0 0 20 20">
                <path d="M17.5 17.5L13.8833 13.8833" stroke="#6B7280" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                <path d="M9.16667 15.8333C12.8486 15.8333 15.8333 12.8486 15.8333 9.16667C15.8333 5.48477 12.8486 2.5 9.16667 2.5C5.48477 2.5 2.5 5.48477 2.5 9.16667C2.5 12.8486 5.48477 15.8333 9.16667 15.8333Z" stroke="#6B7280" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
            </svg>
        </div>
        <button class="header__search-btn"><label class="header__search-btn-label">검색</label></button>
        
        <div class="header__actions">
            <!-- 알림 버튼 -->
            <button class="header__notification">
                <svg width="20" height="20" fill="none" viewBox="0 0 20 20">
                    <path d="M8.55662 17.5C8.70291 17.7533 8.9133 17.9637 9.16666 18.11C9.42001 18.2563 9.70741 18.3333 9.99995 18.3333C10.2925 18.3333 10.5799 18.2563 10.8333 18.11C11.0866 17.9637 11.297 17.7533 11.4433 17.5" stroke="#6B7280" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                    <path d="M2.71833 12.7717C2.60947 12.891 2.53763 13.0394 2.51155 13.1988C2.48547 13.3582 2.50627 13.5217 2.57142 13.6695C2.63658 13.8173 2.74328 13.943 2.87855 14.0312C3.01381 14.1195 3.17182 14.1665 3.33333 14.1667H16.6667C16.8282 14.1667 16.9862 14.1199 17.1216 14.0318C17.2569 13.9437 17.3637 13.8181 17.4291 13.6704C17.4944 13.5227 17.5154 13.3592 17.4895 13.1998C17.4637 13.0404 17.392 12.892 17.2833 12.7725C16.175 11.63 15 10.4158 15 6.66667C15 5.34058 14.4732 4.06881 13.5355 3.13113C12.5979 2.19345 11.3261 1.66667 10 1.66667C8.67392 1.66667 7.40215 2.19345 6.46447 3.13113C5.52679 4.06881 5 5.34058 5 6.66667C5 10.4158 3.82417 11.63 2.71833 12.7717Z" stroke="#6B7280" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                </svg>
                <span class="header__notification-badge"></span>
            </button>

            <!-- 구분선 -->
            <div class="header__divider"></div>

            <!-- 사용자 정보 -->
            <div class="header__user">
                <div class="header__user-info">
                    <p class="header__user-name">관리자</p>
                    <p class="header__user-email">admin@hospital.com</p>
                </div>
                <div class="header__user-avatar">
                    <svg width="20" height="20" fill="none" viewBox="0 0 20 20">
                        <path d="M15.8333 17.5V15.8333C15.8333 14.9493 15.4821 14.1014 14.857 13.4763C14.2319 12.8512 13.3841 12.5 12.5 12.5H7.5C6.61594 12.5 5.7681 12.8512 5.14298 13.4763C4.51786 14.1014 4.16667 14.9493 4.16667 15.8333V17.5" stroke="white" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                        <path d="M10 9.16667C11.8409 9.16667 13.3333 7.67428 13.3333 5.83333C13.3333 3.99238 11.8409 2.5 10 2.5C8.15905 2.5 6.66667 3.99238 6.66667 5.83333C6.66667 7.67428 8.15905 9.16667 10 9.16667Z" stroke="white" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                    </svg>
                </div>
            </div>
        </div>
    </header>
</body>
</html>