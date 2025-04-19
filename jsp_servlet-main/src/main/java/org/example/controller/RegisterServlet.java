package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.example.DAO.ProvinceDAO;
import org.example.DAO.UserDAO;
import org.example.DAO.UserDAOImpl;
import org.example.model.User;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/register")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 200 * 1024, maxRequestSize = 1024 * 1024)
public class RegisterServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAOImpl();
    private final ProvinceDAO provinceDAO = new ProvinceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("provinces", provinceDAO.getAll());
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> errors = new ArrayList<>();

        // Lấy dữ liệu từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String dobStr = request.getParameter("dob");
        String provinceIdStr = request.getParameter("province_id");
        Part avatarPart = request.getPart("avatar");

        // Kiểm tra username
        if (userDAO.findByUsername(username) != null) {
            errors.add("Tên đăng nhập đã tồn tại.");
        }

        // Kiểm tra định dạng email
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            errors.add("Email không hợp lệ.");
        }

        // Kiểm tra email trùng lặp
        if (userDAO.existsByEmail(email)) {
            errors.add("Email đã tồn tại.");
        }
        
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("provinces", provinceDAO.getAll());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra độ tuổi
        LocalDate dob = null;
        try {
            dob = LocalDate.parse(dobStr);
            if (ChronoUnit.YEARS.between(dob, LocalDate.now()) < 15) {
                errors.add("Bạn phải đủ 15 tuổi để đăng ký.");
            }
        } catch (Exception e) {
            errors.add("Ngày sinh không hợp lệ.");
        }

        // Kiểm tra province_id
        int provinceId;
        try {
            provinceId = Integer.parseInt(provinceIdStr);
        } catch (NumberFormatException e) {
            errors.add("Vui lòng chọn nơi ở.");
            provinceId = -1;
        }

        // Kiểm tra avatar
        String avatarPath = null;
        if (avatarPart != null && avatarPart.getSize() > 0) {
            String contentType = avatarPart.getContentType();
            if (!(contentType.equals("image/jpeg") || contentType.equals("image/png"))) {
                errors.add("Ảnh đại diện phải là định dạng JPG hoặc PNG.");
            } else if (avatarPart.getSize() > 200 * 1024) {
                errors.add("Kích thước ảnh không được vượt quá 200KB.");
            } else {
                String fileName = System.currentTimeMillis() + "_" + Paths.get(avatarPart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("/img");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                avatarPart.write(uploadPath + File.separator + fileName);
                avatarPath = "img/" + fileName;
            }
        }

        // Nếu có lỗi, hiển thị lại form
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("provinces", provinceDAO.getAll());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Tạo user mới
        User user = new User();
        user.setUsername(username);
        user.setPassword(password); // TODO: Mã hóa mật khẩu
        user.setRole("USER");
        user.setCreatedAt(java.time.LocalDateTime.now());
        user.setEmail(email);
        if (dob != null) { // Chỉ set nếu dob hợp lệ
            user.setDob(dob);
        }
        user.setProvince_id(provinceId);
        user.setAvatar(avatarPath);

        userDAO.save(user); // Lưu thông tin đăng ký
        request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}