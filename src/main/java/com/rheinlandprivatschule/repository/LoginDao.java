package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.SystemUser;
import com.rheinlandprivatschule.model.Table;

import java.sql.*;
import java.util.Date;

public class LoginDao {

    public static void main(String[] args){

    }

    public LoginDao(){
        this.error=null;

        this.userID=0;
        this.loginDate=null;
        this.loginTime=null;
        this.loggedCity=0;
        this.status=0;
    }

    public boolean addLoginInformation(int userID, int status, int loggedcity){
        boolean b = false;
        Table table= TableManager.getTable(TableManager.RPS_LOGIN);
        try{
            Date d1 = new Date();
            java.sql.Date d2 = new java.sql.Date(d1.getTime());
            Time t1 = new Time(d1.getTime());
            String q =
                    "INSERT INTO "+table.getTableName()+"("+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+") VALUES('" +
                            userID + "'," + replaceNull(d2) + "," + replaceNull(t1) + ",'" +
                            status + "'," + replaceNull(loggedcity)+ ")";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean available(String login, String pass){
        boolean b = false;
        SystemUserDao sdb=new SystemUserDao();
        Table table=TableManager.getTable(TableManager.RPS_LOGIN);
        try {
            SystemUser u = sdb.loginUser(login, pass);
            System.out.println("MOA2. SystemUser u ist: " + u);
            if(u.getUserID() > 0){
                int code = 0;
                String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(3)+"='" + code + "' WHERE "+table.getColumn(0)+"='" + u.getUserID() + "'";
                DBHelper.getInstance().updateQuery(q);
                System.out.println("MOA1: " + q);
                b = true;
            }else{
                b = false;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        System.out.println("MOA3. b ist: " + b);
        return b;
    }

    public boolean getInfo(int methodUserID){
        boolean b = false;
        Table table=TableManager.getTable(TableManager.RPS_LOGIN);
        try{
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='" + methodUserID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                setUserID(rs.getInt(table.getColumn(0)));
                setLoginDate(rs.getDate(table.getColumn(1)));
                setLoginTime(rs.getTime(table.getColumn(2)));
                //setStatus(rs.getInt(table.getColumn(3)));
                setLoggedCity(rs.getInt(table.getColumn(4)));

            }
            if(this.userID == methodUserID){
                b = true;
            }else{
                b = false;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean isExist(int code){
        boolean b = false;
        try{
            if(getInfo(code)){
                b = true;
            }else{
                addLoginInformation(code, 0,0);
                if(getInfo(code)){
                    b = true;
                }else{
                    b = false;
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean login(int userid,int userloggedcity){
        boolean b = false;
        Table table=TableManager.getTable(TableManager.RPS_LOGIN);
        try{
            if(this.status == 0 && userid == this.userID){
                Date d1 = new Date();
                java.sql.Date d2 = new java.sql.Date(d1.getTime());
                Time t1 = new Time(d1.getTime());
                int code = 1;
                String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(3)+"='" + code + "', "+table.getColumn(1)+"=" + replaceNull(d2) + ", "+table.getColumn(2)+"=" + replaceNull(t1) +","+table.getColumn(4)+"='"+ userloggedcity + "'  WHERE "+table.getColumn(0)+"='" + userid + "'";
                DBHelper.getInstance().updateQuery(q);
                b = true;
            }else{
                b = false;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean changeCity(int userid,int userloggedcity){
        boolean b = false;
        Table table=TableManager.getTable(TableManager.RPS_LOGIN);
        try{
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(4)+"='"+ userloggedcity + "'  WHERE "+table.getColumn(0)+"='" + userid + "'";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean logout(int userid,int loggedcity){
        boolean b = false;
        Table table=TableManager.getTable(TableManager.RPS_LOGIN);
        try{
            int code = 0;
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(3)+"='"+code+"', "+table.getColumn(4)+"='"+loggedcity+"' WHERE "+table.getColumn(0)+"='" + userid + "'";
            DBHelper.getInstance().updateQuery(q);

            userID = 0;
            loginDate = null;
            loginTime = null;
            status = 0;
            loggedCity=0;
            b = true;
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public void setUserID(int code){
        userID = code;
    }

    public int getUerID(){
        return userID;
    }

    public void setLoginDate(java.sql.Date code){
        loginDate = code;
    }

    public java.sql.Date getLoginDate(){
        return loginDate;
    }

    public void setLoginTime(Time code){
        loginTime = code;
    }

    public Time getLoginTime(){
        return loginTime;
    }

    public void setLoggedCity(int userloggedcity){
        loggedCity=userloggedcity;
    }

    public int getLoggedCity(){
        return loggedCity;
    }

    public void setStatus(int code){
        status = code;
    }

    public int getStatus(){
        return status;
    }

    /*Utility Methods*/
    public Object replaceNull(Object o){
        if(o == null){
            return null;
        }else{
            return "'" + o + "'";
        }
    }

    public String getError(){
        return error;
    }

    public void setError(String errorString){
        error=errorString;
    }

    //Instance Variables
    private String error;

    private int userID;
    private java.sql.Date loginDate;
    private Time loginTime;
    private int loggedCity;
    private int status;

}
