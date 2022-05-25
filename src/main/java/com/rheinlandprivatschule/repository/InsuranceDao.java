package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Insurance;
import com.rheinlandprivatschule.model.Table;

import java.sql.*;
import java.util.ArrayList;

public class InsuranceDao {

    public boolean addInsurance(Insurance insurance) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_INSURANCE);
        try {
            String q = "INSERT INTO " + table.getTableName() + "("
                    + table.getColumn(1) + "," + table.getColumn(2)
                    + ")VALUES(" + replaceNull(insurance.getInsuranceName()) + ","
                    + replaceNull(insurance.getInsuranceDescription()) + ")";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteWerbung(int insuranceID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_INSURANCE);
        try {
            String q = "DELETE FROM " + table.getTableName() + " WHERE "
                    + table.getColumn(0) + "='" + insuranceID + "'";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public Insurance getInsurance(int insuranceID) {
        Insurance insurance = new Insurance();
        Table table = TableManager.getTable(TableManager.RPS_INSURANCE);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + "," + table.getColumn(2) + " FROM "
                    + table.getTableName() + " WHERE " + table.getColumn(0)
                    + "='" + insuranceID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                insurance.setInsuranceID(rs.getInt(table.getColumn(0)));
                insurance.setInsuranceName(rs.getString(table.getColumn(1)));
                insurance.setInsuranceDescription(rs.getString(table.getColumn(2)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return insurance;
    }

    public ArrayList<Insurance> getAllInsurances() {
        ArrayList<Insurance> werbungList = new ArrayList<Insurance>();
        Table table = TableManager.getTable(TableManager.RPS_INSURANCE);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + "," + table.getColumn(2) + " FROM "
                    + table.getTableName() + " ORDER BY " + table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Insurance insurance = new Insurance();
                insurance.setInsuranceID(rs.getInt(table.getColumn(0)));
                insurance.setInsuranceName(rs.getString(table.getColumn(1)));
                insurance.setInsuranceDescription(rs.getString(table.getColumn(2)));
                werbungList.add(insurance);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungList;
    }

    public boolean updateInsurance(Insurance insurance) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_INSURANCE);
        try {
            String q = "UPDATE " + table.getTableName() + " SET "
                    + table.getColumn(1) + "="
                    + replaceNull(insurance.getInsuranceName()) + ", "
                    + table.getColumn(2) + "="
                    + replaceNull(insurance.getInsuranceDescription()) + " WHERE "
                    + table.getColumn(0) + "='" + insurance.getInsuranceID() + "'";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean addInsuranceRelatedToStudent(int studentID, int insuranceID,String insuranceDetail) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_INSURANCERELATED);
        try {
            String q = "INSERT INTO " + table.getTableName() + "("
                    + table.getColumn(0) + "," + table.getColumn(1)
                    + ","+table.getColumn(2)+")VALUES('" + studentID + "','" + insuranceID + "',"+replaceNull(insuranceDetail)+")";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteInsuranceRelatedToStudent(int studentID, int insuranceID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_INSURANCERELATED);
        try {
            String q = "DELETE FROM " + table.getTableName() + " WHERE "
                    + table.getColumn(0) + "='" + studentID + "' AND "
                    + table.getColumn(1) + "='" + insuranceID + "'";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteAllInsuranceRelatedToStudent(int studentID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_INSURANCERELATED);
        try {
            String q = "DELETE FROM " + table.getTableName() + " WHERE "
                    + table.getColumn(0) + "='" + studentID + "'";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public Insurance getInsuranceRelatedToStudent(int studentID) {

        Insurance insurance = new Insurance();
        Table insuranceTable = TableManager.getTable(TableManager.RPS_INSURANCE);
        Table insuranceRelatedTable = TableManager.getTable(TableManager.RPS_INSURANCERELATED);
        try {
            String q = "SELECT a." + insuranceTable.getColumn(0) + ",a."
                    + insuranceTable.getColumn(1) + ",a."
                    + insuranceTable.getColumn(2) + ",b."+insuranceRelatedTable.getColumn(0)+",b."+insuranceRelatedTable.getColumn(2)+" FROM "
                    + insuranceTable.getTableName() + " AS a,"
                    + insuranceRelatedTable.getTableName() + " AS b" + " WHERE a."
                    + insuranceTable.getColumn(0) + "=b."
                    + insuranceRelatedTable.getColumn(1) + " AND b."+insuranceRelatedTable.getColumn(0)+"="+studentID;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                insurance.setInsuranceID(rs.getInt(insuranceTable.getColumn(0)));
                insurance.setInsuranceName(rs.getString(insuranceTable.getColumn(1)));
                insurance.setInsuranceDescription(rs.getString(insuranceTable.getColumn(2)));
                insurance.setStudentID(rs.getInt(insuranceRelatedTable.getColumn(0)));
                insurance.setStudentInsuranceDescription(rs.getString(insuranceRelatedTable.getColumn(2)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return insurance;
    }

    public boolean isInsured(int studentID) {
        boolean is=false;
        Table insuranceRelatedTable = TableManager.getTable(TableManager.RPS_INSURANCERELATED);
        try {
            int tempInsuranceID=0;
            String q = "SELECT "+insuranceRelatedTable.getColumn(1)+" FROM "
                    + insuranceRelatedTable.getTableName() + " WHERE "+insuranceRelatedTable.getColumn(0)+"="+studentID;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                tempInsuranceID=rs.getInt(insuranceRelatedTable.getColumn(1));
            }
            if(tempInsuranceID>0){
                is=true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return is;
    }

    public int countAssociatedInsurances(int insuranceID) {
        int count = 0;
        Table insuranceRelatedTable = TableManager.getTable(TableManager.RPS_INSURANCERELATED);
        try {
            String q = "SELECT count(" + insuranceRelatedTable.getColumn(1)
                    + ") AS count" + " FROM "
                    + insuranceRelatedTable.getTableName() + " WHERE "
                    + insuranceRelatedTable.getColumn(1) + "='" + insuranceID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return count;
    }

    public boolean isRelatedToStudent(int studentID, int insuranceID) {
        boolean b = false;
        int temp = 0;
        Table table = TableManager.getTable(TableManager.RPS_INSURANCERELATED);
        try {
            String q = "SELECT " + table.getColumn(1) + " FROM "
                    + table.getTableName() + " WHERE " + table.getColumn(0)
                    + "='" + studentID + "' AND " + table.getColumn(1) + "='"
                    + insuranceID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                temp = rs.getInt(table.getColumn(1));
            }
            if (temp > 0) {
                b = true;
            }
        } catch (Exception e) {
            setError(e.toString());
            b = false;
        }
        return b;
    }

    public boolean canSeeInsuranceList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"11.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewInsurance(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"11.2.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateInsurance(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"11.2.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeeInsuranceStudents(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"11.2.3");
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
