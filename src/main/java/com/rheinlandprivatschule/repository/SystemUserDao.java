package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.PasswordManager;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.Vector;


public class SystemUserDao {

    public static void main(String[] args){


    }

    public boolean addContactToAddressBook(int userID, int categoryID) {
        boolean result = false;
        Table table= TableManager.getTable(TableManager.RPS_ADDRESSBOOK);
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

    public int addNewSystemUser(SystemUser user) {
        int newAdminID = 0;
        Table table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "INSERT INTO "+table.getTableName()+" ("
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+","
                    +table.getColumn(8)+","
                    +table.getColumn(9)+","
                    +table.getColumn(10)+","
                    +table.getColumn(11)+","
                    +table.getColumn(12)+","
                    +table.getColumn(13)+","
                    +table.getColumn(14)+","
                    +table.getColumn(15)+","
                    +table.getColumn(16)+","
                    +table.getColumn(17)+","
                    +table.getColumn(18)+","
                    +table.getColumn(19)+","
                    +table.getColumn(20)+","
                    +table.getColumn(21)+","
                    +table.getColumn(22)+","
                    +table.getColumn(23)+","
                    +table.getColumn(24)+") VALUES ("
                    + replaceNull(user.getUserFirstName())+ ","
                    + replaceNull(user.getUserLastName())+ ","
                    + replaceNull(user.getUserBirthDate())+ ",'"
                    + user.getUserGender()+ "',"
                    + replaceNull(user.getUserBirthPlace())+ ","
                    + replaceNull(user.getUserNationality())+ ","
                    + replaceNull(user.getUserAddress())+ ","
                    + replaceNull(user.getUserPostCode())+ ","
                    + replaceNull(user.getUserCity())+ ","
                    + replaceNull(user.getUserCountry())+ ","
                    + replaceNull(user.getUserHomePhone())+ ","
                    + replaceNull(user.getUserMobilePhone())+ ","
                    + replaceNull(user.getUserFax())+ ","
                    + replaceNull(user.getUserEmail())+ ","
                    + replaceNull(user.getUserAccountNo())+ ","
                    + replaceNull(user.getUserBLZ())+ ","
                    + replaceNull(user.getUserBankName())+ ",'"
                    + user.getUserType()+ "',"
                    + replaceNull(user.getUserLoginName())+ ","
                    + replaceNull(user.getUserPassword())+ ","
                    + replaceNull(user.getUserRemarks())+ ","
                    + user.getUserStundenLohn()+ ","
                    + replaceNull(user.getUserCompany())+ ","
                    + replaceNull(user.getUserBamfNumber()) + ")";
            DBHelper.getInstance().updateQuery(q);
            q = "SELECT LAST_INSERT_ID() AS id";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                newAdminID = rs.getInt("id");
            }
            if(newAdminID>0){
                addPlacesToUser(newAdminID,user.getUserPlaces());
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return newAdminID;
    }

    public boolean addNewUserCategory(UserCategory category) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_SYSTEMUSERCAT);
        try {
            String q = "INSERT INTO rps_usercat("+table.getColumn(1)+","+table.getColumn(2)+")VALUES("
                    + replaceNull(category.getUserCategoryName()) + ",'"
                    + category.getOwner() + "')";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public void addPlacesToUser(int userID, Vector placesList) {
        Table table=TableManager.getTable(TableManager.RPS_SYSTEMUSERPLACES);
        try {
            for (int i = 0; i < placesList.size(); i++) {
                String placeID = (String) placesList.elementAt(i);
                String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(0)+","+table.getColumn(1)+")VALUES('"
                        + userID + "','" + placeID + "')";
                DBHelper.getInstance().updateQuery(q);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
    }

    public boolean deleteUserPlace(int userid) {
        Table table=TableManager.getTable(TableManager.RPS_SYSTEMUSERPLACES);
        boolean result = false;
        try {
            String q = "DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='" + userid
                    + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public Vector<SystemUser> getAllDSHLehrerByPlace(int placeID, int userType, int categoryID) {
        Vector<SystemUser> usersList = new Vector<SystemUser>();
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        Table user_address=TableManager.getTable(TableManager.RPS_ADDRESSBOOK);
        Table user_places=TableManager.getTable(TableManager.RPS_SYSTEMUSERPLACES);
        try {
            String q = "SELECT a."+user_table.getColumn(0)+",a."
                    +user_table.getColumn(1)+",a."
                    +user_table.getColumn(2)+",a."
                    +user_table.getColumn(3)+",a."
                    +user_table.getColumn(4)+",a."
                    +user_table.getColumn(5)+",a."
                    +user_table.getColumn(6)+",a."
                    +user_table.getColumn(7)+",a."
                    +user_table.getColumn(8)+",a."
                    +user_table.getColumn(9)+",a."
                    +user_table.getColumn(10)+",a."
                    +user_table.getColumn(11)+",a."
                    +user_table.getColumn(12)+",a."
                    +user_table.getColumn(13)+",a."
                    +user_table.getColumn(14)+",a."
                    +user_table.getColumn(15)+",a."
                    +user_table.getColumn(16)+",a."
                    +user_table.getColumn(17)+",a."
                    +user_table.getColumn(18)+",a."
                    +user_table.getColumn(19)+",a."
                    +user_table.getColumn(20)+",a."
                    +user_table.getColumn(21)+",a."
                    +user_table.getColumn(22)+" FROM "
                    +user_table.getTableName()+" AS a,"
                    +user_places.getTableName()+" AS b,"
                    +user_address.getTableName()+" as c WHERE a."
                    +user_table.getColumn(18)+"='" + userType + "' AND a."
                    +user_table.getColumn(0)+"=b." +user_places.getColumn(0)+" AND b."
                    +user_places.getColumn(1)+"='"+ placeID + "' AND a."
                    +user_table.getColumn(0)+"=c."+user_address.getColumn(0)+" AND c."
                    +user_address.getColumn(1)+"='" + categoryID + "' ORDER BY a."
                    +user_table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                SystemUser u = new SystemUser();
                u.setUserID(rs.getInt(user_table.getColumn(0)));
                u.setUserFirstName(rs.getString(user_table.getColumn(1)));
                u.setUserLastName(rs.getString(user_table.getColumn(2)));
                u.setUserBirthDate(rs.getDate(user_table.getColumn(3)));
                u.setUserGender(rs.getInt(user_table.getColumn(4)));
                u.setUserBirthPlace(rs.getString(user_table.getColumn(5)));
                u.setUserNationality(rs.getString(user_table.getColumn(6)));
                u.setUserAddress(rs.getString(user_table.getColumn(7)));
                u.setUserPostCode(rs.getString(user_table.getColumn(8)));
                u.setUserCity(rs.getString(user_table.getColumn(9)));
                u.setUserCountry(rs.getString(user_table.getColumn(10)));
                u.setUserHomePhone(rs.getString(user_table.getColumn(11)));
                u.setUserMobilePhone(rs.getString(user_table.getColumn(12)));
                u.setUserFax(rs.getString(user_table.getColumn(13)));
                u.setUserEmail(rs.getString(user_table.getColumn(14)));
                u.setUserAccountNo(rs.getString(user_table.getColumn(15)));
                u.setUserBLZ(rs.getString(user_table.getColumn(16)));
                u.setUserBankName(rs.getString(user_table.getColumn(17)));
                u.setUserType(rs.getInt(user_table.getColumn(18)));
                u.setUserLoginName(rs.getString(user_table.getColumn(19)));
                u.setUserPassword(rs.getString(user_table.getColumn(20)));
                u.setUserRemarks(rs.getString(user_table.getColumn(21)));
                u.setUserStundenLohn(rs.getDouble(user_table.getColumn(22)));
                usersList.addElement(u);
            }
            for (int i = 0; i < usersList.size(); i++) {
                SystemUser temp = (SystemUser) usersList.elementAt(i);
                temp.setUserPlaces(getAllPlacesByUser(temp.getUserID()));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return usersList;
    }

    public Vector<SystemUser> getAllEmployees(int placeID, int categoryID, int categoryID1) {
        Vector<SystemUser> usersList = new Vector<SystemUser>();
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        Table user_address=TableManager.getTable(TableManager.RPS_ADDRESSBOOK);
        Table user_places=TableManager.getTable(TableManager.RPS_SYSTEMUSERPLACES);
        try {
            String q = "SELECT a."+user_table.getColumn(0)+",a."
                    +user_table.getColumn(1)+",a."
                    +user_table.getColumn(2)+",a."
                    +user_table.getColumn(3)+",a."
                    +user_table.getColumn(4)+",a."
                    +user_table.getColumn(5)+",a."
                    +user_table.getColumn(6)+",a."
                    +user_table.getColumn(7)+",a."
                    +user_table.getColumn(8)+",a."
                    +user_table.getColumn(9)+",a."
                    +user_table.getColumn(10)+",a."
                    +user_table.getColumn(11)+",a."
                    +user_table.getColumn(12)+",a."
                    +user_table.getColumn(13)+",a."
                    +user_table.getColumn(14)+",a."
                    +user_table.getColumn(15)+",a."
                    +user_table.getColumn(16)+",a."
                    +user_table.getColumn(17)+",a."
                    +user_table.getColumn(18)+",a."
                    +user_table.getColumn(19)+",a."
                    +user_table.getColumn(20)+",a."
                    +user_table.getColumn(21)+",a."
                    +user_table.getColumn(22)+" FROM "
                    +user_table.getTableName()+" AS a,"
                    +user_places.getTableName()+" AS b,"
                    +user_address.getTableName()+" as c WHERE a."
                    +user_table.getColumn(0)+"=b." +user_places.getColumn(0)+" AND b."
                    +user_places.getColumn(1)+"='"+ placeID + "' AND a."
                    +user_table.getColumn(0)+"=c."+user_address.getColumn(0)+" AND c."
                    +user_address.getColumn(1)+" IN ("+categoryID+","+categoryID1+") ORDER BY a."
                    +user_table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                SystemUser u = new SystemUser();
                u.setUserID(rs.getInt(user_table.getColumn(0)));
                u.setUserFirstName(rs.getString(user_table.getColumn(1)));
                u.setUserLastName(rs.getString(user_table.getColumn(2)));
                u.setUserBirthDate(rs.getDate(user_table.getColumn(3)));
                u.setUserGender(rs.getInt(user_table.getColumn(4)));
                u.setUserBirthPlace(rs.getString(user_table.getColumn(5)));
                u.setUserNationality(rs.getString(user_table.getColumn(6)));
                u.setUserAddress(rs.getString(user_table.getColumn(7)));
                u.setUserPostCode(rs.getString(user_table.getColumn(8)));
                u.setUserCity(rs.getString(user_table.getColumn(9)));
                u.setUserCountry(rs.getString(user_table.getColumn(10)));
                u.setUserHomePhone(rs.getString(user_table.getColumn(11)));
                u.setUserMobilePhone(rs.getString(user_table.getColumn(12)));
                u.setUserFax(rs.getString(user_table.getColumn(13)));
                u.setUserEmail(rs.getString(user_table.getColumn(14)));
                u.setUserAccountNo(rs.getString(user_table.getColumn(15)));
                u.setUserBLZ(rs.getString(user_table.getColumn(16)));
                u.setUserBankName(rs.getString(user_table.getColumn(17)));
                u.setUserType(rs.getInt(user_table.getColumn(18)));
                u.setUserLoginName(rs.getString(user_table.getColumn(19)));
                u.setUserPassword(rs.getString(user_table.getColumn(20)));
                u.setUserRemarks(rs.getString(user_table.getColumn(21)));
                u.setUserStundenLohn(rs.getDouble(user_table.getColumn(22)));
                usersList.addElement(u);
            }
            for (int i = 0; i < usersList.size(); i++) {
                SystemUser temp = (SystemUser) usersList.elementAt(i);
                temp.setUserPlaces(getAllPlacesByUser(temp.getUserID()));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return usersList;
    }

    public Vector<SystemUser> getAllLehrer(int placeID, int categoryID) {
        Vector<SystemUser> usersList = new Vector<SystemUser>();
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        Table user_address=TableManager.getTable(TableManager.RPS_ADDRESSBOOK);
        Table user_places=TableManager.getTable(TableManager.RPS_SYSTEMUSERPLACES);
        try {
            String q = "SELECT a."+user_table.getColumn(0)+",a."
                    +user_table.getColumn(1)+",a."
                    +user_table.getColumn(2)+",a."
                    +user_table.getColumn(3)+",a."
                    +user_table.getColumn(4)+",a."
                    +user_table.getColumn(5)+",a."
                    +user_table.getColumn(6)+",a."
                    +user_table.getColumn(7)+",a."
                    +user_table.getColumn(8)+",a."
                    +user_table.getColumn(9)+",a."
                    +user_table.getColumn(10)+",a."
                    +user_table.getColumn(11)+",a."
                    +user_table.getColumn(12)+",a."
                    +user_table.getColumn(13)+",a."
                    +user_table.getColumn(14)+",a."
                    +user_table.getColumn(15)+",a."
                    +user_table.getColumn(16)+",a."
                    +user_table.getColumn(17)+",a."
                    +user_table.getColumn(18)+",a."
                    +user_table.getColumn(19)+",a."
                    +user_table.getColumn(20)+",a."
                    +user_table.getColumn(21)+",a."
                    +user_table.getColumn(22)+" FROM "
                    +user_table.getTableName()+" AS a,"
                    +user_places.getTableName()+" AS b,"
                    +user_address.getTableName()+" as c WHERE a."
                    +user_table.getColumn(0)+"=b." +user_places.getColumn(0)+" AND b."
                    +user_places.getColumn(1)+"='"+ placeID + "' AND a."
                    +user_table.getColumn(0)+"=c."+user_address.getColumn(0)+" AND c."
                    +user_address.getColumn(1)+" IN ("+categoryID+") ORDER BY a."
                    +user_table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                SystemUser u = new SystemUser();
                u.setUserID(rs.getInt(user_table.getColumn(0)));
                u.setUserFirstName(rs.getString(user_table.getColumn(1)));
                u.setUserLastName(rs.getString(user_table.getColumn(2)));
                u.setUserBirthDate(rs.getDate(user_table.getColumn(3)));
                u.setUserGender(rs.getInt(user_table.getColumn(4)));
                u.setUserBirthPlace(rs.getString(user_table.getColumn(5)));
                u.setUserNationality(rs.getString(user_table.getColumn(6)));
                u.setUserAddress(rs.getString(user_table.getColumn(7)));
                u.setUserPostCode(rs.getString(user_table.getColumn(8)));
                u.setUserCity(rs.getString(user_table.getColumn(9)));
                u.setUserCountry(rs.getString(user_table.getColumn(10)));
                u.setUserHomePhone(rs.getString(user_table.getColumn(11)));
                u.setUserMobilePhone(rs.getString(user_table.getColumn(12)));
                u.setUserFax(rs.getString(user_table.getColumn(13)));
                u.setUserEmail(rs.getString(user_table.getColumn(14)));
                u.setUserAccountNo(rs.getString(user_table.getColumn(15)));
                u.setUserBLZ(rs.getString(user_table.getColumn(16)));
                u.setUserBankName(rs.getString(user_table.getColumn(17)));
                u.setUserType(rs.getInt(user_table.getColumn(18)));
                u.setUserLoginName(rs.getString(user_table.getColumn(19)));
                u.setUserPassword(rs.getString(user_table.getColumn(20)));
                u.setUserRemarks(rs.getString(user_table.getColumn(21)));
                u.setUserStundenLohn(rs.getDouble(user_table.getColumn(22)));
                usersList.addElement(u);
            }
            for (int i = 0; i < usersList.size(); i++) {
                SystemUser temp = (SystemUser) usersList.elementAt(i);
                temp.setUserPlaces(getAllPlacesByUser(temp.getUserID()));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return usersList;
    }

    public SystemUser getEmployeeForVerificaiton(int userID, int categoryID, int categoryID1,int categoryID2) {
        SystemUser u = new SystemUser();
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        Table user_address=TableManager.getTable(TableManager.RPS_ADDRESSBOOK);
        Table user_places=TableManager.getTable(TableManager.RPS_SYSTEMUSERPLACES);
        try {
            String q = "SELECT a."+user_table.getColumn(0)+",a."
                    +user_table.getColumn(1)+",a."
                    +user_table.getColumn(2)+",a."
                    +user_table.getColumn(3)+",a."
                    +user_table.getColumn(4)+",a."
                    +user_table.getColumn(5)+",a."
                    +user_table.getColumn(6)+",a."
                    +user_table.getColumn(7)+",a."
                    +user_table.getColumn(8)+",a."
                    +user_table.getColumn(9)+",a."
                    +user_table.getColumn(10)+",a."
                    +user_table.getColumn(11)+",a."
                    +user_table.getColumn(12)+",a."
                    +user_table.getColumn(13)+",a."
                    +user_table.getColumn(14)+",a."
                    +user_table.getColumn(15)+",a."
                    +user_table.getColumn(16)+",a."
                    +user_table.getColumn(17)+",a."
                    +user_table.getColumn(18)+",a."
                    +user_table.getColumn(19)+",a."
                    +user_table.getColumn(20)+",a."
                    +user_table.getColumn(21)+",a."
                    +user_table.getColumn(22)+" FROM "
                    +user_table.getTableName()+" AS a,"
                    +user_places.getTableName()+" AS b,"
                    +user_address.getTableName()+" as c WHERE a."
                    +user_table.getColumn(0)+"=b." +user_places.getColumn(0)+" AND b."
                    +user_places.getColumn(0)+"='"+ userID + "' AND a."
                    +user_table.getColumn(0)+"=c."+user_address.getColumn(0)+" AND c."
                    +user_address.getColumn(1)+" IN ("+categoryID+","+categoryID1+","+categoryID2+") ORDER BY a."
                    +user_table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                u.setUserID(rs.getInt(user_table.getColumn(0)));
                u.setUserFirstName(rs.getString(user_table.getColumn(1)));
                u.setUserLastName(rs.getString(user_table.getColumn(2)));
                u.setUserBirthDate(rs.getDate(user_table.getColumn(3)));
                u.setUserGender(rs.getInt(user_table.getColumn(4)));
                u.setUserBirthPlace(rs.getString(user_table.getColumn(5)));
                u.setUserNationality(rs.getString(user_table.getColumn(6)));
                u.setUserAddress(rs.getString(user_table.getColumn(7)));
                u.setUserPostCode(rs.getString(user_table.getColumn(8)));
                u.setUserCity(rs.getString(user_table.getColumn(9)));
                u.setUserCountry(rs.getString(user_table.getColumn(10)));
                u.setUserHomePhone(rs.getString(user_table.getColumn(11)));
                u.setUserMobilePhone(rs.getString(user_table.getColumn(12)));
                u.setUserFax(rs.getString(user_table.getColumn(13)));
                u.setUserEmail(rs.getString(user_table.getColumn(14)));
                u.setUserAccountNo(rs.getString(user_table.getColumn(15)));
                u.setUserBLZ(rs.getString(user_table.getColumn(16)));
                u.setUserBankName(rs.getString(user_table.getColumn(17)));
                u.setUserType(rs.getInt(user_table.getColumn(18)));
                u.setUserLoginName(rs.getString(user_table.getColumn(19)));
                u.setUserPassword(rs.getString(user_table.getColumn(20)));
                u.setUserRemarks(rs.getString(user_table.getColumn(21)));
                u.setUserStundenLohn(rs.getDouble(user_table.getColumn(22)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return u;
    }


    public Vector<String> getAllPlacesByUser(int userID) {
        Vector<String> result = new Vector<String>();
        Table table=TableManager.getTable(TableManager.RPS_PLACE);
        Table userplaces=TableManager.getTable(TableManager.RPS_SYSTEMUSERPLACES);
        try {
            String q = "SELECT a."+table.getColumn(0)+" FROM "+table.getTableName()+" as a,"+userplaces.getTableName()+" as b WHERE a."+table.getColumn(0)+"=b."+userplaces.getColumn(1)+" AND b."+userplaces.getColumn(0)+"='"
                    + userID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                int placeID=rs.getInt(table.getColumn(0));
                result.addElement(placeID+"");
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }


    public Vector<SystemUser> getAllSystemUser(int userType) {
        Vector<SystemUser> usersList = new Vector<SystemUser>();
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "";
            if (userType == 0) {
                q = "SELECT "+user_table.getColumn(0)+","+user_table.getColumn(1)+","+user_table.getColumn(2)+","+user_table.getColumn(3)+","+user_table.getColumn(4)+","+user_table.getColumn(5)+","+user_table.getColumn(6)+","+user_table.getColumn(7)+","+user_table.getColumn(8)+","+user_table.getColumn(9)+","+user_table.getColumn(10)+","+user_table.getColumn(11)+","+user_table.getColumn(12)+","+user_table.getColumn(13)+","+user_table.getColumn(14)+","+user_table.getColumn(15)+","+user_table.getColumn(16)+","+user_table.getColumn(17)+","+user_table.getColumn(18)+","+user_table.getColumn(19)+","+user_table.getColumn(20)+","+user_table.getColumn(21)+","+user_table.getColumn(22)+" FROM "+user_table.getTableName()+" WHERE "+user_table.getColumn(18)+"!=5 ORDER BY "+user_table.getColumn(1);
            } else if (userType > 0) {
                q = "SELECT "+user_table.getColumn(0)+","+user_table.getColumn(1)+","+user_table.getColumn(2)+","+user_table.getColumn(3)+","+user_table.getColumn(4)+","+user_table.getColumn(5)+","+user_table.getColumn(6)+","+user_table.getColumn(7)+","+user_table.getColumn(8)+","+user_table.getColumn(9)+","+user_table.getColumn(10)+","+user_table.getColumn(11)+","+user_table.getColumn(12)+","+user_table.getColumn(13)+","+user_table.getColumn(14)+","+user_table.getColumn(15)+","+user_table.getColumn(16)+","+user_table.getColumn(17)+","+user_table.getColumn(18)+","+user_table.getColumn(19)+","+user_table.getColumn(20)+","+user_table.getColumn(21)+","+user_table.getColumn(22)+" FROM "+user_table.getTableName()+" WHERE "+user_table.getColumn(18)+"='"
                        + userType + "' ORDER BY "+user_table.getColumn(1);
            }
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                SystemUser u = new SystemUser();
                u.setUserID(rs.getInt(user_table.getColumn(0)));
                u.setUserFirstName(rs.getString(user_table.getColumn(1)));
                u.setUserLastName(rs.getString(user_table.getColumn(2)));
                u.setUserBirthDate(rs.getDate(user_table.getColumn(3)));
                u.setUserGender(rs.getInt(user_table.getColumn(4)));
                u.setUserBirthPlace(rs.getString(user_table.getColumn(5)));
                u.setUserNationality(rs.getString(user_table.getColumn(6)));
                u.setUserAddress(rs.getString(user_table.getColumn(7)));
                u.setUserPostCode(rs.getString(user_table.getColumn(8)));
                u.setUserCity(rs.getString(user_table.getColumn(9)));
                u.setUserCountry(rs.getString(user_table.getColumn(10)));
                u.setUserHomePhone(rs.getString(user_table.getColumn(11)));
                u.setUserMobilePhone(rs.getString(user_table.getColumn(12)));
                u.setUserFax(rs.getString(user_table.getColumn(13)));
                u.setUserEmail(rs.getString(user_table.getColumn(14)));
                u.setUserAccountNo(rs.getString(user_table.getColumn(15)));
                u.setUserBLZ(rs.getString(user_table.getColumn(16)));
                u.setUserBankName(rs.getString(user_table.getColumn(17)));
                u.setUserType(rs.getInt(user_table.getColumn(18)));
                u.setUserLoginName(rs.getString(user_table.getColumn(19)));
                u.setUserPassword(rs.getString(user_table.getColumn(20)));
                u.setUserRemarks(rs.getString(user_table.getColumn(21)));
                u.setUserStundenLohn(rs.getDouble(user_table.getColumn(22)));
                usersList.addElement(u);
            }
            for (int i = 0; i < usersList.size(); i++) {
                SystemUser temp = (SystemUser) usersList.elementAt(i);
                temp.setUserPlaces(getAllPlacesByUser(temp.getUserID()));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return usersList;
    }


    public Vector<SystemUser> getAllSystemUserByCategory(int categoryID) {
        Vector<SystemUser> usersList = new Vector<SystemUser>();
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        Table user_address=TableManager.getTable(TableManager.RPS_ADDRESSBOOK);
        try {
            String q = "SELECT a."+user_table.getColumn(0)+",a."+user_table.getColumn(1)+",a."+user_table.getColumn(2)+",a."+user_table.getColumn(3)+",a."+user_table.getColumn(4)+",a."+user_table.getColumn(5)+",a."+user_table.getColumn(6)+",a."+user_table.getColumn(7)+",a."+user_table.getColumn(8)+",a."+user_table.getColumn(9)+",a."+user_table.getColumn(10)+",a."+user_table.getColumn(11)+",a."+user_table.getColumn(12)+",a."+user_table.getColumn(13)+",a."+user_table.getColumn(14)+",a."+user_table.getColumn(15)+",a."+user_table.getColumn(16)+",a."+user_table.getColumn(17)+",a."+user_table.getColumn(18)+",a."+user_table.getColumn(19)+",a."+user_table.getColumn(20)+",a."+user_table.getColumn(21)+",a."+user_table.getColumn(22)+" FROM "+user_table.getTableName()+" As a,"+user_address.getTableName()+" AS b WHERE a."+user_table.getColumn(0)+"=b."+user_address.getColumn(0)+" AND b."+user_address.getColumn(1)+"='"
                    + categoryID + "' ORDER BY "+user_table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                SystemUser u = new SystemUser();
                u.setUserID(rs.getInt(user_table.getColumn(0)));
                u.setUserFirstName(rs.getString(user_table.getColumn(1)));
                u.setUserLastName(rs.getString(user_table.getColumn(2)));
                u.setUserBirthDate(rs.getDate(user_table.getColumn(3)));
                u.setUserGender(rs.getInt(user_table.getColumn(4)));
                u.setUserBirthPlace(rs.getString(user_table.getColumn(5)));
                u.setUserNationality(rs.getString(user_table.getColumn(6)));
                u.setUserAddress(rs.getString(user_table.getColumn(7)));
                u.setUserPostCode(rs.getString(user_table.getColumn(8)));
                u.setUserCity(rs.getString(user_table.getColumn(9)));
                u.setUserCountry(rs.getString(user_table.getColumn(10)));
                u.setUserHomePhone(rs.getString(user_table.getColumn(11)));
                u.setUserMobilePhone(rs.getString(user_table.getColumn(12)));
                u.setUserFax(rs.getString(user_table.getColumn(13)));
                u.setUserEmail(rs.getString(user_table.getColumn(14)));
                u.setUserAccountNo(rs.getString(user_table.getColumn(15)));
                u.setUserBLZ(rs.getString(user_table.getColumn(16)));
                u.setUserBankName(rs.getString(user_table.getColumn(17)));
                u.setUserType(rs.getInt(user_table.getColumn(18)));
                u.setUserLoginName(rs.getString(user_table.getColumn(19)));
                u.setUserPassword(rs.getString(user_table.getColumn(20)));
                u.setUserRemarks(rs.getString(user_table.getColumn(21)));
                u.setUserStundenLohn(rs.getDouble(user_table.getColumn(22)));
                usersList.addElement(u);
            }
            for (int i = 0; i < usersList.size(); i++) {
                SystemUser temp = (SystemUser) usersList.elementAt(i);
                temp.setUserPlaces(getAllPlacesByUser(temp.getUserID()));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return usersList;
    }


    public Vector<SystemUser> searchSystemUsersByCriteria(int criteria,String keyword,boolean all) {
        Vector<SystemUser> usersList = new Vector<SystemUser>();
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String without="(0)";
            if(!all){
                without=getUsersOtherThanX();
            }
            String q="";
            if(criteria==1){
                //Vorname
                q = "SELECT "+user_table.getColumn(0)+","+user_table.getColumn(1)+","+user_table.getColumn(2)+","+user_table.getColumn(3)+","+user_table.getColumn(4)+","+user_table.getColumn(5)+","+user_table.getColumn(6)+","+user_table.getColumn(7)+","+user_table.getColumn(8)+","+user_table.getColumn(9)+","+user_table.getColumn(10)+","+user_table.getColumn(11)+","+user_table.getColumn(12)+","+user_table.getColumn(13)+","+user_table.getColumn(14)+","+user_table.getColumn(15)+","+user_table.getColumn(16)+","+user_table.getColumn(17)+","+user_table.getColumn(18)+","+user_table.getColumn(19)+","+user_table.getColumn(20)+","+user_table.getColumn(21)+","+user_table.getColumn(22)+" FROM "+user_table.getTableName()+" WHERE "+user_table.getColumn(1)+" LIKE '%"+keyword+"%' AND "+user_table.getColumn(0)+" NOT IN "+without+" ORDER BY "+user_table.getColumn(1);
            }else if(criteria==2){
                //Nachname
                q = "SELECT "+user_table.getColumn(0)+","+user_table.getColumn(1)+","+user_table.getColumn(2)+","+user_table.getColumn(3)+","+user_table.getColumn(4)+","+user_table.getColumn(5)+","+user_table.getColumn(6)+","+user_table.getColumn(7)+","+user_table.getColumn(8)+","+user_table.getColumn(9)+","+user_table.getColumn(10)+","+user_table.getColumn(11)+","+user_table.getColumn(12)+","+user_table.getColumn(13)+","+user_table.getColumn(14)+","+user_table.getColumn(15)+","+user_table.getColumn(16)+","+user_table.getColumn(17)+","+user_table.getColumn(18)+","+user_table.getColumn(19)+","+user_table.getColumn(20)+","+user_table.getColumn(21)+","+user_table.getColumn(22)+" FROM "+user_table.getTableName()+" WHERE "+user_table.getColumn(2)+" LIKE '%"+keyword+"%' AND "+user_table.getColumn(0)+" NOT IN "+without+" ORDER BY "+user_table.getColumn(1);
            }

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                SystemUser u = new SystemUser();
                u.setUserID(rs.getInt(user_table.getColumn(0)));
                u.setUserFirstName(rs.getString(user_table.getColumn(1)));
                u.setUserLastName(rs.getString(user_table.getColumn(2)));
                u.setUserBirthDate(rs.getDate(user_table.getColumn(3)));
                u.setUserGender(rs.getInt(user_table.getColumn(4)));
                u.setUserBirthPlace(rs.getString(user_table.getColumn(5)));
                u.setUserNationality(rs.getString(user_table.getColumn(6)));
                u.setUserAddress(rs.getString(user_table.getColumn(7)));
                u.setUserPostCode(rs.getString(user_table.getColumn(8)));
                u.setUserCity(rs.getString(user_table.getColumn(9)));
                u.setUserCountry(rs.getString(user_table.getColumn(10)));
                u.setUserHomePhone(rs.getString(user_table.getColumn(11)));
                u.setUserMobilePhone(rs.getString(user_table.getColumn(12)));
                u.setUserFax(rs.getString(user_table.getColumn(13)));
                u.setUserEmail(rs.getString(user_table.getColumn(14)));
                u.setUserAccountNo(rs.getString(user_table.getColumn(15)));
                u.setUserBLZ(rs.getString(user_table.getColumn(16)));
                u.setUserBankName(rs.getString(user_table.getColumn(17)));
                u.setUserType(rs.getInt(user_table.getColumn(18)));
                u.setUserLoginName(rs.getString(user_table.getColumn(19)));
                u.setUserPassword(rs.getString(user_table.getColumn(20)));
                u.setUserRemarks(rs.getString(user_table.getColumn(21)));
                u.setUserStundenLohn(rs.getDouble(user_table.getColumn(22)));
                usersList.addElement(u);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return usersList;
    }

    public boolean isSystemUserOfThisCategory(int systemUserID,int categoryID) {
        boolean result=false;
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        Table user_address=TableManager.getTable(TableManager.RPS_ADDRESSBOOK);
        try {
            int tempSystemUserID=0;
            String q = "SELECT a."+user_table.getColumn(0)+" FROM "+user_table.getTableName()+" As a,"+user_address.getTableName()+" AS b WHERE a."+user_table.getColumn(0)+"='"+systemUserID+"' AND a."+user_table.getColumn(0)+"=b."+user_address.getColumn(0)+" AND b."+user_address.getColumn(1)+"='"+ categoryID+"'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                tempSystemUserID=rs.getInt(user_table.getColumn(0));
            }
            if(tempSystemUserID==systemUserID){
                result=true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public Vector<SystemUser> getAllSystemUserByPlace(int placeid, int usertype) {
        Vector<SystemUser> usersList = new Vector<SystemUser>();
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        Table user_places=TableManager.getTable(TableManager.RPS_SYSTEMUSERPLACES);
        try {
            String q = "";
            if (usertype == 0) {
                q = "SELECT a."+user_table.getColumn(0)+",a."+user_table.getColumn(1)+",a."+user_table.getColumn(2)+",a."+user_table.getColumn(3)+",a."+user_table.getColumn(4)+",a."+user_table.getColumn(5)+",a."+user_table.getColumn(6)+",a."+user_table.getColumn(7)+",a."+user_table.getColumn(8)+",a."+user_table.getColumn(9)+",a."+user_table.getColumn(10)+",a."+user_table.getColumn(11)+",a."+user_table.getColumn(12)+",a."+user_table.getColumn(13)+",a."+user_table.getColumn(14)+",a."+user_table.getColumn(15)+",a."+user_table.getColumn(16)+",a."+user_table.getColumn(17)+",a."+user_table.getColumn(18)+",a."+user_table.getColumn(19)+",a."+user_table.getColumn(20)+",a."+user_table.getColumn(21)+",a."+user_table.getColumn(22)+" FROM "+user_table.getTableName()+" As a,"+user_places.getTableName()+" AS b WHERE a."+user_table.getColumn(18)+"!=5 AND a."+user_table.getColumn(0)+"=b."+user_places.getColumn(0)+" AND b."+user_places.getColumn(1)+"='"
                        + placeid + "' ORDER BY "+user_table.getColumn(1);
            } else if (usertype > 0) {
                q = "SELECT a."+user_table.getColumn(0)+",a."+user_table.getColumn(1)+",a."+user_table.getColumn(2)+",a."+user_table.getColumn(3)+",a."+user_table.getColumn(4)+",a."+user_table.getColumn(5)+",a."+user_table.getColumn(6)+",a."+user_table.getColumn(7)+",a."+user_table.getColumn(8)+",a."+user_table.getColumn(9)+",a."+user_table.getColumn(10)+",a."+user_table.getColumn(11)+",a."+user_table.getColumn(12)+",a."+user_table.getColumn(13)+",a."+user_table.getColumn(14)+",a."+user_table.getColumn(15)+",a."+user_table.getColumn(16)+",a."+user_table.getColumn(17)+",a."+user_table.getColumn(18)+",a."+user_table.getColumn(19)+",a."+user_table.getColumn(20)+",a."+user_table.getColumn(21)+",a."+user_table.getColumn(22)+" FROM "+user_table.getTableName()+" AS a,"+user_places.getTableName()+" AS b WHERE a."+user_table.getColumn(18)+"='"
                        + usertype
                        + "' AND a."+user_table.getColumn(0)+"=b."+user_places.getColumn(0)+" AND b."+user_places.getColumn(1)+"='"
                        + placeid + "' ORDER BY "+user_table.getColumn(1);
            }
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                SystemUser u = new SystemUser();
                u.setUserID(rs.getInt(user_table.getColumn(0)));
                u.setUserFirstName(rs.getString(user_table.getColumn(1)));
                u.setUserLastName(rs.getString(user_table.getColumn(2)));
                u.setUserBirthDate(rs.getDate(user_table.getColumn(3)));
                u.setUserGender(rs.getInt(user_table.getColumn(4)));
                u.setUserBirthPlace(rs.getString(user_table.getColumn(5)));
                u.setUserNationality(rs.getString(user_table.getColumn(6)));
                u.setUserAddress(rs.getString(user_table.getColumn(7)));
                u.setUserPostCode(rs.getString(user_table.getColumn(8)));
                u.setUserCity(rs.getString(user_table.getColumn(9)));
                u.setUserCountry(rs.getString(user_table.getColumn(10)));
                u.setUserHomePhone(rs.getString(user_table.getColumn(11)));
                u.setUserMobilePhone(rs.getString(user_table.getColumn(12)));
                u.setUserFax(rs.getString(user_table.getColumn(13)));
                u.setUserEmail(rs.getString(user_table.getColumn(14)));
                u.setUserAccountNo(rs.getString(user_table.getColumn(15)));
                u.setUserBLZ(rs.getString(user_table.getColumn(16)));
                u.setUserBankName(rs.getString(user_table.getColumn(17)));
                u.setUserType(rs.getInt(user_table.getColumn(18)));
                u.setUserLoginName(rs.getString(user_table.getColumn(19)));
                u.setUserPassword(rs.getString(user_table.getColumn(20)));
                u.setUserRemarks(rs.getString(user_table.getColumn(21)));
                u.setUserStundenLohn(rs.getDouble(user_table.getColumn(22)));
                usersList.addElement(u);
            }
            for (int i = 0; i < usersList.size(); i++) {
                SystemUser temp = (SystemUser) usersList.elementAt(i);
                temp.setUserPlaces(getAllPlacesByUser(temp.getUserID()));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return usersList;
    }

    public String getUsersOtherThanX(){
        String result="(0";
        Table table=TableManager.getTable(TableManager.RPS_ADDRESSBOOK);
        try{
            String q="SELECT "+table.getColumn(0)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='5'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                result=result+","+rs.getInt(table.getColumn(0));
            }
            result=result+")";
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public Vector<SystemUser> getAllSystemUserWOTeacher() {
        Vector<SystemUser> usersList = new Vector<SystemUser>();
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        Table tran_table=TableManager.getTable(TableManager.RPS_TRAN);
        try {
            String q = "SELECT distinct a."+user_table.getColumn(0)+",a."
                    +user_table.getColumn(1)+",a."
                    +user_table.getColumn(2)+",a."
                    +user_table.getColumn(3)+",a."
                    +user_table.getColumn(4)+",a."
                    +user_table.getColumn(5)+",a."
                    +user_table.getColumn(6)+",a."
                    +user_table.getColumn(7)+",a."
                    +user_table.getColumn(8)+",a."
                    +user_table.getColumn(9)+",a."
                    +user_table.getColumn(10)+",a."
                    +user_table.getColumn(11)+",a."
                    +user_table.getColumn(12)+",a."
                    +user_table.getColumn(13)+",a."
                    +user_table.getColumn(14)+",a."
                    +user_table.getColumn(15)+",a."
                    +user_table.getColumn(16)+",a."
                    +user_table.getColumn(17)+",a."
                    +user_table.getColumn(18)+",a."
                    +user_table.getColumn(19)+",a."
                    +user_table.getColumn(20)+",a."
                    +user_table.getColumn(21)+",a."
                    +user_table.getColumn(22)+" FROM "
                    +user_table.getTableName()+" As a,"
                    +tran_table.getTableName()+" AS b WHERE a."
                    +user_table.getColumn(18)+"!=5 AND a."
                    +user_table.getColumn(18)+"!=4 AND b."
                    +tran_table.getColumn(7)+"=a."+user_table.getColumn(0)+" AND b."
                    +tran_table.getColumn(2)+">= DATE_ADD(curdate(), INTERVAL -3 month) ORDER BY a."
                    +user_table.getColumn(1);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                SystemUser u = new SystemUser();
                u.setUserID(rs.getInt(user_table.getColumn(0)));
                u.setUserFirstName(rs.getString(user_table.getColumn(1)));
                u.setUserLastName(rs.getString(user_table.getColumn(2)));
                u.setUserBirthDate(rs.getDate(user_table.getColumn(3)));
                u.setUserGender(rs.getInt(user_table.getColumn(4)));
                u.setUserBirthPlace(rs.getString(user_table.getColumn(5)));
                u.setUserNationality(rs.getString(user_table.getColumn(6)));
                u.setUserAddress(rs.getString(user_table.getColumn(7)));
                u.setUserPostCode(rs.getString(user_table.getColumn(8)));
                u.setUserCity(rs.getString(user_table.getColumn(9)));
                u.setUserCountry(rs.getString(user_table.getColumn(10)));
                u.setUserHomePhone(rs.getString(user_table.getColumn(11)));
                u.setUserMobilePhone(rs.getString(user_table.getColumn(12)));
                u.setUserFax(rs.getString(user_table.getColumn(13)));
                u.setUserEmail(rs.getString(user_table.getColumn(14)));
                u.setUserAccountNo(rs.getString(user_table.getColumn(15)));
                u.setUserBLZ(rs.getString(user_table.getColumn(16)));
                u.setUserBankName(rs.getString(user_table.getColumn(17)));
                u.setUserType(rs.getInt(user_table.getColumn(18)));
                u.setUserLoginName(rs.getString(user_table.getColumn(19)));
                u.setUserPassword(rs.getString(user_table.getColumn(20)));
                u.setUserRemarks(rs.getString(user_table.getColumn(21)));
                u.setUserStundenLohn(rs.getDouble(user_table.getColumn(22)));
                usersList.addElement(u);
            }

            for (int i = 0; i < usersList.size(); i++) {
                SystemUser temp = (SystemUser) usersList.elementAt(i);
                temp.setUserPlaces(getAllPlacesByUser(temp.getUserID()));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return usersList;
    }

    public Vector<SystemUser> getAllSystemUserWOTeacherAll() {
        Vector<SystemUser> usersList = new Vector<SystemUser>();
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "SELECT "+user_table.getColumn(0)+","
                    +user_table.getColumn(1)+","
                    +user_table.getColumn(2)+","
                    +user_table.getColumn(3)+","
                    +user_table.getColumn(4)+","
                    +user_table.getColumn(5)+","
                    +user_table.getColumn(6)+","
                    +user_table.getColumn(7)+","
                    +user_table.getColumn(8)+","
                    +user_table.getColumn(9)+","
                    +user_table.getColumn(10)+","
                    +user_table.getColumn(11)+","
                    +user_table.getColumn(12)+","
                    +user_table.getColumn(13)+","
                    +user_table.getColumn(14)+","
                    +user_table.getColumn(15)+","
                    +user_table.getColumn(16)+","
                    +user_table.getColumn(17)+","
                    +user_table.getColumn(18)+","
                    +user_table.getColumn(19)+","
                    +user_table.getColumn(20)+","
                    +user_table.getColumn(21)+","
                    +user_table.getColumn(22)+" FROM "
                    +user_table.getTableName()+" WHERE "
                    +user_table.getColumn(18)+"!=5 AND "+user_table.getColumn(18)+"!=4 ORDER BY "
                    +user_table.getColumn(1);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                SystemUser u = new SystemUser();
                u.setUserID(rs.getInt(user_table.getColumn(0)));
                u.setUserFirstName(rs.getString(user_table.getColumn(1)));
                u.setUserLastName(rs.getString(user_table.getColumn(2)));
                u.setUserBirthDate(rs.getDate(user_table.getColumn(3)));
                u.setUserGender(rs.getInt(user_table.getColumn(4)));
                u.setUserBirthPlace(rs.getString(user_table.getColumn(5)));
                u.setUserNationality(rs.getString(user_table.getColumn(6)));
                u.setUserAddress(rs.getString(user_table.getColumn(7)));
                u.setUserPostCode(rs.getString(user_table.getColumn(8)));
                u.setUserCity(rs.getString(user_table.getColumn(9)));
                u.setUserCountry(rs.getString(user_table.getColumn(10)));
                u.setUserHomePhone(rs.getString(user_table.getColumn(11)));
                u.setUserMobilePhone(rs.getString(user_table.getColumn(12)));
                u.setUserFax(rs.getString(user_table.getColumn(13)));
                u.setUserEmail(rs.getString(user_table.getColumn(14)));
                u.setUserAccountNo(rs.getString(user_table.getColumn(15)));
                u.setUserBLZ(rs.getString(user_table.getColumn(16)));
                u.setUserBankName(rs.getString(user_table.getColumn(17)));
                u.setUserType(rs.getInt(user_table.getColumn(18)));
                u.setUserLoginName(rs.getString(user_table.getColumn(19)));
                u.setUserPassword(rs.getString(user_table.getColumn(20)));
                u.setUserRemarks(rs.getString(user_table.getColumn(21)));
                u.setUserStundenLohn(rs.getDouble(user_table.getColumn(22)));
                usersList.addElement(u);
            }

            for (int i = 0; i < usersList.size(); i++) {
                SystemUser temp = (SystemUser) usersList.elementAt(i);
                temp.setUserPlaces(getAllPlacesByUser(temp.getUserID()));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return usersList;
    }

    public Vector<UserCategory> getAllUserCategories(int ownerID) {
        Vector<UserCategory> v = new Vector<UserCategory>();
        Table table=TableManager.getTable(TableManager.RPS_SYSTEMUSERCAT);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(2)+"='"
                    + ownerID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                UserCategory cat = new UserCategory();
                cat.setUserCategoryID(rs.getInt(table.getColumn(0)));
                cat.setUserCategoryName(rs.getString(table.getColumn(1)));
                cat.setOwner(rs.getInt(table.getColumn(2)));
                v.addElement(cat);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<UserType> getAllUserTypes() {
        Vector<UserType> v = new Vector<UserType>();
        Table table=TableManager.getTable(TableManager.RPS_SYSTEMUSERTYPE);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+" FROM "+table.getTableName();
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                UserType ut = new UserType();
                ut.setUserTypeID(rs.getInt("typeID"));
                ut.setUserTypeName(rs.getString("typeName"));
                v.addElement(ut);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public SystemUser getSystemUser(int userID) {
        SystemUser u = new SystemUser();
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "SELECT "+user_table.getColumn(0)+","
                    +user_table.getColumn(1)+","
                    +user_table.getColumn(2)+","
                    +user_table.getColumn(3)+","
                    +user_table.getColumn(4)+","
                    +user_table.getColumn(5)+","
                    +user_table.getColumn(6)+","
                    +user_table.getColumn(7)+","
                    +user_table.getColumn(8)+","
                    +user_table.getColumn(9)+","
                    +user_table.getColumn(10)+","
                    +user_table.getColumn(11)+","
                    +user_table.getColumn(12)+","
                    +user_table.getColumn(13)+","
                    +user_table.getColumn(14)+","
                    +user_table.getColumn(15)+","
                    +user_table.getColumn(16)+","
                    +user_table.getColumn(17)+","
                    +user_table.getColumn(18)+","
                    +user_table.getColumn(19)+","
                    +user_table.getColumn(20)+","
                    +user_table.getColumn(21)+","
                    +user_table.getColumn(22)+","
                    +user_table.getColumn(23)+","
                    +user_table.getColumn(24)+" FROM "
                    +user_table.getTableName()+" WHERE "
                    +user_table.getColumn(0)+"='"+ userID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                u.setUserID(rs.getInt(user_table.getColumn(0)));
                u.setUserFirstName(rs.getString(user_table.getColumn(1)));
                u.setUserLastName(rs.getString(user_table.getColumn(2)));
                u.setUserBirthDate(rs.getDate(user_table.getColumn(3)));
                u.setUserGender(rs.getInt(user_table.getColumn(4)));
                u.setUserBirthPlace(rs.getString(user_table.getColumn(5)));
                u.setUserNationality(rs.getString(user_table.getColumn(6)));
                u.setUserAddress(rs.getString(user_table.getColumn(7)));
                u.setUserPostCode(rs.getString(user_table.getColumn(8)));
                u.setUserCity(rs.getString(user_table.getColumn(9)));
                u.setUserCountry(rs.getString(user_table.getColumn(10)));
                u.setUserHomePhone(rs.getString(user_table.getColumn(11)));
                u.setUserMobilePhone(rs.getString(user_table.getColumn(12)));
                u.setUserFax(rs.getString(user_table.getColumn(13)));
                u.setUserEmail(rs.getString(user_table.getColumn(14)));
                u.setUserAccountNo(rs.getString(user_table.getColumn(15)));
                u.setUserBLZ(rs.getString(user_table.getColumn(16)));
                u.setUserBankName(rs.getString(user_table.getColumn(17)));
                u.setUserType(rs.getInt(user_table.getColumn(18)));
                u.setUserLoginName(rs.getString(user_table.getColumn(19)));
                u.setUserPassword(rs.getString(user_table.getColumn(20)));
                u.setUserRemarks(rs.getString(user_table.getColumn(21)));
                u.setUserStundenLohn(rs.getDouble(user_table.getColumn(22)));
                u.setUserCompany(rs.getString(user_table.getColumn(23)));
                u.setUserBamfNumber(rs.getString(user_table.getColumn(24)));
            }
            u.setUserPlaces(getAllPlacesByUser(u.getUserID()));
        } catch (Exception e) {
            setError(e.toString());
        }
        return u;
    }

    public boolean isLoginNameExist(String loginName) {
        boolean b = false;
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String query = "SELECT "+user_table.getColumn(19)+" FROM "+user_table.getTableName()+" WHERE "+user_table.getColumn(19)+"='"
                    + loginName + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(query);
            while (rs.next()) {
                String name = rs.getString(user_table.getColumn(19));
                if (name.equalsIgnoreCase(loginName)) {
                    b = true;
                }
            }
        } catch (Exception e) {
            setError(e.toString());
            b = true;
        }
        return b;
    }

    public boolean isPlaceMatch(Vector placesList, int placeID) {
        boolean b = false;
        for (int i = 0; i < placesList.size(); i++) {
            String temp = (String) placesList.elementAt(i);
            if (Integer.parseInt(temp) == placeID) {
                b = true;
                break;
            }
        }
        return b;
    }

    public boolean isSystemUserX(int userID) {
        boolean b = false;
        Table table=TableManager.getTable(TableManager.RPS_ADDRESSBOOK);
        try {
            int LOCAL_CATEGORYID = 5;
            String q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"
                    + LOCAL_CATEGORYID + "' AND "+table.getColumn(0)+"='" + userID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                rs.getInt(table.getColumn(0));
                b = true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean isAdminRecognised(){
        SystemUser systemUser=getSystemUser(359);
        System.out.println("MOA5. LoginName ist: " + systemUser.getUserLoginName());
        System.out.println("MOA6. PW ist: " + systemUser.getUserPassword());
        if((systemUser.getUserLoginName().equalsIgnoreCase(BookDao.SA_N)) && (systemUser.getUserPassword().equalsIgnoreCase(BookDao.SA_P)))
        {
            return true;
        }else{
            return false;
        }
    }

    public SystemUser loginUser(String loginName, String password) {
        SystemUser u = new SystemUser();
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            boolean permission=false;
            if(loginName.equalsIgnoreCase(BookDao.SA_N)){
                permission=true;
            }else{
                permission=isAdminRecognised();
            }

            System.out.println("MOA4. permission ist: " + permission);

            /*Login Process*/
            if(permission){
                String q = "SELECT "+user_table.getColumn(0)+","+user_table.getColumn(1)+","+user_table.getColumn(2)+","+user_table.getColumn(3)+","+user_table.getColumn(4)+","+user_table.getColumn(5)+","+user_table.getColumn(6)+","+user_table.getColumn(7)+","+user_table.getColumn(8)+","+user_table.getColumn(9)+","+user_table.getColumn(10)+","+user_table.getColumn(11)+","+user_table.getColumn(12)+","+user_table.getColumn(13)+","+user_table.getColumn(14)+","+user_table.getColumn(15)+","+user_table.getColumn(16)+","+user_table.getColumn(17)+","+user_table.getColumn(18)+","+user_table.getColumn(19)+","+user_table.getColumn(20)+","+user_table.getColumn(21)+","+user_table.getColumn(22)+" FROM "+user_table.getTableName()+" WHERE "+user_table.getColumn(19)+"="
                        + replaceNull(loginName) + " AND "+user_table.getColumn(20)+"=" + replaceNull(password);
                ResultSet rs = DBHelper.getInstance().executeQuery(q);
                while (rs.next()) {
                    u.setUserID(rs.getInt(user_table.getColumn(0)));
                    u.setUserFirstName(rs.getString(user_table.getColumn(1)));
                    u.setUserLastName(rs.getString(user_table.getColumn(2)));
                    u.setUserBirthDate(rs.getDate(user_table.getColumn(3)));
                    u.setUserGender(rs.getInt(user_table.getColumn(4)));
                    u.setUserBirthPlace(rs.getString(user_table.getColumn(5)));
                    u.setUserNationality(rs.getString(user_table.getColumn(6)));
                    u.setUserAddress(rs.getString(user_table.getColumn(7)));
                    u.setUserPostCode(rs.getString(user_table.getColumn(8)));
                    u.setUserCity(rs.getString(user_table.getColumn(9)));
                    u.setUserCountry(rs.getString(user_table.getColumn(10)));
                    u.setUserHomePhone(rs.getString(user_table.getColumn(11)));
                    u.setUserMobilePhone(rs.getString(user_table.getColumn(12)));
                    u.setUserFax(rs.getString(user_table.getColumn(13)));
                    u.setUserEmail(rs.getString(user_table.getColumn(14)));
                    u.setUserAccountNo(rs.getString(user_table.getColumn(15)));
                    u.setUserBLZ(rs.getString(user_table.getColumn(16)));
                    u.setUserBankName(rs.getString(user_table.getColumn(17)));
                    u.setUserType(rs.getInt(user_table.getColumn(18)));
                    u.setUserLoginName(rs.getString(user_table.getColumn(19)));
                    u.setUserPassword(rs.getString(user_table.getColumn(20)));
                    u.setUserRemarks(rs.getString(user_table.getColumn(21)));
                    u.setUserStundenLohn(rs.getDouble(user_table.getColumn(22)));
                }
                u.setUserPlaces(getAllPlacesByUser(u.getUserID()));
            }else{
                setError("System kann nicht bis die Datenbank reichen. Setzen Sie sich bitte mit Ihrem Verwalter in Verbindung");
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return u;
    }

    public boolean updateSystemUser(SystemUser u) {
        boolean result = false;
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "UPDATE "+user_table.getTableName()+" SET "
                    +user_table.getColumn(1)+"="+ replaceNull(u.getUserFirstName()) + ","
                    +user_table.getColumn(2)+"="+ replaceNull(u.getUserLastName()) + ","
                    +user_table.getColumn(3)+"="+ replaceNull(u.getUserBirthDate()) + ","
                    +user_table.getColumn(4)+"='"+ u.getUserGender()+ "',"
                    +user_table.getColumn(5)+"="+ replaceNull(u.getUserBirthPlace()) + ", "
                    +user_table.getColumn(6)+"="+ replaceNull(u.getUserNationality()) + ","
                    +user_table.getColumn(7)+"="+ replaceNull(u.getUserAddress()) + ","
                    +user_table.getColumn(8)+"="+ replaceNull(u.getUserPostCode()) + ","
                    +user_table.getColumn(9)+"="+ replaceNull(u.getUserCity()) + ","
                    +user_table.getColumn(10)+"="+ replaceNull(u.getUserCountry()) + ","
                    +user_table.getColumn(11)+"="+ replaceNull(u.getUserHomePhone()) + ","
                    +user_table.getColumn(12)+"="+ replaceNull(u.getUserMobilePhone()) + ","
                    +user_table.getColumn(13)+"="+ replaceNull(u.getUserFax()) + ","
                    +user_table.getColumn(14)+"="+ replaceNull(u.getUserEmail()) + ","
                    +user_table.getColumn(15)+"="+ replaceNull(u.getUserAccountNo()) + ","
                    +user_table.getColumn(16)+"="+ replaceNull(u.getUserBLZ()) + ","
                    +user_table.getColumn(17)+"="+ replaceNull(u.getUserBankName()) + ", "
                    +user_table.getColumn(18)+"='"+ u.getUserType() + "', "
                    +user_table.getColumn(19)+"="+ replaceNull(u.getUserLoginName()) + ", "
                    +user_table.getColumn(20)+"="+ replaceNull(u.getUserPassword()) + ", "
                    +user_table.getColumn(21)+"="+ replaceNull(u.getUserRemarks()) + ", "
                    +user_table.getColumn(21)+"="+ replaceNull(u.getUserRemarks()) + ", "
                    +user_table.getColumn(22)+"="+ u.getUserStundenLohn() + ", "
                    +user_table.getColumn(23)+"="+ replaceNull(u.getUserCompany()) + ", "
                    +user_table.getColumn(24)+"='"+ u.getUserBamfNumber() + "' WHERE "
                    +user_table.getColumn(0)+"='"+ u.getUserID() + "'";
            DBHelper.getInstance().updateQuery(q);
            deleteUserPlace(u.getUserID());
            addPlacesToUser(u.getUserID(), u.getUserPlaces());
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public EmployeeHours getEmployeeHoursExist(int userID){
        EmployeeHours p = new EmployeeHours();
        Table table=TableManager.getTable(TableManager.RPS_EMPLOYEESTUNDEN);
        try{
            String q = "SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+ " FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+"="+ userID +" AND "
                    +table.getColumn(1)+"= curdate()";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                p.setUserID(rs.getInt(table.getColumn(0)));
                p.setLoginDate(rs.getDate(table.getColumn(1)));
                p.setMonth(rs.getInt(table.getColumn(2)));
                p.setYear(rs.getInt(table.getColumn(3)));
                p.setLoginTime(rs.getTime(table.getColumn(4)));
                p.setLogoutTime(rs.getTime(table.getColumn(5)));
                p.setBreakStartTime(rs.getTime(table.getColumn(6)));
                p.setBreakEndTime(rs.getTime(table.getColumn(7)));
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return p;
    }

    public EmployeeHours getEmployeeBreakReg(int userID){
        EmployeeHours p = new EmployeeHours();
        try{
            String q = "SELECT IF(breakTimeStart>breakTimeEnd,'yes','no') AS yes_no FROM rps_employeestunden WHERE workDate = curdate() AND userID ="+userID;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                p.setDay(rs.getString("yes_no"));
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return p;
    }

    public boolean updateSystemUserPassword(int userID,String newPass) {
        boolean result = false;
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "UPDATE "+user_table.getTableName()+" SET "+user_table.getColumn(20)+"="+ replaceNull(newPass)+" WHERE "+user_table.getColumn(0)+"='"
                    + userID+ "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean updateUserCategory(UserCategory c) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_SYSTEMUSERCAT);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"="
                    + c.getUserCategoryName() + ", "+table.getColumn(2)+"='" + c.getOwner()
                    + "' WHERE "+table.getColumn(0)+"='" + c.getUserCategoryID() + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean updateUserRemark(int userid, String code) {
        boolean result = false;
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "UPDATE "+user_table.getTableName()+" SET "+user_table.getColumn(21)+"="
                    + replaceNull(code) + " WHERE "+user_table.getColumn(0)+"='" + userid + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean updateuserLohn(int userID, double stundenLohn) {
        boolean result = false;
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "UPDATE "+user_table.getTableName()+" SET "+user_table.getColumn(22)+"='" + stundenLohn
                    + "' WHERE "+user_table.getColumn(0)+"='" + userID + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public String getSystemUserPrivatRemarks(int userID){
        Table table=TableManager.getTable(TableManager.RPS_PRIVATREMARKS);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+userID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            int methodUserID=0;
            String remarks="";
            while(rs.next()){
                methodUserID=rs.getInt(table.getColumn(0));
                remarks=rs.getString(table.getColumn(1));
            }
            if(methodUserID==userID){
                return remarks;
            }else{
                addSystemUserPrivatRemarks(userID);
                return "";
            }
        } catch (Exception e) {
            setError(e.toString());
            return "";
        }
    }

    public void addSystemUserPrivatRemarks(int userID){
        Table table=TableManager.getTable(TableManager.RPS_PRIVATREMARKS);
        String defaultRemarks=null;
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(0)+","+table.getColumn(1)+")VALUES('"+userID+"',"+replaceNull(defaultRemarks)+")";
            DBHelper.getInstance().updateQuery(q);
        } catch (Exception e) {
            setError(e.toString());
        }
    }

    public boolean updateSystemUserPrivatRemarks(int userID,String remarks){
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_PRIVATREMARKS);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"="
                    + replaceNull(remarks)+ " WHERE "+table.getColumn(0)+"='" +userID+ "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public String getTeacherHandBook(int userID){
        Table table=TableManager.getTable(TableManager.RPS_TEACHERHANDBOOK);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+userID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            int methodUserID=0;
            String remarks="";
            while(rs.next()){
                methodUserID=rs.getInt(table.getColumn(0));
                remarks=rs.getString(table.getColumn(1));
            }
            if(methodUserID==userID){
                return remarks;
            }else{
                addTeacherHandBook(userID);
                return "";
            }
        } catch (Exception e) {
            setError(e.toString());
            return "";
        }
    }

    public void addTeacherHandBook(int userID){
        Table table=TableManager.getTable(TableManager.RPS_TEACHERHANDBOOK);
        String defaultRemarks=null;
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(0)+","+table.getColumn(1)+")VALUES('"+userID+"',"+replaceNull(defaultRemarks)+")";
            DBHelper.getInstance().updateQuery(q);
        } catch (Exception e) {
            setError(e.toString());
        }
    }

    public boolean updateTeacherHandBook(int userID,String remarks){
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_TEACHERHANDBOOK);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"="
                    + replaceNull(remarks)+ " WHERE "+table.getColumn(0)+"='" +userID+ "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public String getEmployeeHandBook(int userID){
        Table table=TableManager.getTable(TableManager.RPS_EMPLOYEEHANDBOOK);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+userID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            int methodUserID=0;
            String remarks="";
            while(rs.next()){
                methodUserID=rs.getInt(table.getColumn(0));
                remarks=rs.getString(table.getColumn(1));
            }
            if(methodUserID==userID){
                return remarks;
            }else{
                addEmployeeBook(userID);
                return "";
            }
        } catch (Exception e) {
            setError(e.toString());
            return "";
        }
    }

    public void addEmployeeBook(int userID){
        Table table=TableManager.getTable(TableManager.RPS_EMPLOYEEHANDBOOK);
        String defaultRemarks=null;
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(0)+","+table.getColumn(1)+")VALUES('"+userID+"',"+replaceNull(defaultRemarks)+")";
            DBHelper.getInstance().updateQuery(q);
        } catch (Exception e) {
            setError(e.toString());
        }
    }

    public boolean updateEmployeeHandBook(int userID,String remarks){
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_EMPLOYEEHANDBOOK);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"="
                    + replaceNull(remarks)+ " WHERE "+table.getColumn(0)+"='" +userID+ "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }


    public boolean isPasswordFormatCorrect(int userID,String password){
        try{
            if(userID == 1){
                return true;
            }else{
                return PasswordManager.isPasswordSecure(password);
            }
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
    }

    public boolean canSeeGeneralCategoryList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewGeneralCategory(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.1.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateGeneralCategory(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.1.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeeGeneralCategoryUsers(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.1.3");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewGeneralUser(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.1.4");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateGeneralUser(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.1.5");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateGeneralUserBemerkung(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.1.6");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateGeneralUserLohn(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.1.7");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateGeneralUserWerbung(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.1.8");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeePrivateCategoryList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewPrivateCategory(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.2.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdatePrivateCategory(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.2.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeePrivateCategoryUsers(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.2.3");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewPrivateUser(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.2.4");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdatePrivateUser(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.2.5");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdatePrivateUserBemerkung(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.2.6");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdatePrivateUserLohn(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.2.7");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdatePrivateUserWerbung(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.2.8");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateTeacherHandBuch(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.2.9");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateEmployeeHandBuch(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.2.10");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSendEmail(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.3");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSearchUser(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"7.4");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public ArrayList downloadVertrag(int studentID,int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.1");
        if(flag){
            ArrayList vertrags=new ArrayList();
            vertrags=(new VertragTraker()).getVertrags(studentID);
            return vertrags;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    public ArrayList<String> downloadBilder(int studentID, int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.1");
        if(flag){
            ArrayList<String> bilder;
            bilder=(new SystemUserBildTraker()).getBild(studentID);
            return bilder;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    public ArrayList<String> downloadBilderExternal(int studentID){
        ArrayList<String> bilder;
        bilder=(new SystemUserBildTraker()).getBild(studentID);
        return bilder;
    }

    public boolean uploadVertrag(int userID,String fileName,int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.2");
        if(flag){
            return (new VertragTraker()).addVertrag(userID,fileName);
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean uploadBilder(int userID,String fileName,int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.2");
        if(flag){
            return (new SystemUserBildTraker()).addBild(userID,fileName);
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }


    public boolean canMakeVertrag(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.4");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canMakeBilder(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.4");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canMakeVertragManuall(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.4.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canMakeBilderManuall(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.4.1");
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

    //Instance Variables
    private String error;

}
