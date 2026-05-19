package com.hangaura.Model;

import java.sql.Date;

/**
 * Maps to the `users` table.
 * Field names match JSP EL expressions: user.firstName, user.lastName, etc.
 */
public class UserModel {

    private int    userId;
    private String firstName;
    private String lastName;
    private String userName;
    private String email;
    private String number;       // phone
    private String gender;
    private Date   dob;
    private String password;
    private byte[] profileImage;
    private int    programId;

    // ── Constructors ─────────────────────────────────────────────────────
    public UserModel() {}

    public UserModel(String firstName, String lastName, String userName,
                String email, String number, String gender,
                Date dob, String password, int programId) {
        this.firstName = firstName;
        this.lastName  = lastName;
        this.userName  = userName;
        this.email     = email;
        this.number    = number;
        this.gender    = gender;
        this.dob       = dob;
        this.password  = password;
        this.programId = programId;
    }

    // ── Getters / Setters ─────────────────────────────────────────────────
    public int    getUserId()       { return userId; }
    public void   setUserId(int v)  { this.userId = v; }

    public String getFirstName()          { return firstName; }
    public void   setFirstName(String v)  { this.firstName = v; }

    public String getLastName()           { return lastName; }
    public void   setLastName(String v)   { this.lastName = v; }

    public String getUserName()           { return userName; }
    public void   setUserName(String v)   { this.userName = v; }

    public String getEmail()              { return email; }
    public void   setEmail(String v)      { this.email = v; }

    public String getNumber()             { return number; }
    public void   setNumber(String v)     { this.number = v; }

    public String getGender()             { return gender; }
    public void   setGender(String v)     { this.gender = v; }

    public Date   getDob()                { return dob; }
    public void   setDob(Date v)          { this.dob = v; }

    public String getPassword()           { return password; }
    public void   setPassword(String v)   { this.password = v; }

    public byte[] getProfileImage()             { return profileImage; }
    public void   setProfileImage(byte[] v)     { this.profileImage = v; }

    public int    getProgramId()          { return programId; }
    public void   setProgramId(int v)     { this.programId = v; }

    @Override
    public String toString() {
        return "User{userId=" + userId + ", userName='" + userName + "'}";
    }
}