package com.rheinlandprivatschule.model;

import java.sql.Date;

public class Course {

    public Course(int courseID, String courseName, String courseDesc, Date courseStartDate, Date courseEndDate,
                  double courseFee, int coursePlace, String courseTiming) {
        this.courseID = courseID;
        this.courseName = courseName;
        this.courseDesc = courseDesc;
        this.courseStartDate = courseStartDate;
        this.courseEndDate = courseEndDate;
        this.courseFee = courseFee;
        this.coursePlace = coursePlace;
        this.courseTiming = courseTiming;
        this.courseStrength = 0;
        this.courseHours = "25 Std";
        this.courseTHours = "252 * 45 min";
        this.courseType = 0;
        this.courseDuration = 0.0;
        this.courseBamfNr = null;
        this.courseModule = null;
        this.courseDailyHrs = null;
        this.remarks = null;
        this.courseInit = null;
    }

    public Course() {
        this.courseID = 0;
        this.courseName = null;
        this.courseDesc = null;
        this.courseStartDate = null;
        this.courseEndDate = null;
        this.courseFee = 0.0;
        this.coursePlace = 0;
        this.courseTiming = null;
        this.courseStrength = 0;

        this.courseHours = null;
        this.courseType = 0;
        this.courseTHours = null;
        this.courseDuration = 0.0;
        this.courseBamfNr = null;
        this.courseModule = null;
        this.courseDailyHrs = null;
        this.remarks = null;
        this.courseInit = null;
    }

    //Getters

    public String getCourseDesc() {
        return this.courseDesc;
    }

    public Date getCourseEndDate() {
        return this.courseEndDate;
    }

    public double getCourseFee() {
        return this.courseFee;
    }

    public String getCourseHours() {
        return this.courseHours;
    }

    public int getCourseID() {
        return this.courseID;
    }

    public String getCourseName() {
        return this.courseName;
    }

    public int getCoursePlace() {
        return this.coursePlace;
    }

    public Date getCourseStartDate() {
        return this.courseStartDate;
    }

    public int getCourseStrength() {
        return this.courseStrength;
    }

    public String getCourseTiming() {
        return this.courseTiming;
    }

    public String getCourseTotalHours() {
        return this.courseTHours;
    }

    public int getCourseType() {
        return this.courseType;
    }

    public double getCourseDuration() {
        return this.courseDuration;
    }

    public String getCourseBamfNr() {
        return this.courseBamfNr;
    }

    public String getCourseModule() {
        return this.courseModule;
    }

    public String getCourseDailyHrs() {
        return this.courseDailyHrs;
    }

    public String getRemarks() {
        return this.remarks;
    }

    public String getCourseInit() {
        return this.courseInit;
    }

    //Setters

    public void setCourseDesc(String code) {
        this.courseDesc = code;
    }

    public void setCourseEndDate(Date code) {
        this.courseEndDate = code;
    }

    public void setCourseFee(double code) {
        this.courseFee = code;
    }

    public void setCourseHours(String code) {
        this.courseHours = code;
    }

    public void setCourseID(int code) {
        this.courseID = code;
    }

    public void setCourseName(String code) {
        this.courseName = code;
    }

    public void setCoursePlace(int code) {
        this.coursePlace = code;
    }

    public void setCourseStartDate(Date code) {
        this.courseStartDate = code;
    }

    public void setCourseStrength(int code) {
        this.courseStrength = code;
    }

    public void setCourseTiming(String code) {
        this.courseTiming = code;
    }

    public void setCourseTotalHours(String code) {
        this.courseTHours = code;
    }

    public void setCourseType(int code) {
        this.courseType = code;
    }

    public void setCourseDuration(double code) {
        this.courseDuration = code;
    }

    public void setCourseBamfNr(String code) {
        this.courseBamfNr = code;
    }

    public void setCourseModule(String code) {
        this.courseModule = code;
    }

    public void setCourseDailyHrs(String code) {
        this.courseDailyHrs = code;
    }

    public void setRemarks(String code) {
        this.remarks = code;
    }

    public void setCourseInit(String code) {
        this.courseInit = code;
    }
    //Instance Variables
    private String courseDesc;

    private Date courseEndDate;

    private double courseFee;

    private String courseHours;

    private int courseID;

    private String courseName;

    private int coursePlace;

    private Date courseStartDate;

    private int courseStrength;

    private String courseTHours;

    private String courseTiming;

    private int courseType;

    private double courseDuration;

    private String courseBamfNr;

    private String courseModule;

    private String courseDailyHrs;

    private String remarks;

    private String courseInit;

}
