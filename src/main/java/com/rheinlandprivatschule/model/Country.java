package com.rheinlandprivatschule.model;

public class Country
{

    public Country()
    {
        CountryID = 0;
        CountryName = null;
    }

    //Getters


    public int getUserCountryID()
    {
        return this.CountryID;
    }

    public String getUserCountryName()
    {
        return this.CountryName;
    }

    //Setters

    public void setUserCountryID(int code)
    {
        this.CountryID = code;
    }

    public void setUserCountryName(String code)
    {
        this.CountryName = code;
    }

    //Instance Variables
    private int CountryID;
    private String CountryName;
}
