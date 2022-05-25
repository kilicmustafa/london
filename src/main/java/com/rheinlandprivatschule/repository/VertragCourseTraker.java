package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Table;

import java.util.ArrayList;
import java.sql.ResultSet;

public class VertragCourseTraker {

    public boolean addVertrag(int courseID,String fileName){
        boolean b=false;
        Table table= TableManager.getTable(TableManager.RPS_COURSEVERTRAG);
        try{
            String q="INSERT INTO "+table.getTableName()+"("
                    +table.getColumn(0)+","
                    +table.getColumn(1)+") VALUES('"
                    +courseID+"',"
                    +this.replaceNull(fileName)+")";
            DBHelper.getInstance().updateQuery(q);
            b=true;
        }catch(Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteVertrag(int courseID,String fileName) {
        boolean b=false;
        Table table=TableManager.getTable(TableManager.RPS_COURSEVERTRAG);
        try {
            String q="DELETE FROM "+table.getTableName()+" WHERE  "
                    +table.getColumn(0)+"='"+courseID+"' AND "
                    +table.getColumn(1)+"="+this.replaceNull(fileName);
            DBHelper.getInstance().updateQuery(q);
            b=true;
        } catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteVertrag(int courseID) {
        boolean b=false;
        Table table=TableManager.getTable(TableManager.RPS_COURSEVERTRAG);
        try  {
            String q="DELETE FROM "+table.getTableName()+" WHERE  "+table.getColumn(0)+"='"+courseID+"'";
            DBHelper.getInstance().updateQuery(q);
            b=true;
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public ArrayList<String> getVertrags(int courseID) {
        ArrayList<String> vertrags = new ArrayList<String>();
        Table table=TableManager.getTable(TableManager.RPS_COURSEVERTRAG);
        try {
            String q = "SELECT "+table.getColumn(1)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+"='"
                    + courseID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                vertrags.add((String) rs.getString("vertrag"));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return vertrags;
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
