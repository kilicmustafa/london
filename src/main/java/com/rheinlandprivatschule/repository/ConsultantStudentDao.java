package com.rheinlandprivatschule.repository;


import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Table;
import com.rheinlandprivatschule.model.Werbung;

import java.sql.*;
import java.util.Vector;


public class ConsultantStudentDao {

    public boolean addStudentConsultant(Werbung w) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_CONSULTANTSTUDENT);
        try {
            String q = "INSERT INTO " + table.getTableName() + "("
                    + table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+","
                    +table.getColumn(9)+","
                    +table.getColumn(10)+","
                    +table.getColumn(11)+","
                    +table.getColumn(12)+")VALUES("
                    + replaceNull(w.getConsultantID())+","
                    +replaceNull(w.getFirstName())+","
                    +replaceNull(w.getLastName())+","
                    +replaceNull(w.getEmail())+", DATE_ADD("
                    +replaceNull(w.getBeginDate())+" ,INTERVAL -3 month),"
                    +replaceNull(w.getRemarks())+","
                    +replaceNull(w.getTelephoneNumber())+","
                    +replaceNull(w.getFax())+","
                    +replaceNull(w.getMobile())+","
                    +replaceNull(w.getWeb())+","
                    +replaceNull(w.getConsultantAddress())+")";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteStudentConsultant(int companyID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_CONSULTANTSTUDENT);
        try {
            String q = "DELETE FROM " + table.getTableName() + " WHERE "
                    + table.getColumn(0) + "='" + companyID + "'";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public Werbung getStudentConsultant(int companyID) {
        Werbung werbungClass = new Werbung();
        Table table = TableManager.getTable(TableManager.RPS_CONSULTANTSTUDENT);
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
                    +table.getColumn(10)+","
                    +table.getColumn(11)+","
                    +table.getColumn(12)+" FROM "
                    + table.getTableName() + " WHERE "
                    + table.getColumn(0)+ "='" + companyID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setStudentID(rs.getInt(table.getColumn(0)));
                werbungClass.setConsultantID(rs.getInt(table.getColumn(1)));
                werbungClass.setFirstName(rs.getString(table.getColumn(2)));
                werbungClass.setLastName(rs.getString(table.getColumn(3)));
                werbungClass.setEmail(rs.getString(table.getColumn(4)));
                werbungClass.setBeginDate(rs.getDate(table.getColumn(5)));
                werbungClass.setRemarks(rs.getString(table.getColumn(6)));
                werbungClass.setTelephoneNumber(rs.getString(table.getColumn(7)));
                werbungClass.setStudentActive(rs.getInt(table.getColumn(8)));
                werbungClass.setFax(rs.getString(table.getColumn(9)));
                werbungClass.setMobile(rs.getString(table.getColumn(10)));
                werbungClass.setWeb(rs.getString(table.getColumn(11)));
                werbungClass.setConsultantAddress(rs.getString(table.getColumn(12)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Werbung getMinStudentID(int consultantID) {
        Werbung werbungClass = new Werbung();
        try {
            String q = "select MIN(companyID) AS companyID from RPS_consultantstudent WHERE studentActive = 0 AND beginDate <= curdate() AND consultantID ="+consultantID;

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setStudentID(rs.getInt("companyID"));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Werbung getMinStudentIDN(int consultantID) {
        Werbung werbungClass = new Werbung();
        try {
            String q = "select MIN(companyID) AS companyID from RPS_consultantstudent WHERE studentActive = 1 AND beginDate <= curdate() AND consultantID ="+consultantID;

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setStudentID(rs.getInt("companyID"));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Werbung getMinStudentIDInterested(int consultantID) {
        Werbung werbungClass = new Werbung();
        try {
            String q = "select MIN(companyID) AS companyID from RPS_consultantstudent WHERE studentActive = 2 AND beginDate <= curdate() AND consultantID ="+consultantID;

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setStudentID(rs.getInt("companyID"));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Werbung getMinInterested() {
        Werbung werbungClass = new Werbung();
        try {
            String q = "select MIN(companyID) AS companyID from RPS_consultantstudent WHERE studentActive = 2 AND beginDate <= curdate()";

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setStudentID(rs.getInt("companyID"));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Werbung getNextDay(int companyID) {
        Werbung werbungClass = new Werbung();
        try {
            String q = "select DATE_ADD(curdate(),INTERVAL 1 day) AS beginDate from RPS_consultantstudent where companyID="+companyID;

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setBeginDate(rs.getDate("beginDate"));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Werbung getMaxStudentID(int consultantID, int companyID) {
        int active =0;
        Werbung werbungClass = new Werbung();
        Table table = TableManager.getTable(TableManager.RPS_CONSULTANTSTUDENT);
        try {
            String q = "SELECT "+table.getColumn(0)+ " FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+">" + companyID +" AND "
                    +table.getColumn(8)+"=" + active +" AND "
                    +table.getColumn(5)+"<= curdate() AND "
                    +table.getColumn(1)+"= "+ consultantID +" limit 1";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setStudentID(rs.getInt(table.getColumn(0)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Werbung getMaxStudentIDN(int consultantID, int companyID) {
        int active =1;
        Werbung werbungClass = new Werbung();
        Table table = TableManager.getTable(TableManager.RPS_CONSULTANTSTUDENT);
        try {
            String q = "SELECT "+table.getColumn(0)+ " FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+">" + companyID +" AND "
                    +table.getColumn(8)+"=" + active +" AND "
                    +table.getColumn(5)+"<= curdate() AND "
                    +table.getColumn(1)+"= "+ consultantID +" limit 1";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setStudentID(rs.getInt(table.getColumn(0)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Werbung getMaxStudentIDInterested(int consultantID, int companyID) {
        int active =2;
        Werbung werbungClass = new Werbung();
        Table table = TableManager.getTable(TableManager.RPS_CONSULTANTSTUDENT);
        try {
            String q = "SELECT "+table.getColumn(0)+ " FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+">" + companyID +" AND "
                    +table.getColumn(8)+"=" + active +" AND "
                    +table.getColumn(5)+"<= curdate() AND "
                    +table.getColumn(1)+"= "+ consultantID +" limit 1";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setStudentID(rs.getInt(table.getColumn(0)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Werbung getMaxInterested(int companyID) {
        int active =2;
        Werbung werbungClass = new Werbung();
        Table table = TableManager.getTable(TableManager.RPS_CONSULTANTSTUDENT);
        try {
            String q = "SELECT "+table.getColumn(0)+ " FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+">" + companyID +" AND "
                    +table.getColumn(8)+"=" + active +" AND "
                    +table.getColumn(5)+"<= curdate() limit 1";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                werbungClass.setStudentID(rs.getInt(table.getColumn(0)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return werbungClass;
    }

    public Vector<Werbung> getAllStudentConsultant(int consultantID) {
        Vector<Werbung> v = new Vector<Werbung>();
        Table table=TableManager.getTable(TableManager.RPS_CONSULTANTSTUDENT);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+","
                    +table.getColumn(9)+","
                    +table.getColumn(10)+","
                    +table.getColumn(11)+","
                    +table.getColumn(12)+" FROM "
                    + table.getTableName() + " WHERE "
                    + table.getColumn(1)+ "='" + consultantID + "' ORDER BY " + table.getColumn(2);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Werbung w = new Werbung();
                w.setStudentID(rs.getInt(table.getColumn(0)));
                w.setConsultantID(rs.getInt(table.getColumn(1)));
                w.setFirstName(rs.getString(table.getColumn(2)));
                w.setLastName(rs.getString(table.getColumn(3)));
                w.setEmail(rs.getString(table.getColumn(4)));
                w.setBeginDate(rs.getDate(table.getColumn(5)));
                w.setRemarks(rs.getString(table.getColumn(6)));
                w.setTelephoneNumber(rs.getString(table.getColumn(7)));
                w.setFax(rs.getString(table.getColumn(9)));
                w.setMobile(rs.getString(table.getColumn(10)));
                w.setWeb(rs.getString(table.getColumn(11)));
                w.setConsultantAddress(rs.getString(table.getColumn(12)));
                v.addElement(w);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<Werbung> getAllStudentMesse() {
        Vector<Werbung> v = new Vector<Werbung>();
        Table table=TableManager.getTable(TableManager.RPS_CONSULTANTSTUDENT);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+","
                    +table.getColumn(9)+","
                    +table.getColumn(10)+","
                    +table.getColumn(11)+","
                    +table.getColumn(12)+" FROM "
                    + table.getTableName();
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Werbung w = new Werbung();
                w.setStudentID(rs.getInt(table.getColumn(0)));
                w.setConsultantID(rs.getInt(table.getColumn(1)));
                w.setFirstName(rs.getString(table.getColumn(2)));
                w.setLastName(rs.getString(table.getColumn(3)));
                w.setEmail(rs.getString(table.getColumn(4)));
                w.setBeginDate(rs.getDate(table.getColumn(5)));
                w.setRemarks(rs.getString(table.getColumn(6)));
                w.setTelephoneNumber(rs.getString(table.getColumn(7)));
                w.setFax(rs.getString(table.getColumn(9)));
                w.setMobile(rs.getString(table.getColumn(10)));
                w.setWeb(rs.getString(table.getColumn(11)));
                w.setConsultantAddress(rs.getString(table.getColumn(12)));
                v.addElement(w);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<Werbung> getAllStudentEmail() {
        Vector<Werbung> v = new Vector<Werbung>();
        Table table=TableManager.getTable(TableManager.RPS_CONSULTANTSTUDENT);
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

    public Vector<Werbung> getAllStudentTelephone(int consultantID) {
        int active=0;
        Vector<Werbung> v = new Vector<Werbung>();
        Table table=TableManager.getTable(TableManager.RPS_CONSULTANTSTUDENT);
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
                    +table.getColumn(10)+","
                    +table.getColumn(11)+","
                    +table.getColumn(12)+" FROM "
                    +table.getTableName() + " WHERE "
                    +table.getColumn(5)+"<= curdate() AND "
                    +table.getColumn(8)+"=" + active + " AND "
                    +table.getColumn(1)+ "='" + consultantID +"' ORDER BY " + table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Werbung w = new Werbung();
                w.setStudentID(rs.getInt(table.getColumn(0)));
                w.setConsultantID(rs.getInt(table.getColumn(1)));
                w.setFirstName(rs.getString(table.getColumn(2)));
                w.setLastName(rs.getString(table.getColumn(3)));
                w.setEmail(rs.getString(table.getColumn(4)));
                w.setBeginDate(rs.getDate(table.getColumn(5)));
                w.setRemarks(rs.getString(table.getColumn(6)));
                w.setTelephoneNumber(rs.getString(table.getColumn(7)));
                w.setStudentActive(rs.getInt(table.getColumn(8)));
                w.setFax(rs.getString(table.getColumn(9)));
                w.setMobile(rs.getString(table.getColumn(10)));
                w.setWeb(rs.getString(table.getColumn(11)));
                w.setConsultantAddress(rs.getString(table.getColumn(12)));
                v.addElement(w);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<Werbung> getAllStudentTelephoneN(int consultantID) {
        int active=1;
        Vector<Werbung> v = new Vector<Werbung>();
        Table table=TableManager.getTable(TableManager.RPS_CONSULTANTSTUDENT);
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
                    +table.getColumn(10)+","
                    +table.getColumn(11)+","
                    +table.getColumn(12)+" FROM "
                    +table.getTableName() + " WHERE "
                    +table.getColumn(5)+"<= curdate() AND "
                    +table.getColumn(8)+"=" + active + " AND "
                    +table.getColumn(1)+ "='" + consultantID +"' ORDER BY " + table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Werbung w = new Werbung();
                w.setStudentID(rs.getInt(table.getColumn(0)));
                w.setConsultantID(rs.getInt(table.getColumn(1)));
                w.setFirstName(rs.getString(table.getColumn(2)));
                w.setLastName(rs.getString(table.getColumn(3)));
                w.setEmail(rs.getString(table.getColumn(4)));
                w.setBeginDate(rs.getDate(table.getColumn(5)));
                w.setRemarks(rs.getString(table.getColumn(6)));
                w.setTelephoneNumber(rs.getString(table.getColumn(7)));
                w.setStudentActive(rs.getInt(table.getColumn(8)));
                w.setFax(rs.getString(table.getColumn(9)));
                w.setMobile(rs.getString(table.getColumn(10)));
                w.setWeb(rs.getString(table.getColumn(11)));
                w.setConsultantAddress(rs.getString(table.getColumn(12)));
                v.addElement(w);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<Werbung> getAllStudentTelephoneInterested(int consultantID) {
        int active=2;
        Vector<Werbung> v = new Vector<Werbung>();
        Table table=TableManager.getTable(TableManager.RPS_CONSULTANTSTUDENT);
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
                    +table.getColumn(10)+","
                    +table.getColumn(11)+","
                    +table.getColumn(12)+" FROM "
                    +table.getTableName() + " WHERE "
                    +table.getColumn(5)+"<= curdate() AND "
                    +table.getColumn(8)+"=" + active + " AND "
                    +table.getColumn(1)+ "='" + consultantID +"' ORDER BY " + table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Werbung w = new Werbung();
                w.setStudentID(rs.getInt(table.getColumn(0)));
                w.setConsultantID(rs.getInt(table.getColumn(1)));
                w.setFirstName(rs.getString(table.getColumn(2)));
                w.setLastName(rs.getString(table.getColumn(3)));
                w.setEmail(rs.getString(table.getColumn(4)));
                w.setBeginDate(rs.getDate(table.getColumn(5)));
                w.setRemarks(rs.getString(table.getColumn(6)));
                w.setTelephoneNumber(rs.getString(table.getColumn(7)));
                w.setStudentActive(rs.getInt(table.getColumn(8)));
                w.setFax(rs.getString(table.getColumn(9)));
                w.setMobile(rs.getString(table.getColumn(10)));
                w.setWeb(rs.getString(table.getColumn(11)));
                w.setConsultantAddress(rs.getString(table.getColumn(12)));
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
        Table table=TableManager.getTable(TableManager.RPS_CONSULTANTSTUDENT);
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
                    +table.getColumn(10)+","
                    +table.getColumn(11)+","
                    +table.getColumn(12)+" FROM "
                    +table.getTableName() + " WHERE "
                    +table.getColumn(5)+"<= curdate() AND "
                    +table.getColumn(8)+"=" + active + " ORDER BY " + table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Werbung w = new Werbung();
                w.setStudentID(rs.getInt(table.getColumn(0)));
                w.setConsultantID(rs.getInt(table.getColumn(1)));
                w.setFirstName(rs.getString(table.getColumn(2)));
                w.setLastName(rs.getString(table.getColumn(3)));
                w.setEmail(rs.getString(table.getColumn(4)));
                w.setBeginDate(rs.getDate(table.getColumn(5)));
                w.setRemarks(rs.getString(table.getColumn(6)));
                w.setTelephoneNumber(rs.getString(table.getColumn(7)));
                w.setStudentActive(rs.getInt(table.getColumn(8)));
                w.setFax(rs.getString(table.getColumn(9)));
                w.setMobile(rs.getString(table.getColumn(10)));
                w.setWeb(rs.getString(table.getColumn(11)));
                w.setConsultantAddress(rs.getString(table.getColumn(12)));
                v.addElement(w);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }


    public boolean updateStudentConsultant(Werbung c){
        boolean result=false;
        Table table=TableManager.getTable(TableManager.RPS_CONSULTANTSTUDENT);
        try{
            String q = "UPDATE "+table.getTableName()+" SET "
                    +table.getColumn(2)+"=" + replaceNull(c.getFirstName()) + ", "
                    +table.getColumn(3)+"=" + replaceNull(c.getLastName()) + ", "
                    +table.getColumn(4)+"=" + replaceNull(c.getEmail()) + ", "
                    +table.getColumn(5)+"=" + replaceNull(c.getBeginDate()) + ", "
                    +table.getColumn(6)+"=" + replaceNull(c.getRemarks()) + ", "
                    +table.getColumn(7)+"=" + replaceNull(c.getTelephoneNumber()) + ", "
                    +table.getColumn(8)+"=" + replaceNull(c.getStudentActive()) + ", "
                    +table.getColumn(9)+"=" + replaceNull(c.getFax()) + ", "
                    +table.getColumn(10)+"=" + replaceNull(c.getMobile()) + ", "
                    +table.getColumn(11)+"=" + replaceNull(c.getWeb()) + ", "
                    +table.getColumn(12)+"=" + replaceNull(c.getConsultantAddress()) + " WHERE "
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

    public boolean canSeeStudentConsultantList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"11.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewStudentConsultant(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"11.1.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateStudentConsultant(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"11.1.2");
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
