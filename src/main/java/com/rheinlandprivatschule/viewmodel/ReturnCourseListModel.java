package com.rheinlandprivatschule.viewmodel;

import java.util.List;

public class ReturnCourseListModel {

    private List<CourseListViewModel> courses;
    private int activeFuture;
    private int totalAs;

    public ReturnCourseListModel(List<CourseListViewModel> courses, int activeFuture, int totalAs) {
        this.courses = courses;
        this.activeFuture = activeFuture;
        this.totalAs = totalAs;
    }

    public List<CourseListViewModel> getCourses() {
        return courses;
    }

    public void setCourses(List<CourseListViewModel> courses) {
        this.courses = courses;
    }

    public int getActiveFuture() {
        return activeFuture;
    }

    public void setActiveFuture(int activeFuture) {
        this.activeFuture = activeFuture;
    }

    public int getTotalAs() {
        return totalAs;
    }

    public void setTotalAs(int totalAs) {
        this.totalAs = totalAs;
    }
}
