package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Course;
import com.rheinlandprivatschule.model.CourseRegistration;
import com.rheinlandprivatschule.model.Table;

import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Vector;

public class RegistrationDao {

    public boolean payOnline(int courseID,int studentID,double courseFee,double paid,int registrationType,double addition,int registrationStatus,Vector<Course> courses){
        /*To Pay Money*/
        //if(isAnyNochOffenOtherThan(studentID,courseID)){
        //	setError("Es gibt Betrag, um f�r anderen Kurs zu zahlen. Sie m�ssen das zuerst bezahlen.");
        //	return false;
        //}else{
        if(addNewCourseRegistration(courseID,studentID,MyDate.getCurrentSQLDate(),registrationType,(courseFee+addition)-paid,(courseFee+addition),MyDate.getCurrentSQLDate(),registrationStatus)){
            boolean ch=true;
            for(int i=0;i<courses.size();i++){
                Course course=(Course)courses.elementAt(i);
                if(course.getCourseID()!=courseID){
                    ch=addNewCourseRegistration(course.getCourseID(),studentID,MyDate.getCurrentSQLDate(),registrationType,course.getCourseFee(),course.getCourseFee(),null,O_ONLINE);
                }
            }
            return ch;
        }else{
            return false;
        }
    }

    public boolean payFirstTime(int courseID, int studentID, double courseFee, double paid, int registrationType, double addition, int registrationStatus, Vector<Course> courses, String integration){
        /*To Pay Money*/
        //if(isAnyNochOffenOtherThan(studentID,courseID)){
        //	setError("Es gibt Betrag, um für anderen Kurs zu zahlen. Sie müssen das zuerst bezahlen.");
        //	return false;
        //}else{
        if(canPayThisAmount(studentID,courseID,(courseFee+addition),paid)){
            boolean canpay=false;
            Course tempCourse=new Course();
            CourseDao courseDB=new CourseDao();
            tempCourse=courseDB.getCourse(courseID);
            if(courseDB.isCourseActive(tempCourse)){
                double check=(courseFee+addition)-paid;
                if(check==0){
                    canpay=true;
                }else if(integration!=null){
                    canpay=true;
                }else{
                    setError("Kurs ist aktiv. Sie müssen volle Gebühr bezahlen.");
                }
            }else{

                if(paid>=200){
                    canpay=true;
                }else if(integration!=null){
                    canpay=true;
                }
                else{
                    setError("Kurs ist nicht aktiv. Sie müssen Minimum 200,00 € bezahlen.");
                }
            }
            if(canpay){
                if(addNewCourseRegistration(courseID,studentID,MyDate.getCurrentSQLDate(),registrationType,(courseFee+addition)-paid,(courseFee+addition),MyDate.getCurrentSQLDate(),registrationStatus)){
                    boolean ch=true;
                    for(int i=0;i<courses.size();i++){
                        Course course=(Course)courses.elementAt(i);
                        ch=addNewCourseRegistration(course.getCourseID(),studentID,MyDate.getCurrentSQLDate(),registrationType,course.getCourseFee(),course.getCourseFee(),null,V_VERTRAG);
                    }
                    return ch;
                }else{
                    return false;
                }
            }else{
                return false;
            }
        }else{
            return false;
        }
    }

