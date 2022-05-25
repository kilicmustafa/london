package com.rheinlandprivatschule.model;

public class MahnungElement {

    public MahnungElement() {
        userID = 0;
        userName = null;
        userLast = null;
        courseID = 0;
        courseName = null;
        balance = 0;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int code) {
        userID = code;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String code) {
        userName = code;
    }

    public String getUserLastName() {
        return userLast;
    }

    public void setUserLastName(String code) {
        userLast = code;
    }

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int code) {
        courseID = code;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String code) {
        courseName = code;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double code) {
        balance = code;
    }

    //Instance Variables
    private int userID;
    private String userName;
    private String userLast;
    private int courseID;
    private String courseName;
    private double balance;
}
