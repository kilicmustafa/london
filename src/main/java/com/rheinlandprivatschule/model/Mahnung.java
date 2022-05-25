package com.rheinlandprivatschule.model;

import java.sql.Date;

public class Mahnung
{

    public Mahnung()
    {
        mahnungID = 0;
        userID = 0;
        courseID = 0;
        date = null;
        status = 0;
        adminID = 0;
        balance = 0;
    }

    public int getMahnungID()
    {
        return mahnungID;
    }
    public void setMahnungID(int code)
    {
        mahnungID = code;
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

    public double getBalance()
    {
        return balance;
    }
    public void setBalance(double code)
    {
        balance = code;
    }

    public Date getMahnngDate()
    {
        return date;
    }
    public void setMahnungDate(Date code)
    {
        date = code;
    }

    public int getStatus()
    {
        return status;
    }
    public void setStatus(int code)
    {
        status = code;
    }

    public int getAdminID()
    {
        return adminID;
    }
    public void setAdminID(int code)
    {
        adminID = code;
    }

    //Instance Variables
    private int mahnungID;
    private int userID;
    private int courseID;
    private double balance;
    private Date date;
    private int status;
    private int adminID;

}
