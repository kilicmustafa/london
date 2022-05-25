package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Table;
import com.rheinlandprivatschule.model.Werbung;

import java.sql.*;

import java.util.Vector;

public class ConsultantDao {

    public boolean addConsultant(Werbung w) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_CONSULTANT);
        try {
            String q = "INSERT INTO " + table.getTableName() + "("
                    + table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+")VALUES("
                    + replaceNull(w.getConsultantPlace())+","
                    +replaceNull(w.getConsultantCountry())+","
                    +replaceNull(w.getConsultantOrg())+","
                    +replaceNull(w.getConsultantDate())+","
                    +replaceNull(w.getConsultantUser())+")";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteConsultant(int consultantID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_CONSULTANT);
        try {
            String q = "DELETE FROM " + table.getTableName() + " WHERE "
                    + table.getColumn(0) + "='" + consultantID + "'";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public Werbung getConsultant(int consultantID) {
        Werbung werbungClass = new Werbung();
        Table table = TableManager.getTable(TableManager.RPS_CONSULTANT);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+" FROM "
                    + table.getTableName() + " WHERE "
                    + table.getColumn(0)+ "='" + consultantID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setConsultantID(rs.getInt(table.getColumn(0)));
                werbungClass.setConsultantPlace(rs.getString(table.getColumn(1)));
                werbungClass.setConsultantCountry(rs.getString(table.getColumn(2)));
                werbungClass.setConsultantOrg(rs.getString(table.getColumn(3)));
                werbungClass.setConsultantDate(rs.getDate(table.getColumn(4)));
                werbungClass.setConsultantUser(rs.getString(table.getColumn(5)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Vector<Werbung> getAllConsultant() {
        Vector<Werbung> v = new Vector<Werbung>();
        Table table=TableManager.getTable(TableManager.RPS_CONSULTANT);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+" FROM "
                    + table.getTableName() + " ORDER BY "
                    + table.getColumn(2);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Werbung w = new Werbung();
                w.setConsultantID(rs.getInt(table.getColumn(0)));
                w.setConsultantPlace(rs.getString(table.getColumn(1)));
                w.setConsultantCountry(rs.getString(table.getColumn(2)));
                w.setConsultantOrg(rs.getString(table.getColumn(3)));
                w.setConsultantDate(rs.getDate(table.getColumn(4)));
                w.setConsultantUser(rs.getString(table.getColumn(5)));
                v.addElement(w);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public boolean updateConsultant(Werbung c){
        boolean result=false;
        Table table=TableManager.getTable(TableManager.RPS_CONSULTANT);
        try{
            String q = "UPDATE "+table.getTableName()+" SET "
                    +table.getColumn(1)+"=" + replaceNull(c.getConsultantPlace()) + ", "
                    +table.getColumn(2)+"=" + replaceNull(c.getConsultantCountry()) + ", "
                    +table.getColumn(3)+"=" + replaceNull(c.getConsultantOrg()) + ", "
                    +table.getColumn(4)+"=" + replaceNull(c.getConsultantDate()) + ", "
                    +table.getColumn(5)+"=" + replaceNull(c.getConsultantUser()) + " WHERE "
                    +table.getColumn(0)+"='" + c.getConsultantID() + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public boolean canSeeConsultantList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"11.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewConsultant(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"11.1.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateConsultant(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"11.1.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    //Basic Methods//
    private Object replaceNull(Object o) {
        if (o == null) {
            return null;
        } else {
            return "'" + o + "'";
        }
    }

    private void setError(String error) {
        errorMessage = error;
    }

    public String getError() {
        return errorMessage;
    }

    //Instance Variables//
    private String errorMessage;
}
