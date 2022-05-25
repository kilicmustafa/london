package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Table;
import com.rheinlandprivatschule.model.Werbung;

import java.sql.*;
import java.util.Vector;


public class MesseDao {

    public boolean addMesse(Werbung w) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_MESSE);
        try {
            String q = "INSERT INTO " + table.getTableName() + "("
                    + table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+")VALUES("
                    + replaceNull(w.getMessePlace())+","
                    +replaceNull(w.getMesseCountry())+","
                    +replaceNull(w.getMesseOrg())+","
                    +replaceNull(w.getMesseDate())+","
                    +replaceNull(w.getMesseUser())+")";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteMesse(int messeID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_MESSE);
        try {
            String q = "DELETE FROM " + table.getTableName() + " WHERE "
                    + table.getColumn(0) + "='" + messeID + "'";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public Werbung getMesse(int messeID) {
        Werbung werbungClass = new Werbung();
        Table table = TableManager.getTable(TableManager.RPS_MESSE);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+" FROM "
                    + table.getTableName() + " WHERE "
                    + table.getColumn(0)+ "='" + messeID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setMesseID(rs.getInt(table.getColumn(0)));
                werbungClass.setMessePlace(rs.getString(table.getColumn(1)));
                werbungClass.setMesseCountry(rs.getString(table.getColumn(2)));
                werbungClass.setMesseOrg(rs.getString(table.getColumn(3)));
                werbungClass.setMesseDate(rs.getDate(table.getColumn(4)));
                werbungClass.setMesseUser(rs.getString(table.getColumn(5)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Vector<Werbung> getAllMesse() {
        Vector<Werbung> v = new Vector<Werbung>();
        Table table=TableManager.getTable(TableManager.RPS_MESSE);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+" FROM "
                    + table.getTableName();
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Werbung w = new Werbung();
                w.setMesseID(rs.getInt(table.getColumn(0)));
                w.setMessePlace(rs.getString(table.getColumn(1)));
                w.setMesseCountry(rs.getString(table.getColumn(2)));
                w.setMesseOrg(rs.getString(table.getColumn(3)));
                w.setMesseDate(rs.getDate(table.getColumn(4)));
                w.setMesseUser(rs.getString(table.getColumn(5)));
                v.addElement(w);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public boolean updateMesse(Werbung c){
        boolean result=false;
        Table table=TableManager.getTable(TableManager.RPS_MESSE);
        try{
            String q = "UPDATE "+table.getTableName()+" SET "
                    +table.getColumn(1)+"=" + replaceNull(c.getMessePlace()) + ", "
                    +table.getColumn(2)+"=" + replaceNull(c.getMesseCountry()) + ", "
                    +table.getColumn(3)+"=" + replaceNull(c.getMesseOrg()) + ", "
                    +table.getColumn(4)+"=" + replaceNull(c.getMesseDate()) + ", "
                    +table.getColumn(5)+"=" + replaceNull(c.getMesseUser()) + " WHERE "
                    +table.getColumn(0)+"='" + c.getMesseID() + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public boolean canSeeMesseList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"17.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewMesse(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"17.1.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateMesse(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"17.1.2");
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
