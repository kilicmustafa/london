package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Table;

import java.util.ArrayList;
import java.sql.ResultSet;

public class SystemUserBildTraker {

    public boolean addBild(int userID,String fileName){
        boolean b=false;
        Table table= TableManager.getTable(TableManager.RPS_SYSUSERBILD);
        try{
            String q="INSERT INTO "+table.getTableName()+"("
                    +table.getColumn(0)+","
                    +table.getColumn(1)+") VALUES('"
                    +userID+"',"
                    +this.replaceNull(fileName)+")";
            DBHelper.getInstance().updateQuery(q);
            b=true;
        }catch(Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteBild(int userID,String fileName) {
        boolean b=false;
        Table table=TableManager.getTable(TableManager.RPS_SYSUSERBILD);
        try {
            String q="DELETE FROM "+table.getTableName()+" WHERE  "
                    +table.getColumn(0)+"='"+userID+"' AND "
                    +table.getColumn(1)+"="+this.replaceNull(fileName);
            DBHelper.getInstance().updateQuery(q);
            b=true;
        } catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteBild(int userID) {
        boolean b=false;
        Table table=TableManager.getTable(TableManager.RPS_SYSUSERBILD);
        try  {
            String q="DELETE FROM "+table.getTableName()+" WHERE  "+table.getColumn(0)+"='"+userID+"'";
            DBHelper.getInstance().updateQuery(q);
            b=true;
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public ArrayList<String> getBild(int userID) {
        ArrayList<String> bild = new ArrayList<String>();
        Table table=TableManager.getTable(TableManager.RPS_SYSUSERBILD);
        try {
            String q = "SELECT "+table.getColumn(1)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+"='"
                    + userID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                bild.add((String) rs.getString("bild"));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return bild;
    }

    public boolean existsBild(int userID) {
        boolean is=false;
        Table bildTable = TableManager.getTable(TableManager.RPS_SYSUSERBILD);
        try {
            int tempBildID=0;
            String q = "SELECT "+bildTable.getColumn(0)+" FROM "
                    + bildTable.getTableName() + " WHERE "+bildTable.getColumn(0)+"="+userID;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                tempBildID=rs.getInt(bildTable.getColumn(0));
            }
            if(tempBildID>0){
                is=true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return is;
    }

    public String getError()
    {
        return error;
    }

    private void setError(String errorPara) {
        this.error=errorPara;
    }

    public Object replaceNull(Object o)
    {
        if(o == null){
            return null;
        }else{
            return "'" + o + "'";
        }
    }

    //Instance Variables
    private String error;
}
