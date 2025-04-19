<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Cập nhật hồ sơ</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 500px; margin: 50px auto; padding: 20px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; }
        .form-group input, .form-group select { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .error { color: red; margin-bottom: 15px; }
        .success { color: green; margin-bottom: 15px; }
        .btn { background-color: #4CAF50; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; }
        .btn:hover { background-color: #45a049; }
    </style>
</head>
<body>
<h2>Cập nhật hồ sơ người dùng</h2>

<c:if test="${not empty success}">
    <div class="success">${success}</div>
</c:if>
<c:if test="${not empty errors}">
    <div class="error">
        <ul>
            <c:forEach var="err" items="${errors}">
                <li>${err}</li>
            </c:forEach>
        </ul>
    </div>
</c:if>

<form action="userprofile" method="post" enctype="multipart/form-data">
    <div class="form-group">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="${sessionScope.user.email}" required>
    </div>
    <div class="form-group">
        <label for="dob">Ngày sinh:</label>
        <input type="date" id="dob" name="dob" value="${sessionScope.user.dob}" required>
    </div>
    <div class="form-group">
        <label for="province_id">Nơi ở:</label>
        <select id="province_id" name="province_id" required>
            <option value="">Chọn tỉnh/thành</option>
            <c:forEach var="p" items="${provinces}">
                <option value="${p.idProvince}" ${p.idProvince == sessionScope.user.province_id ? 'selected' : ''}>
                    ${p.nameProvince}
                </option>
            </c:forEach>
        </select>
    </div>
    <div class="form-group">
        <label for="avatar">Ảnh đại diện:</label>
        <input type="file" id="avatar" name="avatar" accept=".jpg,.png">
    </div>
    <button type="submit" class="btn">Lưu thông tin</button>
</form>

<c:if test="${not empty sessionScope.user.avatar}">
    <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" width="100" height="100" alt="Avatar" />
</c:if>
</body>
</html>