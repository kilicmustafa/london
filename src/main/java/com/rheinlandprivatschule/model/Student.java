package com.rheinlandprivatschule.model;


public class Student extends User {

    public Student(){
        super();
        fahrtKosten = 0.0;
    }

    //Getters


    public double getUserFahrtKosten()
    {
        return this.fahrtKosten;
    }
    //Setters

    public void setUserFahrtKosten(double code)
    {
        this.fahrtKosten = code;
    }

    private double fahrtKosten;
}