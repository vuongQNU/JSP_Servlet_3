package org.example.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class User {
    private Long id;
    private String username;
    private String password;
    private String role;
    private String email;
    private LocalDate dob; // Kiểu dữ liệu là LocalDate
    private String avatar;
    private int province_id;
    private LocalDateTime createdAt;
    private List<Posts> posts = new ArrayList<>();
    private List<Follow> following = new ArrayList<>();
    private List<Follow> followers = new ArrayList<>();
    private boolean followedByCurrentUser;

    public User() {}
    
    public User(String email, LocalDate birthDate, int i, String avatarPath) {
        this.email = email;
        this.dob = birthDate;
        this.province_id = i;
        this.avatar = avatarPath;
    }

    public User(long id) {
        this.id = id;
    }

    // Getter và Setter cho dob
    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    // Các getter/setter khác
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }
    public int getProvince_id() { return province_id; }
    public void setProvince_id(int province_id) { this.province_id = province_id; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public List<Posts> getPosts() { return posts; }
    public void setPosts(List<Posts> posts) { this.posts = posts; }
    public List<Follow> getFollowing() { return following; }
    public void setFollowing(List<Follow> following) { this.following = following; }
    public List<Follow> getFollowers() { return followers; }
    public void setFollowers(List<Follow> followers) { this.followers = followers; }
    public boolean getFollowedByCurrentUser() { return followedByCurrentUser; }
    public void setFollowedByCurrentUser(boolean followedByCurrentUser) { this.followedByCurrentUser = followedByCurrentUser; }

    @Override
    public String toString() {
        return "User{id=" + id + ", username='" + username + "'}";
    }
}