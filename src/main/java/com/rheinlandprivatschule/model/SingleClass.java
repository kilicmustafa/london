package com.rheinlandprivatschule.model;

import java.sql.Date;

public class SingleClass {

    public SingleClass() {
        this.classID = 0;
        this.studentID = 0;
        this.courseName = null;
        this.teacherID = 0;
        this.classDate = null;
        this.classTime = 0;
        this.fee = 0;

    }

    public void setClassID(int code) {
        this.classID = code;
    }

    public void setStudentID(int code) {
        this.studentID = code;
    }

    public void setCourseName(String code) {
        this.courseName = code;
    }

    public void setTeacherID(int code) {
        this.teacherID = code;
    }

    public void setCLassDate(Date code) {
        this.classDate = code;
    }

    public void setClassTime(int code) {
        this.classTime = code;
    }

    public void setCourseFee(double code) {
        this.fee = code;
    }

    public void setPlaceID(int placeID){
        this.placeID=placeID;
    }

    public int getClassID() {
        return this.classID;
    }

    public int getStudentID() {
        return this.studentID;
    }

    public String getCourseName() {
        return this.courseName;
    }

    public int getTeacherID() {
        return this.teacherID;
    }

    public Date getCLassDate() {
        return this.classDate;
    }

    public int getClassTime() {
        return this.classTime;
    }

    public double getCourseFee() {
        return this.fee;
    }

    public int getPlaceID(){
        return this.placeID;
    }

    //Instance Variables
    private int classID;
    private int studentID;
    private String courseName;
    private int teacherID;
    private Date classDate;
    private int classTime;
    private double fee;
    private int placeID=0;
}
