<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%--
  회원 공통 사이드바 (member-sidebar.jsp)
  - 메인 레이아웃 JSP에서 <jsp:include> 또는 <%@ include>로 호출됩니다.
  - 이 파일의 CSS는 메인 페이지의 <head>에서 링크해야 합니다.
--%>
<aside class="member-sidebar">

    <div class="member-sidebar__user">
        <h2 class="member-sidebar__user-name">홍길동님</h2>
        <p class="member-sidebar__user-id">병원등록번호 : 11111111</p>
    </div>

    <nav class="member-sidebar__nav-group">
        <h3 class="member-sidebar__nav-title">진료서비스</h3>
        <ul class="member-sidebar__nav-list">
            <li class="member-sidebar__nav-item">
                <a href="#" class="member-sidebar__nav-link member-sidebar__nav-link--active">본인예약현황</a>
            </li>
            <li class="member-sidebar__nav-item">
                <a href="#" class="member-sidebar__nav-link">진료내역</a>
            </li>
            <li class="member-sidebar__nav-item">
                <a href="#" class="member-sidebar__nav-link">알레르기 이력</a>
            </li>
            <li class="member-sidebar__nav-item">
                <a href="#" class="member-sidebar__nav-link">투약내역</a>
            </li>
            <li class="member-sidebar__nav-item">
                <a href="#" class="member-sidebar__nav-link">진단검사결과</a>
            </li>
            <li class="member-sidebar__nav-item">
                <a href="#" class="member-sidebar__nav-link">건강검진결과</a>
            </li>
        </ul>
    </nav>

    <nav class="member-sidebar__nav-group">
        <h3 class="sidebar-menu-title" id="open-password-modal">
            <a href="${pageContext.request.contextPath}/member/info.me">
                회원정보
            </a>
        </h3>
        <ul class="member-sidebar__nav-list">
            <li class="member-sidebar__nav-item">
                <a href="#" class="member-sidebar__nav-link member-sidebar__nav-link--active">회원정보수정</a>
            </li>
            <li class="member-sidebar__nav-item">
                <a href="#" class="member-sidebar__nav-link member-sidebar__nav-link--medium">비밀번호 변경</a>
            </li>
            <li class="member-sidebar__nav-item">
                <a href="#" class="member-sidebar__nav-link">회원 탈퇴</a>
            </li>
        </ul>
    </nav>

</aside>