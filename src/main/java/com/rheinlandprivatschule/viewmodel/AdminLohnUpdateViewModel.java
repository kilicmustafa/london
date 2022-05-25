package com.rheinlandprivatschule.viewmodel;

import com.rheinlandprivatschule.model.TeacherLohn;

public class AdminLohnUpdateViewModel {
    private TeacherLohn teacherLohn;
    private String startDate;
    private String loopEndDate;
    private String teacherLohnDisplay;

    public AdminLohnUpdateViewModel(TeacherLohn teacherLohn, String startDate, String loopEndDate, String teacherLohnDisplay) {
        this.teacherLohn = teacherLohn;
        this.startDate = startDate;
        this.loopEndDate = loopEndDate;
        this.teacherLohnDisplay = teacherLohnDisplay;
    }

    public TeacherLohn getTeacherLohn() {
        return teacherLohn;
    }

    public void setTeacherLohn(TeacherLohn teacherLohn) {
        this.teacherLohn = teacherLohn;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getLoopEndDate() {
        return loopEndDate;
    }

    public void setLoopEndDate(String loopEndDate) {
        this.loopEndDate = loopEndDate;
    }

    public String getTeacherLohnDisplay() {
        return teacherLohnDisplay;
    }

    public void setTeacherLohnDisplay(String teacherLohnDisplay) {
        this.teacherLohnDisplay = teacherLohnDisplay;
    }
}
