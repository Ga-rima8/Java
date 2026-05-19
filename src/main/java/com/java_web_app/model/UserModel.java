package com.java_web_app.model;

public class UserModel {
    private int    userId;
    private String fullName;
    private String email;
    private String phone;
    private String gender;
    private String status;
    private String createdAt;

    public int    getUserId()                      { return userId; }
    public void   setUserId(int userId)            { this.userId = userId; }
    public String getFullName()                    { return fullName; }
    public void   setFullName(String fullName)     { this.fullName = fullName; }
    public String getEmail()                       { return email; }
    public void   setEmail(String email)           { this.email = email; }
    public String getPhone()                       { return phone; }
    public void   setPhone(String phone)           { this.phone = phone; }
    public String getGender()                      { return gender; }
    public void   setGender(String gender)         { this.gender = gender; }
    public String getStatus()                      { return status; }
    public void   setStatus(String status)         { this.status = status; }
    public String getCreatedAt()                   { return createdAt; }
    public void   setCreatedAt(String createdAt)   { this.createdAt = createdAt; }
}