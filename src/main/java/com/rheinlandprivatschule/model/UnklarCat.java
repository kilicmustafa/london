package com.rheinlandprivatschule.model;

public class UnklarCat
{
    public UnklarCat()
    {
        this.catID=0;
        this.catName=null;
    }

    public void setCatID(int code)
    {
        this.catID=code;
    }
    public int getCatID()
    {
        return this.catID;
    }

    public void setCatName(String code)
    {
        this.catName=code;
    }
    public String getCatName()
    {
        return this.catName;
    }

    //Instance Variables
    private int catID;
    private String catName;
}
