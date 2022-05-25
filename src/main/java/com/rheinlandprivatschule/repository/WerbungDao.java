package com.rheinlandprivatschule.repository;


import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Student;
import com.rheinlandprivatschule.model.Table;
import com.rheinlandprivatschule.model.Werbung;

import java.sql.*;
import java.util.ArrayList;
import java.util.Vector;


public class WerbungDao {

    public boolean addWerbung(Werbung w) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_WERBUNG);
        try {
            String q = "INSERT INTO " + table.getTableName() + "("
                    + table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+")VALUES("
                    + replaceNull(w.getWerbungName())+","
                    +replaceNull(w.getWerbungDetail())+",'"
                    +w.getWerbungParent()+"')";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean updateWerbungParent(int werbungParent) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_WERBUNG);
        try {
            String q = "UPDATE " + table.getTableName() + " SET "
                    + table.getColumn(4) + "="+ 1 + " WHERE "
                    + table.getColumn(0) + "='" + werbungParent + "'";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteWerbung(int werbungID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_WERBUNG);
        try {
            String q = "DELETE FROM " + table.getTableName() + " WHERE "
                    + table.getColumn(0) + "='" + werbungID + "'";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public Werbung getWerbung(int werbungID) {
        Werbung werbungClass = new Werbung();
        Table table = TableManager.getTable(TableManager.RPS_WERBUNG);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+" FROM "
                    + table.getTableName() + " WHERE "
                    + table.getColumn(0)+ "='" + werbungID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setWerbungID(rs.getInt(table.getColumn(0)));
                werbungClass.setWerbungName(rs.getString(table.getColumn(1)));
                werbungClass.setWerbungDetail(rs.getString(table.getColumn(2)));
                werbungClass.setWerbungParent(rs.getInt(table.getColumn(3)));
                werbungClass.setStatus(rs.getInt(table.getColumn(4)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public ArrayList<Werbung> getAllWerbungs(int parent) {
        ArrayList<Werbung> werbungClassList = new ArrayList<Werbung>();
        Table table = TableManager.getTable(TableManager.RPS_WERBUNG);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) +","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+" FROM "
                    + table.getTableName() + " WHERE "
                    +table.getColumn(3)+"='"+parent+"' ORDER BY "
                    + table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Werbung werbungClass = new Werbung();
                werbungClass.setWerbungID(rs.getInt(table.getColumn(0)));
                werbungClass.setWerbungName(rs.getString(table.getColumn(1)));
                werbungClass.setWerbungDetail(rs.getString(table.getColumn(2)));
                werbungClass.setWerbungParent(rs.getInt(table.getColumn(3)));
                werbungClass.setStatus(rs.getInt(table.getColumn(4)));
                werbungClass.setWerbungActive(rs.getInt(table.getColumn(5)));
                werbungClassList.add(werbungClass);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClassList;
    }

    public ArrayList<Werbung> getAllWerbungsStatus(int parent, int status) {
        ArrayList<Werbung> werbungClassList = new ArrayList<Werbung>();
        Table table = TableManager.getTable(TableManager.RPS_WERBUNG);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) +","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+" FROM "
                    + table.getTableName() + " WHERE "
                    +table.getColumn(3)+"='"+parent+"' AND "
                    +table.getColumn(5)+"='"+status+"' ORDER BY "
                    + table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Werbung werbungClass = new Werbung();
                werbungClass.setWerbungID(rs.getInt(table.getColumn(0)));
                werbungClass.setWerbungName(rs.getString(table.getColumn(1)));
                werbungClass.setWerbungDetail(rs.getString(table.getColumn(2)));
                werbungClass.setWerbungParent(rs.getInt(table.getColumn(3)));
                werbungClass.setStatus(rs.getInt(table.getColumn(4)));
                werbungClass.setWerbungActive(rs.getInt(table.getColumn(5)));
                werbungClassList.add(werbungClass);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClassList;
    }

    public boolean isWerbungClasseDir(int werbungID) {
        boolean result=false;
        int count=0;
        Table table = TableManager.getTable(TableManager.RPS_WERBUNG);
        try {
            String q = "SELECT count(*) AS classcount FROM "
                    + table.getTableName() + " WHERE "+table.getColumn(3)+"='"+werbungID+"'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                count=rs.getInt("classcount");
            }
            if(count>0){
                result=true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean updateWerbung(Werbung werbung) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_WERBUNG);
        try {
            String q = "UPDATE " + table.getTableName() + " SET "
                    + table.getColumn(1) + "="
                    + replaceNull(werbung.getWerbungName()) + ","+table.getColumn(2)+"="+replaceNull(werbung.getWerbungDetail())+","+table.getColumn(3)+"='"+werbung.getWerbungParent()+"' WHERE "
                    + table.getColumn(0) + "='" + werbung.getWerbungID() + "'";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean addWerbungRelatedToClient(int clientID, int werbungID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_WERBUNGRELATED);
        try {
            String q = "INSERT INTO " + table.getTableName() + "("
                    + table.getColumn(0) + "," + table.getColumn(1)
                    + ")VALUES('" + clientID + "','" + werbungID + "')";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteWerbungRelatedToClient(int clientID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_WERBUNGRELATED);
        try {
            String q = "DELETE FROM " + table.getTableName() + " WHERE "
                    + table.getColumn(0) + "='" + clientID + "'";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public Werbung getWerbungRelatedToStudent(int studentID) {
        Werbung werbung = new Werbung();
        Table werbungTable = TableManager.getTable(TableManager.RPS_WERBUNG);
        Table werbungRelatedTable = TableManager.getTable(TableManager.RPS_WERBUNGRELATED);
        try {
            String q = "SELECT a." + werbungTable.getColumn(0) + ",a."
                    + werbungTable.getColumn(1) + ",a."
                    + werbungTable.getColumn(2) + ",a."+werbungTable.getColumn(3)+" FROM "
                    + werbungTable.getTableName() + " AS a,"
                    + werbungRelatedTable.getTableName() + " AS b" + " WHERE a."
                    + werbungTable.getColumn(0) + "=b."
                    + werbungRelatedTable.getColumn(1) + " AND b."+werbungRelatedTable.getColumn(0)+"="+studentID+" ORDER BY a."
                    + werbungTable.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbung.setWerbungID(rs.getInt(werbungTable.getColumn(0)));
                werbung.setWerbungName(rs.getString(werbungTable.getColumn(1)));
                werbung.setWerbungDetail(rs.getString(werbungTable.getColumn(2)));
                werbung.setWerbungParent(rs.getInt(werbungTable.getColumn(3)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbung;
    }

    public int countAssociatedWerbungs(int werbungID) {

        int count = 0;
        Table werbungRelatedTable = TableManager
                .getTable(TableManager.RPS_WERBUNGRELATED);
        try {
            String q = "SELECT count(" + werbungRelatedTable.getColumn(1)
                    + ") AS count" + " FROM "
                    + werbungRelatedTable.getTableName() + " WHERE "
                    + werbungRelatedTable.getColumn(1) + "='" + werbungID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return count;
    }

    public boolean isRelatedToClient(int clientID, int werbungID) {
        boolean b = false;
        int temp = 0;
        Table table = TableManager.getTable(TableManager.RPS_WERBUNGRELATED);
        try {
            String q = "SELECT " + table.getColumn(1) + " FROM "
                    + table.getTableName() + " WHERE " + table.getColumn(0)
                    + "='" + clientID + "' AND " + table.getColumn(1) + "='"
                    + werbungID + "'";
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

    public boolean addRelationToAdmin(int adminID, int werbungID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_ADMINWERBUNG);
        try {
            String q = "INSERT INTO " + table.getTableName() + "("
                    + table.getColumn(0) + "," + table.getColumn(1)
                    +")VALUES('"+adminID+"','"
                    + werbungID+ "')";
            DBHelper.getInstance().updateQuery(q);
            b=true;
        } catch (Exception e) {
            setError(e.toString());
            b = false;
        }
        return b;
    }

    public boolean updateRelationToAdmin(int adminID, int werbungID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_ADMINWERBUNG);
        try {
            if(isRelationToAdminExist(adminID)){
                String q = "UPDATE " + table.getTableName() + " SET "
                        + table.getColumn(1) + "='"
                        + werbungID+"' WHERE "
                        + table.getColumn(0) + "='" + adminID+ "'";
                DBHelper.getInstance().updateQuery(q);
                b = true;
            }else{
                b=addRelationToAdmin(adminID,werbungID);
            }

        } catch (Exception e) {
            setError(e.toString());
            b = false;
        }
        return b;
    }

    public boolean isRelationToAdminExist(int adminID) {
        boolean b = false;
        int temp = 0;
        Table table = TableManager.getTable(TableManager.RPS_ADMINWERBUNG);
        try {
            String q = "SELECT " + table.getColumn(1) + " FROM "
                    + table.getTableName() + " WHERE " + table.getColumn(0)
                    + "='" + adminID + "'";
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

    public int getAdminWerbung(int adminID) {
        int werbungID=0;
        Table table = TableManager.getTable(TableManager.RPS_ADMINWERBUNG);
        try {
            String q = "SELECT " + table.getColumn(1) + " FROM "
                    + table.getTableName() + " WHERE " + table.getColumn(0)
                    + "='" + adminID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungID=rs.getInt(table.getColumn(1));
            }
            return werbungID;
        } catch (Exception e) {
            setError(e.toString());
            return 0;
        }
    }

    public int getWerbungAgent(int werbungID) {
        int agentID=0;
        Table table = TableManager.getTable(TableManager.RPS_ADMINWERBUNG);
        try {
            String q = "SELECT " + table.getColumn(0) + " FROM "
                    + table.getTableName() + " WHERE " + table.getColumn(1)
                    + "='" + werbungID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                agentID=rs.getInt(table.getColumn(0));
            }
            return agentID;
        } catch (Exception e) {
            setError(e.toString());
            return 0;
        }
    }

    public Vector getStudentRelatedToWerbung(int werbungID, int studentStatus) {
        Vector<Student> result = new Vector<Student>();
        Vector<String> ids=new Vector<String>();
        Table student_table=TableManager.getTable(TableManager.RPS_USER);
        Table werbung_table=TableManager.getTable(TableManager.RPS_WERBUNGRELATED);

        try {
            String q = "SELECT a."+student_table.getColumn(0)+",a."
                    +student_table.getColumn(1)+",a."
                    +student_table.getColumn(2)+" FROM "
                    +student_table.getTableName()+" AS a,"
                    +werbung_table.getTableName()+" AS b WHERE b."
                    +werbung_table.getColumn(0)+"=a."+student_table.getColumn(0)+" AND b."
                    +werbung_table.getColumn(1)+"='"+werbungID+"' ORDER BY a."
                    +student_table.getColumn(1);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                String temp=""+rs.getInt(student_table.getColumn(0));
                ids.addElement(temp);
            }
            StudentDao sdb=new StudentDao();
            for(int i=0;i<ids.size();i++){
                int tempStudentID=Integer.parseInt((String)ids.elementAt(i));
                int tempStatus=getWerbungStudentStatus(tempStudentID);
                if(tempStatus==studentStatus){
                    result.addElement(sdb.getStudentForSubProcess(tempStudentID));
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }


    public int getWerbungStudentStatus(int clientID){
        int studentStatus=-1;
        Table table=TableManager.getTable(TableManager.RPS_WERBUNGRELATED);
        try{
            String q="SELECT "+table.getColumn(2)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+clientID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            int tempStatus=-1;
            while(rs.next()){
                tempStatus=rs.getInt("studentStatus");
            }

            if(tempStatus>=0){
                studentStatus=tempStatus;
            }else{
                insertWerbungStudentStatus(clientID,STUDENTACTIVE);
                studentStatus=STUDENTACTIVE;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return studentStatus;
    }

    public int getWerbungStatus(int werbungID){
        int studentStatus=-1;
        Table table=TableManager.getTable(TableManager.RPS_WERBUNG);
        try{
            String q="SELECT "+table.getColumn(5)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+"='"+werbungID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            int tempStatus=-1;
            while(rs.next()){
                tempStatus=rs.getInt("studentStatus");
            }

            if(tempStatus>=0){
                studentStatus=tempStatus;
            }else{
                insertWerbungStatus(werbungID,STUDENTACTIVE);
                studentStatus=STUDENTACTIVE;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return studentStatus;
    }

    public boolean insertWerbungStudentStatus(int clientID,int studentStatus){
        Table table=TableManager.getTable(TableManager.RPS_WERBUNGRELATED);
        try{
            String q="INSERT INTO "+table.getTableName()+"("+table.getColumn(0)+","+table.getColumn(2)+") VALUES('"+clientID+"','"+studentStatus+"')";
            DBHelper.getInstance().updateQuery(q);
            return true;
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
    }

    public boolean insertWerbungStatus(int werbungID,int werbungStatus){
        Table table=TableManager.getTable(TableManager.RPS_WERBUNG);
        try{
            String q="INSERT INTO "+table.getTableName()+"("
                    +table.getColumn(0)+","
                    +table.getColumn(5)+") VALUES('"
                    +werbungID+"','"
                    +werbungStatus+"')";
            DBHelper.getInstance().updateQuery(q);
            return true;
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
    }

    public boolean setStudentStatus(int clientID,int studentStatus){
        Table table=TableManager.getTable(TableManager.RPS_WERBUNGRELATED);
        try{
            String q="UPDATE "+table.getTableName()+" SET "+table.getColumn(2)+"='"+studentStatus+"' WHERE "+table.getColumn(0)+"='"+clientID+"'";
            DBHelper.getInstance().updateQuery(q);
            return true;
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
    }

    public boolean setWerbungStatus(int werbungID,int studentStatus){
        Table table=TableManager.getTable(TableManager.RPS_WERBUNG);
        try{
            String q="UPDATE "+table.getTableName()+" SET "+table.getColumn(5)+"='"+studentStatus+"' WHERE "
                    +table.getColumn(0)+"='"+werbungID+"'";
            DBHelper.getInstance().updateQuery(q);
            return true;
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
    }

    public Vector<Werbung> getProperVector(Vector werbungList, Vector werbungIDSLIST){
        Vector<Werbung> v=new Vector<Werbung>();
        WerbungDao sdb=new WerbungDao();
        try{
            for(int i = 0; i < werbungList.size(); i++){
                Werbung s = (Werbung)werbungList.elementAt(i);
                if(isActive(werbungIDSLIST,s.getWerbungActive())){
                    int active = 1;
                    v.addElement(s);
                    sdb.makeWerbungActive(active, s.getWerbungActive());
                }else{
                    int active = 0;
                    sdb.makeWerbungActive(active, s.getWerbungActive());
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public boolean makeWerbungActive(int active, int werbungID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_WERBUNG);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(5)+"='" + active
                    + "' WHERE "+table.getColumn(0)+"='" + werbungID + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean isActive(Vector werbungIDSLIST, int werbungID){
        boolean result = false;
        try{
            for(int i = 0; i < werbungIDSLIST.size(); i++){
                String temp = (String)werbungIDSLIST.elementAt(i);
                if(werbungID == Integer.parseInt(temp)){
                    result = true;
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public boolean canSeeWerbungList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"11.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewWerbung(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"11.1.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateWerbung(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"11.1.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeeWerbungStudents(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"11.1.3");
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
    public int STUDENTACTIVE=0;
    public int STUDENTNOTACTIVE=1;
}
