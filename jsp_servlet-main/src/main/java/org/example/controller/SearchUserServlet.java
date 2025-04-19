package org.example.controller;

import java.io.IOException;
import java.util.List;

import org.example.DAO.FollowDAO;
import org.example.DAO.FollowDAOImpl;
import org.example.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Logger;
@SuppressWarnings("serial")
@WebServlet("/search")
public class SearchUserServlet extends HttpServlet {
    private FollowDAO followDAO;
    private static final Logger logger = Logger.getLogger(SearchUserServlet.class.getName());
    @Override
    public void init() throws ServletException {
        followDAO = new FollowDAOImpl(); // Khởi tạo DAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	logger.info("SearchUserServlet được gọi");
        String minFollowingParam = request.getParameter("minFollowing");
        String minFollowersParam = request.getParameter("minFollowers");

        int minFollowing = 0;
        int minFollowers = 0;

        if (minFollowingParam != null && !minFollowingParam.isEmpty()) {
            minFollowing = Integer.parseInt(minFollowingParam);
        }
        if (minFollowersParam != null && !minFollowersParam.isEmpty()) {
            minFollowers = Integer.parseInt(minFollowersParam);
        }

        List<User> result = followDAO.searchUsersByFollowStats(minFollowing, minFollowers);
        request.setAttribute("searchResults", result);
        request.getRequestDispatcher("/search_users.jsp").forward(request, response);
        
    }
}

