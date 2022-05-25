package com.rheinlandprivatschule.repository;

import java.sql.*;
import java.util.Vector;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Complaint;
import com.rheinlandprivatschule.model.Table;

public class ComplaintDao {

    public boolean addComplaints(Complaint complaints) {
        boolean result = false;
        Table table= TableManager.getTable(TableManager.RPS_COMPLAINTS);
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(1)+")VALUES("
                    + replaceNull(complaints.getComplaintName()) + ")";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean deleteComplaints(int complaintID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_COMPLAINTS);
        try {
            String q = "DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='" + complaintID + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public Complaint getComplaints(int complaintID) {
        Complaint c = new Complaint();
        Table table=TableManager.getTable(TableManager.RPS_COMPLAINTS);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                    + complaintID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                c.setComplaintID(rs.getInt(table.getColumn(0)));
                c.setComplaintName(rs.getString(table.getColumn(1)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return c;
    }

    public Vector<Complaint> getAllComplaints(int status) {
        Vector<Complaint> v = new Vector<Complaint>();
        Table table=TableManager.getTable(TableManager.RPS_COMPLAINTS);
        try {
            String q = "SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+" FROM "
                    +table.getTableName() + " WHERE "+table.getColumn(2)+"='"
                    + status + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Complaint c = new Complaint();
                c.setComplaintID(rs.getInt(table.getColumn(0)));
                c.setComplaintName(rs.getString(table.getColumn(1)));
                v.addElement(c);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public boolean updateComplaints(Complaint c) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_COMPLAINTS);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"="
                    + replaceNull(c.getComplaintName()) + " WHERE "+table.getColumn(0)+"='"
                    + c.getComplaintID() + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public int getComplaintStatus(int complaintID){
        int studentStatus=-1;
        Table table=TableManager.getTable(TableManager.RPS_COMPLAINTS);
        try{
            String q="SELECT "+table.getColumn(2)+" FROM "
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
        Table table=TableManager.getTable(TableManager.RPS_COMPLAINTS);
        try{
            String q="INSERT INTO "+table.getTableName()+"("
                    +table.getColumn(0)+","
                    +table.getColumn(2)+") VALUES('"
                    +complaintID+"','"
                    +complaintStatus+"')";
            DBHelper.getInstance().updateQuery(q);
            return true;
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
    }

    public boolean setGroupStatus(int complaintID,int complaintStatus){
        Table table=TableManager.getTable(TableManager.RPS_COMPLAINTS);
        try{
            String q="UPDATE "+table.getTableName()+" SET "+table.getColumn(2)+"='"+complaintStatus+"' WHERE "
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
        Table table=TableManager.getTable(TableManager.RPS_COMPLAINTS);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(2)+"='" + active
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
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"20.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewComplaints(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"20.1.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateComplaint(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"20.1.2");
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
}
