package com.java_web_app.model;

import java.sql.Date;

public class AdmingetUserModel {

    private int    userId;
    private String firstName;
    private String lastName;
    private String userName;
    private String email;
    private String number;
    private String gender;
    private Date   dob;
    private String status;
    private int    programId;
    private String createdAt;   

    public int    getUserId()     { return userId; }
    public String getFirstName()  { return firstName; }
    public String getLastName()   { return lastName; }
    public String getUserName()   { return userName; }
    public String getEmail()      { return email; }
    public String getNumber()     { return number; }
    public String getGender()     { return gender; }
    public Date   getDob()        { return dob; }
    public String getStatus()     { return status; }
    public int    getProgramId()  { return programId; }
    public String getCreatedAt()  { return createdAt; }

    public void setUserId(int v)       { this.userId = v; }
    public void setFirstName(String v) { this.firstName = v; }
    public void setLastName(String v)  { this.lastName = v; }
    public void setUserName(String v)  { this.userName = v; }
    public void setEmail(String v)     { this.email = v; }
    public void setNumber(String v)    { this.number = v; }
    public void setGender(String v)    { this.gender = v; }
    public void setDob(Date v)         { this.dob = v; }
    public void setStatus(String v)    { this.status = v; }
    public void setProgramId(int v)    { this.programId = v; }
    public void setCreatedAt(String v) { this.createdAt = v; }
}