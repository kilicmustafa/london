package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Table;

import java.util.ArrayList;
import java.sql.ResultSet;

public class VertragTrakerSTK {

    public boolean addVertrag(int studentID,String fileName){
        boolean b=false;
        Table table= TableManager.getTable(TableManager.RPS_VERTRAGLIST);
        try{
            String q="INSERT INTO "+table.getTableName()+"("
                    +table.getColumn(0)+","
                    +table.getColumn(1)+") VALUES('"
                    +studentID+"',"
                    +this.replaceNull(fileName)+")";
            DBHelper.getInstance().updateQuery(q);
            b=true;
        }catch(Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteVertrag(int studentID,String fileName) {
        boolean b=false;
        Table table=TableManager.getTable(TableManager.RPS_VERTRAGLIST);
        try {
            String q="DELETE FROM "+table.getTableName()+" WHERE  "
                    +table.getColumn(0)+"='"+studentID+"' AND "
                    +table.getColumn(1)+"="+this.replaceNull(fileName);
            DBHelper.getInstance().updateQuery(q);
            b=true;
        } catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteVertrag(int studentID) {
        boolean b=false;
        Table table=TableManager.getTable(TableManager.RPS_VERTRAGLIST);
        try  {
            String q="DELETE FROM "+table.getTableName()+" WHERE  "+table.getColumn(0)+"='"+studentID+"'";
            DBHelper.getInstance().updateQuery(q);
            b=true;
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public ArrayList<String> getVertrags(int studentID) {
        ArrayList<String> vertrags = new ArrayList<String>();
        Table table=TableManager.getTable(TableManager.RPS_VERTRAGLIST);
        try {
            String q = "SELECT "+table.getColumn(1)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+"='"
                    + studentID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                vertrags.add((String) rs.getString("vertrag"));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return vertrags;
    }

    public boolean existsVertrag(int studentID) {
        boolean is=false;
        Table vertragTable = TableManager.getTable(TableManager.RPS_VERTRAGLIST);
        try {
            int tempVertragID=0;
            String q = "SELECT "+vertragTable.getColumn(0)+" FROM "
                    + vertragTable.getTableName() + " WHERE "+vertragTable.getColumn(0)+"="+studentID;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                tempVertragID=rs.getInt(vertragTable.getColumn(0));
            }
            if(tempVertragID>0){
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
