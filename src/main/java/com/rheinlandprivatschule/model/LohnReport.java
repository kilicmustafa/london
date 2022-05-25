package com.rheinlandprivatschule.model;


import java.sql.Date;

public class LohnReport {

    public LohnReport(){
        this.schoolID = 0;
        this.schoolName = "Alle Schulen";
        this.upperDate = null;
        this.lowerDate = null;
        this.totalHoursWorkedNormal = 0;
        this.totalHoursWorkedPrivate = 0;
        this.totalHoursWorkedForCourse = 0;
        this.amountPayable = 0;
    }

    public int getSchoolID() {
        return schoolID;
    }
    public void setSchoolID(int schoolID) {
        this.schoolID = schoolID;
    }

    public String getSchoolName() {
        return schoolName;
    }
    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    public Date getUpperDate() {
        return upperDate;
    }
    public void setUpperDate(Date upperDate) {
        this.upperDate = upperDate;
    }

    public Date getLowerDate() {
        return lowerDate;
    }
    public void setLowerDate(Date lowerDate) {
        this.lowerDate = lowerDate;
    }

    public int getTotalHoursWorkedNormal() {
        return totalHoursWorkedNormal;
    }
    public void setTotalHoursWorkedNormal(int totalHoursWorked) {
        this.totalHoursWorkedNormal = totalHoursWorked;
    }

    public int getTotalHoursWorkedPrivate() {
        return totalHoursWorkedPrivate;
    }

    public void setTotalHoursWorkedPrivate(int totalHoursWorkedPrivate) {
        this.totalHoursWorkedPrivate = totalHoursWorkedPrivate;
    }

    public int getTotalHoursWorkedForCourse() {
        return totalHoursWorkedForCourse;
    }

    public void setTotalHoursWorkedForCourse(int totalHoursWorkedForCourse) {
        this.totalHoursWorkedForCourse = totalHoursWorkedForCourse;
    }

    public double getAmountPayable() {
        return amountPayable;
    }
    public void setAmountPayable(double amountPayable) {
        this.amountPayable = amountPayable;
    }

    //Instance Variables
    private int schoolID;
    private String schoolName;
    private Date upperDate;
    private Date lowerDate;
    protected int totalHoursWorkedNormal;
    protected int totalHoursWorkedPrivate;
    protected int totalHoursWorkedForCourse;
    protected double amountPayable;
}
