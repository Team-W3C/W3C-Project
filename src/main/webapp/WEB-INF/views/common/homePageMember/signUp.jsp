<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - 병원 시설 예약 시스템</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/signUp.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/homePage/index.css">

<!-- 
    <link rel="stylesheet" href="/signUp/signUp.css">
    <link rel="stylesheet" href="/메인화면/header/header.css">
    <link rel="stylesheet" href="/메인화면/footer/footer.css">
    <link rel="stylesheet" href="/메인화면/index.css"> 
-->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

</head>
<body>
    <!-- Header Include -->
    <jsp:include page="header_member.jsp" />

    <!-- 메인 콘텐츠 -->
    <main class="signup-main">
        <div class="signup-container">
            <h1 class="signup-title">회원가입</h1>
            
            <form class="signup-form" method="post" action="${pageContext.request.contextPath}/member/signUp">
                <!-- 아이디 -->
                <div class="signup-field-row">
                    <div class="signup-field-group">
                        <label for="userId" class="signup-label">아이디</label>
                        <input type="text" id="userId" name="memberId" class="signup-input signup-input-short" placeholder="아이디">
                    </div>
                    <button type="button" class="signup-btn-check">아이디 중복확인</button>
                </div>

                <!-- 비밀번호 -->
                <div class="signup-field-group">
                    <label for="password" class="signup-label">비밀번호</label>
                    <input type="password" id="password" class="signup-input signup-input-full" placeholder="비밀번호">
                </div>

                <!-- 비밀번호 확인 -->
                <div class="signup-field-group">
                    <label for="passwordConfirm" class="signup-label">비밀번호 확인</label>
                    <input type="password" id="passwordConfirm" class="signup-input signup-input-short" placeholder="비밀번호 확인">
                </div>

                <!-- 이름 -->
                <div class="signup-field-group">
                    <label for="userName" class="signup-label">이름</label>
                    <input type="text" id="userName" class="signup-input signup-input-short" placeholder="이름">
                </div>
                
                <div class="blood-ssn-container">
                    <!-- 주민등록번호 -->
                    <div class="signup-field-ssn">
                        <div class="signup-field-group">
                            <label for="ssnFront" class="signup-label">주민등록번호</label>
                            <input type="text" id="ssnFront" class="signup-input signup-input-ssn" placeholder="주민등록번호" maxlength="6">
                        </div>
                        <span class="signup-ssn-dash">-</span>
                        <input type="password" id="ssnBack" class="signup-input signup-input-ssn" placeholder="뒷자리" maxlength="7">
                    </div>

                    <!-- 혈액형 -->
                    <div class="signup-field-row signup-field-blood">
                        <div class="signup-field-group">
                            <label for="bloodType" class="signup-label">혈액형</label>
                            <input type="text" id="bloodType" class="signup-input signup-input-blood" placeholder="혈액형">
                        </div>
                    </div>
                </div>

                <div class="phone-address-container">
                    <!-- 전화번호 -->
                    <div class="signup-field-group">
                        <label for="phone" class="signup-label">전화번호</label>
                        <input type="tel" id="phone" class="signup-input signup-input-short" placeholder="전화번호">
                    </div>

                    <!-- 주소 -->
                    <div class="signup-field-group signup-field-address">
                        <label for="address" class="signup-label">주소</label>
                        <input type="text" id="address" class="signup-input signup-input-short" placeholder="주소">
                    </div>
                </div>

                <div class="email-notes-container">
                    <!-- 이메일 -->
                    <div class="signup-field-group">
                        <label for="email" class="signup-label">이메일</label>
                        <input type="email" id="email" class="signup-input signup-input-short" placeholder="이메일">
                    </div>

                    <!-- 특이사항 -->
                    <div class="signup-field-group signup-field-notes">
                        <label for="notes" class="signup-label">특이사항(기저질환, 알레르기)</label>
                        <input type="text" id="notes" class="signup-input signup-input-short" placeholder="특이사항">
                    </div>
                </div>

                <!-- 버튼 -->
                <div class="signup-actions">
                    <button type="reset" class="signup-btn-reset">되돌리기</button>
                    <button type="submit" class="signup-btn-submit">회원가입</button>
                </div>
            </form>
        </div>
    </main>

    <!-- Footer Include -->
    <jsp:include page="../homePageFooter/footer.jsp" />

    <!-- script -->
    <script src="${pageContext.request.contextPath}/js/index.js"></script>

</body>
</html>