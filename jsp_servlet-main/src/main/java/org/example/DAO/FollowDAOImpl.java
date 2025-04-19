package org.example.DAO;

import org.example.model.User;
import org.example.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FollowDAOImpl implements FollowDAO {
    private final DatabaseConnection databaseConnection = new DatabaseConnection();

    @Override
    public void follow(User follower, User following) {
        String sql = "INSERT INTO follows (follower_id, following_id) VALUES (?, ?)";
        try (Connection connection = databaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, follower.getId());
            statement.setLong(2, following.getId());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void unfollow(User follower, User following) {
        if (follower == null || following == null || follower.getId() == null || following.getId() == null) {
            throw new IllegalArgumentException("Follower or following user is null or has null ID");
        }
        
        String sql = "DELETE FROM follows WHERE follower_id = ? AND following_id = ?";
        try (Connection connection = databaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, follower.getId());
            statement.setLong(2, following.getId());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<User> findFollowing(User user) {
        List<User> followingUsers = new ArrayList<>();
        String sql = "SELECT u.id, u.username " +
                     "FROM follows f " +
                     "JOIN users u ON f.following_id = u.id " +
                     "WHERE f.follower_id = ?";
        try (Connection connection = databaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, user.getId());
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                User followingUser = new User();
                followingUser.setId(resultSet.getLong("id"));
                followingUser.setUsername(resultSet.getString("username"));
                followingUsers.add(followingUser);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return followingUsers;
    }


    @Override
    public List<User> findFollowers(User user) {
        List<User> followers = new ArrayList<>();
        String sql = "SELECT follower_id FROM follows WHERE following_id = ?";
        try (Connection connection = databaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, user.getId());
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Long followerId = resultSet.getLong("follower_id");
                User followerUser = new User(); // Fetch user details based on followerId
                followerUser.setId(followerId);
                followers.add(followerUser);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return followers;
    }
    @Override
    public List<User> searchUsersByFollowStats(int minFollowing, int minFollowers) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT u.id, u.username, " +
                     "COUNT(DISTINCT f1.following_id) AS following_count, " +
                     "COUNT(DISTINCT f2.follower_id) AS follower_count " +
                     "FROM users u " +
                     "LEFT JOIN follows f1 ON u.id = f1.follower_id " +
                     "LEFT JOIN follows f2 ON u.id = f2.following_id " +
                     "GROUP BY u.id, u.username " +
                     "HAVING following_count >= ? OR follower_count >= ?";
        try (Connection conn = databaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, minFollowing);
            stmt.setInt(2, minFollowers);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getLong("id"));
                user.setUsername(rs.getString("username"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

}