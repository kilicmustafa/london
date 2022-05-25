package com.rheinlandprivatschule.model;

import java.util.Vector;

public class CourseLohnReport extends LohnReport{

    public int getCourseID() {
        return courseID;
    }
    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public String getCourseName() {
        return courseName;
    }
    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getCoursePlace(){
        return this.coursePlace;
    }
    public void setCoursePlace(String coursePlace){
        this.coursePlace = coursePlace;
    }

    public Vector<TeacherLohnReport> getTeacherLohnReport() {
        return teacherLohnReport;
    }
    public void setTeacherLohnReport(Vector<TeacherLohnReport> teacherLohnReport) {
        this.teacherLohnReport = teacherLohnReport;
    }

    //Instance Variables
    private int courseID;
    private String courseName;
    private String coursePlace;
    private Vector<TeacherLohnReport> teacherLohnReport;
}
