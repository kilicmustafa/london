package com.rheinlandprivatschule.repository;

import java.sql.ResultSet;
import java.util.Vector;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.ResidenceMieten;
import com.rheinlandprivatschule.model.Table;

public class MietenDB {

    public boolean addNewMieten(ResidenceMieten residenceMieten) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_RESIDENCEMIETEN);
        try {
            String q = "INSERT INTO "+table.getTableName()+" ("+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+") VALUES ('"
                    + residenceMieten.getResidenceID()
                    + "','"
                    + residenceMieten.getResidentID()
                    + "',"
                    + replaceNull(residenceMieten.getMietStart())
                    + ","
                    + replaceNull(residenceMieten.getMietEnd())
                    + ")";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean updateResidenceMieten(ResidenceMieten residenceMieten) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_RESIDENCEMIETEN);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(2)+"="+replaceNull(residenceMieten.getMietStart())+","+table.getColumn(3)+"="+replaceNull(residenceMieten.getMietEnd())+" WHERE "+table.getColumn(0)+"='"+residenceMieten.getResidenceID()+"' AND "+table.getColumn(1)+"='"+residenceMieten.getResidentID()+"'";
            DBHelper.getInstance().updateQuery(q);
            result = false;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public Vector<ResidenceMieten> getAllResidences() {
        Vector<ResidenceMieten> residenceMietenList = new Vector<ResidenceMieten>();
        Table residencemieten_table=TableManager.getTable(TableManager.RPS_RESIDENCEMIETEN);
        try {
            String q = "SELECT "+residencemieten_table.getColumn(0)+","+residencemieten_table.getColumn(1)+","+residencemieten_table.getColumn(2)+","+residencemieten_table.getColumn(3)+" FROM "+residencemieten_table.getTableName()+" ORDER BY "+residencemieten_table.getColumn(0)+","+residencemieten_table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                ResidenceMieten residenceMieten = new ResidenceMieten();
                residenceMieten.setResidenceID(rs.getInt(residencemieten_table.getColumn(0)));
                residenceMieten.setResidentID(rs.getInt(residencemieten_table.getColumn(1)));
                residenceMieten.setMietStart(rs.getDate(residencemieten_table.getColumn(2)));
                residenceMieten.setMietEnd(rs.getDate(residencemieten_table.getColumn(3)));
                residenceMietenList.addElement(residenceMieten);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residenceMietenList;
    }

    public ResidenceMieten getResidenceMietenByMieter( int residentID) {
        ResidenceMieten residenceMieten = new ResidenceMieten();
        Table residencemieten_table=TableManager.getTable(TableManager.RPS_RESIDENCEMIETEN);
        try {
            String q = "SELECT "+residencemieten_table.getColumn(0)+","+residencemieten_table.getColumn(1)+","+residencemieten_table.getColumn(2)+","+residencemieten_table.getColumn(3)+" FROM "+residencemieten_table.getTableName()+" WHERE "+residencemieten_table.getColumn(1)+"='" + residentID+"'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                residenceMieten.setResidenceID(rs.getInt(residencemieten_table.getColumn(0)));
                residenceMieten.setResidentID(rs.getInt(residencemieten_table.getColumn(1)));
                residenceMieten.setMietStart(rs.getDate(residencemieten_table.getColumn(2)));
                residenceMieten.setMietEnd(rs.getDate(residencemieten_table.getColumn(3)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residenceMieten;
    }

    public Vector<ResidenceMieten> getResidenceMietenByResidence(int residenceID) {
        Vector<ResidenceMieten> residenceMietenList = new Vector<ResidenceMieten>();
        Table residencemieten_table= TableManager.getTable(TableManager.RPS_RESIDENCEMIETEN);
        try {
            String q = "SELECT "+residencemieten_table.getColumn(0)+","+residencemieten_table.getColumn(1)+","+residencemieten_table.getColumn(2)+","+residencemieten_table.getColumn(3)+" FROM "+residencemieten_table.getTableName()+" WHERE "+residencemieten_table.getColumn(0)+"='" + residenceID+"'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                ResidenceMieten residenceMieten = new ResidenceMieten();
                residenceMieten.setResidenceID(rs.getInt(residencemieten_table.getColumn(0)));
                residenceMieten.setResidentID(rs.getInt(residencemieten_table.getColumn(1)));
                residenceMieten.setMietStart(rs.getDate(residencemieten_table.getColumn(2)));
                residenceMieten.setMietEnd(rs.getDate(residencemieten_table.getColumn(3)));
                residenceMietenList.add(residenceMieten);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residenceMietenList;
    }

    public boolean canAddNewResidenceMieten(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"16.10");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateResidenceMieten(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"16.11");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeeResidenceMieten(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"16.12");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    /* Methods Related To Every Method */
    private void setError(String errorPara) {
        this.error=errorPara;
    }

    public String getError() {
        return error;
    }

    public Object replaceNull(Object o) {
        if (o == null) {
            return null;
        } else {
            return "'" + o + "'";
        }
    }

    // Instance Variables
    private String error;

    public static int RESIDENCEBUSY = 1;
    public static int RESIDENCEFREE = 0;
}
