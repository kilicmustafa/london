package com.rheinlandprivatschule.model;

import java.sql.Date;

public class CourseRegistration
{

    public CourseRegistration(int courseID, int studentID,Date registrationDate,int registrationType,double courseBalance,double courseFee,Date firstPayDate,int registrationStatus){
        this.courseID=courseID;
        this.studentID=studentID;
        this.registrationDate=registrationDate;
        this.registrationType=registrationType;
        this.courseBalance=courseBalance;
        this.courseFee=courseFee;
        this.firstPayDate=firstPayDate;
        this.registrationStatus=registrationStatus;
    }

    public CourseRegistration(){
        this.courseID=0;
        this.studentID=0;
        this.registrationDate=null;
        this.registrationType=-1;
        this.courseBalance=-1;
        this.courseFee=-1;
        this.firstPayDate=null;
        this.registrationStatus=-1;
    }

    public int getCourseID() {
        return courseID;
    }
    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public int getStudentID() {
        return studentID;
    }
    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }

    public Date getRegistrationDate() {
        return registrationDate;
    }
    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }

    public int getRegistrationType() {
        return registrationType;
    }
    public void setRegistrationType(int registrationType) {
        this.registrationType = registrationType;
    }

    public double getCourseBalance() {
        return courseBalance;
    }
    public void setCourseBalance(double courseBalance) {
        this.courseBalance = courseBalance;
    }

    public double getCourseFee() {
        return courseFee;
    }
    public void setCourseFee(double courseFee) {
        this.courseFee = courseFee;
    }

    public Date getFirstPayDate() {
        return firstPayDate;
    }
    public void setFirstPayDate(Date firstPayDate) {
        this.firstPayDate = firstPayDate;
    }

    public int getRegistrationStatus() {
        return registrationStatus;
    }
    public void setRegistrationStatus(int registrationStatus) {
        this.registrationStatus = registrationStatus;
    }

    //Instance Variables
    private int courseID;
    private int studentID;
    private Date registrationDate;
    private int registrationType;
    private double courseBalance;
    private double courseFee;
    private Date firstPayDate;
    private int registrationStatus;
}
