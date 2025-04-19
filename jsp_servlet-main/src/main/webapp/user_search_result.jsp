<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Kết quả tìm kiếm người dùng</title>
</head>
<body>
<h2>Kết quả tìm kiếm:</h2>

<c:choose>
    <c:when test="${not empty searchResults}">
        <ul>
            <c:forEach var="user" items="${searchResults}">
                <li>${user.username}</li>
            </c:forEach>
        </ul>
    </c:when>
    <c:otherwise>
        <div style="text-align:center;">
 <img src="${pageContext.request.contextPath}/img/not-found.png" alt="Không tìm thấy" width="300" />

            <p>Không tìm thấy người dùng phù hợp.</p>
        </div>
    </c:otherwise>
</c:choose>

<a href="home">Quay về trang chủ</a>
</body>
</html>
