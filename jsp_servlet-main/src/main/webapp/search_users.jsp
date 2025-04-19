<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Tìm kiếm người dùng</title>
    <style>
        .search-form {
            margin: 20px auto;
            text-align: center;
        }
        .user-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
            max-width: 600px;
            margin: 20px auto;
        }
        .user-item {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
        .not-found {
            text-align: center;
            margin-top: 30px;
        }
    </style>
</head>
<body>

    <div class="search-form">
        <h2>Tìm kiếm theo số lượng Follow</h2>
        <form method="get" action="${pageContext.request.contextPath}/search">
            <input type="number" name="minFollowing" placeholder="Tối thiểu following" />
            <input type="number" name="minFollowers" placeholder="Tối thiểu follower" />
            <button type="submit">Tìm kiếm</button>
        </form>
    </div>

    <div class="user-list">
        <c:choose>
            <c:when test="${not empty searchResults}">
                <c:forEach var="user" items="${searchResults}">
                    <div class="user-item">
                        <h3>Tên người dùng: ${user.username}</h3>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="not-found">
                    <img src="${pageContext.request.contextPath}/images/not-found.png" alt="Không tìm thấy" width="300" />
                    <p>Không tìm thấy người dùng nào phù hợp!</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</body>
</html>
