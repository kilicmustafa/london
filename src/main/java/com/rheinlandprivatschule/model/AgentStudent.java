package com.rheinlandprivatschule.model;

import java.sql.Date;

public class AgentStudent {

    public int getAgentID() {
        return agentID;
    }
    public void setAgentID(int agentID) {
        this.agentID = agentID;
    }
    public int isResidence() {
        return residence;
    }
    public void setResidence(int residence) {
        this.residence = residence;
    }
    public String getStudentDetail() {
        return studentDetail;
    }
    public void setStudentDetail(String studentDetail) {
        this.studentDetail = studentDetail;
    }
    public int getStudentID() {
        return studentID;
    }
    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }
    public Date getTravel() {
        return travel;
    }
    public void setTravel(Date travel) {
        this.travel = travel;
    }
    public int isUniversity() {
        return university;
    }
    public void setUniversity(int university) {
        this.university = university;
    }
    public int getWerbungID() {
        return werbungID;
    }
    public void setWerbungID(int werbungID) {
        this.werbungID = werbungID;
    }

    public String getAgentName() {
        return agentName;
    }
    public void setAgentName(String agentName) {
        this.agentName = agentName;
    }

    public String getStudentName() {
        return studentName;
    }
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public Date getRegistrationDate() {
        return registrationDate;
    }
    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }

    //Instance Variables
    private int agentID;
    private int werbungID;
    private int studentID;
    private int university;
    private int residence;
    private Date travel;
    private String studentDetail;

    private String agentName;
    private String studentName;
    private Date registrationDate;
}
