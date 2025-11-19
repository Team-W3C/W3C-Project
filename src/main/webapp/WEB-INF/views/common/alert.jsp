<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>알림</title>
</head>
<body>
<script>
    alert("${alertMessage}");
    <c:choose>
    <c:when test="${not empty redirectUrl}">
    location.href = "${pageContext.request.contextPath}${redirectUrl}";
    </c:when>
    <c:otherwise>
    history.back();
    </c:otherwise>
    </c:choose>
</script>
</body>
</html>