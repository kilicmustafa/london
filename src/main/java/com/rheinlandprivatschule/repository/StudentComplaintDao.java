package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.StudentComplaint;
import com.rheinlandprivatschule.model.Table;

import java.sql.*;
import java.util.Date;
import java.util.Vector;

public class StudentComplaintDao {

    public boolean addStudentComplaints(StudentComplaint complaints) {
        boolean result = false;
        Table table= TableManager.getTable(TableManager.RPS_COMPLAINTSTUDENT);
        try {
            String q = "INSERT INTO "+table.getTableName()+" ("
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+") VALUES ("
                    + replaceNull(complaints.getStudentID()) + ","
                    + replaceNull(complaints.getComplaintID()) + ","
                    + replaceNull(complaints.getRemarks()) + ","
                    + replaceNull(complaints.getAdminID()) + ","
                    + replaceNull(complaints.getPlaceID()) + ","
                    + replaceNull(complaints.getComplaintDate()) + ")";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean deleteStudentComplaints(int complaintID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_COMPLAINTSTUDENT);
        try {
            String q = "DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='" + complaintID + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public StudentComplaint getStudentComplaints(int studentID) {
        StudentComplaint c = new StudentComplaint();
        Table table=TableManager.getTable(TableManager.RPS_COMPLAINTSTUDENT);
        try {
            String q = "SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(1)+"='" + studentID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                c.setComStudentID(rs.getInt(table.getColumn(0)));
                c.setStudentID(rs.getInt(table.getColumn(1)));
                c.setComplaintID(rs.getInt(table.getColumn(2)));
                c.setRemarks(rs.getString(table.getColumn(3)));
                c.setAdminID(rs.getInt(table.getColumn(4)));
                c.setPlaceID(rs.getInt(table.getColumn(5)));
                c.setComplaintDate(rs.getDate(table.getColumn(6)));
                c.setStatus(rs.getInt(table.getColumn(7)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return c;
    }

    public StudentComplaint getComplaint(int comStudentID) {
        StudentComplaint c = new StudentComplaint();
        Table table=TableManager.getTable(TableManager.RPS_COMPLAINTSTUDENT);
        try {
            String q = "SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+"='" + comStudentID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                c.setComStudentID(rs.getInt(table.getColumn(0)));
                c.setStudentID(rs.getInt(table.getColumn(1)));
                c.setComplaintID(rs.getInt(table.getColumn(2)));
                c.setRemarks(rs.getString(table.getColumn(3)));
                c.setAdminID(rs.getInt(table.getColumn(4)));
                c.setPlaceID(rs.getInt(table.getColumn(5)));
                c.setComplaintDate(rs.getDate(table.getColumn(6)));
                c.setStatus(rs.getInt(table.getColumn(7)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return c;
    }

    public Vector<StudentComplaint> getComplaintSearch1(int criteria, int adminID,Date startDate, Date endDate, int placeID, int studentID, int status) {
        Vector<StudentComplaint> v = new Vector<StudentComplaint>();
        Table tran_table = TableManager.getTable(TableManager.RPS_COMPLAINTSTUDENT);
        try {
            String q = "SELECT a." + tran_table.getColumn(0) + ",a."
                    + tran_table.getColumn(1) + ",a."
                    + tran_table.getColumn(2) + ",a."
                    + tran_table.getColumn(3) + ",a."
                    + tran_table.getColumn(4) + ",a."
                    + tran_table.getColumn(5) + ",a."
                    + tran_table.getColumn(6) + ",a."
                    + tran_table.getColumn(7) + " FROM "
                    + tran_table.getTableName() + " AS a" + " WHERE a."
                    + tran_table.getColumn(7) + "=" + status;
            if (criteria == SPECIFICDATE) {
                if (adminID > 0 && placeID > 0) {
                    q = q + " AND " + tran_table.getColumn(4) + "=" + adminID + " AND "
                            + tran_table.getColumn(5) + "=" + placeID + " AND "
                            + tran_table.getColumn(6) + "=" + replaceNull(startDate);
                } else if (adminID == 0 && placeID > 0) {
                    q = q + " AND " + tran_table.getColumn(5) + "=" + placeID + " AND "
                            + tran_table.getColumn(6) + "=" + replaceNull(startDate);
                } else if (adminID > 0 && placeID == 0) {
                    q = q + " AND " + tran_table.getColumn(4) + "=" + adminID + " AND "
                            + tran_table.getColumn(6) + "=" + replaceNull(startDate);
                } else if (adminID == 0 && placeID == 0) {
                    q = q + " AND " + tran_table.getColumn(6) + "="	+ replaceNull(startDate);
                }
            } else if (criteria == DATELIMIT) {
                if (adminID > 0 && placeID > 0) {
                    q = q + " AND " + tran_table.getColumn(4) + "=" + adminID + " AND "
                            + tran_table.getColumn(5) + "="	+ placeID + " AND "
                            + tran_table.getColumn(6) + ">=" + replaceNull(startDate) + " AND "
                            + tran_table.getColumn(6) + "<=" + replaceNull(endDate);
                } else if (adminID == 0 && placeID > 0) {
                    q = q + " AND " + tran_table.getColumn(5) + "=" + placeID + " AND "
                            + tran_table.getColumn(6) + ">=" + replaceNull(startDate) + " AND "
                            + tran_table.getColumn(6) + "<=" + replaceNull(endDate);
                } else if (adminID > 0 && placeID == 0) {
                    q = q + " AND " + tran_table.getColumn(4) + "=" + adminID + " AND "
                            + tran_table.getColumn(6) + ">=" + replaceNull(startDate) + " AND "
                            + tran_table.getColumn(6) + "<=" + replaceNull(endDate);
                } else if (adminID == 0 && placeID == 0) {
                    q = q + " AND " + tran_table.getColumn(6) + ">=" + replaceNull(startDate) + " AND "
                            + tran_table.getColumn(6) + "<=" + replaceNull(endDate);
                }
            } else if (criteria == TRANSACTIONNO) {
                q = q + " AND " + tran_table.getColumn(1) + "=" + studentID;
            }
            q = q + " ORDER BY " + tran_table.getColumn(6);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                StudentComplaint c = new StudentComplaint();
                c.setComStudentID(rs.getInt(tran_table.getColumn(0)));
                c.setStudentID(rs.getInt(tran_table.getColumn(1)));
                c.setComplaintID(rs.getInt(tran_table.getColumn(2)));
                c.setRemarks(rs.getString(tran_table.getColumn(3)));
                c.setAdminID(rs.getInt(tran_table.getColumn(4)));
                c.setPlaceID(rs.getInt(tran_table.getColumn(5)));
                c.setComplaintDate(rs.getDate(tran_table.getColumn(6)));
                c.setStatus(rs.getInt(tran_table.getColumn(7)));
                v.addElement(c);
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return v;
    }

    public Vector<StudentComplaint> getAllStudentComplaints(int studentID, int status) {
        Vector<StudentComplaint> v = new Vector<StudentComplaint>();
        Table table=TableManager.getTable(TableManager.RPS_COMPLAINTSTUDENT);
        try {
            String q = "SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(1)+"='" + studentID + "' AND "
                    +table.getColumn(7)+"='" + status + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                StudentComplaint c = new StudentComplaint();
                c.setComStudentID(rs.getInt(table.getColumn(0)));
                c.setStudentID(rs.getInt(table.getColumn(1)));
                c.setComplaintID(rs.getInt(table.getColumn(2)));
                c.setRemarks(rs.getString(table.getColumn(3)));
                c.setAdminID(rs.getInt(table.getColumn(4)));
                c.setPlaceID(rs.getInt(table.getColumn(5)));
                c.setComplaintDate(rs.getDate(table.getColumn(6)));
                c.setStatus(rs.getInt(table.getColumn(7)));
                v.addElement(c);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public boolean updateStudentComplaints(StudentComplaint c) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_COMPLAINTSTUDENT);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "
                    +table.getColumn(1)+"=" + replaceNull(c.getStudentID()) + ", "
                    +table.getColumn(2)+"=" + replaceNull(c.getComplaintID()) + ", "
                    +table.getColumn(3)+"=" + replaceNull(c.getRemarks()) + ", "
                    +table.getColumn(4)+"=" + replaceNull(c.getAdminID()) + ", "
                    +table.getColumn(5)+"='" + c.getPlaceID() + "', "
                    +table.getColumn(6)+"='" + c.getComplaintDate() + "', "
                    +table.getColumn(7)+"=" + replaceNull(c.getStatus()) + " WHERE "
                    +table.getColumn(0)+"='" + c.getComStudentID() + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public int getComplaintStatus(int complaintID){
        int studentStatus=-1;
        Table table=TableManager.getTable(TableManager.RPS_COMPLAINTSTUDENT);
        try{
            String q="SELECT "+table.getColumn(7)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+"='"+complaintID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            int tempStatus=-1;
            while(rs.next()){
                tempStatus=rs.getInt("studentStatus");
            }

            if(tempStatus>=0){
                studentStatus=tempStatus;
            }else{
                insertComplaintStatus(complaintID,COMPLAINTACTIVE);
                studentStatus=COMPLAINTACTIVE;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return studentStatus;
    }

    public boolean insertComplaintStatus(int complaintID,int complaintStatus){
        Table table=TableManager.getTable(TableManager.RPS_COMPLAINTSTUDENT);
        try{
            String q="INSERT INTO "+table.getTableName()+"("
                    +table.getColumn(0)+","
                    +table.getColumn(7)+") VALUES('"
                    +complaintID+"','"
                    +complaintStatus+"')";
            DBHelper.getInstance().updateQuery(q);
            return true;
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
    }

    public boolean setComplaintStatus(int complaintID,int complaintStatus){
        Table table=TableManager.getTable(TableManager.RPS_COMPLAINTSTUDENT);
        try{
            String q="UPDATE "+table.getTableName()+" SET "+table.getColumn(7)+"='"+complaintStatus+"' WHERE "
                    +table.getColumn(0)+"='"+complaintID+"'";
            DBHelper.getInstance().updateQuery(q);
            return true;
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
    }

    public boolean makeComplaintActive(int active, int complaintID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_COMPLAINTSTUDENT);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(7)+"='" + active
                    + "' WHERE "+table.getColumn(0)+"='" + complaintID + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean isActive(Vector complaintIDSLIST, int complaintID){
        boolean result = false;
        try{
            for(int i = 0; i < complaintIDSLIST.size(); i++){
                String temp = (String)complaintIDSLIST.elementAt(i);
                if(complaintID == Integer.parseInt(temp)){
                    result = true;
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public boolean canSeeComplaintList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"8.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewComplaints(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"8.1.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateComplaint(int loginUser){
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

    //Instance Variables//
    public int COMPLAINTACTIVE=0;
    public int COMPLAINTNOTACTIVE=1;

    public static int BARTYPE=0;
    public static int UEBERWEISENTYPE=1;
    public static int ONLINETYPE=2;

    public static int SPECIFICDATE=1;
    public static int DATELIMIT=2;
    public static int TRANSACTIONNO=3;
}
