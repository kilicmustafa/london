package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.*;

import java.sql.*;
import java.util.Vector;

public class SingleClassDao {

    public static void main(String[] args){
        //SingleClassDB scdb=new SingleClassDB();
    }

    public boolean addSingleClass(SingleClass c){
        boolean b=false;
        Table table= TableManager.getTable(TableManager.RPS_EUNTERRICHT);
        try{
            String q="INSERT INTO "+table.getTableName()+"("+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+","+table.getColumn(7)+") VALUES('"+c.getStudentID()+"',"+this.replaceNull(c.getCourseName())+",'"+c.getTeacherID()+"',"+this.replaceNull(c.getCLassDate())+",'"+c.getClassTime()+"','"+c.getCourseFee()+"','"+c.getPlaceID()+"')";
            DBHelper.getInstance().updateQuery(q);
            updateGutHabenForReg(c.getStudentID(),(c.getCourseFee()*c.getClassTime()));
            b=true;
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public double getDefaultFee(int studentID,int teacherID){
        double fee=18;
        Table table=TableManager.getTable(TableManager.RPS_EUNTERRICHT);
        try{
            String q="SELECT "+table.getColumn(6)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"+studentID+"' AND "+table.getColumn(3)+"='"+teacherID+"' ORDER BY "+table.getColumn(0);
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                fee=rs.getDouble(table.getColumn(6));
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return fee;
    }

    public boolean updateGutHabenForReg(int studentID,double newGutHaben){
        boolean b=false;
        Table table=TableManager.getTable(TableManager.RPS_EUNTERBALANCE);
        try{
            boolean chk=isExist(studentID);
            String q;
            if(chk){
                double chkA=getStudentGutHaben(studentID);
                q="UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"='"+(chkA-newGutHaben)+"' WHERE "+table.getColumn(0)+"='"+studentID+"'";
            }else{
                q="INSERT INTO "+table.getTableName()+"("+table.getColumn(0)+","+table.getColumn(1)+") VALUES('"+studentID+"','"+(0-newGutHaben)+"')";
            }
            DBHelper.getInstance().updateQuery(q);
            b=true;
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean updateGutHabenForDeletion(int studentID,double newGutHaben){
        boolean b=false;
        Table table=TableManager.getTable(TableManager.RPS_EUNTERBALANCE);
        try{
            boolean chk=isExist(studentID);
            String q="";
            if(chk){
                double currentGutHaben=getStudentGutHaben(studentID);
                q="UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"='"+(currentGutHaben+newGutHaben)+"' WHERE "+table.getColumn(0)+"='"+studentID+"'";
            }
            DBHelper.getInstance().updateQuery(q);
            b=true;
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public double getStudentGutHaben(int studentID){
        double b=0;
        Table table=TableManager.getTable(TableManager.RPS_EUNTERBALANCE);
        try{
            String q="SELECT "+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+studentID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                b=rs.getDouble(table.getColumn(1));
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public int updateSingleClass(SingleClass oldSingleClass,SingleClass newSingleClass){
        int b=0;
        Table table=TableManager.getTable(TableManager.RPS_EUNTERRICHT);
        try{
            double oldFactor=oldSingleClass.getCourseFee()*oldSingleClass.getClassTime();
            double newFactor=newSingleClass.getCourseFee()*newSingleClass.getClassTime();
            double guthaben=-1*(oldFactor-newFactor);
            boolean bl=updateGutHabenForReg(newSingleClass.getStudentID(),guthaben);

            if(bl){
                String q="UPDATE "+table.getTableName()+" SET "+table.getColumn(2)+"="+this.replaceNull(newSingleClass.getCourseName())+", "+table.getColumn(3)+"='"+newSingleClass.getTeacherID()+"', "+table.getColumn(4)+"="+this.replaceNull(newSingleClass.getCLassDate())+", "+table.getColumn(5)+"='"+newSingleClass.getClassTime()+"', "+table.getColumn(6)+"='"+newSingleClass.getCourseFee()+"', "+table.getColumn(7)+"='"+newSingleClass.getPlaceID()+"' WHERE "+table.getColumn(0)+"='"+newSingleClass.getClassID()+"'";
                DBHelper.getInstance().updateQuery(q);
                b=1;
            }else{
                b=0;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public double getTotalPayableFee(int studentID){
        double b=0;
        Table table=TableManager.getTable(TableManager.RPS_EUNTERRICHT);
        try{
            String q="SELECT SUM("+table.getColumn(5)+"*"+table.getColumn(6)+") amount FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"+studentID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                b=rs.getDouble("amount");
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean isExist(int studentID){
        boolean b=false;
        Table table=TableManager.getTable(TableManager.RPS_EUNTERBALANCE);
        try{
            String q="SELECT "+table.getColumn(0)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+studentID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                b=true;
            }
        }
        catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public int updateBalance(SingleClassBalance singleClass, double newGutHaben){
        int b=0;
        Table table=TableManager.getTable(TableManager.RPS_EUNTERBALANCE);
        try{
            boolean chk=isExist(singleClass.getStudentID());
            String q="";
            if(chk){
                q="UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"='"+(singleClass.getBalance()+newGutHaben)+"' WHERE "+table.getColumn(0)+"='"+singleClass.getStudentID()+"'";
            }else{
                q="INSERT INTO "+table.getTableName()+"("+table.getColumn(0)+","+table.getColumn(1)+") VALUES('"+singleClass.getStudentID()+"','"+newGutHaben+"')";
            }
            DBHelper.getInstance().updateQuery(q);
            b=1;
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteSingleClass(int classID){
        boolean b=false;
        Table table=TableManager.getTable(TableManager.RPS_EUNTERRICHT);
        try{
            SingleClass sc=getSingleClass(classID);
            int studentID=sc.getStudentID();
            String q="DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+classID+"'";
            DBHelper.getInstance().updateQuery(q);
            updateGutHabenForDeletion(studentID,(sc.getCourseFee()*sc.getClassTime()));
            b=true;
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public Vector getSingleClasses(int studentID){
        Vector<SingleClass> v=new Vector<SingleClass>();
        Table table=TableManager.getTable(TableManager.RPS_EUNTERRICHT);
        try{
            String q="SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+","+table.getColumn(7)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"+studentID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                SingleClass sc=new SingleClass();
                sc.setClassID(rs.getInt(table.getColumn(0)));
                sc.setStudentID(rs.getInt(table.getColumn(1)));
                sc.setCourseName(rs.getString(table.getColumn(2)));
                sc.setTeacherID(rs.getInt(table.getColumn(3)));
                sc.setCLassDate(rs.getDate(table.getColumn(4)));
                sc.setClassTime(rs.getInt(table.getColumn(5)));
                sc.setCourseFee(rs.getDouble(table.getColumn(6)));
                sc.setPlaceID(rs.getInt(table.getColumn(7)));
                v.addElement(sc);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public SingleClass getSingleClass(int classID){
        SingleClass sc=new SingleClass();
        Table table=TableManager.getTable(TableManager.RPS_EUNTERRICHT);
        try{
            String q="SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+","+table.getColumn(7)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+classID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                sc.setClassID(rs.getInt(table.getColumn(0)));
                sc.setStudentID(rs.getInt(table.getColumn(1)));
                sc.setCourseName(rs.getString(table.getColumn(2)));
                sc.setTeacherID(rs.getInt(table.getColumn(3)));
                sc.setCLassDate(rs.getDate(table.getColumn(4)));
                sc.setClassTime(rs.getInt(table.getColumn(5)));
                sc.setCourseFee(rs.getDouble(table.getColumn(6)));
                sc.setPlaceID(rs.getInt(table.getColumn(7)));
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return sc;
    }

    public int addTransaction(int studentID,int tranID){
        int b=0;
        Table table=TableManager.getTable(TableManager.RPS_EUNTERSTUDENTTRAN);
        try{
            String q="INSERT INTO "+table.getTableName()+" ("+table.getColumn(0)+","+table.getColumn(1)+") VALUES('"+studentID+"','"+tranID+"')";
            DBHelper.getInstance().updateQuery(q);
            b=1;
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public Vector getTransactions(int studentID){
        Vector<Transaction> v=new Vector<Transaction>();
        Table table=TableManager.getTable(TableManager.RPS_EUNTERSTUDENTTRAN);
        try{
            Vector<String> temp=new Vector<String>();
            String q="SELECT "+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+studentID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                temp.addElement(""+rs.getInt("tranID"));
            }
            TransactionDao trdb=new TransactionDao();
            for(int i=0;i<temp.size();i++){
                String tempid=(String)temp.elementAt(i);
                int id=Integer.parseInt(tempid);
                Transaction t=trdb.getTransaction(id);
                v.addElement(t);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public SingleClassBalance getStudentRecord(int code){
        SingleClassBalance sc=new SingleClassBalance();
        Table table=TableManager.getTable(TableManager.RPS_EUNTERBALANCE);
        try{
            String q="SELECT "+table.getColumn(0)+","+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+code+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                sc.setStudentID(rs.getInt(table.getColumn(0)));
                sc.setBalance(rs.getDouble(table.getColumn(1)));
            }
            sc.setTransactions(getTransactions(code));
        }catch(Exception e){
            setError(e.toString());
        }
        return sc;
    }

    public Vector getStudentForTeacher(int teacherID,int studentStatus){
        Vector<Student> result=new Vector<Student>();
        Vector<String> ids=new Vector<String>();
        Table table=TableManager.getTable(TableManager.RPS_EUNTERRICHT);
        try{
            String q="SELECT DISTINCT "+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(3)+"='"+teacherID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                String temp=""+rs.getInt(table.getColumn(1));
                ids.addElement(temp);
            }
            StudentDao sdb=new StudentDao();
            for(int i=0;i<ids.size();i++){
                int tempStudentID=Integer.parseInt((String)ids.elementAt(i));
                int tempStatus=getStudentStatus(tempStudentID);
                if(tempStatus==studentStatus){
                    result.addElement(sdb.getStudentForSubProcess(tempStudentID));
                }
            }
        }
        catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public Vector<SingleClass> getSingleClassesForTeacher(int studentID, int teacherID){
        Vector<SingleClass> v=new Vector<SingleClass>();
        Table table=TableManager.getTable(TableManager.RPS_EUNTERRICHT);
        try{
            String q="SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+","+table.getColumn(7)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"+studentID+"' AND "+table.getColumn(3)+"='"+teacherID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                SingleClass sc=new SingleClass();
                sc.setClassID(rs.getInt(table.getColumn(0)));
                sc.setStudentID(rs.getInt(table.getColumn(1)));
                sc.setCourseName(rs.getString(table.getColumn(2)));
                sc.setTeacherID(rs.getInt(table.getColumn(3)));
                sc.setCLassDate(rs.getDate(table.getColumn(4)));
                sc.setClassTime(rs.getInt(table.getColumn(5)));
                sc.setCourseFee(rs.getDouble(table.getColumn(6)));
                sc.setPlaceID(rs.getInt(table.getColumn(7)));
                v.addElement(sc);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public Vector<SingleClass> getSCForTeacherAndMonth(int teacherID,Date startDate,Date endDate){
        Vector<SingleClass> v=new Vector<SingleClass>();
        Table table=TableManager.getTable(TableManager.RPS_EUNTERRICHT);
        try{
            String q="SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+","+table.getColumn(7)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(3)+"='"+teacherID+"' AND "+table.getColumn(4)+" BETWEEN " + replaceNull(startDate) + " AND " +
                    replaceNull(endDate) + " ORDER BY "+table.getColumn(4) ;
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                SingleClass sc=new SingleClass();
                sc.setClassID(rs.getInt(table.getColumn(0)));
                sc.setStudentID(rs.getInt(table.getColumn(1)));
                sc.setCourseName(rs.getString(table.getColumn(2)));
                sc.setTeacherID(rs.getInt(table.getColumn(3)));
                sc.setCLassDate(rs.getDate(table.getColumn(4)));
                sc.setClassTime(rs.getInt(table.getColumn(5)));
                sc.setCourseFee(rs.getDouble(table.getColumn(6)));
                sc.setPlaceID(rs.getInt(table.getColumn(7)));
                v.addElement(sc);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public Vector<SingleClassBalance> getStudentWithMinusGuthaben(){
        Vector<SingleClassBalance> v=new Vector<SingleClassBalance>();
        Table table=TableManager.getTable(TableManager.RPS_EUNTERBALANCE);
        Table student_table=TableManager.getTable(TableManager.RPS_USER);
        try{
            String q="SELECT a."+table.getColumn(0)+",a."+table.getColumn(1)+" FROM "+table.getTableName()+" AS a,"+student_table.getTableName()+" AS b WHERE "+table.getColumn(1)+" < '0' AND a."+table.getColumn(0)+"=b."+student_table.getColumn(0)+" ORDER BY "+student_table.getColumn(1);
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                SingleClassBalance sc=new SingleClassBalance();
                sc.setStudentID(rs.getInt(table.getColumn(0)));
                sc.setBalance(rs.getDouble(table.getColumn(1)));
                v.addElement(sc);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public int getStudentStatus(int studentID){
        int studentStatus=-1;
        Table table=TableManager.getTable(TableManager.RPS_EUNTERSTUDENTSTATUS);
        try{
            String q="SELECT "+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+studentID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            int tempStatus=-1;
            while(rs.next()){
                tempStatus=rs.getInt("studentStatus");
            }

            if(tempStatus>=0){
                studentStatus=tempStatus;
            }else{
                insertStudentStatus(studentID,STUDENTACTIVE);
                studentStatus=STUDENTACTIVE;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return studentStatus;
    }

    public boolean insertStudentStatus(int studentID,int studentStatus){
        Table table=TableManager.getTable(TableManager.RPS_EUNTERSTUDENTSTATUS);
        try{
            String q="INSERT INTO "+table.getTableName()+"("+table.getColumn(0)+","+table.getColumn(1)+") VALUES('"+studentID+"','"+studentStatus+"')";
            DBHelper.getInstance().updateQuery(q);
            return true;
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
    }

    public boolean setStudentStatus(int studentID,int studentStatus){
        Table table=TableManager.getTable(TableManager.RPS_EUNTERSTUDENTSTATUS);
        try{
            String q="UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"='"+studentStatus+"' WHERE "+table.getColumn(0)+"='"+studentID+"'";
            DBHelper.getInstance().updateQuery(q);
            return true;
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
    }

    //Basic Methods
    public String getError(){
        return error;
    }

    public void setError(String errorString){
        this.error=errorString;
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
    public int STUDENTACTIVE=0;
    public int STUDENTNOTACTIVE=1;
}
