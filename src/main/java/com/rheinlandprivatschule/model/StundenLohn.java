package com.rheinlandprivatschule.model;

import java.sql.Date;

public class StundenLohn {

    public StundenLohn() {
        this.stdCID = 0;
        this.stdCourse = null;
        this.stdCourseCity = null;
        this.stdDate = null;
        this.stdDay = null;
        this.stdTID = 0;
        this.stdSTD = 0;
    }

    //Getters

    public int getCourseID() {
        return this.stdCID;
    }

    public String getCourseName() {
        return this.stdCourse;
    }

    public String getCourseCity() {
        return stdCourseCity;
    }

    public String getDay() {
        return this.stdDay;
    }

    public int getStunden() {
        return this.stdSTD;
    }

    public Date getStundenDate() {
        return this.stdDate;
    }

    public int getTeacherID() {
        return this.stdTID;
    }

    public int getTeacherStunden(){
        return this.teaSTD;
    }


    //Setters

    public void setCourseID(int code) {
        this.stdCID = code;
    }

    public void setCourseName(String code) {
        this.stdCourse = code;
    }

    public void setCourseCity(String stdCourseCity) {
        this.stdCourseCity = stdCourseCity;
    }

    public void setDay(String code) {
        this.stdDay = code;
    }

    public void setStunden(int code) {
        this.stdSTD = code;
    }

    public void setStundenDate(Date code) {
        this.stdDate = code;
    }

    public void setTeacherID(int code) {
        this.stdTID = code;
    }

    public void setTeacherStunden(int code){
        this.teaSTD=code;
    }

    //Instance Variables
    private int stdCID;
    private String stdCourse;
    private String stdCourseCity;
    private Date stdDate;
    private String stdDay;
    private int stdSTD;
    private int stdTID;
    private int teaSTD;
}
