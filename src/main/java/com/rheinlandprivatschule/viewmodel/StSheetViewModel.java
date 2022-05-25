package com.rheinlandprivatschule.viewmodel;

import com.rheinlandprivatschule.model.Course;
import com.rheinlandprivatschule.model.StundenPlan;

public class StSheetViewModel {

    private Course course;
    private String t1Temp;
    private String t2Temp;
    private String t3Temp;
    private String t4Temp;
    private String t5Temp;
    private StundenPlan stundenPlan;
    private String init;

    public StSheetViewModel(Course course, String t1Temp, String t2Temp, String t3Temp, String t4Temp, String t5Temp, StundenPlan stundenPlan) {
        super();
        this.course = course;
        this.t1Temp = t1Temp;
        this.t2Temp = t2Temp;
        this.t3Temp = t3Temp;
        this.t4Temp = t4Temp;
        this.t5Temp = t5Temp;
        this.stundenPlan = stundenPlan;
        this.init = init;
        String init="-"+course.getCourseInit();
        if(course.getCourseInit() == null) {
            init = "";
        }
    }

    public StundenPlan getStundenPlan() {
        return stundenPlan;
    }

    public void setStundenPlan(StundenPlan stundenPlan) {
        this.stundenPlan = stundenPlan;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public String getT1Temp() {
        return t1Temp;
    }

    public void setT1Temp(String t1Temp) {
        this.t1Temp = t1Temp;
    }

    public String getT2Temp() {
        return t2Temp;
    }

    public void setT2Temp(String t2Temp) {
        this.t2Temp = t2Temp;
    }

    public String getT3Temp() {
        return t3Temp;
    }

    public void setT3Temp(String t3Temp) {
        this.t3Temp = t3Temp;
    }

    public String getT4Temp() {
        return t4Temp;
    }

    public void setT4Temp(String t4Temp) {
        this.t4Temp = t4Temp;
    }

    public String getT5Temp() {
        return t5Temp;
    }

    public void setT5Temp(String t5Temp) {
        this.t5Temp = t5Temp;
    }

    public String getInit() {
        return init;
    }

    public void setInit(String init) {
        this.init = init;
    }
}
