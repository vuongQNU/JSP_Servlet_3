<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hồ sơ người dùng</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 600px; margin: 50px auto; padding: 20px; }
        .profile-container { border: 1px solid #ddd; padding: 20px; border-radius: 5px; }
        .profile-container h2 { margin-top: 0; }
        .profile-container img { max-width: 150px; border-radius: 50%; }
        .profile-container p { margin: 10px 0; }
        .profile-container .label { font-weight: bold; }
        .btn { display: inline-block; padding: 10px 15px; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 4px; }
        .btn:hover { background-color: #45a049; }
        .error { color: red; }
    </style>
</head>
<body>
<div class="profile-container">
    <h2>Hồ sơ người dùng</h2>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <c:if test="${not empty user}">
        <c:if test="${not empty user.avatar}">
            <img src="${pageContext.request.contextPath}/${user.avatar}" alt="Ảnh đại diện">
        </c:if>
        <p><span class="label">Tên đăng nhập:</span> ${user.username}</p>
        <p><span class="label">Email:</span> ${user.email}</p>
        <p><span class="label">Ngày sinh:</span> ${user.dob}</p>
        <p><span class="label">Nơi ở:</span> ${provinceName}</p>
        <p><span class="label">Ngày tạo tài khoản:</span> ${user.createdAt}</p>
    </c:if>

    <a href="${pageContext.request.contextPath}/userprofile" class="btn">Chỉnh sửa hồ sơ</a>
    <a href="${pageContext.request.contextPath}/logout" class="btn" style="background-color: #f44336;">Đăng xuất</a>
</div>
</body>
</html>