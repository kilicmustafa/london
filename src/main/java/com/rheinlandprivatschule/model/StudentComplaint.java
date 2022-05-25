package com.rheinlandprivatschule.model;

import java.sql.Date;

public class StudentComplaint {

    public StudentComplaint(
            int comStudentID,
            int studentID,
            int complaintID,
            String remarks,
            int adminID,
            int placeID,
            Date complaintDate,
            int status
    )
    {
        this.comStudentID =comStudentID;
        this.studentID =studentID;
        this.complaintID=complaintID;
        this.remarks= remarks;
        this.adminID=adminID;
        this.placeID =placeID;
        this.complaintDate =complaintDate;
        this.status=status;

    }

    public StudentComplaint(){
        this.comStudentID =0;
        this.studentID =0;
        this.complaintID=0;
        this.remarks=null;
        this.adminID=0;
        this.placeID =0;
        this.complaintDate =null;
        this.status=0;
    }

    public void setComStudentID(int comStudentID) {
        this.comStudentID = comStudentID;
    }
    public int getComStudentID() {
        return comStudentID;
    }
    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }
    public int getStudentID() {
        return studentID;
    }

    public void setComplaintID(int complaintID) {
        this.complaintID = complaintID;
    }
    public int getComplaintID() {
        return complaintID;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
    public String getRemarks() {
        return this.remarks;
    }

    public void setAdminID(int adminID) {
        this.adminID = adminID;
    }
    public int getAdminID() {
        return adminID;
    }

    public void setPlaceID(int placeID) {
        this.placeID = placeID;
    }
    public int getPlaceID() {
        return placeID;
    }

    public Date getComplaintDate(){
        return this.complaintDate;
    }
    public void setComplaintDate(Date complaintDate){
        this.complaintDate = complaintDate;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    public int getStatus() {
        return status;
    }


    //Instance Variables
    private int comStudentID;
    private int studentID;
    private int complaintID;
    private String remarks;
    private int adminID;
    private int placeID;
    private Date complaintDate;
    private int status;



}
