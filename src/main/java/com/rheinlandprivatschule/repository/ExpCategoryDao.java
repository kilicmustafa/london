package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.ExpCategory;
import com.rheinlandprivatschule.model.Table;

import java.sql.*;
import java.util.Vector;

public class ExpCategoryDao {

    public boolean addExpCategory(ExpCategory expCategory) {
        boolean result = false;
        Table table= TableManager.getTable(TableManager.RPS_EXPCATEGORY);
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(1)+","+table.getColumn(2)+")VALUES("
                    + replaceNull(expCategory.getCategoryName()) + ","
                    + replaceNull(expCategory.getCategoryDesc()) + ")";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean deleteExpCategory(int expCategoryID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_EXPCATEGORY);
        try {
            String q = "DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='" + expCategoryID + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public ExpCategory getAllExpCategories(int expCategoryID) {
        ExpCategory c = new ExpCategory();
        Table table=TableManager.getTable(TableManager.RPS_EXPCATEGORY);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                    + expCategoryID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                c.setCategoryID(rs.getInt(table.getColumn(0)));
                c.setCategoryName(rs.getString(table.getColumn(1)));
                c.setCategoryDesc(rs.getString(table.getColumn(2)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return c;
    }

    public Vector<ExpCategory> getAllExpCategories() {
        Vector<ExpCategory> v = new Vector<ExpCategory>();
        Table table=TableManager.getTable(TableManager.RPS_EXPCATEGORY);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+" FROM "+table.getTableName();
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                ExpCategory c = new ExpCategory();
                c.setCategoryID(rs.getInt(table.getColumn(0)));
                c.setCategoryName(rs.getString(table.getColumn(1)));
                c.setCategoryDesc(rs.getString(table.getColumn(2)));
                v.addElement(c);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public boolean updateExpCategory(ExpCategory c) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_EXPCATEGORY);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"="
                    + replaceNull(c.getCategoryName()) + ", "+table.getColumn(2)+"="
                    + replaceNull(c.getCategoryDesc()) + " WHERE "+table.getColumn(0)+"='"
                    + c.getCategoryID() + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean canSeeAusgabeCategoryList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"8.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewAusgabeCategory(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"8.1.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateAusgabeCategory(int loginUser){
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
