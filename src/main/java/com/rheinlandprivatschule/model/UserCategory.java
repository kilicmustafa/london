package com.rheinlandprivatschule.model;

public class UserCategory
{

    public UserCategory()
    {
        this.userCatID = 0;
        this.userCatName = null;
        this.owner = 0;
    }

    //Getters

    public int getOwner()
    {
        return this.owner;
    }

    public int getUserCategoryID()
    {
        return this.userCatID;
    }

    public String getUserCategoryName()
    {
        return this.userCatName;
    }

    //Setters

    public void setOwner(int code)
    {
        this.owner = code;
    }

    public void setUserCategoryID(int code)
    {
        this.userCatID = code;
    }

    public void setUserCategoryName(String code)
    {
        this.userCatName = code;
    }

    //Instance Variables
    private int owner;
    private int userCatID;
    private String userCatName;
}
