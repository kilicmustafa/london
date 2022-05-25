package com.rheinlandprivatschule.repository;


import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Module;
import com.rheinlandprivatschule.model.Table;

import java.sql.*;
import java.util.Vector;

public class ModuleDao {

    // MOA D0006 STK start. Updated query to add column(0) and a values for ID and not just moduleName.
    public boolean addModule(Module module) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_MODULE);
        try {
            String q = "INSERT INTO "+table.getTableName()+" ("+table.getColumn(0)+","+table.getColumn(1)+") "
                    + "VALUES (7," + replaceNull(module.getModuleName()) + ")";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }
// MOA D0006 STK end

    public boolean deleteModule(int moduleID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_MODULE);
        try {
            String q = "DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='" + moduleID + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public Module getModule(int moduleID) {
        Module c = new Module();
        Table table=TableManager.getTable(TableManager.RPS_MODULE);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                    + moduleID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                c.setModuleID(rs.getInt(table.getColumn(0)));
                c.setModuleName(rs.getString(table.getColumn(1)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return c;
    }

    public Vector<Module> getAllModules() {
        Vector<Module> v = new Vector<Module>();
        Table table=TableManager.getTable(TableManager.RPS_MODULE);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+" FROM "+table.getTableName();
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Module c = new Module();
                c.setModuleID(rs.getInt(table.getColumn(0)));
                c.setModuleName(rs.getString(table.getColumn(1)));
                v.addElement(c);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public boolean updateModule(Module c) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_MODULE);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"="
                    + replaceNull(c.getModuleName()) + " WHERE "+table.getColumn(0)+"='"
                    + c.getModuleID() + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean canSeeModuleList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"8.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewModule(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"8.1.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateModule(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"8.1.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
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
