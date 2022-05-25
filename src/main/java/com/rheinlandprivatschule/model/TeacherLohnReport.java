package com.rheinlandprivatschule.model;

public class TeacherLohnReport extends LohnReport {

    public int getTeacherID() {
        return teacherID;
    }
    public void setTeacherID(int teacherID) {
        this.teacherID = teacherID;
    }

    public String getTeacherName() {
        return teacherName;
    }
    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public double getLohnPerHour() {
        return lohnPerHour;
    }
    public void setLohnPerHour(double lohnPerHour) {
        this.lohnPerHour = lohnPerHour;
    }

    //Instance Variables
    private int teacherID;
    private String teacherName;
    private double lohnPerHour;
}
