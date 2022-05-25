package com.rheinlandprivatschule.model;

import java.util.Vector;

public class SchoolLohnReport extends LohnReport {

    public int getTotalHoursWorkedNormal() {
        if(this.teacherReports != null){
            for(int track = 0;track < this.teacherReports.size();track++){
                TeacherLohnReport teacherReport = (TeacherLohnReport)this.teacherReports.elementAt(track);
                this.totalHoursWorkedNormal+=teacherReport.getTotalHoursWorkedNormal();
            }
        }else if(this.courseReports != null){
            for(int track = 0;track < this.courseReports.size();track++){
                CourseLohnReport courseReport = (CourseLohnReport)this.courseReports.elementAt(track);
                this.totalHoursWorkedNormal+=courseReport.getTotalHoursWorkedNormal();
            }
        }
        return this.totalHoursWorkedNormal;
    }

    public int getTotalHoursWorkedPrivate() {
        if(this.teacherReports != null){
            for(int track = 0;track < this.teacherReports.size();track++){
                TeacherLohnReport teacherReport = (TeacherLohnReport)this.teacherReports.elementAt(track);
                this.totalHoursWorkedPrivate+=teacherReport.getTotalHoursWorkedPrivate();
            }
        }
        return this.totalHoursWorkedPrivate;
    }

    public double getAmountPayable() {
        if(this.teacherReports != null){
            for(int track = 0;track < this.teacherReports.size();track++){
                TeacherLohnReport teacherReport = (TeacherLohnReport)this.teacherReports.elementAt(track);
                this.amountPayable+=teacherReport.getAmountPayable();
            }
        }else if(this.courseReports != null){
            for(int track = 0;track < this.courseReports.size();track++){
                CourseLohnReport courseReport = (CourseLohnReport)this.courseReports.elementAt(track);
                this.amountPayable+=courseReport.getAmountPayable();
            }
        }
        return this.amountPayable;
    }

    public Vector<TeacherLohnReport> getTeacherReports() {
        return teacherReports;
    }
    public void setTeacherReports(Vector<TeacherLohnReport> teacherReports) {
        this.teacherReports = teacherReports;
    }

    public Vector<CourseLohnReport> getCourseReports() {
        return courseReports;
    }
    public void setCourseReports(Vector<CourseLohnReport> courseReports) {
        this.courseReports = courseReports;
    }

    //Instance Variables
    private Vector<TeacherLohnReport> teacherReports;
    private Vector<CourseLohnReport> courseReports;
}
