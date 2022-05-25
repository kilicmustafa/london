package com.rheinlandprivatschule.model;

import java.sql.Date;

public class Certificate {

    public Certificate() {
        this.certificateID=0;
        this.studentID=0;
        this.courseID=0;

        this.listenPercentage=0;
        this.writtingPercentage=0;
        this.readPercentage=0;
        this.contentPercentage=0;
        this.oralPercentage=0;
        this.stunden=0;
        this.totalPercentage=0;

        this.issueDate=null;
        this.adminID=0;
    }

    public void setCertificateID(int certificateID) {
        this.certificateID = certificateID;
    }
    public int getCertificateID() {
        return this.certificateID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }
    public int getStudentID() {
        return this.studentID;
    }

    public void setCourseID(int courseID) {
        this.courseID=courseID;
    }
    public int getCourseID() {
        return this.courseID;
    }


    public void setListenPercentage(double listenPercentage) {
        this.listenPercentage = listenPercentage;
    }
    public double getListenPercentage() {
        return listenPercentage;
    }

    public void setWrittingPercentage(double writtingPercentage) {
        this.writtingPercentage = writtingPercentage;
    }
    public double getWrittingPercentage() {
        return writtingPercentage;
    }

    public void setReadPercentage(double readPercentage) {
        this.readPercentage = readPercentage;
    }
    public double getReadPercentage() {
        return readPercentage;
    }

    public void setContentPercentage(double contentPercentage) {
        this.contentPercentage = contentPercentage;
    }
    public double getContentPercentage() {
        return contentPercentage;
    }

    public void setOralPercentage(double oralPercentage) {
        this.oralPercentage = oralPercentage;
    }
    public double getOralPercentage() {
        return oralPercentage;
    }

    public void setStunden(double code) {
        this.stunden = code;
    }
    public double getStunden() {
        return this.stunden;
    }

    public void setTotalPercentage(double totalPercentage) {
        this.totalPercentage = totalPercentage;
    }
    public double getTotalPercentage() {
        return totalPercentage;
    }


    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }
    public Date getIssueDate() {
        return this.issueDate;
    }

    public void setAdminID(int adminID) {
        this.adminID = adminID;
    }
    public int getAdminID() {
        return this.adminID;
    }

    public String getNote() {
        if (totalPercentage >= 90) {
            return "sehr gut";
        }else if (totalPercentage >= 80) {
            return "gut";
        } else if (totalPercentage >= 70) {
            return "befriedigend";
        } else if (totalPercentage >= 60) {
            return "ausreichend";
        }else if(totalPercentage == 0){
            return "nicht geprüft";
        }else{
            return "nicht bestanden";
        }
    }

    //Instance Variables
    public int certificateID;
    public int studentID;
    public int courseID;

    private double listenPercentage;
    private double writtingPercentage;
    private double readPercentage;
    private double contentPercentage;
    private double oralPercentage;
    public double stunden;
    public double totalPercentage;

    public Date issueDate;
    public int adminID;
}