    public boolean addNewCourseRegistration(int courseID, int studentID, Date registrationDate, int registrationType, double courseBalance, double courseFee, Date firstPayDate, int registrationStatus){
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+","+table.getColumn(7)+") VALUES('"
                    +courseID
                    +"','"
                    +studentID
                    + "',"
                    +replaceNull(registrationDate)
                    +",'"
                    +registrationType
                    +"','"
                    +courseBalance
                    +"','"
                    +courseFee+"',"+replaceNull(firstPayDate)+",'"+registrationStatus+"')";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError ("Kurs ist bereits zu diesem Kursteilnehmer registriert worden");
        }
        return result;
    }

    public boolean paySecondTime(int courseID,int studentID,double currentBalance,double courseFee,double paid,int paymentType,boolean minusFlag){
        if(minusFlag){
            /*To Return Money*/
            if(canReturnThisAmount(studentID,courseID,currentBalance,courseFee,paid)){
                if(updateSecondTimeRegistration(courseID,studentID,(currentBalance-paid))){
                    return true;
                }else{
                    return false;
                }
            }else{
                return false;
            }
        }else{
            /*To Pay Money*/
            if(canPayThisAmount(studentID,courseID,currentBalance,paid)){
                if(updateSecondTimeRegistration(courseID,studentID,(currentBalance-paid))){
                    return true;
                }else{
                    return false;
                }
            }else{
                return false;
            }
        }
    }

    public boolean canPayThisAmount(int studentID,int courseID,double courseBalance,double amount){
        boolean result=false;
        try{
            if(courseBalance!=0){
                if(amount<=courseBalance){
                    result=true;
                }else{
                    setError("Betrag ist nicht richtig.");
                }
            }else{
                setError("Kurs-Geb�hr ist bereits bezahlt worden.");
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public boolean canReturnThisAmount(int studentID,int courseID,double courseBalance,double courseFee,double amount){
        boolean result=false;
        try{
            double amountPaid=(new StudentDao()).hasPaidForTheCourse(studentID,courseID);
            double localAmount=(-1)*amount;
            if(localAmount<=amountPaid){
                result=true;
            }else{
                setError("Betrag ist nicht richtig. Oder Das ist mehr als der Betrag, der vom Studenten bezahlt wird.");
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public ArrayList<CourseRegistration> getRegistrationByStudentID(int studentID) {

        ArrayList<CourseRegistration> registrations = new ArrayList<CourseRegistration>();
        Table registration_table = TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        Table courses_table=TableManager.getTable(TableManager.RPS_COURSES);
        try {
            String q = "SELECT a." + registration_table.getColumn(0) + ",a."
                    + registration_table.getColumn(1) + ",a."
                    + registration_table.getColumn(2) + ",a."
                    + registration_table.getColumn(3) + ",a."
                    + registration_table.getColumn(4) + ",a."
                    + registration_table.getColumn(5) + ",a."
                    + registration_table.getColumn(6) + ",a."
                    + registration_table.getColumn(7) + " FROM "
                    + registration_table.getTableName() + " AS a,"+courses_table.getTableName()+" AS b WHERE "
                    + registration_table.getColumn(1) + "='" + studentID + "' AND b."
                    + courses_table.getColumn(0)+"=a."+registration_table.getColumn(0)
                    +" ORDER BY b."+courses_table.getColumn(10)+",a."+registration_table.getColumn(2);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                CourseRegistration registration = new CourseRegistration();
                registration.setCourseID(rs.getInt(registration_table.getColumn(0)));
                registration.setStudentID(rs.getInt(registration_table.getColumn(1)));
                registration.setRegistrationDate(rs.getDate(registration_table.getColumn(2)));
                registration.setRegistrationType(rs.getInt(registration_table.getColumn(3)));
                registration.setCourseBalance(rs.getDouble(registration_table.getColumn(4)));
                registration.setCourseFee(rs.getDouble(registration_table.getColumn(5)));
                registration.setFirstPayDate(rs.getDate(registration_table.getColumn(6)));
                registration.setRegistrationStatus(rs.getInt(registration_table.getColumn(7)));
                registrations.add(registration);
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return registrations;
    }

    public CourseRegistration getRegistrationByStudent(int courseID,int studentID) {
        CourseRegistration registration = new CourseRegistration();
        Table registration_table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        try {
            String q = "SELECT "+registration_table.getColumn(0)+","+registration_table.getColumn(1)+","+registration_table.getColumn(2)+","+registration_table.getColumn(3)+","+registration_table.getColumn(4)+","+registration_table.getColumn(5)+","+registration_table.getColumn(6)+","+registration_table.getColumn(7)+" FROM "+registration_table.getTableName()+" WHERE "+registration_table.getColumn(0)+"='"
                    + courseID + "' AND "+registration_table.getColumn(1)+"='" + studentID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                registration.setCourseID(rs.getInt(registration_table.getColumn(0)));
                registration.setStudentID(rs.getInt(registration_table.getColumn(1)));
                registration.setRegistrationDate(rs.getDate(registration_table.getColumn(2)));
                registration.setRegistrationType(rs.getInt(registration_table.getColumn(3)));
                registration.setCourseBalance(rs.getDouble(registration_table.getColumn(4)));
                registration.setCourseFee(rs.getDouble(registration_table.getColumn(5)));
                registration.setFirstPayDate(rs.getDate(registration_table.getColumn(6)));
                registration.setRegistrationStatus(rs.getInt(registration_table.getColumn(7)));
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return registration;
    }

    public boolean updateSecondTimeRegistration(int courseID,int studentID,double courseBalance) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(4)+"='"
                    + courseBalance+ "',"+table.getColumn(7)+"='"+R_REGISTERED+"' WHERE "+table.getColumn(0)+"='" + courseID+ "' AND "+table.getColumn(1)+"='"
                    + studentID+ "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
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

    public static int R_REGISTERED=1;
    public static int V_VERTRAG=0;
    public static int A_ABMELDUNG=2;
    public static int O_ONLINE=3;

    public static double DEFAULTPAYMENT=200;

    public static int SYSTEMPAYMENTMODE=0;
    public static int MANUALPAYMENTMODE=1;
}
