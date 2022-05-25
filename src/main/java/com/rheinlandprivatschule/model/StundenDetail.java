package com.rheinlandprivatschule.model;

public class StundenDetail {
    public StundenDetail(){
        stundenValue=0;
        stundenDetail=null;
    }
    public int getStundenValue() {
        return stundenValue;
    }
    public void setStundenValue(int stundenValue) {
        this.stundenValue = stundenValue;
    }

    public int getStufeValue() {
        return stufeValue;
    }
    public void setStufeValue(int stufeValue) {
        this.stufeValue = stufeValue;
    }

    public String getStundenDetail() {
        return stundenDetail;
    }
    public void setStundenDetail(String stundenDetail) {
        this.stundenDetail = stundenDetail;
    }

    //Instance Variables
    private int stundenValue;
    private int stufeValue;
    private String stundenDetail;

}
