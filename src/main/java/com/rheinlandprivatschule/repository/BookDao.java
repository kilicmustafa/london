package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.SystemUser;
import com.rheinlandprivatschule.model.Table;
import com.rheinlandprivatschule.model.UserCategory;

import java.sql.*;
import java.util.Vector;

public class BookDao {

    public static void main(String[] args){
    }

    public boolean addNewBookCategory(UserCategory uc) {
        boolean result = false;
        Table table= TableManager.getTable(TableManager.RPS_SYSTEMUSERCAT);
        try {
            String q = "INSERT INTO "+table.getTableName()+" ("+table.getColumn(1)+","+table.getColumn(2)+")VALUES("
                    + replaceNull(uc.getUserCategoryName()) + ",'"
                    + uc.getOwner() + "')";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean addUserToBook(int userID, int categoryID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_ADDRESSBOOK);
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(0)+","+table.getColumn(1)+")VALUES('"
                    + userID + "','" + categoryID + "')";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public Vector<UserCategory> getAllCategoryByOwner(int ownerID) {
        Vector<UserCategory> v = new Vector<UserCategory>();
        Table table=TableManager.getTable(TableManager.RPS_SYSTEMUSERCAT);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(2)+"='"
                    + ownerID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                UserCategory u = new UserCategory();
                u.setUserCategoryID(rs.getInt(table.getColumn(0)));
                u.setUserCategoryName(rs.getString(table.getColumn(1)));
                u.setOwner(rs.getInt(table.getColumn(2)));
                v.addElement(u);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<SystemUser> getAllUserByCategory(int categoryID) {
        Vector<SystemUser> usersList = new Vector<SystemUser>();
        Vector<String> userIDSLIST = new Vector<String>();
        SystemUserDao systemUserDB = new SystemUserDao();
        Table table=TableManager.getTable(TableManager.RPS_ADDRESSBOOK);
        try {
            String q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"
                    + categoryID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                userIDSLIST.addElement("" + rs.getInt(table.getColumn(0)));
            }
            for (int i = 0; i < userIDSLIST.size(); i++) {
                String tempUserID = (String) userIDSLIST.elementAt(i);
                SystemUser systemUser = systemUserDB.getSystemUser(Integer.parseInt(tempUserID));
                if(systemUser.getUserID()>0){
                    usersList.addElement(systemUser);
                }else{
                    removeFromAddressBook(categoryID,Integer.parseInt(tempUserID));
                }

            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return usersList;
    }

    public void removeFromAddressBook(int categoryID,int userID){
        Table table=TableManager.getTable(TableManager.RPS_ADDRESSBOOK);
        try {
            String q = "DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"
                    + categoryID + "' AND "+table.getColumn(1)+"='"+userID+"'";
            DBHelper.getInstance().updateQuery(q);
        }catch(Exception e){
            setError(e.toString());
        }
    }

    public UserCategory getCategory(int categoryID) {
        UserCategory u = new UserCategory();
        Table table=TableManager.getTable(TableManager.RPS_SYSTEMUSERCAT);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                    + categoryID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                u.setUserCategoryID(rs.getInt(table.getColumn(0)));
                u.setUserCategoryName(rs.getString(table.getColumn(1)));
                u.setOwner(rs.getInt(table.getColumn(2)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return u;
    }

    public int getUserCategory(int userID) {
        int categoryID = 0;
        Table table=TableManager.getTable(TableManager.RPS_ADDRESSBOOK);
        try {
            String q = "SELECT "+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                    + userID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                categoryID = rs.getInt(table.getColumn(1));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return categoryID;
    }

    public boolean updateBookCategory(UserCategory us) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_SYSTEMUSERCAT);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"="
                    + replaceNull(us.getUserCategoryName()) + " WHERE "+table.getColumn(0)+"='"
                    + us.getUserCategoryID() + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public int updateUserToBook(int userID, int categoryID) {
        int b = 0;
        Table table=TableManager.getTable(TableManager.RPS_ADDRESSBOOK);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"='" + categoryID
                    + "' WHERE "+table.getColumn(0)+"='" + userID + "'";
            b = DBHelper.getInstance().updateQuery(q);
            if(!(b > 0)){
                addUserToBook(userID, categoryID);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    /* Methods Related To Every Method */
    private void setError(String errorPara) {
        this.error = errorPara;
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

    //Instance Variables
    private String error;
    //	public static String SA_N="tauseef";
//	public static String SA_P="2050";
    //	public static String SA_N="moa";
//	public static String SA_P="Murat2018";
    public static String SA_N="moa";
    public static String SA_P="inCorrect123";

}
