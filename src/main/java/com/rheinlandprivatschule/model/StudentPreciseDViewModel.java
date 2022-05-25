package com.rheinlandprivatschule.model;

public class StudentPreciseDViewModel {
    public CourseRegistration courseRegistration;
    public Course course;
    public String mys;
    public String inkasso;
    public double cre;
    public String tempb;
    public String courseStartDate;
    public String courseFee;
    public String creStr;
    public String balance;

    public String getTempb() {
        return tempb;
    }

    public void setTempb(String tempb) {
        this.tempb = tempb;
    }

    public double getCre() {
        return cre;
    }

    public void setCre(double cre) {
        this.cre = cre;
    }

    public CourseRegistration getCourseRegistration() {
        return courseRegistration;
    }

    public void setCourseRegistration(CourseRegistration courseRegistration) {
        this.courseRegistration = courseRegistration;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public String getMys() {
        return mys;
    }

    public void setMys(String mys) {
        this.mys = mys;
    }

    public String getInkasso() {
        return inkasso;
    }

    public void setInkasso(String inkasso) {
        this.inkasso = inkasso;
    }

    public String getCourseStartDate() {
        return courseStartDate;
    }

    public void setCourseStartDate(String courseStartDate) {
        this.courseStartDate = courseStartDate;
    }

    public String getCourseFee() {
        return courseFee;
    }

    public void setCourseFee(String courseFee) {
        this.courseFee = courseFee;
    }


    public String getCreStr() {
        return creStr;
    }

    public void setCreStr(String creStr) {
        this.creStr = creStr;
    }

    public String getBalance() {
        return balance;
    }

    public void setBalance(String balance) {
        this.balance = balance;
    }
}
