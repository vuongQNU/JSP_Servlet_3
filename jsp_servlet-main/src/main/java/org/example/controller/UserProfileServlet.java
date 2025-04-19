package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import org.example.DAO.ProvinceDAO;
import org.example.DAO.UserDAO;
import org.example.DAO.UserDAOImpl;
import org.example.model.Province;
import org.example.model.User;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/userprofile")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 200 * 1024, maxRequestSize = 1024 * 1024)
public class UserProfileServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAOImpl();
    private final ProvinceDAO provinceDAO = new ProvinceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        List<Province> provinces = provinceDAO.getAll();
        request.setAttribute("provinces", provinces);
        request.getRequestDispatcher("/user_form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        List<String> errors = new ArrayList<>();
        String email = request.getParameter("email");
        String dobStr = request.getParameter("dob");
        String provinceIdStr = request.getParameter("province_id");
        Part avatarPart = request.getPart("avatar");

        // Kiểm tra định dạng email
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            errors.add("Email không hợp lệ.");
        }

        // Kiểm tra email trùng lặp (bỏ qua email của chính người dùng)
        if (!email.equals(currentUser.getEmail()) && userDAO.existsByEmail(email)) {
            errors.add("Email đã tồn tại.");
        }

        // Kiểm tra độ tuổi
        LocalDate dob = null;
        try {
            dob = LocalDate.parse(dobStr);
            if (ChronoUnit.YEARS.between(dob, LocalDate.now()) < 15) {
                errors.add("Bạn phải đủ 15 tuổi để cập nhật hồ sơ.");
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
        String avatarPath = currentUser.getAvatar();
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

        // Nếu có lỗi, quay lại form
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("provinces", provinceDAO.getAll());
            request.getRequestDispatcher("/user_form.jsp").forward(request, response);
            return;
        }

        // Cập nhật thông tin người dùng
        currentUser.setEmail(email);
        if (dob != null) { // Chỉ set nếu dob hợp lệ
            currentUser.setDob(dob);
        }
        currentUser.setProvince_id(provinceId);
        if (avatarPath != null) {
            currentUser.setAvatar(avatarPath);
        }
        userDAO.update(currentUser);

        request.setAttribute("success", "Cập nhật thông tin thành công!");
        doGet(request, response);
    }
}