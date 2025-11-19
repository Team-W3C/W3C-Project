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
    <jsp:include page="header.jsp" />

    <!-- 메인 콘텐츠 -->
    <main class="signup-main">
        <div class="signup-container">
            <h1 class="signup-title">회원가입</h1>
            
            <form class="signup-form" method="post" action="${pageContext.request.contextPath}/api/member/signUp">
                <!-- 아이디 -->
                <div class="signup-field-row">
                    <div class="signup-field-group">
                        <label for="userId" class="signup-label">아이디</label>
                        <input type="text" id="userId" name="memberId" class="signup-input signup-input-short" required placeholder="아이디">
                    </div>
                    <button type="button" class="signup-btn-check" onclick="idDuplicateCheck()">아이디 중복확인</button>
                </div>

                <!-- 비밀번호 -->
                <div class="signup-field-group">
                    <label for="password" class="signup-label">비밀번호</label>
                    <input type="password" id="password" name="memberPwd" class="signup-input signup-input-full" required placeholder="비밀번호">
                </div>

                <!-- 비밀번호 확인 -->
                <div class="signup-field-group">
                    <label for="passwordConfirm" class="signup-label">비밀번호 확인</label>
                    <input type="password" id="passwordConfirm" class="signup-input signup-input-short" required placeholder="비밀번호 확인">
                </div>

                <div class="name-blood-container">
                    <!-- 이름 -->
                    <div class="signup-field-group">
                        <label for="userName" class="signup-label">이름</label>
                        <input type="text" id="userName" name="memberName" class="signup-input signup-input-short" required placeholder="이름">
                    </div>
                    <!-- 혈액형 -->
                    <div class="signup-field-row signup-field-blood">
                        <div class="signup-field-group">
                            <label for="bloodType" class="signup-label">혈액형</label>
<%--                            <input type="text" id="bloodType" name="memberBloodType" class="signup-input signup-input-blood" placeholder="혈액형">--%>
                            <select name="memberBloodType" id="bloodType" class="signup-input signup-input-blood">
                                <option value="A+">A+</option>
                                <option value="B+">B+</option>
                                <option value="AB+">AB+</option>
                                <option value="O+">O+</option>

                                <option value="A-">A-</option>
                                <option value="B-">B-</option>
                                <option value="AB-">AB-</option>
                                <option value="O-">O-</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="ssn-phone-container">
                    <!-- 주민등록번호 -->
                    <div class="signup-field-ssn">
                        <div class="signup-field-group">
                            <label for="ssnFront" class="signup-label">주민등록번호</label>
                            <input type="text" id="ssnFront" name="memberSsnFront" class="signup-input signup-input-ssn" required placeholder="주민등록번호" maxlength="6">
                        </div>
                        <span class="signup-ssn-dash">-</span>
                        <input type="password" id="ssnBack" name="memberSsnBack" class="signup-input signup-input-ssn" required placeholder="뒷자리" maxlength="7">
                    </div>

                    <!-- 전화번호 -->
                    <div class="signup-field-group">
                        <label for="phone" class="signup-label">전화번호</label>
                        <input type="tel" id="phone" name="memberPhone" class="signup-input signup-input-short" required placeholder="전화번호">
                    </div>
                </div>

                <div class="address-email-container">
                    <!-- 주소 -->
                    <div class="signup-field-group signup-field-address">
                        <label for="address" class="signup-label">주소</label>
                        <input type="text" id="address" name="memberAddress" class="signup-input signup-input-short" required placeholder="주소">
                    </div>

                    <!-- 이메일 -->
                    <div class="signup-field-group">
                        <label for="email" class="signup-label">이메일</label>
                        <input type="email" id="email" name="memberEmail" class="signup-input signup-input-short" required placeholder="이메일">
                    </div>
                </div>

                <div class="notes-container">
                    <!-- 기저질환 -->
                    <div class="signup-field-group signup-field-notes">
                        <label for="notes" class="signup-label">기저질환</label>
                        <input type="text" id="note-underlying-disease" name="memberChronicDisease" class="signup-input signup-input-short" required placeholder="예) 천식, 없음 등">
                    </div>
                    <!-- 알레르기 -->
                    <div class="signup-field-group signup-field-notes">
                        <input type="text" id="note-allergy" name="memberAllergy" class="signup-input signup-input-short" required placeholder="예) 망고 알레르기, 없음 등">
                    </div>
                </div>

                <!-- 버튼 -->
                <div class="signup-actions">
                    <button type="reset" class="signup-btn-reset">되돌리기</button>
                    <button type="submit" class="signup-btn-submit" onclick="return validationCheck()">회원가입</button>
                </div>
            </form>
        </div>
    </main>

    <!-- Footer Include -->
    <jsp:include page="../homePageFooter/footer.jsp" />

    <!-- script -->
    <script>
        function validationCheck(){
            const pwdInputList = document.querySelectorAll(".signup-form input[type=password]");

            if(pwdInputList[0].value !== pwdInputList[1].value){
                alert("비밀번호가 일치하지 않습니다.");
                return false;
            }
        }

        function idDuplicateCheck() {
            const idInput = document.querySelector(".signup-form input[name=memberId]");

            if(idInput.value.length < 5) { //아이디 형식에대한 예외처리
                return;
            }

            $.ajax({
                url : "/api/member/idDuplicateCheck",
                type : "get",
                data : {
                    checkId : idInput.value
                },
                success: function(result){
                    if(result === "F") { //존재한다면
                        alert("이미 존재하는 ID입니다.");
                        idInput.focus();
                    } else { //존재하지 않는다면
                        if(confirm("사용가능한 아이디입니다. 사용하시겠습니까?")){

                            const submitBtn = document.querySelector(".signup-form button[type=submit]");
                            submitBtn.removeAttribute("disabled");
                        } else{
                            idInput.focus();
                        }
                    }
                },
                error: function(err){
                    console.log("아이디 체크 요청 실패 : ", err);
                }
            })
        }
    </script>

</body>
</html>