package com.rheinlandprivatschule.model;

import java.sql.Date;

public class ResidenceMieten {

    public ResidenceMieten(){
        this.residenceID = 0;
        this.residentID = 0;
        this.mietStart = null;
        this.mietEnd = null;
    }

    public int getResidenceID() {
        return residenceID;
    }

    public int getResidentID() {
        return residentID;
    }

    public Date getMietStart() {
        return mietStart;
    }

    public Date getMietEnd() {
        return mietEnd;
    }


    public void setResidenceID(int residenceID) {
        this.residenceID = residenceID;
    }

    public void setResidentID(int residentID) {
        this.residentID = residentID;
    }

    public void setMietStart(Date mietStart) {
        this.mietStart = mietStart;
    }

    public void setMietEnd(Date mietEnd) {
        this.mietEnd = mietEnd;
    }

    // Instance Variables
    private int residenceID;
    private int residentID;
    private Date mietStart;
    private Date mietEnd;
}
