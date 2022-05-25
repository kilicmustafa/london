package com.rheinlandprivatschule.repository;


import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Identity;
import com.rheinlandprivatschule.model.Table;

import java.sql.ResultSet;
import java.util.Vector;


public class IdentityDao {

    //public static void main(String[] args){
    //IdentityDB db = new IdentityDB();
    //identitydb db= new identitydb();
    //Vector a= db.getIdentity();
    //System.out.println(a.size());
    //}

    public boolean addIdentity(Identity identity) {
        boolean result = false;
        Table table= TableManager.getTable(TableManager.RPS_USERIDENTITY);
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(1)+")VALUES("
                    + replaceNull(identity.getUserIdentityName())  + ")";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean deleteIdentity(int identityID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_USERIDENTITY);
        try {
            String q = "DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='" + identityID + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public Identity getAllIdentities(int identityID) {
        Identity v = new Identity();
        Table table=TableManager.getTable(TableManager.RPS_USERIDENTITY);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)
                    +" FROM "+table.getTableName()
                    +" WHERE "+table.getColumn(0)+"='"+ identityID + "'"
                    +" ORDER BY " +table.getColumn(1) ;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Identity c = new Identity();
                c.setUserIdentityID(rs.getInt(table.getColumn(0)));
                c.setUserIdentityName(rs.getString(table.getColumn(1)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<Identity> getAllIdentities() {
        Vector<Identity> v = new Vector<Identity>();
        Table table=TableManager.getTable(TableManager.RPS_USERIDENTITY);
        try {
            String q = "SELECT "+table.getColumn(0)
                    +","+table.getColumn(1)
                    +" FROM "+table.getTableName()
                    +" ORDER BY " +table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Identity c = new Identity();
                c.setUserIdentityID(rs.getInt(table.getColumn(0)));
                c.setUserIdentityName(rs.getString(table.getColumn(1)));
                v.addElement(c);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public boolean updateIdentity(Identity c) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_USERIDENTITY);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"="
                    + replaceNull(c.getUserIdentityName())  + " WHERE "+table.getColumn(0)+"='"
                    + c.getUserIdentityID() + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean canSeeIdentityList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"8.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewIdentity(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"8.1.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateIdentity(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"8.1.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public Identity getIdentity(int identityID) {
        Identity u = new Identity();
        Table table=TableManager.getTable(TableManager.RPS_USERIDENTITY);
        try {
            String q = "SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+
                    " FROM "+table.getTableName()+" WHERE "
                    +table.getColumn(0)+"='"
                    + identityID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                u.setUserIdentityID(rs.getInt(table.getColumn(0)));
                u.setUserIdentityName(rs.getString(table.getColumn(1)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return u;
    }

    public int Identity(int ityID) {
        int identityID = 0;
        Table table=TableManager.getTable(TableManager.RPS_USERIDENTITY);
        try {
            String q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                    + ityID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                identityID = rs.getInt(table.getColumn(0));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return identityID;
    }

    public String getError(){
        return error;
    }

    public void setError(String errorMessage){
        error=errorMessage;
    }

    public Object replaceNull(Object o){
        if(o == null){
            return null;
        }else{
            return "'" + o + "'";
        }
    }

    //Instance Variables
    private String error;
}
