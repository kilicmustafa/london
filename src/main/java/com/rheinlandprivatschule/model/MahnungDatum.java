package com.rheinlandprivatschule.model;

import java.sql.Date;

public class MahnungDatum
{

    public MahnungDatum()
    {
        courseID = 0;
        userID = 0;
        datum = null;
        desc = null;
    }

    public int getUserID()
    {
        return userID;
    }
    public void setUserID(int code)
    {
        userID = code;
    }

    public int getCourseID()
    {
        return courseID;
    }
    public void setCourseID(int code)
    {
        courseID = code;
    }

    public String getDesc()
    {
        return desc;
    }
    public void setDesc(String code)
    {
        desc = code;
    }

    public Date getMahnungDate()
    {
        return datum;
    }
    public void setMahnungDate(Date code)
    {
        datum = code;
    }

    //Instance Variables
    private int userID;
    private int courseID;
    private String desc;
    private Date datum;
}
