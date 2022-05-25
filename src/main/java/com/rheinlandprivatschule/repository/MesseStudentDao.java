package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Table;
import com.rheinlandprivatschule.model.Werbung;

import java.sql.*;
import java.util.Vector;

public class MesseStudentDao {

    public boolean addStudentMesse(Werbung w) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_MESSESTUDENT);
        try {
            String q = "INSERT INTO " + table.getTableName() + "("
                    + table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+","
                    +table.getColumn(8)+","
                    +table.getColumn(9)+")VALUES("
                    + replaceNull(w.getMesseID())+","
                    +replaceNull(w.getFirstName())+","
                    +replaceNull(w.getLastName())+","
                    +replaceNull(w.getEmail())+","
                    +replaceNull(w.getStudyReason())+", DATE_ADD("
                    +replaceNull(w.getBeginDate())+" ,INTERVAL -3 month),"
                    +replaceNull(w.getIntendedLanguage())+","
                    +replaceNull(w.getRemarks())+","
                    +replaceNull(w.getTelephoneNumber())+")";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteStudentMesse(int studentID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_MESSESTUDENT);
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

    public Werbung getStudentMesse(int studentID) {
        Werbung werbungClass = new Werbung();
        Table table = TableManager.getTable(TableManager.RPS_MESSESTUDENT);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+","
                    +table.getColumn(8)+","
                    +table.getColumn(9)+","
                    +table.getColumn(10)+" FROM "
                    + table.getTableName() + " WHERE "
                    + table.getColumn(0)+ "='" + studentID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setStudentID(rs.getInt(table.getColumn(0)));
                werbungClass.setMesseID(rs.getInt(table.getColumn(1)));
                werbungClass.setFirstName(rs.getString(table.getColumn(2)));
                werbungClass.setLastName(rs.getString(table.getColumn(3)));
                werbungClass.setEmail(rs.getString(table.getColumn(4)));
                werbungClass.setStudyReason(rs.getString(table.getColumn(5)));
                werbungClass.setBeginDate(rs.getDate(table.getColumn(6)));
                werbungClass.setIntendedLanguage(rs.getString(table.getColumn(7)));
                werbungClass.setRemarks(rs.getString(table.getColumn(8)));
                werbungClass.setTelephoneNumber(rs.getString(table.getColumn(9)));
                werbungClass.setStudentActive(rs.getInt(table.getColumn(10)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Werbung getMinStudentID(int messeID) {
        Werbung werbungClass = new Werbung();
        try {
            String q = "select MIN(studentID) AS studentID from rps_messestudent WHERE studentActive = 0 AND beginDate <= curdate() AND messeID ="+messeID;

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setStudentID(rs.getInt("studentID"));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Werbung getMinStudentIDN(int messeID) {
        Werbung werbungClass = new Werbung();
        try {
            String q = "select MIN(studentID) AS studentID from rps_messestudent WHERE studentActive = 1 AND beginDate <= curdate() AND messeID ="+messeID;

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setStudentID(rs.getInt("studentID"));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Werbung getMinStudentIDInterested(int messeID) {
        Werbung werbungClass = new Werbung();
        try {
            String q = "select MIN(studentID) AS studentID from rps_messestudent WHERE studentActive = 2 AND beginDate <= curdate() AND messeID ="+messeID;

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setStudentID(rs.getInt("studentID"));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Werbung getMinInterested() {
        Werbung werbungClass = new Werbung();
        try {
            String q = "select MIN(studentID) AS studentID from rps_messestudent WHERE studentActive = 2 AND beginDate <= curdate()";

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setStudentID(rs.getInt("studentID"));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Werbung getNextDay(int stuID) {
        Werbung werbungClass = new Werbung();
        try {
            String q = "select DATE_ADD(curdate(),INTERVAL 1 day) AS beginDate from rps_messestudent where studentID="+stuID;

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setBeginDate(rs.getDate("beginDate"));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Werbung getMaxStudentID(int messeID, int studentID) {
        int active =0;
        Werbung werbungClass = new Werbung();
        Table table = TableManager.getTable(TableManager.RPS_MESSESTUDENT);
        try {
            String q = "SELECT "+table.getColumn(0)+ " FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+">" + studentID +" AND "
                    +table.getColumn(10)+"=" + active +" AND "
                    +table.getColumn(6)+"<= curdate() AND "
                    +table.getColumn(1)+"= "+ messeID +" limit 1";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setStudentID(rs.getInt(table.getColumn(0)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Werbung getMaxStudentIDN(int messeID, int studentID) {
        int active =1;
        Werbung werbungClass = new Werbung();
        Table table = TableManager.getTable(TableManager.RPS_MESSESTUDENT);
        try {
            String q = "SELECT "+table.getColumn(0)+ " FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+">" + studentID +" AND "
                    +table.getColumn(10)+"=" + active +" AND "
                    +table.getColumn(6)+"<= curdate() AND "
                    +table.getColumn(1)+"= "+ messeID +" limit 1";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setStudentID(rs.getInt(table.getColumn(0)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Werbung getMaxStudentIDInterested(int messeID, int studentID) {
        int active =2;
        Werbung werbungClass = new Werbung();
        Table table = TableManager.getTable(TableManager.RPS_MESSESTUDENT);
        try {
            String q = "SELECT "+table.getColumn(0)+ " FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+">" + studentID +" AND "
                    +table.getColumn(10)+"=" + active +" AND "
                    +table.getColumn(6)+"<= curdate() AND "
                    +table.getColumn(1)+"= "+ messeID +" limit 1";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setStudentID(rs.getInt(table.getColumn(0)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Werbung getMaxInterested(int studentID) {
        int active =2;
        Werbung werbungClass = new Werbung();
        Table table = TableManager.getTable(TableManager.RPS_MESSESTUDENT);
        try {
            String q = "SELECT "+table.getColumn(0)+ " FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+">" + studentID +" AND "
                    +table.getColumn(10)+"=" + active +" AND "
                    +table.getColumn(6)+"<= curdate() limit 1";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setStudentID(rs.getInt(table.getColumn(0)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Vector<Werbung> getAllStudentMesse(int messeID) {
        Vector<Werbung> v = new Vector<Werbung>();
        Table table=TableManager.getTable(TableManager.RPS_MESSESTUDENT);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+","
                    +table.getColumn(8)+","
                    +table.getColumn(9)+" FROM "
                    + table.getTableName() + " WHERE "
                    + table.getColumn(1)+ "='" + messeID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Werbung w = new Werbung();
                w.setStudentID(rs.getInt(table.getColumn(0)));
                w.setMesseID(rs.getInt(table.getColumn(1)));
                w.setFirstName(rs.getString(table.getColumn(2)));
                w.setLastName(rs.getString(table.getColumn(3)));
                w.setEmail(rs.getString(table.getColumn(4)));
                w.setStudyReason(rs.getString(table.getColumn(5)));
                w.setBeginDate(rs.getDate(table.getColumn(6)));
                w.setIntendedLanguage(rs.getString(table.getColumn(7)));
                w.setRemarks(rs.getString(table.getColumn(8)));
                w.setTelephoneNumber(rs.getString(table.getColumn(9)));
                v.addElement(w);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<Werbung> getAllStudentEmail() {
        Vector<Werbung> v = new Vector<Werbung>();
        Table table=TableManager.getTable(TableManager.RPS_MESSESTUDENT);
        try {
            String q = "SELECT " +table.getColumn(4)+" FROM "
                    + table.getTableName();
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Werbung w = new Werbung();
                w.setEmail(rs.getString(table.getColumn(4)));
                v.addElement(w);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<Werbung> getAllStudentTelephone(int messeID) {
        int active=0;
        Vector<Werbung> v = new Vector<Werbung>();
        Table table=TableManager.getTable(TableManager.RPS_MESSESTUDENT);
        try {
            String q = "SELECT " +table.getColumn(0) + ","
                    +table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+","
                    +table.getColumn(8)+","
                    +table.getColumn(9)+","
                    +table.getColumn(10)+" FROM "
                    +table.getTableName() + " WHERE "
                    +table.getColumn(6)+"<= curdate() AND "
                    +table.getColumn(10)+"=" + active + " AND "
                    +table.getColumn(1)+ "='" + messeID +"' ORDER BY " + table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Werbung w = new Werbung();
                w.setStudentID(rs.getInt(table.getColumn(0)));
                w.setMesseID(rs.getInt(table.getColumn(1)));
                w.setFirstName(rs.getString(table.getColumn(2)));
                w.setLastName(rs.getString(table.getColumn(3)));
                w.setEmail(rs.getString(table.getColumn(4)));
                w.setStudyReason(rs.getString(table.getColumn(5)));
                w.setBeginDate(rs.getDate(table.getColumn(6)));
                w.setIntendedLanguage(rs.getString(table.getColumn(7)));
                w.setRemarks(rs.getString(table.getColumn(8)));
                w.setTelephoneNumber(rs.getString(table.getColumn(9)));
                w.setStudentActive(rs.getInt(table.getColumn(10)));
                v.addElement(w);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<Werbung> getAllStudentTelephoneN(int messeID) {
        int active=1;
        Vector<Werbung> v = new Vector<Werbung>();
        Table table=TableManager.getTable(TableManager.RPS_MESSESTUDENT);
        try {
            String q = "SELECT " +table.getColumn(0) + ","
                    +table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+","
                    +table.getColumn(8)+","
                    +table.getColumn(9)+","
                    +table.getColumn(10)+" FROM "
                    +table.getTableName() + " WHERE "
                    +table.getColumn(6)+"<= curdate() AND "
                    +table.getColumn(10)+"=" + active + " AND "
                    +table.getColumn(1)+ "='" + messeID +"' ORDER BY " + table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Werbung w = new Werbung();
                w.setStudentID(rs.getInt(table.getColumn(0)));
                w.setMesseID(rs.getInt(table.getColumn(1)));
                w.setFirstName(rs.getString(table.getColumn(2)));
                w.setLastName(rs.getString(table.getColumn(3)));
                w.setEmail(rs.getString(table.getColumn(4)));
                w.setStudyReason(rs.getString(table.getColumn(5)));
                w.setBeginDate(rs.getDate(table.getColumn(6)));
                w.setIntendedLanguage(rs.getString(table.getColumn(7)));
                w.setRemarks(rs.getString(table.getColumn(8)));
                w.setTelephoneNumber(rs.getString(table.getColumn(9)));
                w.setStudentActive(rs.getInt(table.getColumn(10)));
                v.addElement(w);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<Werbung> getAllStudentTelephoneInterested(int messeID) {
        int active=2;
        Vector<Werbung> v = new Vector<Werbung>();
        Table table=TableManager.getTable(TableManager.RPS_MESSESTUDENT);
        try {
            String q = "SELECT " +table.getColumn(0) + ","
                    +table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+","
                    +table.getColumn(8)+","
                    +table.getColumn(9)+","
                    +table.getColumn(10)+" FROM "
                    +table.getTableName() + " WHERE "
                    +table.getColumn(6)+"<= curdate() AND "
                    +table.getColumn(10)+"=" + active + " AND "
                    +table.getColumn(1)+ "='" + messeID +"' ORDER BY " + table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Werbung w = new Werbung();
                w.setStudentID(rs.getInt(table.getColumn(0)));
                w.setMesseID(rs.getInt(table.getColumn(1)));
                w.setFirstName(rs.getString(table.getColumn(2)));
                w.setLastName(rs.getString(table.getColumn(3)));
                w.setEmail(rs.getString(table.getColumn(4)));
                w.setStudyReason(rs.getString(table.getColumn(5)));
                w.setBeginDate(rs.getDate(table.getColumn(6)));
                w.setIntendedLanguage(rs.getString(table.getColumn(7)));
                w.setRemarks(rs.getString(table.getColumn(8)));
                w.setTelephoneNumber(rs.getString(table.getColumn(9)));
                w.setStudentActive(rs.getInt(table.getColumn(10)));
                v.addElement(w);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<Werbung> getAllStudentInterested() {
        int active=2;
        Vector<Werbung> v = new Vector<Werbung>();
        Table table=TableManager.getTable(TableManager.RPS_MESSESTUDENT);
        try {
            String q = "SELECT " +table.getColumn(0) + ","
                    +table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+","
                    +table.getColumn(8)+","
                    +table.getColumn(9)+","
                    +table.getColumn(10)+" FROM "
                    +table.getTableName() + " WHERE "
                    +table.getColumn(6)+"<= curdate() AND "
                    +table.getColumn(10)+"=" + active + " ORDER BY " + table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Werbung w = new Werbung();
                w.setStudentID(rs.getInt(table.getColumn(0)));
                w.setMesseID(rs.getInt(table.getColumn(1)));
                w.setFirstName(rs.getString(table.getColumn(2)));
                w.setLastName(rs.getString(table.getColumn(3)));
                w.setEmail(rs.getString(table.getColumn(4)));
                w.setStudyReason(rs.getString(table.getColumn(5)));
                w.setBeginDate(rs.getDate(table.getColumn(6)));
                w.setIntendedLanguage(rs.getString(table.getColumn(7)));
                w.setRemarks(rs.getString(table.getColumn(8)));
                w.setTelephoneNumber(rs.getString(table.getColumn(9)));
                w.setStudentActive(rs.getInt(table.getColumn(10)));
                v.addElement(w);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }


    public boolean updateStudentMesse(Werbung c){
        boolean result=false;
        Table table=TableManager.getTable(TableManager.RPS_MESSESTUDENT);
        try{
            String q = "UPDATE "+table.getTableName()+" SET "
                    +table.getColumn(2)+"=" + replaceNull(c.getFirstName()) + ", "
                    +table.getColumn(3)+"=" + replaceNull(c.getLastName()) + ", "
                    +table.getColumn(4)+"=" + replaceNull(c.getEmail()) + ", "
                    +table.getColumn(5)+"=" + replaceNull(c.getStudyReason()) + ", "
                    +table.getColumn(6)+"=" + replaceNull(c.getBeginDate()) + ", "
                    +table.getColumn(7)+"=" + replaceNull(c.getIntendedLanguage()) + ", "
                    +table.getColumn(8)+"=" + replaceNull(c.getRemarks()) + ", "
                    +table.getColumn(9)+"=" + replaceNull(c.getTelephoneNumber()) + ", "
                    +table.getColumn(10)+"=" + replaceNull(c.getStudentActive()) + " WHERE "
                    +table.getColumn(0)+"='" + c.getStudentID() + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public String getEmailText(int textID){
        Table table=TableManager.getTable(TableManager.RPS_EMAILTEXT);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+textID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            int methodUserID=0;
            String remarks="";
            while(rs.next()){
                methodUserID=rs.getInt(table.getColumn(0));
                remarks=rs.getString(table.getColumn(1));
            }
            if(methodUserID==textID){
                return remarks;
            }else{
                addEmailText(textID);
                return "";
            }
        } catch (Exception e) {
            setError(e.toString());
            return "";
        }
    }

    public void addEmailText(int textID){
        Table table=TableManager.getTable(TableManager.RPS_EMAILTEXT);
        String defaultRemarks=null;
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(0)+","+table.getColumn(1)+")VALUES('"+textID+"',"+replaceNull(defaultRemarks)+")";
            DBHelper.getInstance().updateQuery(q);
        } catch (Exception e) {
            setError(e.toString());
        }
    }

    public boolean updateEmailText(int textID, String textDesc){
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_EMAILTEXT);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"="
                    + replaceNull(textDesc)+ " WHERE "+table.getColumn(0)+"='" +textID+ "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean canSeeStudentMesseList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"17.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewStudentMesse(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"17.1.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateStudentMesse(int loginUser){
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
