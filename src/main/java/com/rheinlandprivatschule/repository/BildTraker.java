package com.rheinlandprivatschule.repository;


import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Student;
import com.rheinlandprivatschule.model.Table;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Vector;


public class BildTraker {

    public boolean addBild(int studentID,String fileName){
        boolean b=false;
        Table table= TableManager.getTable(TableManager.RPS_BILDLIST);
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

    public boolean delBild() {
        boolean b=false;
        Table table=TableManager.getTable(TableManager.RPS_BILDLIST);
        try {
            String q="DELETE FROM "+table.getTableName()+" WHERE  "
                    +table.getColumn(1)+"=''";
            DBHelper.getInstance().updateQuery(q);
            b=true;
        } catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteBild(int studentID,int bildID) {
        boolean b=false;
        Table table=TableManager.getTable(TableManager.RPS_BILDLIST);
        try {
            String q="DELETE FROM "+table.getTableName()+" WHERE  "
                    +table.getColumn(0)+"='"+studentID+"' AND "
                    +table.getColumn(2)+"="+bildID;
            DBHelper.getInstance().updateQuery(q);
            b=true;
        } catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteBild(int studentID) {
        boolean b=false;
        Table table=TableManager.getTable(TableManager.RPS_BILDLIST);
        try  {
            String q="DELETE FROM "+table.getTableName()+" WHERE  "+table.getColumn(0)+"='"+studentID+"'";
            DBHelper.getInstance().updateQuery(q);
            b=true;
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public ArrayList<Student> getBild(int studentID) {
        ArrayList<Student> bild = new ArrayList<Student>();
        Table table=TableManager.getTable(TableManager.RPS_BILDLIST);
        try {
            String q = "SELECT "+table.getColumn(1)+","
                    +table.getColumn(2)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+"='"
                    + studentID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Student student = new Student();
                student.setBildName(rs.getString(table.getColumn(1)));
                student.setBildID(rs.getInt(table.getColumn(2)));
                bild.add(student);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return bild;
    }

    public boolean existsBild(int studentID) {
        boolean is=false;
        Table bildTable = TableManager.getTable(TableManager.RPS_BILDLIST);
        try {
            int tempBildID=0;
            String q = "SELECT "+bildTable.getColumn(0)+" FROM "
                    + bildTable.getTableName() + " WHERE "+bildTable.getColumn(0)+"="+studentID;
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
