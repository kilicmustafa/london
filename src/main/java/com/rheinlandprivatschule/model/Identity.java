package com.rheinlandprivatschule.model;

public class Identity
{

    public Identity()
    {
        IdentityID = 0;
        IdentityName = null;
    }

    //Getters


    public int getUserIdentityID()
    {
        return this.IdentityID;
    }

    public String getUserIdentityName()
    {
        return this.IdentityName;
    }

    //Setters

    public void setUserIdentityID(int code)
    {
        this.IdentityID = code;
    }

    public void setUserIdentityName(String code)
    {
        this.IdentityName = code;
    }

    //Instance Variables
    private int IdentityID;
    private String IdentityName;
}
