package com.rheinlandprivatschule.model;


import java.sql.Date;

public class TeacherLohn {

    public TeacherLohn() {
        this.userID = 0;
        this.startDate = null;
        this.endDate = null;
        this.teacherLohn = 0;
    }

    public int getUserID() {
        return userID;
    }
    public void setUserID(int userID) {
        this.userID = userID;
    }

    public Date getStartDate() {
        return startDate;
    }
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public double getTeacherLohn() {
        return teacherLohn;
    }
    public void setTeacherLohn(double teacherLohn) {
        this.teacherLohn = teacherLohn;
    }

    //Instance Variables
    private int userID;
    private Date startDate;
    private Date endDate;
    private double teacherLohn;
}
