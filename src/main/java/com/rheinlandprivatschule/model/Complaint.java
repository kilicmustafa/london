package com.rheinlandprivatschule.model;

public class Complaint {

    public Complaint(
            int complaintID,
            String complaintName,
            int status,
            int complaintActive
    )
    {
        this.complaintID =complaintID;
        this.complaintName =complaintName;
        this.status=status;
        this.complaintActive=complaintActive;

    }

    public Complaint(){
        this.complaintID = 0;
        this.complaintName = null;
        this.status = 0;
        this.complaintActive =0;
    }

    public void setComplaintID(int complaintID) {
        this.complaintID = complaintID;
    }
    public int getComplaintID() {
        return complaintID;
    }

    public void setComplaintActive(int complaintActive) {
        this.complaintActive = complaintActive;
    }
    public int getComplaintActive() {
        return complaintActive;
    }

    public void setComplaintName(String complaintName) {
        this.complaintName = complaintName;
    }
    public String getComplaintName() {
        return this.complaintName;
    }


    public void setStatus(int status) {
        this.status = status;
    }
    public int getStatus() {
        return status;
    }


    //Instance Variables
    private int complaintID;
    private String complaintName;
    private int status;
    private int complaintActive;



}
