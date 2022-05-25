package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Student;
import com.rheinlandprivatschule.model.Table;

import java.sql.Date;
import java.sql.ResultSet;
import java.util.Vector;

public class IntegrationCostDao {

    public int addNewXtraCost(Student student) {
        int chk=0;
        Table table= TableManager.getTable(TableManager.RPS_INTEGRATIONCOST);
        try{
            String q = "INSERT INTO "+table.getTableName()+" ("
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+") VALUES (" +
                    replaceNull(student.getUserID()) + "," +
                    replaceNull(student.getUserRemarks()) + "," +
                    replaceNull(student.getUserStundenLohn()) + "," +
                    replaceNull(student.getUserRegDate()) + ")";
            DBHelper.getInstance().updateQuery(q);
            chk = 1;
        }catch(Exception e){
            setError(e.toString());
        }
        return chk;
    }

    public Student getXtraCost(int costID) {
        Student student = new Student();
        Table table=TableManager.getTable(TableManager.RPS_INTEGRATIONCOST);
        try {
            String q = "SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+"=" + costID;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                student.setCostID(rs.getInt(table.getColumn(0)));
                student.setUserID(rs.getInt(table.getColumn(1)));
                student.setcostDesc(rs.getString(table.getColumn(2)));
                student.setActualFee(rs.getDouble(table.getColumn(3)));
                student.setUserRegDate(rs.getDate(table.getColumn(4)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return student;
    }

    public Vector<Student> getXtraCosts(int userID) {
        Vector<Student> v = new Vector<Student>();
        Table table=TableManager.getTable(TableManager.RPS_INTEGRATIONCOST);
        try {
            String q = "SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(1)+"=" + userID;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Student student = new Student();
                student.setResidenceID(rs.getInt(table.getColumn(0)));
                student.setUserID(rs.getInt(table.getColumn(1)));
                student.setUserRemarks(rs.getString(table.getColumn(2)));
                student.setUserStundenLohn(rs.getDouble(table.getColumn(3)));
                student.setUserRegDate(rs.getDate(table.getColumn(4)));
                v.add(student);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<Student> getXtraCostsAll() {
        Vector<Student> v = new Vector<Student>();
        Table table=TableManager.getTable(TableManager.RPS_INTEGRATIONCOST);
        Table student_table=TableManager.getTable(TableManager.RPS_USER);
        try {
            String q = "SELECT a."+table.getColumn(0)+",b."
                    +student_table.getColumn(1)+",b."
                    +student_table.getColumn(2)+",a."
                    +table.getColumn(1)+",a."
                    +table.getColumn(2)+",a."
                    +table.getColumn(3)+",a."
                    +table.getColumn(4)+" FROM "+table.getTableName()+" AS a,"
                    +student_table.getTableName()+" AS b WHERE b."
                    +student_table.getColumn(0)+"=a."+table.getColumn(1)+" ORDER BY a."
                    +table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Student student = new Student();
                student.setResidenceID(rs.getInt(table.getColumn(0)));
                student.setUserFirstName(rs.getString(student_table.getColumn(1)));
                student.setUserLastName(rs.getString(student_table.getColumn(2)));
                student.setUserID(rs.getInt(table.getColumn(1)));
                student.setUserRemarks(rs.getString(table.getColumn(2)));
                student.setUserStundenLohn(rs.getDouble(table.getColumn(3)));
                student.setUserRegDate(rs.getDate(table.getColumn(4)));
                v.add(student);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<Student> getXtraTran(int costID) {
        Vector<Student> v = new Vector<Student>();
        Table table=TableManager.getTable(TableManager.RPS_INT_TRAN);
        try {
            String q = "SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+","
                    +table.getColumn(8)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(1)+"=" + costID;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Student student = new Student();
                student.setResidenceID(rs.getInt(table.getColumn(0)));
                student.setCostID(rs.getInt(table.getColumn(1)));
                student.setTotalPay(rs.getDouble(table.getColumn(2)));
                student.setTransPayType(rs.getInt(table.getColumn(3)));
                student.setUserRegDate(rs.getDate(table.getColumn(4)));
                student.setTranBalance(rs.getDouble(table.getColumn(5)));
                student.setUserID(rs.getInt(table.getColumn(6)));
                student.setPlaceID(rs.getInt(table.getColumn(7)));
                student.setAdminID(rs.getInt(table.getColumn(8)));
                v.add(student);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Student getXtraTranPrint(int residenceID) {
        Student student = new Student();
        Table table=TableManager.getTable(TableManager.RPS_INT_TRAN);
        try {
            String q = "SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+","
                    +table.getColumn(8)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+"=" + residenceID;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                student.setResidenceID(rs.getInt(table.getColumn(0)));
                student.setCostID(rs.getInt(table.getColumn(1)));
                student.setTotalPay(rs.getDouble(table.getColumn(2)));
                student.setTransPayType(rs.getInt(table.getColumn(3)));
                student.setUserRegDate(rs.getDate(table.getColumn(4)));
                student.setTranBalance(rs.getDouble(table.getColumn(5)));
                student.setUserID(rs.getInt(table.getColumn(6)));
                student.setPlaceID(rs.getInt(table.getColumn(7)));
                student.setAdminID(rs.getInt(table.getColumn(8)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return student;
    }

    public Student getCostStudent(int costID,int studentID) {
        Student student = new Student();
        Table cost_table=TableManager.getTable(TableManager.RPS_INT_TRAN);
        try {
            String q = "SELECT SUM("+cost_table.getColumn(2)+") AS totalpay FROM "
                    +cost_table.getTableName()+" WHERE "
                    +cost_table.getColumn(1)+"='" + costID + "' AND "
                    +cost_table.getColumn(6)+"='" + studentID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                student.setTotalPay(rs.getDouble("totalpay"));
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return student;
    }

    public int updateXtraCost(Student student) {
        int updateStatus = 0;
        Table table=TableManager.getTable(TableManager.RPS_INTEGRATIONCOST);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "
                    +table.getColumn(1)+"="+replaceNull(student.getUserID())+","
                    +table.getColumn(2)+"="+replaceNull(student.getCostDesc())+","
                    +table.getColumn(3)+"="+replaceNull(student.getActualFee())+" WHERE "
                    +table.getColumn(0)+"='"+student.getCostID()+"'";
            DBHelper.getInstance().updateQuery(q);
            updateStatus = 1;
        } catch (Exception e) {
            setError(e.toString());
        }
        return updateStatus;
    }

    public int addXtraCostTran(int costID,
                               double tranPay,
                               int tranType,
                               Date tranDate,
                               double tranBalance,
                               int studentID,
                               int placeID,
                               int loginUserID){
        int transactionNo =-1;
        Table table=TableManager.getTable(TableManager.RPS_INT_TRAN);
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
                    +costID+ "',"
                    +tranPay + ",'"
                    +tranType+"','"
                    +tranDate+ "',"
                    +tranBalance+ ",'"
                    +studentID+"','"
                    +placeID+"','"
                    +loginUserID+"')";
            DBHelper.getInstance().updateQuery(q);
            q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName();
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
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

    public Student getXtraCostByStudent(int costID,int studentID) {
        Student student = new Student();
        Table registration_table=TableManager.getTable(TableManager.RPS_INT_TRAN);
        try {
            String q = "SELECT "+registration_table.getColumn(1)+","
                    +registration_table.getColumn(2)+","
                    +registration_table.getColumn(3)+","
                    +registration_table.getColumn(4)+","
                    +registration_table.getColumn(5)+","
                    +registration_table.getColumn(6)+","
                    +registration_table.getColumn(7)+","
                    +registration_table.getColumn(8)+" FROM "
                    +registration_table.getTableName()+" WHERE "
                    +registration_table.getColumn(0)+"='" + costID + "' AND "
                    +registration_table.getColumn(6)+"='" + studentID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                student.setCostID(rs.getInt(registration_table.getColumn(1)));
                student.setTotalPay(rs.getDouble(registration_table.getColumn(2)));
                student.setTransPayType(rs.getInt(registration_table.getColumn(3)));
                student.setUserRegDate(rs.getDate(registration_table.getColumn(4)));
                student.setTranBalance(rs.getDouble(registration_table.getColumn(5)));
                student.setUserID(rs.getInt(registration_table.getColumn(6)));
                student.setPlaceID(rs.getInt(registration_table.getColumn(7)));
                student.setAdminID(rs.getInt(registration_table.getColumn(8)));
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return student;
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

    /* End Methods Related To Every Method */

    // Instance Variables
    private String error;

    //Class Variables
    public static final int ACTIVE=1;
    public static final int FIRSTNAME=2;
    public static final int LASTNAME=3;
    public static final int DATEOFBIRTH=4;
    public static final int KUNDENNR=5;
    public static final int NOCRITERION=6;
    public static final int NOTACTIVE=7;

    public static final int ONLINESTUDENT=3;

    public static final int INKASSO=2;
}
