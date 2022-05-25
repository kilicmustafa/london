package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Table;
import com.rheinlandprivatschule.model.Transaction;

import java.sql.*;
import java.util.ArrayList;


public class TransactionDao{

    public synchronized int addTransaction(double tranPay,Date tranDate,int tranType,int studentID,int courseID,int placeID,int loginUserID, int initialTest){
        int transactionNo =-1;
        Table table= TableManager.getTable(TableManager.RPS_TRAN);
        try{
            String q = "INSERT INTO "+table.getTableName()+"("
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+","
                    +table.getColumn(8)+") VALUES('"
                    +tranPay+ "',"
                    +replaceNull(tranDate)
                    + ",'"+tranType+ "','"
                    +studentID+"','"
                    +courseID+"','"
                    +placeID+"','"
                    +loginUserID+"','"
                    +initialTest+"')";
            DBHelper.getInstance().updateQuery(q);
            q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName();
            ResultSet rs=DBHelper.getInstance().executeQuery(q);;
            int value=0;
            while(rs.next()){
                value = rs.getInt(table.getColumn(0));
            }
            if(value>0){
                transactionNo=value;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return transactionNo;
    }

    public synchronized int addNullGebuhr(double tranPay, java.util.Date tranDate, int tranType, int studentID, int courseID, int placeID, int loginUserID) {
        int transactionNo = -1;
        Table table = TableManager.getTable(TableManager.RPS_NULLGEBUHR);
        try {
            String q = "INSERT INTO " + table.getTableName() + "(" +
                    table.getColumn(1) + "," +
                    table.getColumn(2) + "," +
                    table.getColumn(3) + "," +
                    table.getColumn(4) + "," +
                    table.getColumn(5) + "," +
                    table.getColumn(6) + "," +
                    table.getColumn(7) + ") VALUES('" +
                    tranPay + "'," +
                    replaceNull(tranDate) + ",'" +
                    tranType + "','" +
                    studentID + "','" +
                    courseID + "','" +
                    placeID + "','" +
                    loginUserID + "')";
            DBHelper.getInstance().updateQuery(q);
            q = "SELECT " + table.getColumn(0) + " FROM " + table.getTableName();
            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            int value = 0;
            while (rs.next()) {
                value = rs.getInt(table.getColumn(0));
            }
            if (value > 0)
                transactionNo = value;
        }
        catch (Exception e) {
            setError(e.toString());
        }
        return transactionNo;
    }

    public synchronized int addPrintRegRecord(double tranPay, java.util.Date tranDate, int tranType, int studentID, int courseID, int placeID, int loginUserID) {
        int transactionNo = -1;
        Table table = TableManager.getTable(TableManager.RPS_PRINTREGRECORD);
        try {
            String q = "INSERT INTO " + table.getTableName() + "(" +
                    table.getColumn(1) + "," +
                    table.getColumn(2) + "," +
                    table.getColumn(3) + "," +
                    table.getColumn(4) + "," +
                    table.getColumn(5) + "," +
                    table.getColumn(6) + "," +
                    table.getColumn(7) + ") VALUES('" +
                    tranPay + "'," +
                    replaceNull(tranDate) + ",'" +
                    tranType + "','" +
                    studentID + "','" +
                    courseID + "','" +
                    placeID + "','" +
                    loginUserID + "')";
            DBHelper.getInstance().updateQuery(q);
            q = "SELECT " + table.getColumn(0) + " FROM " + table.getTableName();
            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            int value = 0;
            while (rs.next()) {
                value = rs.getInt(table.getColumn(0));
            }
            if (value > 0)
                transactionNo = value;
        }
        catch (Exception e) {
            setError(e.toString());
        }
        return transactionNo;
    }

    public synchronized int addXtraCostTran(int courseID, double tranPay, int tranType, java.util.Date tranDate, int studentID, int placeID, int loginUserID) {
        int transactionNo = -1;
        Table table = TableManager.getTable(TableManager.RPS_TRAN_XTRA);
        try {
            String q = "INSERT INTO " + table.getTableName() + "(" +
                    table.getColumn(1) + "," +
                    table.getColumn(2) + "," +
                    table.getColumn(3) + "," +
                    table.getColumn(4) + "," +
                    table.getColumn(5) + "," +
                    table.getColumn(6) + "," +
                    table.getColumn(7) + ") VALUES('" +
                    courseID + "'," +
                    tranPay + ",'" +
                    tranDate + "','" +
                    tranType + "','" +
                    studentID + "','" +
                    placeID + "','" +
                    loginUserID + "')";
            DBHelper.getInstance().updateQuery(q);
            q = "SELECT " + table.getColumn(0) + " FROM " + table.getTableName();
            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            int value = 0;
            while (rs.next()) {
                value = rs.getInt(table.getColumn(0));
            }
            if (value > 0)
                transactionNo = value;
        }
        catch (Exception e) {
            setError(e.toString());
        }
        return transactionNo;
    }

    public synchronized int addKassea(double kassePay, java.util.Date kasseDate, int placeID, int loginUserID) {
        int kasseNo = -1;
        Table table = TableManager.getTable(TableManager.RPS_KASSE);
        try {
            String q = "INSERT INTO " + table.getTableName() + "(" +
                    table.getColumn(1) + "," +
                    table.getColumn(2) + "," +
                    table.getColumn(3) + "," +
                    table.getColumn(4) + ") VALUES('" +
                    kassePay + "'," +
                    replaceNull(kasseDate) + ",'" +
                    placeID + "','" +
                    loginUserID + "')";
            DBHelper.getInstance().updateQuery(q);
            q = "SELECT " + table.getColumn(0) + " FROM " + table.getTableName();
            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            int value = 0;
            while (rs.next()) {
                value = rs.getInt(table.getColumn(0));
            }
            if (value > 0)
                kasseNo = value;
        }
        catch (Exception e) {
            setError(e.toString());
        }
        return kasseNo;
    }

    public ArrayList<Transaction> getTransactions(int studentID, int courseID) {

        ArrayList<Transaction> v = new ArrayList<Transaction>();
        Table tran_table = TableManager.getTable(TableManager.RPS_TRAN);
        Table student_table = TableManager.getTable(TableManager.RPS_USER);
        Table place_table=TableManager.getTable(TableManager.RPS_PLACE);
        Table loginuser_table = TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {

            String q = "SELECT a." + tran_table.getColumn(0) + ",a."
                    + tran_table.getColumn(1) + ",a." + tran_table.getColumn(2)
                    + ",a." + tran_table.getColumn(3) + ",a."
                    + tran_table.getColumn(4) + ",CONCAT_WS(' ',b."
                    + student_table.getColumn(1) + ",b."
                    + student_table.getColumn(2) + ") AS studentName ,a."
                    + tran_table.getColumn(5) + ",a."
                    + tran_table.getColumn(6) + ",d.placeName,a."
                    + tran_table.getColumn(7) + ",CONCAT_WS(' ',e."
                    + loginuser_table.getColumn(1) + ",e."
                    + loginuser_table.getColumn(2) + ") AS loginUserName"
                    + " FROM " + tran_table.getTableName() + " AS a,"
                    + student_table.getTableName() + " AS b,"
                    + place_table.getTableName()+" AS d,"
                    + loginuser_table.getTableName() + " AS e"
                    + " WHERE a."
                    + tran_table.getColumn(4) + "=b."
                    + student_table.getColumn(0) + " AND a."
                    + tran_table.getColumn(6) + "=d."+place_table.getColumn(0)+" AND a."
                    + tran_table.getColumn(7) + "=e."
                    + loginuser_table.getColumn(0) + " AND a."
                    + tran_table.getColumn(4) + "='" + studentID + "' AND a."
                    + tran_table.getColumn(5) + "='" + courseID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            while (rs.next()) {
                Transaction tr = new Transaction();
                tr.setTransactionNo(rs.getInt(tran_table.getColumn(0)));
                tr.setPaid(rs.getDouble(tran_table.getColumn(1)));
                tr.setPaymentDate(rs.getDate(tran_table.getColumn(2)));
                tr.setPaymentType(rs.getInt(tran_table.getColumn(3)));
                tr.setStudentID(rs.getInt(tran_table.getColumn(4)));
                tr.setCourseID(rs.getInt(tran_table.getColumn(5)));
                tr.setPlaceID(rs.getInt(tran_table.getColumn(6)));
                tr.setLoginUserID(rs.getInt(tran_table.getColumn(7)));
                tr.setStudentCompleteName(rs.getString("studentName"));
                tr.setCourseName("");
                tr.setPlaceName(rs.getString(place_table.getColumn(1)));
                tr.setLoginUserCompleteName(rs.getString("loginUserName"));
                v.add(tr);
            }

        } catch (Exception e) {
            setError(e.toString());
        }
        return completeTransactionsInformation(v);
    }

    public ArrayList<Transaction> getNullGebTran(int studentID, int courseID)
    {
        ArrayList<Transaction> v = new ArrayList<Transaction>();
        Table tran_table = TableManager.getTable(TableManager.RPS_NULLGEBUHR);
        Table student_table = TableManager.getTable(TableManager.RPS_USER);
        Table place_table = TableManager.getTable(TableManager.RPS_PLACE);
        Table loginuser_table = TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try
        {
            String q = "SELECT a." + tran_table.getColumn(0) + ",a." +
                    tran_table.getColumn(1) + ",a." +
                    tran_table.getColumn(2) + ",a." +
                    tran_table.getColumn(3) + ",a." +
                    tran_table.getColumn(4) + ",CONCAT_WS(' ',b." +
                    student_table.getColumn(1) + ",b." +
                    student_table.getColumn(2) + ") AS studentName ,a." +
                    tran_table.getColumn(5) + ",a." +
                    tran_table.getColumn(6) + ",d.placeName,a." +
                    tran_table.getColumn(7) + ",CONCAT_WS(' ',e." +
                    loginuser_table.getColumn(1) + ",e." +
                    loginuser_table.getColumn(2) + ") AS loginUserName" +
                    " FROM " + tran_table.getTableName() + " AS a," +
                    student_table.getTableName() + " AS b," +
                    place_table.getTableName() + " AS d," +
                    loginuser_table.getTableName() + " AS e" + " WHERE a." +
                    tran_table.getColumn(4) + "=b." +
                    student_table.getColumn(0) + " AND a." +
                    tran_table.getColumn(6) + "=d." + place_table.getColumn(0) + " AND a." +
                    tran_table.getColumn(7) + "=e." +
                    loginuser_table.getColumn(0) + " AND a." +
                    tran_table.getColumn(4) + "='" + studentID + "' AND a." +
                    tran_table.getColumn(5) + "='" + courseID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            while (rs.next()) {
                Transaction tr = new Transaction();
                tr.setTransactionNo(rs.getInt(tran_table.getColumn(0)));
                tr.setPaid(rs.getDouble(tran_table.getColumn(1)));
                tr.setPaymentDate(rs.getDate(tran_table.getColumn(2)));
                tr.setPaymentType(rs.getInt(tran_table.getColumn(3)));
                tr.setStudentID(rs.getInt(tran_table.getColumn(4)));
                tr.setCourseID(rs.getInt(tran_table.getColumn(5)));
                tr.setPlaceID(rs.getInt(tran_table.getColumn(6)));
                tr.setLoginUserID(rs.getInt(tran_table.getColumn(7)));
                tr.setStudentCompleteName(rs.getString("studentName"));
                tr.setCourseName("");
                tr.setPlaceName(rs.getString(place_table.getColumn(1)));
                tr.setLoginUserCompleteName(rs.getString("loginUserName"));
                v.add(tr);
            }
        }
        catch (Exception e) {
            setError(e.toString());
        }
        return completeTransactionsInformation(v);
    }

    public ArrayList<Transaction> getPrintRegRecord(int studentID, int courseID)
    {
        ArrayList<Transaction> v = new ArrayList<Transaction>();
        Table tran_table = TableManager.getTable(TableManager.RPS_PRINTREGRECORD);
        Table student_table = TableManager.getTable(TableManager.RPS_USER);
        Table place_table = TableManager.getTable(TableManager.RPS_PLACE);
        Table loginuser_table = TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try
        {
            String q = "SELECT a." + tran_table.getColumn(0) + ",a." +
                    tran_table.getColumn(1) + ",a." +
                    tran_table.getColumn(2) + ",a." +
                    tran_table.getColumn(3) + ",a." +
                    tran_table.getColumn(4) + ",CONCAT_WS(' ',b." +
                    student_table.getColumn(1) + ",b." +
                    student_table.getColumn(2) + ") AS studentName ,a." +
                    tran_table.getColumn(5) + ",a." +
                    tran_table.getColumn(6) + ",d.placeName,a." +
                    tran_table.getColumn(7) + ",CONCAT_WS(' ',e." +
                    loginuser_table.getColumn(1) + ",e." +
                    loginuser_table.getColumn(2) + ") AS loginUserName" +
                    " FROM " + tran_table.getTableName() + " AS a," +
                    student_table.getTableName() + " AS b," +
                    place_table.getTableName() + " AS d," +
                    loginuser_table.getTableName() + " AS e" + " WHERE a." +
                    tran_table.getColumn(4) + "=b." +
                    student_table.getColumn(0) + " AND a." +
                    tran_table.getColumn(6) + "=d." + place_table.getColumn(0) + " AND a." +
                    tran_table.getColumn(7) + "=e." +
                    loginuser_table.getColumn(0) + " AND a." +
                    tran_table.getColumn(4) + "='" + studentID + "' AND a." +
                    tran_table.getColumn(5) + "='" + courseID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            while (rs.next()) {
                Transaction tr = new Transaction();
                tr.setTransactionNo(rs.getInt(tran_table.getColumn(0)));
                tr.setPaid(rs.getDouble(tran_table.getColumn(1)));
                tr.setPaymentDate(rs.getDate(tran_table.getColumn(2)));
                tr.setPaymentType(rs.getInt(tran_table.getColumn(3)));
                tr.setStudentID(rs.getInt(tran_table.getColumn(4)));
                tr.setCourseID(rs.getInt(tran_table.getColumn(5)));
                tr.setPlaceID(rs.getInt(tran_table.getColumn(6)));
                tr.setLoginUserID(rs.getInt(tran_table.getColumn(7)));
                tr.setStudentCompleteName(rs.getString("studentName"));
                tr.setCourseName("");
                tr.setPlaceName(rs.getString(place_table.getColumn(1)));
                tr.setLoginUserCompleteName(rs.getString("loginUserName"));
                v.add(tr);
            }
        }
        catch (Exception e) {
            setError(e.toString());
        }
        return completeTransactionsInformation(v);
    }

    public Transaction getTransaction(int transactionNo) {
        Transaction tr = new Transaction();
        Table tran_table = TableManager.getTable(TableManager.RPS_TRAN);
        Table student_table = TableManager.getTable(TableManager.RPS_USER);
        Table place_table=TableManager.getTable(TableManager.RPS_PLACE);
        Table loginuser_table = TableManager
                .getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "SELECT a." + tran_table.getColumn(0) + ",a."
                    + tran_table.getColumn(1) + ",a." + tran_table.getColumn(2)
                    + ",a." + tran_table.getColumn(3) + ",a."
                    + tran_table.getColumn(4) + ",CONCAT_WS(' ',b."
                    + student_table.getColumn(1) + ",b."
                    + student_table.getColumn(2) + ") AS studentName ,a."
                    + tran_table.getColumn(5) + ",a." + tran_table.getColumn(6)
                    + ",d.placeName,a." + tran_table.getColumn(7)
                    + ",CONCAT_WS(' ',e." + loginuser_table.getColumn(1)
                    + ",e." + loginuser_table.getColumn(2)
                    + ") AS loginUserName" + " FROM "
                    + tran_table.getTableName() + " AS a,"
                    + student_table.getTableName() + " AS b,"
                    + place_table.getTableName()+" AS d," + loginuser_table.getTableName()
                    + " AS e" + " WHERE a." + tran_table.getColumn(4) + "=b."
                    + student_table.getColumn(0) + " AND a."
                    + tran_table.getColumn(6) + "=d."+place_table.getColumn(0)+" AND a."
                    + tran_table.getColumn(7) + "=e."
                    + loginuser_table.getColumn(0) + " AND a."
                    + tran_table.getColumn(0) + "='" + transactionNo + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            while (rs.next()) {
                tr.setTransactionNo(rs.getInt(tran_table.getColumn(0)));
                tr.setPaid(rs.getDouble(tran_table.getColumn(1)));
                tr.setPaymentDate(rs.getDate(tran_table.getColumn(2)));
                tr.setPaymentType(rs.getInt(tran_table.getColumn(3)));
                tr.setStudentID(rs.getInt(tran_table.getColumn(4)));
                tr.setCourseID(rs.getInt(tran_table.getColumn(5)));
                tr.setPlaceID(rs.getInt(tran_table.getColumn(6)));
                tr.setLoginUserID(rs.getInt(tran_table.getColumn(7)));
                tr.setStudentCompleteName(rs.getString("studentName"));
                tr.setCourseName("");
                tr.setPlaceName(rs.getString(place_table.getColumn(1)));
                tr.setLoginUserCompleteName(rs.getString("loginUserName"));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return completeTransactionInformation(tr);
    }

    private ArrayList<Transaction> completeTransactionsInformation(ArrayList<Transaction> transactions){
        try{
            CourseDao CourseDao=new CourseDao();
            for(int i=0;i<transactions.size();i++){
                Transaction transaction=(Transaction)transactions.get(i);
                int tempCourseID=transaction.getCourseID();
                if(tempCourseID==0){
                    transaction.setCourseName("Einzelunterricht");
                }else{
                    String courseName=CourseDao.getCourseNameOnly(tempCourseID);
                    transaction.setCourseName(courseName);
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return transactions;
    }

    private Transaction completeTransactionInformation(Transaction transaction){
        try{
            CourseDao CourseDao=new CourseDao();
            int tempCourseID=transaction.getCourseID();
            if(tempCourseID==0){
                transaction.setCourseName("Einzelunterricht");
            }else{
                String courseName=CourseDao.getCourseNameOnly(tempCourseID);
                transaction.setCourseName(courseName);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return transaction;
    }



    public ArrayList<Transaction> getTransactionsByStudent(int studentID,int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "2.6.12");
        if(flag){
            ArrayList<Transaction> result=new ArrayList<Transaction>();
            Table tran_table = TableManager.getTable(TableManager.RPS_TRAN);
            Table student_table = TableManager.getTable(TableManager.RPS_USER);
            Table place_table=TableManager.getTable(TableManager.RPS_PLACE);
            Table loginuser_table = TableManager.getTable(TableManager.RPS_SYSTEMUSER);

            try {
                String q = "SELECT a." + tran_table.getColumn(0) + ",a."
                        + tran_table.getColumn(1) + ",a." + tran_table.getColumn(2)
                        + ",a." + tran_table.getColumn(3) + ",a."
                        + tran_table.getColumn(4) + ",CONCAT_WS(' ',b."
                        + student_table.getColumn(1) + ",b."
                        + student_table.getColumn(2) + ") AS studentName ,a."
                        + tran_table.getColumn(5) + ",a."
                        + tran_table.getColumn(6) + ",d.placeName,a."
                        + tran_table.getColumn(7) + ",CONCAT_WS(' ',e."
                        + loginuser_table.getColumn(1) + ",e."
                        + loginuser_table.getColumn(2) + ") AS loginUserName"
                        + " FROM " + tran_table.getTableName() + " AS a,"
                        + student_table.getTableName() + " AS b,"
                        + place_table.getTableName()+" AS d,"
                        + loginuser_table.getTableName() + " AS e" + " WHERE a."
                        + tran_table.getColumn(4) + "=b."
                        + student_table.getColumn(0) + " AND a."
                        + tran_table.getColumn(6) + "=d."+place_table.getColumn(0)+" AND a."
                        + tran_table.getColumn(7) + "=e."
                        + loginuser_table.getColumn(0) + " AND a."
                        + tran_table.getColumn(4) + "='" + studentID + "'";
                ResultSet rs = DBHelper.getInstance().executeQuery(q);;
                while (rs.next()) {
                    Transaction tr = new Transaction();
                    tr.setTransactionNo(rs.getInt(tran_table.getColumn(0)));
                    tr.setPaid(rs.getDouble(tran_table.getColumn(1)));
                    tr.setPaymentDate(rs.getDate(tran_table.getColumn(2)));
                    tr.setPaymentType(rs.getInt(tran_table.getColumn(3)));
                    tr.setStudentID(rs.getInt(tran_table.getColumn(4)));
                    tr.setCourseID(rs.getInt(tran_table.getColumn(5)));
                    tr.setPlaceID(rs.getInt(tran_table.getColumn(6)));
                    tr.setLoginUserID(rs.getInt(tran_table.getColumn(7)));

                    tr.setStudentCompleteName(rs.getString("studentName"));
                    tr.setCourseName("");
                    tr.setPlaceName(rs.getString(place_table.getColumn(1)));
                    tr.setLoginUserCompleteName(rs.getString("loginUserName"));
                    result.add(tr);
                }
            } catch (Exception e) {
                setError(e.toString());
            }
            return completeTransactionsInformation(result);
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    public ArrayList<Transaction> getTransactions(int criteria, int adminID,Date startDate, Date endDate, int placeID, int tranNo) {
        ArrayList<Transaction> v = new ArrayList<Transaction>();
        Table tran_table = TableManager.getTable(TableManager.RPS_TRAN);
        Table student_table = TableManager.getTable(TableManager.RPS_USER);
        Table place_table=TableManager.getTable(TableManager.RPS_PLACE);
        Table loginuser_table = TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "SELECT a." + tran_table.getColumn(0) + ",a."
                    + tran_table.getColumn(1) + ",a." + tran_table.getColumn(2)
                    + ",a." + tran_table.getColumn(3) + ",a."
                    + tran_table.getColumn(4) + ",CONCAT_WS(' ',b."
                    + student_table.getColumn(1) + ",b."
                    + student_table.getColumn(2) + ") AS studentName ,a."
                    + tran_table.getColumn(5) + ",a."
                    + tran_table.getColumn(6) + ",d."+place_table.getColumn(1)+",a."
                    + tran_table.getColumn(7) + ",CONCAT_WS(' ',e."
                    + loginuser_table.getColumn(1) + ",e."
                    + loginuser_table.getColumn(2) + ") AS loginUserName"
                    + " FROM " + tran_table.getTableName() + " AS a,"
                    + student_table.getTableName() + " AS b,"
                    + place_table.getTableName()+" AS d,"
                    + loginuser_table.getTableName() + " AS e" + " WHERE a."
                    + tran_table.getColumn(4) + "=b."
                    + student_table.getColumn(0) + " AND a."
                    + tran_table.getColumn(6) + "=d."+place_table.getColumn(0)+" AND a."
                    + tran_table.getColumn(7) + "=e."
                    + loginuser_table.getColumn(0);
            if (criteria == SPECIFICDATE) {
                if (adminID > 0 && placeID > 0) {
                    q = q + " AND " + tran_table.getColumn(7) + "='" + adminID
                            + "' AND " + tran_table.getColumn(6) + "='"
                            + placeID + "' AND " + tran_table.getColumn(2)
                            + "=" + replaceNull(startDate);
                } else if (adminID == 0 && placeID > 0) {
                    q = q + " AND " + tran_table.getColumn(6) + "='" + placeID
                            + "' AND " + tran_table.getColumn(2) + "="
                            + replaceNull(startDate);
                } else if (adminID > 0 && placeID == 0) {
                    q = q + " AND " + tran_table.getColumn(7) + "='" + adminID
                            + "' AND " + tran_table.getColumn(2) + "="
                            + replaceNull(startDate);
                } else if (adminID == 0 && placeID == 0) {
                    q = q + " AND " + tran_table.getColumn(2) + "="
                            + replaceNull(startDate);
                }
            } else if (criteria == DATELIMIT) {
                if (adminID > 0 && placeID > 0) {
                    q = q + " AND " + tran_table.getColumn(7) + "='" + adminID
                            + "' AND " + tran_table.getColumn(6) + "='"
                            + placeID + "' AND " + tran_table.getColumn(2)
                            + ">=" + replaceNull(startDate) + " AND "
                            + tran_table.getColumn(2) + "<="
                            + replaceNull(endDate);
                } else if (adminID == 0 && placeID > 0) {
                    q = q + " AND " + tran_table.getColumn(6) + "='" + placeID
                            + "' AND " + tran_table.getColumn(2) + ">="
                            + replaceNull(startDate) + " AND "
                            + tran_table.getColumn(2) + "<="
                            + replaceNull(endDate);
                } else if (adminID > 0 && placeID == 0) {
                    q = q + " AND " + tran_table.getColumn(7) + "='" + adminID
                            + "' AND " + tran_table.getColumn(2) + ">="
                            + replaceNull(startDate) + " AND "
                            + tran_table.getColumn(2) + "<="
                            + replaceNull(endDate);
                } else if (adminID == 0 && placeID == 0) {
                    q = q + " AND " + tran_table.getColumn(2) + ">="
                            + replaceNull(startDate) + " AND "
                            + tran_table.getColumn(2) + "<="
                            + replaceNull(endDate);
                }
            } else if (criteria == TRANSACTIONNO) {
                q = q + " AND " + tran_table.getColumn(0) + "='" + tranNo + "'";
            }
            q = q + " ORDER BY " + tran_table.getColumn(0);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            while (rs.next()) {
                Transaction tr = new Transaction();
                tr.setTransactionNo(rs.getInt(tran_table.getColumn(0)));
                tr.setPaid(rs.getDouble(tran_table.getColumn(1)));
                tr.setPaymentDate(rs.getDate(tran_table.getColumn(2)));
                tr.setPaymentType(rs.getInt(tran_table.getColumn(3)));
                tr.setStudentID(rs.getInt(tran_table.getColumn(4)));
                tr.setCourseID(rs.getInt(tran_table.getColumn(5)));
                tr.setPlaceID(rs.getInt(tran_table.getColumn(6)));
                tr.setLoginUserID(rs.getInt(tran_table.getColumn(7)));

                tr.setStudentCompleteName(rs.getString("studentName"));
                tr.setCourseName("");
                tr.setPlaceName(rs.getString(place_table.getColumn(1)));
                tr.setLoginUserCompleteName(rs.getString("loginUserName"));
                v.add(tr);
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return completeTransactionsInformation(v);
    }

    public ArrayList<Transaction> getTransactionsMain(int criteria, int adminID, java.util.Date startDate, java.util.Date endDate, int placeID, int tranNo, int paymentType)
    {
        ArrayList<Transaction> v = new ArrayList<Transaction>();
        Table tran_table = TableManager.getTable(TableManager.RPS_TRAN);
        Table student_table = TableManager.getTable(TableManager.RPS_USER);
        Table place_table = TableManager.getTable(TableManager.RPS_PLACE);
        Table loginuser_table = TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "SELECT a." + tran_table.getColumn(0) + ",a." +
                    tran_table.getColumn(1) + ",a." +
                    tran_table.getColumn(2) + ",a." +
                    tran_table.getColumn(3) + ",a." +
                    tran_table.getColumn(4) + ",CONCAT_WS(' ',b." +
                    student_table.getColumn(1) + ",b." +
                    student_table.getColumn(2) + ") AS studentName ,a." +
                    tran_table.getColumn(5) + ",a." +
                    tran_table.getColumn(6) + ",d." +
                    place_table.getColumn(1) + ",a." +
                    tran_table.getColumn(7) + ",CONCAT_WS(' ',e." +
                    loginuser_table.getColumn(1) + ",e." +
                    loginuser_table.getColumn(2) + ") AS loginUserName" +
                    " FROM " + tran_table.getTableName() + " AS a," +
                    student_table.getTableName() + " AS b," +
                    place_table.getTableName() + " AS d," +
                    loginuser_table.getTableName() + " AS e" + " WHERE a." +
                    tran_table.getColumn(4) + "=b." + student_table.getColumn(0) + " AND a." +
                    tran_table.getColumn(6) + "=d." + place_table.getColumn(0) + " AND a." +
                    tran_table.getColumn(7) + "=e." + loginuser_table.getColumn(0);
            if (criteria == SPECIFICDATE) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
                            tran_table.getColumn(6) + "='" + placeID + "' AND " +
                            tran_table.getColumn(2) + "=" + replaceNull(startDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(6) + "='" + placeID + "' AND " +
                            tran_table.getColumn(2) + "=" + replaceNull(startDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
                            tran_table.getColumn(2) + "=" + replaceNull(startDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(2) + "=" + replaceNull(startDate);
            }
            else if ((criteria == DATELIMIT) && (paymentType == 5)) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
                            tran_table.getColumn(6) + "='" + placeID + "' AND " +
                            tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(6) + "='" + placeID + "' AND " +
                            tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
                            tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
            }
            else if ((criteria == DATELIMIT) && (paymentType < 5)) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
                            tran_table.getColumn(6) + "='" + placeID + "' AND " +
                            tran_table.getColumn(3) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(6) + "='" + placeID + "' AND " +
                            tran_table.getColumn(3) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
                            tran_table.getColumn(3) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(3) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
            }
            else if (criteria == TRANSACTIONNO) {
                q = q + " AND " + tran_table.getColumn(0) + "='" + tranNo + "'";
            }
        /*if (criteria == SPECIFICDATE) {
          if ((adminID > 0) && (placeID > 0) && (paymentType<5))
	            q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
					              tran_table.getColumn(6) + "='" + placeID + "' AND " +
					              tran_table.getColumn(3) + "='" + paymentType + "' AND " +
					              tran_table.getColumn(2) + "=" + replaceNull(startDate);
          else if ((adminID > 0) && (placeID == 0)  && (paymentType==5))
	            q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
	              				  tran_table.getColumn(2) + "=" + replaceNull(startDate);
          else if ((adminID > 0) && (placeID > 0)  && (paymentType==5))
	            q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
	              				  tran_table.getColumn(6) + "='" + placeID + "' AND " +
	                		      tran_table.getColumn(2) + "=" + replaceNull(startDate);
          else if ((adminID > 0) && (placeID == 0)  && (paymentType<5))
	            q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
				  				  tran_table.getColumn(3) + "='" + paymentType + "' AND " +
	                		      tran_table.getColumn(2) + "=" + replaceNull(startDate);
          else if ((adminID == 0) && (placeID > 0)  && (paymentType==5))
	            q = q + " AND " + tran_table.getColumn(6) + "='" + placeID + "' AND " +
	              				  tran_table.getColumn(2) + "=" + replaceNull(startDate);
          else if ((adminID == 0) && (placeID > 0)  && (paymentType<5))
	            q = q + " AND " + tran_table.getColumn(6) + "='" + placeID + "' AND " +
	              				  tran_table.getColumn(3) + "='" + paymentType + "' AND " +
	                		      tran_table.getColumn(2) + "=" + replaceNull(startDate);
          else if ((adminID == 0) && (placeID == 0)  && (paymentType<5))
	            q = q + " AND " + tran_table.getColumn(3) + "='" + paymentType + "' AND " +
	                		      tran_table.getColumn(2) + "=" + replaceNull(startDate);

          else if ((adminID == 0) && (placeID == 0) && (paymentType==5))
	            q = q + " AND " + tran_table.getColumn(2) + "=" + replaceNull(startDate);
        }
        else if (criteria == DATELIMIT) {
          if ((adminID > 0) && (placeID > 0 ) && (paymentType<5))
            q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
				              tran_table.getColumn(6) + "='" + placeID + "' AND " +
				              tran_table.getColumn(3) + "='" + paymentType + "' AND " +
				              tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
				              tran_table.getColumn(2) + "<=" + replaceNull(endDate);
          else if ((adminID > 0) && (placeID > 0) && (paymentType == 5))
        	q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
          					  tran_table.getColumn(6) + "='" + placeID + "' AND " +
			                  tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
			                  tran_table.getColumn(2) + "<=" + replaceNull(endDate);
          else if ((adminID > 0) && (placeID == 0) && (paymentType < 5))
            q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
          					  tran_table.getColumn(3) + "='" + paymentType + "' AND " +
			                  tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
			                  tran_table.getColumn(2) + "<=" + replaceNull(endDate);
          else if ((adminID > 0) && (placeID == 0) && (paymentType==0))
            q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
			                  tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
			                  tran_table.getColumn(2) + "<=" + replaceNull(endDate);
          else if ((adminID == 0) && (placeID > 0) && (paymentType < 5))
            q = q + " AND " + tran_table.getColumn(6) + "='" + placeID + "' AND " +
							  tran_table.getColumn(3) + "='" + paymentType + "' AND " +
				              tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
				              tran_table.getColumn(2) + "<=" + replaceNull(endDate);
          else if ((adminID == 0) && (placeID > 0) && (paymentType == 5))
            q = q + " AND " + tran_table.getColumn(6) + "='" + placeID + "' AND " +
  				              tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
  				              tran_table.getColumn(2) + "<=" + replaceNull(endDate);
          else if ((adminID == 0) && (placeID == 0) && (paymentType < 5))
            q = q + " AND " + tran_table.getColumn(3) + "='" + paymentType + "' AND " +
				              tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
				              tran_table.getColumn(2) + "<=" + replaceNull(endDate);
          else if ((adminID == 0) && (placeID == 0) && (paymentType == 5))
            q = q + " AND " + tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
              tran_table.getColumn(2) + "<=" + replaceNull(endDate);
        }
        else if (criteria == TRANSACTIONNO) {
          q = q + " AND " + tran_table.getColumn(0) + "='" + tranNo + "'";
        }*/
            q = q + " ORDER BY " + tran_table.getColumn(0);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            while (rs.next()) {
                Transaction tr = new Transaction();
                tr.setTransactionNo(rs.getInt(tran_table.getColumn(0)));
                tr.setPaid(rs.getDouble(tran_table.getColumn(1)));
                tr.setPaymentDate(rs.getDate(tran_table.getColumn(2)));
                tr.setPaymentType(rs.getInt(tran_table.getColumn(3)));
                tr.setStudentID(rs.getInt(tran_table.getColumn(4)));
                tr.setCourseID(rs.getInt(tran_table.getColumn(5)));
                tr.setPlaceID(rs.getInt(tran_table.getColumn(6)));
                tr.setLoginUserID(rs.getInt(tran_table.getColumn(7)));
                tr.setStudentCompleteName(rs.getString("studentName"));
                tr.setCourseName("");
                tr.setPlaceName(rs.getString(place_table.getColumn(1)));
                tr.setLoginUserCompleteName(rs.getString("loginUserName"));
                v.add(tr);
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return completeTransactionsInformation(v);
    }


    public ArrayList<Transaction> getRentTransaction(int criteria, int adminID, java.util.Date startDate, java.util.Date endDate, int placeID, int tranNo, int paymentType) {
        ArrayList<Transaction> v = new ArrayList<Transaction>();
        Table tran_table = TableManager.getTable(TableManager.RPS_RENTINCOMING);
        Table place_table = TableManager.getTable(TableManager.RPS_PLACE);
        Table loginuser_table = TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "SELECT a." + tran_table.getColumn(7) + ",a." +
                    tran_table.getColumn(0) + ",a." +
                    tran_table.getColumn(1) + ",a." +
                    tran_table.getColumn(2) + ",a." +
                    tran_table.getColumn(3) + ",a." +
                    tran_table.getColumn(5) + ",a." +
                    tran_table.getColumn(6) + ",a." +
                    tran_table.getColumn(8) + ",a." +
                    tran_table.getColumn(9) + ",a." +
                    tran_table.getColumn(11) + ",a." +
                    tran_table.getColumn(12) +
                    " FROM " + tran_table.getTableName() + " AS a," +
                    place_table.getTableName() + " AS d," +
                    loginuser_table.getTableName() + " AS e" + " WHERE a." +
                    tran_table.getColumn(11) + "=d." + place_table.getColumn(0) + " AND a." +
                    tran_table.getColumn(12) + "=e." + loginuser_table.getColumn(0);
            if (criteria == SPECIFICDATE) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(12) + "='" + adminID + "' AND " +
                            tran_table.getColumn(11) + "='" + placeID + "' AND " +
                            tran_table.getColumn(5) + "=" + replaceNull(startDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(11) + "='" + placeID + "' AND " +
                            tran_table.getColumn(5) + "=" + replaceNull(startDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(12) + "='" + adminID + "' AND " +
                            tran_table.getColumn(5) + "=" + replaceNull(startDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(5) + "=" + replaceNull(startDate);
            }
            else if ((criteria == DATELIMIT) && (paymentType == 5)) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(12) + "='" + adminID + "' AND " +
                            tran_table.getColumn(11) + "='" + placeID + "' AND " +
                            tran_table.getColumn(5) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(5) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(11) + "='" + placeID + "' AND " +
                            tran_table.getColumn(5) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(5) + "<=" + replaceNull(endDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(12) + "='" + adminID + "' AND " +
                            tran_table.getColumn(5) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(5) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(5) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(5) + "<=" + replaceNull(endDate);
            }
            else if ((criteria == DATELIMIT) && (paymentType < 5)) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(12) + "='" + adminID + "' AND " +
                            tran_table.getColumn(11) + "='" + placeID + "' AND " +
                            tran_table.getColumn(6) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(5) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(5) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(11) + "='" + placeID + "' AND " +
                            tran_table.getColumn(6) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(5) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(5) + "<=" + replaceNull(endDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(12) + "='" + adminID + "' AND " +
                            tran_table.getColumn(6) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(5) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(5) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(5) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(6) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(5) + "<=" + replaceNull(endDate);
            }
            else if (criteria == TRANSACTIONNO) {
                q = q + " AND " + tran_table.getColumn(0) + "='" + tranNo + "'";
            }
            q = q + " ORDER BY " + tran_table.getColumn(0);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            while (rs.next()) {
                Transaction tr = new Transaction();
                tr.setTransactionNo(rs.getInt(tran_table.getColumn(7)));
                tr.setCourseID(rs.getInt(tran_table.getColumn(0)));
                tr.setMonth(rs.getInt(tran_table.getColumn(1)));
                tr.setYear(rs.getInt(tran_table.getColumn(2)));
                tr.setPaid(rs.getDouble(tran_table.getColumn(3)));
                tr.setPaymentDate(rs.getDate(tran_table.getColumn(5)));
                tr.setPaymentType(rs.getInt(tran_table.getColumn(6)));
                tr.setLoginUserCompleteName(rs.getString(tran_table.getColumn(8)));
                tr.setPlaceName(rs.getString(tran_table.getColumn(9)));
                tr.setPlaceID(rs.getInt(tran_table.getColumn(11)));
                tr.setLoginUserID(rs.getInt(tran_table.getColumn(12)));

                v.add(tr);
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return completeTransactionsInformation(v);
    }

    public ArrayList<Transaction> getXtraTransactions(int criteria, int adminID, java.util.Date startDate, java.util.Date endDate, int placeID, int tranNo, int paymentType) {
        ArrayList<Transaction> v = new ArrayList<Transaction>();
        Table tran_table = TableManager.getTable(TableManager.RPS_TRAN_XTRA);
        Table student_table = TableManager.getTable(TableManager.RPS_USER);
        Table place_table = TableManager.getTable(TableManager.RPS_PLACE);
        Table loginuser_table = TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "SELECT a." + tran_table.getColumn(0) + ",a." +
                    tran_table.getColumn(1) + ",a." +
                    tran_table.getColumn(2) + ",a." +
                    tran_table.getColumn(3) + ",a." +
                    tran_table.getColumn(4) + ",a." +
                    tran_table.getColumn(5) + ",a." +
                    tran_table.getColumn(6) + ",a." +
                    tran_table.getColumn(7) + ",a." +
                    tran_table.getColumn(8) + ",CONCAT_WS(' ',b." +
                    student_table.getColumn(1) + ",b." +
                    student_table.getColumn(2) + ") AS studentName ,d." +
                    place_table.getColumn(1) + ",CONCAT_WS(' ',e." +
                    loginuser_table.getColumn(1) + ",e." +
                    loginuser_table.getColumn(2) + ") AS loginUserName" +
                    " FROM " + tran_table.getTableName() + " AS a," +
                    student_table.getTableName() + " AS b," +
                    place_table.getTableName() + " AS d," +
                    loginuser_table.getTableName() + " AS e" + " WHERE a." +
                    tran_table.getColumn(6) + "=b." + student_table.getColumn(0) + " AND a." +
                    tran_table.getColumn(7) + "=d." + place_table.getColumn(0) + " AND a." +
                    tran_table.getColumn(8) + "=e." + loginuser_table.getColumn(0);
            if (criteria == SPECIFICDATE) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(8) + "='" + adminID + "' AND " +
                            tran_table.getColumn(7) + "='" + placeID + "' AND " +
                            tran_table.getColumn(4) + "=" + replaceNull(startDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + placeID + "' AND " +
                            tran_table.getColumn(4) + "=" + replaceNull(startDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(8) + "='" + adminID + "' AND " +
                            tran_table.getColumn(4) + "=" + replaceNull(startDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(4) + "=" + replaceNull(startDate);
            }
            else if ((criteria == DATELIMIT) && (paymentType == 5)) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(8) + "='" + adminID + "' AND " +
                            tran_table.getColumn(7) + "='" + placeID + "' AND " +
                            tran_table.getColumn(4) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(4) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + placeID + "' AND " +
                            tran_table.getColumn(4) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(4) + "<=" + replaceNull(endDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(8) + "='" + adminID + "' AND " +
                            tran_table.getColumn(4) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(4) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(4) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(4) + "<=" + replaceNull(endDate);
            }
            else if ((criteria == DATELIMIT) && (paymentType < 5)) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(8) + "='" + adminID + "' AND " +
                            tran_table.getColumn(7) + "='" + placeID + "' AND " +
                            tran_table.getColumn(3) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(4) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(4) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + placeID + "' AND " +
                            tran_table.getColumn(3) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(4) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(4) + "<=" + replaceNull(endDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(8) + "='" + adminID + "' AND " +
                            tran_table.getColumn(3) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(4) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(4) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(4) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(3) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(4) + "<=" + replaceNull(endDate);
            }
            else if (criteria == TRANSACTIONNO) {
                q = q + " AND " + tran_table.getColumn(0) + "='" + tranNo + "'";
            }
            q = q + " ORDER BY " + tran_table.getColumn(0);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            while (rs.next()) {
                Transaction tr = new Transaction();
                tr.setTransactionNo(rs.getInt(tran_table.getColumn(0)));
                tr.setPaid(rs.getDouble(tran_table.getColumn(2)));
                tr.setPaymentType(rs.getInt(tran_table.getColumn(3)));
                tr.setPaymentDate(rs.getDate(tran_table.getColumn(4)));
                tr.setStudentID(rs.getInt(tran_table.getColumn(6)));
                tr.setCourseID(rs.getInt(tran_table.getColumn(1)));
                tr.setPlaceID(rs.getInt(tran_table.getColumn(7)));
                tr.setLoginUserID(rs.getInt(tran_table.getColumn(8)));
                tr.setStudentCompleteName(rs.getString("studentName"));
                tr.setPlaceName(rs.getString(place_table.getColumn(1)));
                tr.setLoginUserCompleteName(rs.getString("loginUserName"));
                v.add(tr);
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return completeTransactionsInformation(v);
    }

    public ArrayList<Transaction> getNullGebTran(int criteria, int adminID, java.util.Date startDate, java.util.Date endDate, int placeID, int tranNo) {
        ArrayList<Transaction> v = new ArrayList<Transaction>();
        Table tran_table = TableManager.getTable(TableManager.RPS_NULLGEBUHR);
        Table student_table = TableManager.getTable(TableManager.RPS_USER);
        Table place_table = TableManager.getTable(TableManager.RPS_PLACE);
        Table loginuser_table = TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "SELECT a." + tran_table.getColumn(0) + ",a." +
                    tran_table.getColumn(1) + ",a." +
                    tran_table.getColumn(2) + ",a." +
                    tran_table.getColumn(3) + ",a." +
                    tran_table.getColumn(4) + ",CONCAT_WS(' ',b." +
                    student_table.getColumn(1) + ",b." +
                    student_table.getColumn(2) + ") AS studentName ,a." +
                    tran_table.getColumn(5) + ",a." +
                    tran_table.getColumn(6) + ",d." +
                    place_table.getColumn(1) + ",a." +
                    tran_table.getColumn(7) + ",CONCAT_WS(' ',e." +
                    loginuser_table.getColumn(1) + ",e." +
                    loginuser_table.getColumn(2) + ") AS loginUserName" +
                    " FROM " + tran_table.getTableName() + " AS a," +
                    student_table.getTableName() + " AS b," +
                    place_table.getTableName() + " AS d," +
                    loginuser_table.getTableName() + " AS e" + " WHERE a." +
                    tran_table.getColumn(4) + "=b." + student_table.getColumn(0) + " AND a." +
                    tran_table.getColumn(6) + "=d." + place_table.getColumn(0) + " AND a." +
                    tran_table.getColumn(7) + "=e." + loginuser_table.getColumn(0);
            if (criteria == SPECIFICDATE) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
                            tran_table.getColumn(6) + "='" + placeID + "' AND " +
                            tran_table.getColumn(2) + "=" + replaceNull(startDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(6) + "='" + placeID + "' AND " +
                            tran_table.getColumn(2) + "=" + replaceNull(startDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
                            tran_table.getColumn(2) + "=" + replaceNull(startDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(2) + "=" + replaceNull(startDate);
            }
            else if (criteria == DATELIMIT) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
                            tran_table.getColumn(6) + "='" + placeID + "' AND " +
                            tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(6) + "='" + placeID + "' AND " +
                            tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
                            tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
            }
            else if (criteria == TRANSACTIONNO) {
                q = q + " AND " + tran_table.getColumn(0) + "='" + tranNo + "'";
            }
            q = q + " ORDER BY " + tran_table.getColumn(0);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            while (rs.next()) {
                Transaction tr = new Transaction();
                tr.setTransactionNo(rs.getInt(tran_table.getColumn(0)));
                tr.setPaid(rs.getDouble(tran_table.getColumn(1)));
                tr.setPaymentDate(rs.getDate(tran_table.getColumn(2)));
                tr.setPaymentType(rs.getInt(tran_table.getColumn(3)));
                tr.setStudentID(rs.getInt(tran_table.getColumn(4)));
                tr.setCourseID(rs.getInt(tran_table.getColumn(5)));
                tr.setPlaceID(rs.getInt(tran_table.getColumn(6)));
                tr.setLoginUserID(rs.getInt(tran_table.getColumn(7)));
                tr.setStudentCompleteName(rs.getString("studentName"));
                tr.setCourseName("");
                tr.setPlaceName(rs.getString(place_table.getColumn(1)));
                tr.setLoginUserCompleteName(rs.getString("loginUserName"));
                v.add(tr);
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return completeTransactionsInformation(v);
    }

    public ArrayList<Transaction> getBooksTransactions(int criteria, int adminID, java.util.Date startDate, java.util.Date endDate, int placeID, int tranNo, int paymentType) {
        ArrayList<Transaction> v = new ArrayList<Transaction>();
        Table tran_table = TableManager.getTable(TableManager.RPS_BOOKRECHNUNG);
        Table place_table = TableManager.getTable(TableManager.RPS_PLACE);
        Table loginuser_table = TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "SELECT a." + tran_table.getColumn(0) + ",a." +
                    tran_table.getColumn(1) + ",a." +
                    tran_table.getColumn(2) + ",a." +
                    tran_table.getColumn(3) + ",a." +
                    tran_table.getColumn(4) + ",a." +
                    tran_table.getColumn(5) + ",a." +
                    tran_table.getColumn(6) + ",d." +
                    place_table.getColumn(1) + ",a." +
                    tran_table.getColumn(7) + ",CONCAT_WS(' ',e." +
                    loginuser_table.getColumn(1) + ",e." +
                    loginuser_table.getColumn(2) + ") AS loginUserName" +
                    " FROM " + tran_table.getTableName() + " AS a," +
                    place_table.getTableName() + " AS d," +
                    loginuser_table.getTableName() + " AS e" + " WHERE a." +
                    tran_table.getColumn(7) + "=d." + place_table.getColumn(0) + " AND a." +
                    tran_table.getColumn(3) + "=e." + loginuser_table.getColumn(0);
            if (criteria == SPECIFICDATE) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(3) + "='" + adminID + "' AND " +
                            place_table.getColumn(0) + "=" + placeID + " AND " +
                            tran_table.getColumn(6) + "=" + replaceNull(startDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + place_table.getColumn(0) + "=" + placeID + " AND " +
                            tran_table.getColumn(6) + "=" + replaceNull(startDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(3) + "='" + adminID + "' AND " +
                            tran_table.getColumn(6) + "=" + replaceNull(startDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(6) + "=" + replaceNull(startDate);
            }
            else if ((criteria == DATELIMIT) && (paymentType == 5)) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(3) + "='" + adminID + "' AND " +
                            place_table.getColumn(0) + "=" + placeID + " AND " +
                            tran_table.getColumn(6) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(6) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + place_table.getColumn(0) + "=" + placeID + " AND " +
                            tran_table.getColumn(6) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(6) + "<=" + replaceNull(endDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(3) + "='" + adminID + "' AND " +
                            tran_table.getColumn(6) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(6) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(6) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(6) + "<=" + replaceNull(endDate);
            }
            else if ((criteria == DATELIMIT) && (paymentType < 5)) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(3) + "='" + adminID + "' AND " +
                            place_table.getColumn(0) + "=" + placeID + " AND " +
                            tran_table.getColumn(5) + "=" + paymentType + " AND " +
                            tran_table.getColumn(6) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(6) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + place_table.getColumn(0) + "=" + placeID + " AND " +
                            tran_table.getColumn(5) + "=" + paymentType + " AND " +
                            tran_table.getColumn(6) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(6) + "<=" + replaceNull(endDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(3) + "='" + adminID + "' AND " +
                            tran_table.getColumn(5) + "=" + paymentType + " AND " +
                            tran_table.getColumn(6) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(6) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(6) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(5) + "=" + paymentType + " AND " +
                            tran_table.getColumn(6) + "<=" + replaceNull(endDate);
            }
            else if (criteria == TRANSACTIONNO) {
                q = q + " AND " + tran_table.getColumn(0) + "='" + tranNo + "'";
            }
            q = q + " ORDER BY " + tran_table.getColumn(0);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            while (rs.next()) {
                Transaction tr = new Transaction();
                tr.setTransactionNo(rs.getInt(tran_table.getColumn(0)));
                tr.setStudentID(rs.getInt(tran_table.getColumn(1)));
                tr.setStudentCompleteName(rs.getString(tran_table.getColumn(2)));
                tr.setLoginUserID(rs.getInt(tran_table.getColumn(3)));
                tr.setPaid(rs.getDouble(tran_table.getColumn(4)));
                tr.setPaymentType(rs.getInt(tran_table.getColumn(5)));
                tr.setPaymentDate(rs.getDate(tran_table.getColumn(6)));
                tr.setPlaceID(rs.getInt(tran_table.getColumn(7)));
                tr.setPlaceName(rs.getString(place_table.getColumn(1)));
                tr.setLoginUserCompleteName(rs.getString("loginUserName"));
                v.add(tr);
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return completeTransactionsInformation(v);
    }

    public ArrayList<Transaction> getTransactionCash(int criteria, int adminID, java.util.Date startDate, java.util.Date endDate, int placeID, int tranNo, int paymentType) {
        ArrayList<Transaction> v = new ArrayList<Transaction>();
        Table tran_table = TableManager.getTable(TableManager.RPS_TRAN);
        Table student_table = TableManager.getTable(TableManager.RPS_USER);
        Table place_table = TableManager.getTable(TableManager.RPS_PLACE);
        Table loginuser_table = TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "SELECT a." + tran_table.getColumn(0) + ",a." +
                    tran_table.getColumn(1) + ",a." +
                    tran_table.getColumn(2) + ",a." +
                    tran_table.getColumn(3) + ",a." +
                    tran_table.getColumn(4) + ",CONCAT_WS(' ',b." +
                    student_table.getColumn(1) + ",b." +
                    student_table.getColumn(2) + ") AS studentName ,a." +
                    tran_table.getColumn(5) + ",a." +
                    tran_table.getColumn(6) + ",d." +
                    place_table.getColumn(1) + ",a." +
                    tran_table.getColumn(7) + ",CONCAT_WS(' ',e." +
                    loginuser_table.getColumn(1) + ",e." +
                    loginuser_table.getColumn(2) + ") AS loginUserName" +
                    " FROM " + tran_table.getTableName() + " AS a," +
                    student_table.getTableName() + " AS b," +
                    place_table.getTableName() + " AS d," +
                    loginuser_table.getTableName() + " AS e" + " WHERE a." +
                    tran_table.getColumn(4) + "=b." + student_table.getColumn(0) + " AND a." +
                    tran_table.getColumn(6) + "=d." + place_table.getColumn(0) + " AND a." +
                    tran_table.getColumn(7) + "=e." + loginuser_table.getColumn(0);
            if (criteria == SPECIFICDATE) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
                            tran_table.getColumn(6) + "='" + placeID + "' AND " +
                            tran_table.getColumn(3) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(2) + "=" + replaceNull(startDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(6) + "='" + placeID + "' AND " +
                            tran_table.getColumn(3) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(2) + "=" + replaceNull(startDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
                            tran_table.getColumn(3) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(2) + "=" + replaceNull(startDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(2) + "=" + replaceNull(startDate) + "' AND " +
                            tran_table.getColumn(3) + "='" + paymentType;
            }
            else if (criteria == DATELIMIT) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
                            tran_table.getColumn(6) + "='" + placeID + "' AND " +
                            tran_table.getColumn(3) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(6) + "='" + placeID + "' AND " +
                            tran_table.getColumn(3) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + adminID + "' AND " +
                            tran_table.getColumn(3) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(3) + "='" + paymentType + "' AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
            }
            else if (criteria == TRANSACTIONNO) {
                q = q + " AND " + tran_table.getColumn(0) + "='" + tranNo + "'";
            }
            q = q + " ORDER BY " + tran_table.getColumn(0);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            while (rs.next()) {
                Transaction tr = new Transaction();
                tr.setTransactionNo(rs.getInt(tran_table.getColumn(0)));
                tr.setPaid(rs.getDouble(tran_table.getColumn(1)));
                tr.setPaymentDate(rs.getDate(tran_table.getColumn(2)));
                tr.setPaymentType(rs.getInt(tran_table.getColumn(3)));
                tr.setStudentID(rs.getInt(tran_table.getColumn(4)));
                tr.setCourseID(rs.getInt(tran_table.getColumn(5)));
                tr.setPlaceID(rs.getInt(tran_table.getColumn(6)));
                tr.setLoginUserID(rs.getInt(tran_table.getColumn(7)));
                tr.setStudentCompleteName(rs.getString("studentName"));
                tr.setCourseName("");
                tr.setPlaceName(rs.getString(place_table.getColumn(1)));
                tr.setLoginUserCompleteName(rs.getString("loginUserName"));
                v.add(tr);
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return completeTransactionsInformation(v);
    }

    public ArrayList<Transaction> getKasse(int criteria, int adminID, java.util.Date startDate, java.util.Date endDate, int placeID, int kasseNo) {
        ArrayList<Transaction> v = new ArrayList<Transaction>();
        Table tran_table = TableManager.getTable(TableManager.RPS_KASSE);
        Table place_table = TableManager.getTable(TableManager.RPS_PLACE);
        Table loginuser_table = TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "SELECT a." + tran_table.getColumn(0) + ",a." +
                    tran_table.getColumn(1) + ",a." +
                    tran_table.getColumn(2) + ",a." +
                    tran_table.getColumn(3) + ",a." +
                    tran_table.getColumn(4) + ",CONCAT_WS(' ',e." +
                    loginuser_table.getColumn(1) + ",e." +
                    loginuser_table.getColumn(2) + ") AS loginUserName ,d." +
                    place_table.getColumn(1) +
                    " FROM " + tran_table.getTableName() + " AS a," +
                    place_table.getTableName() + " AS d," +
                    loginuser_table.getTableName() + " AS e" + " WHERE a." +
                    tran_table.getColumn(3) + "=d." + place_table.getColumn(0) + " AND a." +
                    tran_table.getColumn(4) + "=e." + loginuser_table.getColumn(0);
            if (criteria == SPECIFICDATE) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(4) + "='" + adminID + "' AND " +
                            tran_table.getColumn(3) + "='" + placeID + "' AND " +
                            tran_table.getColumn(2) + "=" + replaceNull(startDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(3) + "='" + placeID + "' AND " +
                            tran_table.getColumn(2) + "=" + replaceNull(startDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(4) + "='" + adminID + "' AND " +
                            tran_table.getColumn(2) + "=" + replaceNull(startDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(2) + "=" + replaceNull(startDate);
            }
            else if (criteria == DATELIMIT) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(4) + "='" + adminID + "' AND " +
                            tran_table.getColumn(3) + "='" + placeID + "' AND " +
                            tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(3) + "='" + placeID + "' AND " +
                            tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(4) + "='" + adminID + "' AND " +
                            tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(2) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(2) + "<=" + replaceNull(endDate);
            }
            else if (criteria == TRANSACTIONNO) {
                q = q + " AND " + tran_table.getColumn(0) + "='" + kasseNo + "'";
            }
            q = q + " ORDER BY " + tran_table.getColumn(0);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            while (rs.next()) {
                Transaction tr = new Transaction();
                tr.setKasseNo(rs.getInt(tran_table.getColumn(0)));
                tr.setKassePay(rs.getDouble(tran_table.getColumn(1)));
                tr.setKasseDate(rs.getDate(tran_table.getColumn(2)));
                tr.setPlaceID(rs.getInt(tran_table.getColumn(3)));
                tr.setLoginUserID(rs.getInt(tran_table.getColumn(4)));
                tr.setPlaceName(rs.getString(place_table.getColumn(1)));
                tr.setLoginUserCompleteName(rs.getString("loginUserName"));
                v.add(tr);
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return completeTransactionsInformation(v);
    }

    public ArrayList<Transaction> getBookTransactions(int criteria, int adminID, java.util.Date startDate, java.util.Date endDate, int placeID, int tranNo) {
        ArrayList<Transaction> v = new ArrayList<Transaction>();
        Table tran_table = TableManager.getTable(TableManager.RPS_BOOKRECHNUNG);
        Table loginuser_table = TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        Table book_table = TableManager.getTable(TableManager.RPS_BOOKS);
        Table old_table = TableManager.getTable(TableManager.RPS_BOOKSOLD);
        Table stock_table = TableManager.getTable(TableManager.RPS_BOOKSTOCK);
        Table place_table = TableManager.getTable(TableManager.RPS_PLACE);
        try {
            String q = "SELECT DISTINCT a." + tran_table.getColumn(0) + ",a." +
                    tran_table.getColumn(1) + ",a." +
                    tran_table.getColumn(2) + ",a." +
                    tran_table.getColumn(4) + ",a." +
                    tran_table.getColumn(5) + ",a." +
                    tran_table.getColumn(6) + ",a." +
                    tran_table.getColumn(7) + ",f." +
                    place_table.getColumn(1) + ",CONCAT_WS(' ',e." +
                    loginuser_table.getColumn(1) + ",e." +
                    loginuser_table.getColumn(2) + ") AS loginUserName FROM " +
                    tran_table.getTableName() + " AS a," +
                    old_table.getTableName() + " AS b," +
                    stock_table.getTableName() + " AS c," +
                    book_table.getTableName() + " AS d," +
                    place_table.getTableName() + " AS f," +
                    loginuser_table.getTableName() + " AS e WHERE a." +
                    tran_table.getColumn(3) + "=e." + loginuser_table.getColumn(0) + " AND a." +
                    tran_table.getColumn(0) + "=b." + old_table.getColumn(1) + " AND a." +
                    tran_table.getColumn(7) + "=f." + place_table.getColumn(0) + " AND b." +
                    old_table.getColumn(0) + "=c." + stock_table.getColumn(0) + " AND c." +
                    stock_table.getColumn(1) + "=d." + book_table.getColumn(0);
            if (criteria == SPECIFICDATE) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(3) + "='" + adminID + "' AND " +
                            tran_table.getColumn(7) + "='" + placeID + "' AND " +
                            tran_table.getColumn(6) + "=" + replaceNull(startDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + placeID + "' AND " +
                            tran_table.getColumn(6) + "=" + replaceNull(startDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(3) + "='" + adminID + "' AND " +
                            tran_table.getColumn(6) + "=" + replaceNull(startDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(6) + "=" + replaceNull(startDate);
            }
            else if (criteria == DATELIMIT) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(3) + "='" + adminID + "' AND " +
                            tran_table.getColumn(7) + "='" + placeID + "' AND " +
                            tran_table.getColumn(6) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(6) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND " + tran_table.getColumn(7) + "='" + placeID + "' AND " +
                            tran_table.getColumn(6) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(6) + "<=" + replaceNull(endDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(3) + "='" + adminID + "' AND " +
                            tran_table.getColumn(6) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(6) + "<=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND " + tran_table.getColumn(6) + ">=" + replaceNull(startDate) + " AND " +
                            tran_table.getColumn(6) + "<=" + replaceNull(endDate);
            }
            else if (criteria == TRANSACTIONNO) {
                q = q + " AND " + tran_table.getColumn(0) + "='" + tranNo + "'";
            }
            q = q + " ORDER BY " + tran_table.getColumn(0);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            while (rs.next()) {
                Transaction tr = new Transaction();
                tr.setTransactionNo(rs.getInt(tran_table.getColumn(0)));
                tr.setStudentID(rs.getInt(tran_table.getColumn(1)));
                tr.setStudentCompleteName(rs.getString(tran_table.getColumn(2)));
                tr.setPaid(rs.getDouble(tran_table.getColumn(4)));
                tr.setPaymentType(rs.getInt(tran_table.getColumn(5)));
                tr.setPaymentDate(rs.getDate(tran_table.getColumn(6)));
                tr.setPlaceID(rs.getInt(tran_table.getColumn(7)));
                tr.setPlaceName(rs.getString(place_table.getColumn(1)));
                tr.setLoginUserCompleteName(rs.getString("loginUserName"));
                v.add(tr);
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return completeTransactionsInformation(v);
    }


    public double getPaidForCourse(int studentID,int courseID){
        Table tran_table = TableManager.getTable(TableManager.RPS_TRAN);
        double result=0;
        try{
            String q="SELECT SUM("+tran_table.getColumn(1)+") AS amount FROM "+tran_table.getTableName()+" WHERE "+tran_table.getColumn(4)+"="+studentID+" AND "+tran_table.getColumn(5)+"="+courseID;
            ResultSet rs=DBHelper.getInstance().executeQuery(q);;
            while(rs.next()){
                result=rs.getDouble("amount");
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public ArrayList<EmployeeHours> EmployeeTimeSheetSearch(int criteria, int adminID, java.util.Date startDate, java.util.Date endDate, int placeID, int tranNo) {
        ArrayList<EmployeeHours> v = new ArrayList<EmployeeHours>();
        try {
            String q = "select a.userID AS userID,a.workDate AS workDate,a.timeStart AS timeStart,a.timeEnd AS timeEnd,a.breakTimeStart AS breakTimeStart,a.breakTimeEnd AS breakTimeEnd, sec_to_time((time_to_sec(sec_to_time(time_to_sec(a.timeEnd) - time_to_sec(a.timeStart))))- (time_to_sec(sec_to_time(time_to_sec(a.breakTimeEnd) - time_to_sec(a.breakTimeStart))))) AS totalTime, HOUR(sec_to_time((time_to_sec(sec_to_time(time_to_sec(a.timeEnd) - time_to_sec(a.timeStart))))- (time_to_sec(sec_to_time(time_to_sec(a.breakTimeEnd) - time_to_sec(a.breakTimeStart)))))) AS totalHours, MINUTE(sec_to_time((time_to_sec(sec_to_time(time_to_sec(a.timeEnd) - time_to_sec(a.timeStart))))- (time_to_sec(sec_to_time(time_to_sec(a.breakTimeEnd) - time_to_sec(a.breakTimeStart)))))) AS totalMinutes,CONCAT_WS(' ',c.userFirstName,c.userLastName) AS loginUserName,b.placeName AS placeName from rps_employeestunden a, rps_place b, rps_systemuser c where a.placeID = b.placeID and a.userID =c.userID";
            if (criteria == SPECIFICDATE) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND a.userID=" + adminID + " AND a.placeID=" + placeID + "' AND a.workDate=" + replaceNull(startDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND a.placeID=" + placeID + " AND a.workDate=" + replaceNull(startDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND a.userID=" + adminID + " AND a.workDate=" + replaceNull(startDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND a.workDate=" + replaceNull(startDate);
            }
            else if (criteria == DATELIMIT) {
                if ((adminID > 0) && (placeID > 0))
                    q = q + " AND a.userID=" + adminID + " AND a.placeID=" + placeID + " AND a.workDate>=" + replaceNull(startDate) + " AND a.workDate <=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID > 0))
                    q = q + " AND a.placeID=" + placeID + " AND a.workDate >=" + replaceNull(startDate) + " AND a.workDate <=" + replaceNull(endDate);
                else if ((adminID > 0) && (placeID == 0))
                    q = q + " AND a.userID ='" + adminID + "' AND a.workDate >=" + replaceNull(startDate) + " AND a.workDate <=" + replaceNull(endDate);
                else if ((adminID == 0) && (placeID == 0))
                    q = q + " AND a.workDate >=" + replaceNull(startDate) + " AND a.workDate <=" + replaceNull(endDate);
            }
            else if (criteria == TRANSACTIONNO) {
                q = q + " AND a.workDate ='" + tranNo + "'";
            }
            q = q + " ORDER BY a.userID";

            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            while (rs.next()) {
                EmployeeHours employee = new EmployeeHours();
                employee.setUserID(rs.getInt("userID"));
                employee.setLoginDate(rs.getDate("workDate"));
                employee.setLoginTime(rs.getTime("timeStart"));
                employee.setLogoutTime(rs.getTime("timeEnd"));
                employee.setBreakStartTime(rs.getTime("breakTimeStart"));
                employee.setBreakEndTime(rs.getTime("breakTimeEnd"));
                employee.setTotalHours(rs.getTime("totalTime"));
                employee.setTotalTime(rs.getInt("totalHours"));
                employee.setTotalMinutes(rs.getInt("totalMinutes"));
                employee.setUserName(rs.getString("loginUserName"));
                employee.setPlaceName(rs.getString("placeName"));

                java.util.Date tempDate = new java.util.Date(employee.getLoginDate().getTime());
                String dayName = tempDate.toString().substring(0, 3);
                int dayNumber = MyDate.getDayNumber(dayName, MyDate.DEUTSCH);
                dayName = MyDate.getDayName(dayNumber, MyDate.DEUTSCH);
                employee.setDay(dayName);

                v.add(employee);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public ArrayList<Transaction> getFirstPayTransaction(java.util.Date startDate, java.util.Date endDate, int placeID)
    {
        ArrayList<Transaction> v = new ArrayList<Transaction>();
        Table tran_table = TableManager.getTable(TableManager.RPS_TRAN);
        Table student_table = TableManager.getTable(TableManager.RPS_USER);
        Table course_table = TableManager.getTable(TableManager.RPS_COURSES);
        Table loginuser_table = TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        Table place_table = TableManager.getTable(TableManager.RPS_PLACE);
        try {
            ArrayList<String> firstTransactions=new ArrayList<String>();
            String transationsList = "";
            String q = "SELECT min(" + tran_table.getColumn(0) + ") AS mintran FROM " + tran_table.getTableName() + " GROUP BY " + tran_table.getColumn(4) + " ORDER BY " + tran_table.getColumn(0);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            while (rs.next()) {
                firstTransactions.add(""+rs.getInt("mintran"));
            }
            boolean firstPlace = true;
            for (int i = 0; i < firstTransactions.size(); ++i) {
                if (firstPlace) {
                    transationsList = transationsList + (String)firstTransactions.get(i);
                    firstPlace = false;
                } else {
                    transationsList = transationsList + "," + (String)firstTransactions.get(i);
                }
            }
            q = "SELECT a." + tran_table.getColumn(0) + ",a." +
                    tran_table.getColumn(1) + ",a." + tran_table.getColumn(2) +
                    ",a." + tran_table.getColumn(3) + ",a." +
                    tran_table.getColumn(4) + ",CONCAT_WS(' ',d." +
                    student_table.getColumn(1) + ",d." +
                    student_table.getColumn(2) + ") AS studentName ,a." +
                    tran_table.getColumn(5) + ",a." +
                    tran_table.getColumn(6) + ",f." + place_table.getColumn(1) + ",a." +
                    tran_table.getColumn(7) + ",CONCAT_WS(' ',e." +
                    loginuser_table.getColumn(1) + ",e." +
                    loginuser_table.getColumn(2) + ") AS loginUserName" +
                    " FROM " + tran_table.getTableName() + " AS a," + course_table.getTableName() + " AS c," + student_table.getTableName() + " AS d," + loginuser_table.getTableName() + " AS e," + place_table.getTableName() + " AS f " +
                    "WHERE a." + tran_table.getColumn(2) + " BETWEEN " + replaceNull(startDate) + " AND " + replaceNull(endDate) + " AND a." + tran_table.getColumn(4) + "=d." + student_table.getColumn(0) + " AND a." + tran_table.getColumn(5) + "=c." + course_table.getColumn(0) + " AND a." + tran_table.getColumn(7) + "=e." + loginuser_table.getColumn(0) + " AND c." + course_table.getColumn(6) + "=f." + place_table.getColumn(0) + " AND " + tran_table.getColumn(0) + " IN (" + transationsList + ")";

            if (placeID > 0) {
                q = q + " AND c." + course_table.getColumn(6) + "='" + placeID + "'";
            }
            q = q + " ORDER BY d." + student_table.getColumn(1);
            rs = DBHelper.getInstance().executeQuery(q);;
            while (rs.next()) {
                Transaction tr = new Transaction();
                tr.setTransactionNo(rs.getInt(tran_table.getColumn(0)));
                tr.setPaid(rs.getDouble(tran_table.getColumn(1)));
                tr.setPaymentDate(rs.getDate(tran_table.getColumn(2)));
                tr.setPaymentType(rs.getInt(tran_table.getColumn(3)));
                tr.setStudentID(rs.getInt(tran_table.getColumn(4)));
                tr.setCourseID(rs.getInt(tran_table.getColumn(5)));
                tr.setPlaceID(rs.getInt(tran_table.getColumn(6)));
                tr.setLoginUserID(rs.getInt(tran_table.getColumn(7)));

                tr.setStudentCompleteName(rs.getString("studentName"));
                tr.setCourseName("");
                tr.setPlaceName(rs.getString(place_table.getColumn(1)));
                tr.setLoginUserCompleteName(rs.getString("loginUserName"));
                v.add(tr);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return completeTransactionsInformation(v);
    }

    public ArrayList<Transaction> getFirstPayTransactions(Date startDate, Date endDate, int placeID) {
        ArrayList<Transaction> v = new ArrayList<Transaction>();
        Table tran_table = TableManager.getTable(TableManager.RPS_TRAN);
        Table student_table = TableManager.getTable(TableManager.RPS_USER);
        Table course_table=TableManager.getTable(TableManager.RPS_COURSES);
        Table loginuser_table = TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        Table place_table=TableManager.getTable(TableManager.RPS_PLACE);
        try {
            ArrayList<String> firstTransactions=new ArrayList<String>();
            String transationsList="";
            String q="SELECT min("+tran_table.getColumn(0)+") AS mintran FROM "+tran_table.getTableName()+" GROUP BY "+tran_table.getColumn(4)+" ORDER BY "+tran_table.getColumn(0);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);;
            while(rs.next()){
                firstTransactions.add(""+rs.getInt("mintran"));
            }
            boolean firstPlace=true;
            for(int i=0;i<firstTransactions.size();i++){
                if(firstPlace){
                    transationsList=transationsList+(String)firstTransactions.get(i);
                    firstPlace=false;
                }else{
                    transationsList=transationsList+","+(String)firstTransactions.get(i);
                }
            }
            q="SELECT a." + tran_table.getColumn(0) + ",a."
                    + tran_table.getColumn(1) + ",a." + tran_table.getColumn(2)
                    + ",a." + tran_table.getColumn(3) + ",a."
                    + tran_table.getColumn(4) + ",CONCAT_WS(' ',d."
                    + student_table.getColumn(1) + ",d."
                    + student_table.getColumn(2) + ") AS studentName ,a."
                    + tran_table.getColumn(5) + ",a."
                    + tran_table.getColumn(6) + ",f."+place_table.getColumn(1)+",a."
                    + tran_table.getColumn(7) + ",CONCAT_WS(' ',e."
                    + loginuser_table.getColumn(1) + ",e."
                    + loginuser_table.getColumn(2) + ") AS loginUserName"
                    + " FROM "+tran_table.getTableName()+" AS a,"+course_table.getTableName()+" AS c,"+student_table.getTableName()+" AS d,"+loginuser_table.getTableName()+" AS e,"+place_table.getTableName()+" AS f "
                    + "WHERE a."+tran_table.getColumn(2)+" BETWEEN "+replaceNull(startDate)+" AND "+replaceNull(endDate)+" AND a."+tran_table.getColumn(4)+"=d."+student_table.getColumn(0)+" AND a."+tran_table.getColumn(5)+"=c."+course_table.getColumn(0)+" AND a."+tran_table.getColumn(7)+"=e."+loginuser_table.getColumn(0)+" AND c."+course_table.getColumn(6)+"=f."+place_table.getColumn(0)+" AND "+tran_table.getColumn(0)+" IN ("+transationsList+")";

            if (placeID > 0) {
                q = q + " AND c."+course_table.getColumn(6)+"='"+placeID+"'";
            }
            q = q + " ORDER BY d."+student_table.getColumn(1);
            rs = DBHelper.getInstance().executeQuery(q);;
            while (rs.next()) {
                Transaction tr = new Transaction();
                tr.setTransactionNo(rs.getInt(tran_table.getColumn(0)));
                tr.setPaid(rs.getDouble(tran_table.getColumn(1)));
                tr.setPaymentDate(rs.getDate(tran_table.getColumn(2)));
                tr.setPaymentType(rs.getInt(tran_table.getColumn(3)));
                tr.setStudentID(rs.getInt(tran_table.getColumn(4)));
                tr.setCourseID(rs.getInt(tran_table.getColumn(5)));
                tr.setPlaceID(rs.getInt(tran_table.getColumn(6)));
                tr.setLoginUserID(rs.getInt(tran_table.getColumn(7)));

                tr.setStudentCompleteName(rs.getString("studentName"));
                tr.setCourseName("");
                tr.setPlaceName(rs.getString(place_table.getColumn(1)));
                tr.setLoginUserCompleteName(rs.getString("loginUserName"));
                v.add(tr);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return completeTransactionsInformation(v);
    }

    public synchronized boolean updateTransactions(int oldCourseID,int studentID,int newCourseID){
        boolean result = false;
        Table tran_table = TableManager.getTable(TableManager.RPS_TRAN);
        try{
            String q = "UPDATE "+tran_table.getTableName()+" SET "+tran_table.getColumn(5)+"='" +newCourseID+ "' WHERE "+tran_table.getColumn(5)+"='" +oldCourseID+ "' AND "+tran_table.getColumn(4)+"='"+studentID+"'";
            DBHelper.getInstance().updateQuery(q);
            result=true;
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public boolean canSeeBericht(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "3.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canPrintBericht(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "3.1.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeeSingleClassNochOffen(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "3.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeeFirstPay(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "3.3");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    /* Methods Related To Every Method */
    public static void main(String[] args){
    }
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

    public static int BARTYPE=0;
    public static int UEBERWEISENTYPE=1;
    public static int ONLINETYPE=2;

    public static int SPECIFICDATE=1;
    public static int DATELIMIT=2;
    public static int TRANSACTIONNO=3;
}
