package com.rheinlandprivatschule.model;

public class Sprach {
    public Sprach() {
        this.sparchID = 0;
        this.sprachName = null;
    }

    //Setters

    public void setSprachID(int code) {
        this.sparchID = code;
    }

    public void setSprachName(String code) {
        this.sprachName = code;
    }

    //Getters

    public int getSprachID() {
        return this.sparchID;
    }

    public String getSprachName() {
        return this.sprachName;
    }

    public static void main(String[] args) {
        //Sprach sprach1 = new Sprach();
    }

    //Instacne Variables
    private int sparchID;

    private String sprachName;

}
