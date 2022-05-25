package com.rheinlandprivatschule.viewmodel;

import com.rheinlandprivatschule.model.Course;

public class CourseListViewModel {
    private Course course;
    private double anofano;
    private String bamfActive;
    private int activeCount;
    private String init;
    private int extractStrengthAndCountStudentByCourse;

    public double getAnofano() {
        return anofano;
    }

    public void setAnofano(double anofano) {
        this.anofano = anofano;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public String getBamfActive() {
        return bamfActive;
    }

    public void setBamfActive(String bamfActive) {
        this.bamfActive = bamfActive;
    }

    public int getActiveCount() {
        return activeCount;
    }

    public void setActiveCount(int activeCount) {
        this.activeCount = activeCount;
    }

    public String getInit() {
        return init;
    }

    public void setInit(String init) {
        this.init = init;
    }

    public int getExtractStrengthAndCountStudentByCourse() {
        return extractStrengthAndCountStudentByCourse;
    }

    public void setExtractStrengthAndCountStudentByCourse(int extractStrengthAndCountStudentByCourse) {
        this.extractStrengthAndCountStudentByCourse = extractStrengthAndCountStudentByCourse;
    }
}
