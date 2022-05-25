package com.rheinlandprivatschule.model;

public class UserType
{

    public UserType()
    {
        this.typeID = 0;
        this.typeName = null;
    }

    //Getters

    public int getUserTypeID()
    {
        return this.typeID;
    }

    public String getUserTypeName()
    {
        return this.typeName;
    }

    //Setters

    public void setUserTypeID(int code)
    {
        this.typeID = code;
    }

    public void setUserTypeName(String code)
    {
        this.typeName = code;
    }

    //Instance Variables
    private int typeID;
    private String typeName;
}
