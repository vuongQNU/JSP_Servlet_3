<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 500px; margin: 50px auto; padding: 20px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; }
        .form-group input, .form-group select { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .error { color: red; margin-bottom: 15px; }
        .btn { background-color: #4CAF50; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; }
        .btn:hover { background-color: #45a049; }
        .link { margin-top: 15px; text-align: center; }
    </style>
</head>
<body>
<h2>Đăng ký tài khoản</h2>

<c:if test="${not empty errors}">
    <div class="error">
        <ul>
            <c:forEach var="err" items="${errors}">
                <li>${err}</li>
            </c:forEach>
        </ul>
    </div>
</c:if>
<c:if test="${not empty success}">
    <div style="color: green;">${success}</div>
</c:if>

<form action="register" method="post" enctype="multipart/form-data">
    <div class="form-group">
        <label for="username">Tên đăng nhập:</label>
        <input type="text" id="username" name="username" required>
    </div>
    <div class="form-group">
        <label for="password">Mật khẩu:</label>
        <input type="password" id="password" name="password" required>
    </div>
    <div class="form-group">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
    </div>
    <div class="form-group">
        <label for="dob">Ngày sinh:</label>
        <input type="date" id="dob" name="dob" required>
    </div>
    <div class="form-group">
    <label for="province_id">Nơi ở:</label>
    <<select id="province_id" name="province_id" required>
    <option value="">Chọn tỉnh/thành</option>
    <c:if test="${empty provinces}">
        <option value="">Không có tỉnh/thành nào</option>
    </c:if>
    <c:forEach var="p" items="${provinces}">
        <option value="${p.idProvince}" ${p.idProvince == param.province_id ? 'selected' : ''}>
            ${p.nameProvince}
        </option>
    </c:forEach>
	</select>
	</div>
    <div class="form-group">
        <label for="avatar">Ảnh đại diện:</label>
        <input type="file" id="avatar" name="avatar" accept=".jpg,.png">
    </div>
    <button type="submit" class="btn">Đăng ký</button>
</form>

<div class="link">
    <p>Đã có tài khoản? <a href="login">Đăng nhập</a></p>
</div>
</body>
</html>