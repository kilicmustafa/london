package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.*;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Vector;

public class StudentDao {

    //Class Variables
    public static final int ACTIVE=1;
    public static final int FIRSTNAME=2;
    public static final int LASTNAME=3;
    public static final int DATEOFBIRTH=4;
    public static final int KUNDENNR=5;
    public static final int NOCRITERION=6;
    public static final int NOTACTIVE=7;

    private static final int ONLINESTUDENT=3;

    private static final int INKASSO=2;

    private DBHelper dbHelper;

    public StudentDao() {
        dbHelper = DBHelper.getInstance();
    }

    public boolean updateCourseRegistrationOnline(int courseID,int studentID,double courseFee,double paid,int paymentType,double addition,int registrationStatus,Vector<Course> courses) {
        try{
            RegistrationDao registrationDB=new RegistrationDao();
            boolean result=registrationDB.payOnline(courseID,studentID,courseFee,paid,paymentType,addition,registrationStatus,courses);
            setError(registrationDB.getError());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
    }

    public boolean newEinzelUnterricht(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.6");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean addOnlineInfo(int studentID) {
        boolean result = false;
        try {
            String q = "INSERT INTO rps_onlinestudent(userID)VALUES('" + studentID
                    + "')";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        }catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean canSeeOnlineStudentsInformation(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "2.4");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean updateRemark(int studentID,String rem,int loginUser) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.10");
        if(flag){
            Table table=TableManager.getTable(TableManager.RPS_USER);
            try {
                String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(17)+"=" + replaceNull(rem)
                        + " WHERE "+table.getColumn(0)+"='" + studentID + "'";
                DBHelper.getInstance().updateQuery(q);
                return true;
            } catch (Exception e) {
                setError(e.toString());
                return false;
            }
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean addGroupsToNewStudent(int studentID,int groupID,int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "20.1.3");
        if(flag){
            return new GroupDao().addGroupRelatedToClient(studentID,groupID);
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean payEinzelUnterricht(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.9");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean addWerbungsToNewStudent(int studentID,int werbungID,int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "11.1.3");
        if(flag){
            return new WerbungDao().addWerbungRelatedToClient(studentID,werbungID);
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean updateCourseRegistrationFirstTime(int courseID,int studentID,double courseFee,double paid,int paymentType,double addition,int registrationStatus,Vector<Course> courses, String integration) {
        try{
            RegistrationDao registrationDB=new RegistrationDao();
            boolean result=registrationDB.payFirstTime(courseID,studentID,courseFee,paid,paymentType,addition,registrationStatus,courses, integration);
            setError(registrationDB.getError());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
    }

    public Student getStudentInformationExt(int studentID) {
        Student student = new Student();
        Table table=TableManager.getTable(TableManager.RPS_USER);
        try {
            String q = "SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+","
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
                    +table.getColumn(12)+","
                    +table.getColumn(13)+","
                    +table.getColumn(14)+","
                    +table.getColumn(15)+","
                    +table.getColumn(16)+","
                    +table.getColumn(17)+","
                    +table.getColumn(18)+","
                    +table.getColumn(19)+","
                    +table.getColumn(20)+","
                    +table.getColumn(21)+","
                    +table.getColumn(22)+","
                    +table.getColumn(23)+","
                    +table.getColumn(24)+","
                    +table.getColumn(25)+","
                    +table.getColumn(26)+","
                    +table.getColumn(27)+","
                    +table.getColumn(28)+","
                    +table.getColumn(29)+","
                    +table.getColumn(30)+","
                    +table.getColumn(31)+","
                    +table.getColumn(32)+","
                    +table.getColumn(33)+","
                    +table.getColumn(34)+","
                    +table.getColumn(35)+","
                    +table.getColumn(36)+","
                    +table.getColumn(37)+","
                    +table.getColumn(38)+","
                    +table.getColumn(39)+","
                    +table.getColumn(40)+","
                    +table.getColumn(41)+","
                    +table.getColumn(42)+","
                    +table.getColumn(44)+","
                    +table.getColumn(45)+","
                    +table.getColumn(46)+","
                    +table.getColumn(47)+" FROM "+table.getTableName()+" WHERE "
                    +table.getColumn(0)+"='"
                    + studentID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                student.setUserID(rs.getInt(table.getColumn(0)));
                student.setUserFirstName(rs.getString(table.getColumn(1)));
                student.setUserLastName(rs.getString(table.getColumn(2)));
                student.setUserBirthDate(rs.getDate(table.getColumn(3)));
                student.setUserGender(rs.getInt(table.getColumn(4)));
                student.setUserBirthPlace(rs.getString(table.getColumn(5)));
                student.setUserNationality(rs.getString(table.getColumn(6)));
                student.setUserAddress(rs.getString(table.getColumn(7)));
                student.setUserPostCode(rs.getString(table.getColumn(8)));
                student.setUserCity(rs.getString(table.getColumn(9)));
                student.setUserCountry(rs.getString(table.getColumn(10)));
                student.setUserHomePhone(rs.getString(table.getColumn(11)));
                student.setUserMobilePhone(rs.getString(table.getColumn(12)));
                student.setUserFax(rs.getString(table.getColumn(13)));
                student.setUserEmail(rs.getString(table.getColumn(14)));
                student.setUserLoginName(rs.getString(table.getColumn(15)));
                student.setUserPassword(rs.getString(table.getColumn(16)));
                student.setUserRemarks(rs.getString(table.getColumn(17)));
                student.setUserActive(rs.getInt(table.getColumn(18)));
                student.setUserCO(rs.getString(table.getColumn(19)));
                student.setUserCountryID(rs.getInt(table.getColumn(20)));
                student.setUserHomeCode(rs.getString(table.getColumn(21)));
                student.setUserHomeRegion(rs.getString(table.getColumn(22)));
                student.setUserMobileCode(rs.getString(table.getColumn(23)));
                student.setUserMobileRegion(rs.getString(table.getColumn(24)));
                student.setUserFaxCode(rs.getString(table.getColumn(25)));
                student.setUserFaxRegion(rs.getString(table.getColumn(26)));
                student.setUserBamfNumber(rs.getString(table.getColumn(27)));
                student.setUserBamfChoice(rs.getInt(table.getColumn(28)));
                student.setUserHours(rs.getInt(table.getColumn(29)));
                student.setUserLastVisit(rs.getString(table.getColumn(30)));
                student.setUserBamfNrSchool(rs.getString(table.getColumn(31)));
                student.setUserAcademicPoints(rs.getInt(table.getColumn(32)));
                student.setUserSchoolingYears(rs.getInt(table.getColumn(33)));
                student.setUserIntTest(rs.getInt(table.getColumn(34)));
                student.setUserIntTestCheck(rs.getInt(table.getColumn(35)));
                student.setUserProficency(rs.getInt(table.getColumn(36)));
                student.setUserSponsorShip(rs.getInt(table.getColumn(37)));
                student.setUserIdentityID(rs.getInt(table.getColumn(38)));
                student.setUserCostSharing(rs.getInt(table.getColumn(39)));
                student.setUserClassification(rs.getInt(table.getColumn(40)));
                student.setUserConclusion(rs.getDate(table.getColumn(41)));
                student.setUserConcCourse(rs.getDate(table.getColumn(42)));
                student.setUserVerifiedNumber(rs.getString(table.getColumn(44)));
                student.setUserGradingDate(rs.getDate(table.getColumn(45)));
                student.setUserModuleNr(rs.getInt(table.getColumn(46)));
                student.setUserPassport(rs.getString(table.getColumn(47)));
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return student;
    }

    public ArrayList<CourseRegistration> getRegistrationByStudentIDSubProcess(int studentID){
        RegistrationDao registrationDB = new RegistrationDao();
        ArrayList<CourseRegistration> registrations = registrationDB.getRegistrationByStudentID(studentID);
        return registrations;
    }

    public boolean canChangeCourse(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.11.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean changeCourseRegistration(CourseRegistration oldCourseRegistration,int newCourseID) {
        boolean result = false;
        RegistrationDao rdb=new RegistrationDao();
        CourseDao cdb=new CourseDao();
        MahnungDao mahnungDB = new MahnungDao();

        Course oldCourse=cdb.getCourse(oldCourseRegistration.getCourseID());
        Course newCourse=cdb.getCourse(newCourseID);

        double oldRegistrationFee=oldCourseRegistration.getCourseFee();
        double oldRegistrationExtra=oldRegistrationFee-oldCourse.getCourseFee();
        double oldRegistrationBalance=oldCourseRegistration.getCourseBalance();
        double oldActualPaid=oldRegistrationFee-oldRegistrationBalance;

        double newRegistrationFee=0;
        double newRegistrationBalance=0;
        if(oldRegistrationExtra<0){
            newRegistrationFee=oldRegistrationFee;
            newRegistrationBalance=newRegistrationFee-oldActualPaid;
        }else{
            newRegistrationFee=newCourse.getCourseFee()+oldRegistrationExtra;
            newRegistrationBalance=newRegistrationFee-oldActualPaid;
        }

        if(deleteCourseRegistrationExplicitly(oldCourseRegistration.getCourseID(),oldCourseRegistration.getStudentID())){
            if(rdb.addNewCourseRegistration(newCourseID,oldCourseRegistration.getStudentID(),oldCourseRegistration.getRegistrationDate(),oldCourseRegistration.getRegistrationType(),newRegistrationBalance,newRegistrationFee,oldCourseRegistration.getFirstPayDate(),oldCourseRegistration.getRegistrationStatus())){
                mahnungDB.updateChangeCourseInMahnung(oldCourseRegistration.getStudentID(),oldCourse.getCourseID(),newCourse.getCourseID());
                result = true;
            }else{
                setError(rdb.getError());
            }
        }
        return result;
    }

    public boolean deleteCourseRegistrationExplicitly(int courseID, int studentID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        try {
            if (true) {
                String q = "DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                        + courseID + "' AND "+table.getColumn(1)+"='" + studentID + "'";
                DBHelper.getInstance().updateQuery(q);
                result = true;
            }

        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }


    public boolean canBlockMahnung(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.11.6");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean payForTheCourseMinus(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.11.10");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canMakeVertrag(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.4");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canMakeBilder(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.4");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canMakeVertragManuall(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.4.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canMakeBilderManuall(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.4.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canMakeABAllgemein(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.14");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public int addTransaction(double paid,int registrationType,int studentID,int courseID,int placeID,int loginUserID, int initialTest){
        return (new TransactionDao()).addTransaction(paid,MyDate.getCurrentSQLDate(),registrationType,studentID,courseID,placeID,loginUserID,initialTest);
    }

    public int addNullGebuhr(double paid,int registrationType,int studentID,int courseID,int placeID,int loginUserID){
        return (new TransactionDao()).addNullGebuhr(paid,MyDate.getCurrentSQLDate(),registrationType,studentID,courseID,placeID,loginUserID);
    }

    public int addPrintRegRecord(double paid,int registrationType,int studentID,int courseID,int placeID,int loginUserID){
        return (new TransactionDao()).addPrintRegRecord(paid,MyDate.getCurrentSQLDate(),registrationType,studentID,courseID,placeID,loginUserID);
    }

    public boolean updateCourseRegistrationSecondTime(int courseID,int studentID,double currentBalance,double courseFee,double paid,int paymentType,boolean minusFlag) {
        try{
            RegistrationDao registrationDB=new RegistrationDao();
            boolean result=registrationDB.paySecondTime(courseID,studentID,currentBalance,courseFee,paid,paymentType,minusFlag);
            setError(registrationDB.getError());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
    }

    public ArrayList<Transaction> getTransactions(int studentID,int courseID){
        ArrayList<Transaction> transactions = new ArrayList<Transaction>();
        ArrayList<Transaction> tranVector=(new TransactionDao()).getTransactions(studentID,courseID);
        for(int i=0;i<tranVector.size();i++){
            Transaction transaction=(Transaction)tranVector.get(i);
            transactions.add(transaction);
        }
        return transactions;
    }

    public double hasPaidForTheCourse(int studentID,int courseID){
        double result=0;
        ArrayList<Transaction> trans=getTransactions(studentID,courseID);
        Iterator transIT=trans.iterator();
        while(transIT.hasNext()){
            Transaction tt=(Transaction)transIT.next();
            result=result+tt.getPaid();
        }
        return result;
    }

    public boolean isRegisteredCourseActive(Course course){
        CourseDao courseDB=new CourseDao();
        return courseDB.isCourseActive(course);
    }

    public boolean canPrintRegistration(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.11.5");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canPrintMahnung(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.11.7");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canPrintCertificate(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.11.8");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canGenerateCertificate(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.11.4");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeeCourseRegistration(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.11");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeeFreigabe(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.8");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean updateStudentFreigabe(Student u,int loginUser) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.3");
        if(flag){
            try {
                Table table=TableManager.getTable(TableManager.RPS_USER);
                String q = "UPDATE "+table.getTableName()+" SET "
                        + table.getColumn(49)+"="+ replaceNull(u.getFreigabeStatus()) + ","
                        + table.getColumn(50)+"="+ replaceNull(u.getFreigabeDate())+" WHERE "
                        +table.getColumn(0)+"='"+ u.getUserID() + "'";
                DBHelper.getInstance().updateQuery(q);
                return true;
            } catch (Exception e) {
                setError(e.toString());
                return false;
            }
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public ArrayList downloadVertrag(int studentID,int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.1");
        if(flag){
            ArrayList vertrags=new ArrayList();
            vertrags=(new VertragTraker()).getVertrags(studentID);
            return vertrags;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    public boolean makeStudentActive(int active, int studentID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_USER);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(18)+"='" + active
                    + "' WHERE "+table.getColumn(0)+"='" + studentID + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public int getTotalPay(int studentID, int courseID) {
        int b = 0;
        Table table=TableManager.getTable(TableManager.RPS_TRAN);
        try {
            String q = "SELECT SUM("+table.getColumn(1)+") AS a FROM "+table.getTableName()+" WHERE "+table.getColumn(4)+"='"
                    + studentID + "' AND "+table.getColumn(5)+"='" + courseID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                b = rs.getInt("a");
            }
        } catch (Exception e) {
            this.error = e.toString();
        }
        return b;
    }

    public ArrayList<Student> getAllStudentsNotRegister(int loginUser) {
        boolean flag = PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.5");
        if (flag) {
            Table registration_table = TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
            Table eunterricht_table = TableManager.getTable(TableManager.RPS_EUNTERRICHT);
            Table bericht_table = TableManager.getTable(TableManager.RPS_TRAN);
            Table student_table = TableManager.getTable(TableManager.RPS_USER);
            Table onlinestudent_table=TableManager.getTable(TableManager.RPS_ONLINESTUDENT);
            ArrayList<Student> students = new ArrayList<Student>();
            try {
                /* Fetch Students With Course Registrations */
                String q1 = "SELECT DISTINCT "
                        + registration_table.getColumn(1) + " FROM "
                        + registration_table.getTableName() + " ORDER BY "
                        + registration_table.getColumn(1);
                ResultSet rs1 = dbHelper.executeQuery(q1);
                String list1 = "0";
                String list2 = "0";
                String list3 = "0";
                boolean track1 = false;
                while (rs1.next()) {
                    if (!track1) {
                        list1 = ""
                                + rs1.getInt(registration_table.getColumn(1));
                        track1 = true;
                    } else {
                        list1 = list1 + ","
                                + rs1.getInt(registration_table.getColumn(1));
                    }
                }

                /* Fetch Students With SingleClasses */
                String q2 = "SELECT DISTINCT " + eunterricht_table.getColumn(1)
                        + " FROM " + eunterricht_table.getTableName()
                        + " ORDER BY " + eunterricht_table.getColumn(1);
                ResultSet rs2 = dbHelper.executeQuery(q2);
                boolean track2 = false;
                while (rs2.next()) {
                    if (!track2) {
                        list2 = "" + rs2.getInt(eunterricht_table.getColumn(1));
                        track2 = true;
                    } else {
                        list2 = list2 + ","
                                + rs2.getInt(eunterricht_table.getColumn(1));
                    }
                }

                /* Fetch Students With Payments */
                String q3 = "SELECT DISTINCT " + bericht_table.getColumn(4)
                        + " FROM " + bericht_table.getTableName()
                        + " ORDER BY " + bericht_table.getColumn(4);
                ResultSet rs3 = dbHelper.executeQuery(q3);
                boolean track3 = false;
                while (rs3.next()) {
                    if (!track3) {
                        list3 = "" + rs3.getInt(bericht_table.getColumn(4));
                        track3 = true;
                    } else {
                        list3 = list3 + ","
                                + rs3.getInt(bericht_table.getColumn(4));
                    }
                }

                /* Fetch Actual Students */
                String q = "SELECT " + student_table.getColumn(0) + ","
                        + student_table.getColumn(1) + ","
                        + student_table.getColumn(2) + ","
                        + student_table.getColumn(3) + ","
                        + student_table.getColumn(13) + ","
                        + student_table.getColumn(14) + ","
                        + student_table.getColumn(43) + " FROM "
                        + student_table.getTableName() + " WHERE "
                        + student_table.getColumn(0) + " NOT IN (" + list1
                        + ") AND " + student_table.getColumn(0) + " NOT IN ("
                        + list2 + ") AND " + student_table.getColumn(0) + " NOT IN ("
                        + list3 + ") UNION SELECT a." + student_table.getColumn(0)+",a."
                        + student_table.getColumn(1)+",a."
                        + student_table.getColumn(2)+",a."
                        + student_table.getColumn(3)+",a."
                        + student_table.getColumn(13)+",a."
                        + student_table.getColumn(14)+",a."
                        + student_table.getColumn(43) + " FROM "
                        +student_table.getTableName()+" AS a,"
                        +onlinestudent_table.getTableName()+" AS b WHERE b."
                        +onlinestudent_table.getColumn(0)+"=a."+student_table.getColumn(0)+" AND a."
                        +student_table.getColumn(0)+" NOT IN (" + list2+ ") ORDER BY "
                        +student_table.getColumn(0);

                ResultSet rs = dbHelper.executeQuery(q);
                while (rs.next()) {
                    Student student = new Student();
                    student.setUserID(rs.getInt(student_table.getColumn(0)));
                    student.setUserFirstName(rs.getString(student_table.getColumn(1)));
                    student.setUserLastName(rs.getString(student_table.getColumn(2)));
                    student.setUserBirthDate(rs.getDate(student_table.getColumn(3)));
                    student.setUserFax(rs.getString(student_table.getColumn(13)));
                    student.setUserEmail(rs.getString(student_table.getColumn(14)));
                    student.setUserRegDate(rs.getDate(student_table.getColumn(43)));
                    students.add(student);
                }
                return students;
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        } else {
            return null;
        }
    }

    public String[] getLists() {
        Table registration_table = TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        Table eunterricht_table = TableManager.getTable(TableManager.RPS_EUNTERRICHT);
        Table bericht_table = TableManager.getTable(TableManager.RPS_TRAN);
        try {
            /* Fetch Students With Course Registrations */
            String q1 = "SELECT DISTINCT "
                    + registration_table.getColumn(1) + " FROM "
                    + registration_table.getTableName() + " ORDER BY "
                    + registration_table.getColumn(1);
            ResultSet rs1 = dbHelper.executeQuery(q1);
            String list1 = "0";
            String list2 = "0";
            String list3 = "0";
            boolean track1 = false;
            while (rs1.next()) {
                if (!track1) {
                    list1 = ""
                            + rs1.getInt(registration_table.getColumn(1));
                    track1 = true;
                } else {
                    list1 = list1 + ","
                            + rs1.getInt(registration_table.getColumn(1));
                }
            }

            /* Fetch Students With SingleClasses */
            String q2 = "SELECT DISTINCT " + eunterricht_table.getColumn(1)
                    + " FROM " + eunterricht_table.getTableName()
                    + " ORDER BY " + eunterricht_table.getColumn(1);
            ResultSet rs2 = dbHelper.executeQuery(q2);
            boolean track2 = false;
            while (rs2.next()) {
                if (!track2) {
                    list2 = "" + rs2.getInt(eunterricht_table.getColumn(1));
                    track2 = true;
                } else {
                    list2 = list2 + ","
                            + rs2.getInt(eunterricht_table.getColumn(1));
                }
            }

            /* Fetch Students With Payments */
            String q3 = "SELECT DISTINCT " + bericht_table.getColumn(4)
                    + " FROM " + bericht_table.getTableName()
                    + " ORDER BY " + bericht_table.getColumn(4);
            ResultSet rs3 = dbHelper.executeQuery(q3);
            boolean track3 = false;
            while (rs3.next()) {
                if (!track3) {
                    list3 = "" + rs3.getInt(bericht_table.getColumn(4));
                    track3 = true;
                } else {
                    list3 = list3 + ","
                            + rs3.getInt(bericht_table.getColumn(4));
                }
            }
            System.out.println(q1);
            System.out.println(q2);
            System.out.println(q3);
            return new String[]{list1, list2, list3};
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    public ArrayList<Student> getAllStudentsNotRegisterBetweenIndices(int loginUser, int limit, int offset, String list1, String list2, String list3) {
        boolean flag = PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.5");
        if (flag) {

            Table student_table = TableManager.getTable(TableManager.RPS_USER);
            Table onlinestudent_table=TableManager.getTable(TableManager.RPS_ONLINESTUDENT);
            ArrayList<Student> students = new ArrayList<Student>();
            try {

                /* Fetch Actual Students */
                String q = "SELECT " + student_table.getColumn(0) + ","
                        + student_table.getColumn(1) + ","
                        + student_table.getColumn(2) + ","
                        + student_table.getColumn(3) + ","
                        + student_table.getColumn(13) + ","
                        + student_table.getColumn(14) + ","
                        + student_table.getColumn(43) + " FROM "
                        + student_table.getTableName() + " WHERE "
                        + student_table.getColumn(0) + " NOT IN (" + list1
                        + ") AND " + student_table.getColumn(0) + " NOT IN ("
                        + list2 + ") AND " + student_table.getColumn(0) + " NOT IN ("
                        + list3 + ") UNION SELECT a." + student_table.getColumn(0)+",a."
                        + student_table.getColumn(1)+",a."
                        + student_table.getColumn(2)+",a."
                        + student_table.getColumn(3)+",a."
                        + student_table.getColumn(13)+",a."
                        + student_table.getColumn(14)+",a."
                        + student_table.getColumn(43) + " FROM "
                        +student_table.getTableName()+" AS a,"
                        +onlinestudent_table.getTableName()+" AS b WHERE b."
                        +onlinestudent_table.getColumn(0)+"=a."+student_table.getColumn(0)+" AND a."
                        +student_table.getColumn(0)+" NOT IN (" + list2+ ") ORDER BY "
                        +student_table.getColumn(0) + " LIMIT " + limit + " OFFSET " + offset;
                System.out.println(q);
                ResultSet rs = dbHelper.executeQuery(q);
                while (rs.next()) {
                    Student student = new Student();
                    student.setUserID(rs.getInt(student_table.getColumn(0)));
                    student.setUserFirstName(rs.getString(student_table.getColumn(1)));
                    student.setUserLastName(rs.getString(student_table.getColumn(2)));
                    student.setUserBirthDate(rs.getDate(student_table.getColumn(3)));
                    student.setUserFax(rs.getString(student_table.getColumn(13)));
                    student.setUserEmail(rs.getString(student_table.getColumn(14)));
                    student.setUserRegDate(rs.getDate(student_table.getColumn(43)));
                    students.add(student);
                }
                return students;
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        } else {
            return null;
        }
    }

    public Student getStudent(int studentID,int loginUser) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6");
        if(flag){
            Student student = new Student();
            Table table=TableManager.getTable(TableManager.RPS_USER);
            try {
                String q = "SELECT "+table.getColumn(0)+","
                        +table.getColumn(1)+","
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
                        +table.getColumn(12)+","
                        +table.getColumn(13)+","
                        +table.getColumn(14)+","
                        +table.getColumn(15)+","
                        +table.getColumn(16)+","
                        +table.getColumn(17)+","
                        +table.getColumn(18)+","
                        +table.getColumn(19)+","
                        +table.getColumn(21)+","
                        +table.getColumn(22)+","
                        +table.getColumn(23)+","
                        +table.getColumn(24)+","
                        +table.getColumn(27)+","
                        +table.getColumn(39)+","
                        +table.getColumn(49)+","
                        +table.getColumn(50)+" FROM "
                        +table.getTableName()+" WHERE "
                        +table.getColumn(0)+"='" + studentID + "'";
                ResultSet rs = dbHelper.executeQuery(q);
                while (rs.next()) {
                    student.setUserID(rs.getInt(table.getColumn(0)));
                    student.setUserFirstName(rs.getString(table.getColumn(1)));
                    student.setUserLastName(rs.getString(table.getColumn(2)));
                    student.setUserBirthDate(rs.getDate(table.getColumn(3)));
                    student.setUserGender(rs.getInt(table.getColumn(4)));
                    student.setUserBirthPlace(rs.getString(table.getColumn(5)));
                    student.setUserNationality(rs.getString(table.getColumn(6)));
                    student.setUserAddress(rs.getString(table.getColumn(7)));
                    student.setUserPostCode(rs.getString(table.getColumn(8)));
                    student.setUserCity(rs.getString(table.getColumn(9)));
                    student.setUserCountry(rs.getString(table.getColumn(10)));
                    student.setUserHomePhone(rs.getString(table.getColumn(11)));
                    student.setUserMobilePhone(rs.getString(table.getColumn(12)));
                    student.setUserFax(rs.getString(table.getColumn(13)));
                    student.setUserEmail(rs.getString(table.getColumn(14)));
                    student.setUserLoginName(rs.getString(table.getColumn(15)));
                    student.setUserPassword(rs.getString(table.getColumn(16)));
                    student.setUserRemarks(rs.getString(table.getColumn(17)));
                    student.setUserActive(rs.getInt(table.getColumn(18)));
                    student.setUserCO(rs.getString(table.getColumn(19)));
                    student.setUserHomeCode(rs.getString(table.getColumn(21)));
                    student.setUserHomeRegion(rs.getString(table.getColumn(22)));
                    student.setUserMobileCode(rs.getString(table.getColumn(23)));
                    student.setUserMobileRegion(rs.getString(table.getColumn(24)));
                    student.setUserBamfNumber(rs.getString(table.getColumn(27)));
                    student.setUserCostSharing(rs.getInt(table.getColumn(39)));
                    student.setFreigabeStatus(rs.getInt(table.getColumn(49)));
                    student.setFreigabeDate(rs.getDate(table.getColumn(50)));
                }
            } catch (Exception e) {
                setError(e.toString());
                return null;
            }
            return student;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    public boolean hasPaidXtra(int studentID){
        boolean flag = false;
        Table tran_table = TableManager.getTable(TableManager.RPS_XTRACOSTS);
        try {
            String q = "SELECT " + tran_table.getColumn(0) + " FROM " + tran_table.getTableName()+ " WHERE "
                    + tran_table.getColumn(1) + "='" + studentID + "'";
            ResultSet rs = dbHelper.executeQuery(q);
            while (rs.next()) {
                rs.getInt(tran_table.getColumn(0));
                flag = true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return flag;
    }

    public ArrayList<Student> getAllOnlineNotPaid(int loginUser) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "2.4");
        if(flag){
            ArrayList<Student> tempStudentsList = new ArrayList<Student>();
            ArrayList<Student> studentsList = new ArrayList<Student>();
            Table registration_table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
            Table student_table=TableManager.getTable(TableManager.RPS_USER);
            try {

                String qq = "SELECT DISTINCT "+registration_table.getColumn(1)+" FROM "
                        +registration_table.getTableName()+" WHERE "
                        +registration_table.getColumn(7)+"='"
                        + ONLINESTUDENT + "' ORDER BY "+registration_table.getColumn(1)+" DESC";
                ResultSet rs1 = dbHelper.executeQuery(qq);
                String list = "";
                boolean track = false;
                while (rs1.next()) {
                    if (!track) {
                        list = "" + rs1.getInt(registration_table.getColumn(1));
                        track = true;
                    } else {
                        list = list + "," + rs1.getInt(registration_table.getColumn(1));
                    }
                }
                qq = "SELECT "+student_table.getColumn(0)+","
                        +student_table.getColumn(1)+","
                        +student_table.getColumn(2)+","
                        +student_table.getColumn(3)+","
                        +student_table.getColumn(14)+","
                        +student_table.getColumn(43)+" FROM "
                        +student_table.getTableName()+" WHERE "
                        +student_table.getColumn(0)+" IN ("
                        + list + ") ORDER BY "+student_table.getColumn(0)+" DESC";
                ResultSet rs = dbHelper.executeQuery(qq);
                while (rs.next()) {
                    Student student = new Student();
                    student.setUserID(rs.getInt(student_table.getColumn(0)));
                    student.setUserFirstName(rs.getString(student_table.getColumn(1)));
                    student.setUserLastName(rs.getString(student_table.getColumn(2)));
                    student.setUserBirthDate(rs.getDate(student_table.getColumn(3)));
                    student.setUserEmail(rs.getString(student_table.getColumn(14)));
                    student.setUserRegDate(rs.getDate(student_table.getColumn(43)));
                    tempStudentsList.add(student);
                }

                Iterator stIT = tempStudentsList.iterator();
                while(stIT.hasNext()){
                    Student tempStudent = (Student)stIT.next();
                    if((!hasPaid(tempStudent.getUserID())) || (!hasPaidXtra(tempStudent.getUserID()))){
                        studentsList.add(tempStudent);
                    }
                }
                return studentsList;

            } catch (Exception e) {
                setError(e.toString());
                return null;
            }

        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    public ArrayList<Student> getOnlineStudentWithoutReg(int loginUser) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "2.4");
        if(flag){
            ArrayList<Student>  studentsList = new ArrayList<Student> ();
            ArrayList<String>  stringStudentID = new ArrayList<String> ();
            Table onlinestudent_table=TableManager.getTable(TableManager.RPS_ONLINESTUDENT);
            try {
                String q = "SELECT "+onlinestudent_table.getColumn(0)+" FROM "
                        +onlinestudent_table.getTableName()+" ORDER BY "
                        +onlinestudent_table.getColumn(0)+" DESC";
                ResultSet rs = dbHelper.executeQuery(q);
                while (rs.next()) {
                    stringStudentID.add(""+rs.getInt(onlinestudent_table.getColumn(0)));
                }
                Iterator stringStudentIDIT=stringStudentID.iterator();
                while(stringStudentIDIT.hasNext()){
                    String tempS =(String)stringStudentIDIT.next();
                    int tempN = Integer.parseInt(tempS);
                    boolean isRegistered=isStudentyReg(tempN);
                    boolean isXtra=isStudentyInXtra(tempN);
                    if (!isRegistered){
                        Student tempStudent=getStudentForDisplay(tempN);
                        if(tempStudent.getUserID()==0){
                            deleteOnlineInfo(tempN);
                        }else{
                            if(!isXtra){
                                studentsList.add(tempStudent);
                            }
                        }
                    } else {
                        if(!deleteOnlineInfo(tempN)){
                            setError(getError());
                        }
                    }
                }
                return studentsList;
            } catch (Exception e) {
                setError(e.toString());
                return null;
            }
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    private boolean isStudentyInXtra(int studentID) {
        boolean b = false;
        Table registration_table=TableManager.getTable(TableManager.RPS_XTRACOSTS);
        try {
            String q = "SELECT "+registration_table.getColumn(1)+" FROM "+registration_table.getTableName()+" WHERE "+registration_table.getColumn(1)+"='"
                    + studentID + "'";
            ResultSet rs = dbHelper.executeQuery(q);
            int temp=0;
            while (rs.next()) {
                temp = rs.getInt(registration_table.getColumn(1));
            }
            if (temp == studentID) {
                b = true;
            }
        } catch (Exception e) {
            setError(e.toString());
            b = false;
        }
        return b;
    }

    private boolean deleteOnlineInfo(int studentID) {
        boolean b = false;
        Table onlinestudent_table=TableManager.getTable(TableManager.RPS_ONLINESTUDENT);
        try {
            String q = "DELETE FROM "+onlinestudent_table.getTableName()+" WHERE "+onlinestudent_table.getColumn(0)+"='" + studentID
                    + "'";
            dbHelper.updateQuery(q);
            b = true;
        } catch (Exception e) {
            b = false;
            setError(e.toString());
        }
        return b;
    }

    private Student getStudentForDisplay(int studentID) {
        Student student = new Student();
        Table table=TableManager.getTable(TableManager.RPS_USER);
        try {
            String q = "SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(14)+","
                    +table.getColumn(43)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+"='"+ studentID + "'";
            ResultSet rs = dbHelper.executeQuery(q);
            while (rs.next()) {
                student.setUserID(rs.getInt(table.getColumn(0)));
                student.setUserFirstName(rs.getString(table.getColumn(1)));
                student.setUserLastName(rs.getString(table.getColumn(2)));
                student.setUserBirthDate(rs.getDate(table.getColumn(3)));
                student.setUserEmail(rs.getString(table.getColumn(14)));
                student.setUserRegDate(rs.getDate(table.getColumn(43)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return student;
    }

    private boolean isStudentyReg(int studentID) {
        boolean b = false;
        Table registration_table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        try {
            String q = "SELECT "+registration_table.getColumn(1)+" FROM "+registration_table.getTableName()+" WHERE "+registration_table.getColumn(1)+"='"
                    + studentID + "'";
            ResultSet rs = dbHelper.executeQuery(q);
            int temp=0;
            while (rs.next()) {
                temp = rs.getInt(registration_table.getColumn(1));
            }
            if (temp == studentID) {
                b = true;
            }
        } catch (Exception e) {
            setError(e.toString());
            b = false;
        }
        return b;
    }

    public ArrayList<CourseRegistration> getRegistrationByStudentIDInternally(int studentID){
        RegistrationDao registrationDB=new RegistrationDao();
        ArrayList<CourseRegistration> registrations = new ArrayList<CourseRegistration>();
        registrations=registrationDB.getRegistrationByStudentID(studentID);
        return registrations;
    }

    public ArrayList<CourseRegistration> getRegistrationByStudentID(int studentID,int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6");
        if(flag){
            RegistrationDao registrationDB=new RegistrationDao();
            ArrayList<CourseRegistration> registrations = new ArrayList<CourseRegistration>();
            registrations=registrationDB.getRegistrationByStudentID(studentID);
            return registrations;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    public CourseRegistration getRegistrationByStudent(int courseID,int studentID) {
        RegistrationDao registrationDB=new RegistrationDao();
        CourseRegistration r=registrationDB.getRegistrationByStudent(courseID,studentID);
        return r;
    }

    public boolean hasPaid(int studentID){
        boolean flag = false;
        Table tran_table = TableManager.getTable(TableManager.RPS_TRAN);
        try {
            String q = "SELECT " + tran_table.getColumn(0) + " FROM " + tran_table.getTableName()+ " WHERE "
                    + tran_table.getColumn(4) + "='" + studentID + "'";
            ResultSet rs = dbHelper.executeQuery(q);
            while (rs.next()) {
                rs.getInt(tran_table.getColumn(0));
                flag = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    public Student getStudentInformation(int studentID,int loginUser) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.3");
        if(flag){
            Student student = new Student();
            Table table=TableManager.getTable(TableManager.RPS_USER);
            try {
                String q = "SELECT "+table.getColumn(0)+","
                        +table.getColumn(1)+","
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
                        +table.getColumn(12)+","
                        +table.getColumn(13)+","
                        +table.getColumn(14)+","
                        +table.getColumn(15)+","
                        +table.getColumn(16)+","
                        +table.getColumn(17)+","
                        +table.getColumn(18)+","
                        +table.getColumn(19)+","
                        +table.getColumn(20)+","
                        +table.getColumn(21)+","
                        +table.getColumn(22)+","
                        +table.getColumn(23)+","
                        +table.getColumn(24)+","
                        +table.getColumn(25)+","
                        +table.getColumn(26)+","
                        +table.getColumn(27)+","
                        +table.getColumn(28)+","
                        +table.getColumn(29)+","
                        +table.getColumn(30)+","
                        +table.getColumn(31)+","
                        +table.getColumn(32)+","
                        +table.getColumn(33)+","
                        +table.getColumn(34)+","
                        +table.getColumn(35)+","
                        +table.getColumn(36)+","
                        +table.getColumn(37)+","
                        +table.getColumn(38)+","
                        +table.getColumn(39)+","
                        +table.getColumn(40)+","
                        +table.getColumn(41)+","
                        +table.getColumn(42)+","
                        +table.getColumn(44)+","
                        +table.getColumn(45)+","
                        +table.getColumn(46)+","
                        +table.getColumn(47)+","
                        +table.getColumn(48)+","
                        +table.getColumn(49)+","
                        +table.getColumn(50)+" FROM "+table.getTableName()+" WHERE "
                        +table.getColumn(0)+"='"
                        + studentID + "'";
                ResultSet rs = dbHelper.executeQuery(q);
                while (rs.next()) {
                    student.setUserID(rs.getInt(table.getColumn(0)));
                    student.setUserFirstName(rs.getString(table.getColumn(1)));
                    student.setUserLastName(rs.getString(table.getColumn(2)));
                    student.setUserBirthDate(rs.getDate(table.getColumn(3)));
                    student.setUserGender(rs.getInt(table.getColumn(4)));
                    student.setUserBirthPlace(rs.getString(table.getColumn(5)));
                    student.setUserNationality(rs.getString(table.getColumn(6)));
                    student.setUserAddress(rs.getString(table.getColumn(7)));
                    student.setUserPostCode(rs.getString(table.getColumn(8)));
                    student.setUserCity(rs.getString(table.getColumn(9)));
                    student.setUserCountry(rs.getString(table.getColumn(10)));
                    student.setUserHomePhone(rs.getString(table.getColumn(11)));
                    student.setUserMobilePhone(rs.getString(table.getColumn(12)));
                    student.setUserFax(rs.getString(table.getColumn(13)));
                    student.setUserEmail(rs.getString(table.getColumn(14)));
                    student.setUserLoginName(rs.getString(table.getColumn(15)));
                    student.setUserPassword(rs.getString(table.getColumn(16)));
                    student.setUserRemarks(rs.getString(table.getColumn(17)));
                    student.setUserActive(rs.getInt(table.getColumn(18)));
                    student.setUserCO(rs.getString(table.getColumn(19)));
                    student.setUserCountryID(rs.getInt(table.getColumn(20)));
                    student.setUserHomeCode(rs.getString(table.getColumn(21)));
                    student.setUserHomeRegion(rs.getString(table.getColumn(22)));
                    student.setUserMobileCode(rs.getString(table.getColumn(23)));
                    student.setUserMobileRegion(rs.getString(table.getColumn(24)));
                    student.setUserFaxCode(rs.getString(table.getColumn(25)));
                    student.setUserFaxRegion(rs.getString(table.getColumn(26)));
                    student.setUserBamfNumber(rs.getString(table.getColumn(27)));
                    student.setUserBamfChoice(rs.getInt(table.getColumn(28)));
                    student.setUserHours(rs.getInt(table.getColumn(29)));
                    student.setUserLastVisit(rs.getString(table.getColumn(30)));
                    student.setUserBamfNrSchool(rs.getString(table.getColumn(31)));
                    student.setUserAcademicPoints(rs.getInt(table.getColumn(32)));
                    student.setUserSchoolingYears(rs.getInt(table.getColumn(33)));
                    student.setUserIntTest(rs.getInt(table.getColumn(34)));
                    student.setUserIntTestCheck(rs.getInt(table.getColumn(35)));
                    student.setUserProficency(rs.getInt(table.getColumn(36)));
                    student.setUserSponsorShip(rs.getInt(table.getColumn(37)));
                    student.setUserIdentityID(rs.getInt(table.getColumn(38)));
                    student.setUserCostSharing(rs.getInt(table.getColumn(39)));
                    student.setUserClassification(rs.getInt(table.getColumn(40)));
                    student.setUserConclusion(rs.getDate(table.getColumn(41)));
                    student.setUserConcCourse(rs.getDate(table.getColumn(42)));
                    student.setUserVerifiedNumber(rs.getString(table.getColumn(44)));
                    student.setUserGradingDate(rs.getDate(table.getColumn(45)));
                    student.setUserModuleNr(rs.getInt(table.getColumn(46)));
                    student.setUserPassport(rs.getString(table.getColumn(47)));
                    student.setUserFahrtKosten(rs.getDouble(table.getColumn(48)));
                    student.setFreigabeStatus(rs.getInt(table.getColumn(49)));
                    student.setFreigabeDate(rs.getDate(table.getColumn(50)));
                }
            } catch (Exception e) {
                setError(e.toString());
                return null;
            }
            return student;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    public ArrayList<Country> getAllCountries() {
        ArrayList<Country> v = new ArrayList<>();
        Table table=TableManager.getTable(TableManager.RPS_COUNTRIES);
        try {
            String q = "SELECT "+table.getColumn(0)
                    +","+table.getColumn(1)
                    +" FROM "+table.getTableName()
                    +" ORDER BY " +table.getColumn(1);
            ResultSet rs = dbHelper.executeQuery(q);
            while (rs.next()) {
                Country ut = new Country();
                ut.setUserCountryID(rs.getInt("countryID"));
                ut.setUserCountryName(rs.getString("countryName"));
                v.add(ut);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public ArrayList<Identity> getAllIdentities() {
        ArrayList<Identity> i = new ArrayList<>();
        Table table=TableManager.getTable(TableManager.RPS_USERIDENTITY);
        try {
            String q = "SELECT "+table.getColumn(0)
                    +","+table.getColumn(1)
                    +" FROM "+table.getTableName()
                    +" ORDER BY " +table.getColumn(1);
            ResultSet rs = dbHelper.executeQuery(q);
            while (rs.next()) {
                Identity ut = new Identity();
                ut.setUserIdentityID(rs.getInt("identityID"));
                ut.setUserIdentityName(rs.getString("identityName"));
                i.add(ut);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return i;
    }

    public boolean updateStudent(Student u,int loginUser) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.3");
        if(flag){
            try {
                Table table=TableManager.getTable(TableManager.RPS_USER);
                String q = "UPDATE "+table.getTableName()+" SET "
                        +table.getColumn(1)+"="	+ replaceNull(u.getUserFirstName()) + ","
                        +table.getColumn(2)+"="+ replaceNull(u.getUserLastName()) + ","
                        +table.getColumn(3)+"="+ replaceNull(u.getUserBirthDate()) + ","
                        +table.getColumn(4)+"="+ replaceNull(u.getUserGender()) + ","
                        +table.getColumn(5)+"="+ replaceNull(u.getUserBirthPlace()) + ", "
                        +table.getColumn(6)+"="+ replaceNull(u.getUserNationality()) + ","
                        +table.getColumn(7)+"="+ replaceNull(u.getUserAddress()) + ","
                        +table.getColumn(8)+"="+ replaceNull(u.getUserPostCode()) + ","
                        +table.getColumn(9)+"="+ replaceNull(u.getUserCity()) + ","
                        +table.getColumn(10)+"="+ replaceNull(u.getUserCountry()) + ","
                        +table.getColumn(12)+"="+ replaceNull(u.getUserMobilePhone()) + ","
                        +table.getColumn(13)+"="+ replaceNull(u.getUserFax()) + ","
                        +table.getColumn(14)+"="+ replaceNull(u.getUserEmail()) + ","
                        + table.getColumn(19)+"="+ replaceNull(u.getUserCO()) + ","
                        + table.getColumn(20)+"="+ replaceNull(u.getUserCountryID()) + ","
                        + table.getColumn(21)+"="+ replaceNull(u.getUserHomeCode()) + ","
                        + table.getColumn(22)+"="+ replaceNull(u.getUserHomeRegion()) + ","
                        + table.getColumn(23)+"="+ replaceNull(u.getUserMobileCode()) + ","
                        + table.getColumn(24)+"="+ replaceNull(u.getUserMobileRegion()) + ","
                        + table.getColumn(25)+"="+ replaceNull(u.getUserFaxCode()) + ","
                        + table.getColumn(26)+"="+ replaceNull(u.getUserFaxRegion()) + ","
                        + table.getColumn(27)+"="+ replaceNull(u.getUserBamfNumber()) + ","
                        + table.getColumn(28)+"="+ replaceNull(u.getUserBamfChoice()) + ","
                        + table.getColumn(29)+"="+ replaceNull(u.getUserHours()) + ","
                        + table.getColumn(30)+"="+ replaceNull(u.getUserLastVisit()) + ","
                        + table.getColumn(31)+"="+ replaceNull(u.getUserBamfNrSchool()) + ","
                        + table.getColumn(32)+"="+ replaceNull(u.getUserAcademicPoints()) + ","
                        + table.getColumn(33)+"="+ replaceNull(u.getUserSchoolingYears()) + ","
                        + table.getColumn(34)+"="+ replaceNull(u.getUserIntTest()) + ","
                        + table.getColumn(35)+"="+ replaceNull(u.getUserIntTestCheck()) + ","
                        + table.getColumn(36)+"="+ replaceNull(u.getUserProficency()) + ","
                        + table.getColumn(37)+"="+ replaceNull(u.getUserSponsorShip()) + ","
                        + table.getColumn(38)+"="+ replaceNull(u.getUserIdentityID()) + ","
                        + table.getColumn(39)+"="+ replaceNull(u.getUserCostSharing()) + ","
                        + table.getColumn(40)+"="+ replaceNull(u.getUserClassification()) + ","
                        + table.getColumn(41)+"="+ replaceNull(u.getUserConclusion()) + ","
                        + table.getColumn(42)+"="+ replaceNull(u.getUserConcCourse()) + ","
                        + table.getColumn(44)+"="+ replaceNull(u.getUserVerifiedNumber()) + ","
                        + table.getColumn(45)+"="+ replaceNull(u.getUserGradingDate()) + ","
                        + table.getColumn(46)+"="+ replaceNull(u.getUserModuleNr()) + ","
                        + table.getColumn(47)+"="+ replaceNull(u.getUserPassport()) + ","
                        + table.getColumn(48)+"="+ replaceNull(u.getUserFahrtKosten())+" WHERE "
                        +table.getColumn(0)+"='"+ u.getUserID() + "'";
                dbHelper.updateQuery(q);
                return true;
            } catch (Exception e) {
                setError(e.toString());
                return false;
            }
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public Student getStudentForIntAuszahl(int studentID) {
        double cost=0.0;
        Student student = new Student();
        Table table = TableManager.getTable(TableManager.RPS_USER);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + ","
                    + table.getColumn(2) + ","
                    + table.getColumn(3) + ","
                    + table.getColumn(4) + ","
                    + table.getColumn(5) + ","
                    + table.getColumn(6) + ","
                    + table.getColumn(7) + ","
                    + table.getColumn(8) + ","
                    + table.getColumn(9) + ","
                    + table.getColumn(10) + ","
                    + table.getColumn(11) + ","
                    + table.getColumn(12) + ","
                    + table.getColumn(13) + ","
                    + table.getColumn(14) + ","
                    + table.getColumn(15) + ","
                    + table.getColumn(16) + ","
                    + table.getColumn(17) + ","
                    + table.getColumn(18) + ","
                    + table.getColumn(19) + ","
                    + table.getColumn(27) + ","
                    +table.getColumn(38) + ","
                    +table.getColumn(39) + ","
                    +table.getColumn(40) + ","
                    +table.getColumn(43) + ","
                    +table.getColumn(44) + ","
                    +table.getColumn(45) + ","
                    +table.getColumn(48) + ","
                    +table.getColumn(49) + ","
                    +table.getColumn(50) + " FROM "
                    + table.getTableName() + " WHERE "
                    + table.getColumn(0) + "='" + studentID + "' AND "
                    + table.getColumn(48) + ">" + cost+"";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                student.setUserID(rs.getInt(table.getColumn(0)));
                student.setUserFirstName(rs.getString(table.getColumn(1)));
                student.setUserLastName(rs.getString(table.getColumn(2)));
                student.setUserBirthDate(rs.getDate(table.getColumn(3)));
                student.setUserGender(rs.getInt(table.getColumn(4)));
                student.setUserBirthPlace(rs.getString(table.getColumn(5)));
                student.setUserNationality(rs.getString(table.getColumn(6)));
                student.setUserAddress(rs.getString(table.getColumn(7)));
                student.setUserPostCode(rs.getString(table.getColumn(8)));
                student.setUserCity(rs.getString(table.getColumn(9)));
                student.setUserCountry(rs.getString(table.getColumn(10)));
                student.setUserHomePhone(rs.getString(table.getColumn(11)));
                student.setUserMobilePhone(rs.getString(table.getColumn(12)));
                student.setUserFax(rs.getString(table.getColumn(13)));
                student.setUserEmail(rs.getString(table.getColumn(14)));
                student.setUserLoginName(rs.getString(table.getColumn(15)));
                student.setUserPassword(rs.getString(table.getColumn(16)));
                student.setUserRemarks(rs.getString(table.getColumn(17)));
                student.setUserActive(rs.getInt(table.getColumn(18)));
                student.setUserCO(rs.getString(table.getColumn(19)));
                student.setUserBamfNumber(rs.getString(table.getColumn(27)));
                student.setUserIdentityID(rs.getInt(table.getColumn(38)));
                student.setUserCostSharing(rs.getInt(table.getColumn(39)));
                student.setUserClassification(rs.getInt(table.getColumn(40)));
                student.setUserRegDate(rs.getDate(table.getColumn(43)));
                student.setUserVerifiedNumber(rs.getString(table.getColumn(44)));
                student.setUserGradingDate(rs.getDate(table.getColumn(45)));
                student.setUserFahrtKosten(rs.getDouble(table.getColumn(48)));
                student.setFreigabeStatus(rs.getInt(table.getColumn(49)));
                student.setFreigabeDate(rs.getDate(table.getColumn(50)));
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return student;
    }

    public Student getStudentForSubProcess(int studentID) {

        Student student = new Student();
        Table table = TableManager.getTable(TableManager.RPS_USER);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + ","
                    + table.getColumn(2) + ","
                    + table.getColumn(3) + ","
                    + table.getColumn(4) + ","
                    + table.getColumn(5) + ","
                    + table.getColumn(6) + ","
                    + table.getColumn(7) + ","
                    + table.getColumn(8) + ","
                    + table.getColumn(9) + ","
                    + table.getColumn(10) + ","
                    + table.getColumn(11) + ","
                    + table.getColumn(12) + ","
                    + table.getColumn(13) + ","
                    + table.getColumn(14) + ","
                    + table.getColumn(15) + ","
                    + table.getColumn(16) + ","
                    + table.getColumn(17) + ","
                    + table.getColumn(18) + ","
                    + table.getColumn(19) + ","
                    + table.getColumn(21) + ","
                    + table.getColumn(22) + ","
                    + table.getColumn(23) + ","
                    + table.getColumn(24) + ","
                    + table.getColumn(27) + ","
                    +table.getColumn(38) + ","
                    +table.getColumn(39) + ","
                    +table.getColumn(40) + ","
                    +table.getColumn(43) + ","
                    +table.getColumn(44) + ","
                    +table.getColumn(45) + ","
                    +table.getColumn(48) + ","
                    +table.getColumn(49) + ","
                    +table.getColumn(50) + " FROM "
                    + table.getTableName() + " WHERE "
                    + table.getColumn(0) + "='" + studentID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                student.setUserID(rs.getInt(table.getColumn(0)));
                student.setUserFirstName(rs.getString(table.getColumn(1)));
                student.setUserLastName(rs.getString(table.getColumn(2)));
                student.setUserBirthDate(rs.getDate(table.getColumn(3)));
                student.setUserGender(rs.getInt(table.getColumn(4)));
                student.setUserBirthPlace(rs.getString(table.getColumn(5)));
                student.setUserNationality(rs.getString(table.getColumn(6)));
                student.setUserAddress(rs.getString(table.getColumn(7)));
                student.setUserPostCode(rs.getString(table.getColumn(8)));
                student.setUserCity(rs.getString(table.getColumn(9)));
                student.setUserCountry(rs.getString(table.getColumn(10)));
                student.setUserHomePhone(rs.getString(table.getColumn(11)));
                student.setUserMobilePhone(rs.getString(table.getColumn(12)));
                student.setUserFax(rs.getString(table.getColumn(13)));
                student.setUserEmail(rs.getString(table.getColumn(14)));
                student.setUserLoginName(rs.getString(table.getColumn(15)));
                student.setUserPassword(rs.getString(table.getColumn(16)));
                student.setUserRemarks(rs.getString(table.getColumn(17)));
                student.setUserActive(rs.getInt(table.getColumn(18)));
                student.setUserCO(rs.getString(table.getColumn(19)));
                student.setUserHomeCode(rs.getString(table.getColumn(21)));
                student.setUserHomeRegion(rs.getString(table.getColumn(22)));
                student.setUserMobileCode(rs.getString(table.getColumn(23)));
                student.setUserMobileRegion(rs.getString(table.getColumn(24)));
                student.setUserBamfNumber(rs.getString(table.getColumn(27)));
                student.setUserIdentityID(rs.getInt(table.getColumn(38)));
                student.setUserCostSharing(rs.getInt(table.getColumn(39)));
                student.setUserClassification(rs.getInt(table.getColumn(40)));
                student.setUserRegDate(rs.getDate(table.getColumn(43)));
                student.setUserVerifiedNumber(rs.getString(table.getColumn(44)));
                student.setUserGradingDate(rs.getDate(table.getColumn(45)));
                student.setUserFahrtKosten(rs.getDouble(table.getColumn(48)));
                student.setFreigabeStatus(rs.getInt(table.getColumn(49)));
                student.setFreigabeDate(rs.getDate(table.getColumn(50)));
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return student;
    }

    public ArrayList<Student> downloadBilder(int studentID,int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.1");
        if(flag){
            ArrayList<Student> bilder;
            bilder=(new BildTraker()).getBild(studentID);
            return bilder;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    public ArrayList<Student> downloadBilderExternal(int studentID){
        ArrayList<Student> bilder;
        bilder=(new BildTraker()).getBild(studentID);
        return bilder;
    }

    public boolean uploadVertrag(int studentID,String fileName,int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.2");
        if(flag){
            return (new VertragTraker()).addVertrag(studentID,fileName);
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean uploadBilder(int studentID,String fileName,int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.2");
        if(flag){
            return (new BildTraker()).addBild(studentID,fileName);
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean isInKasso(int userID, int courseID,int loginUser) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6");
        boolean flag_2=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.11");
        if(flag || flag_2){
            boolean b = false;
            Table mahnung_table=TableManager.getTable(TableManager.RPS_MAHNUNG);
            try {
                String q = "SELECT "+mahnung_table.getColumn(2)+" FROM "
                        +mahnung_table.getTableName()+" WHERE "
                        +mahnung_table.getColumn(2)+"='" + userID+ "' AND "
                        +mahnung_table.getColumn(1)+"='" + courseID + "' AND "
                        +mahnung_table.getColumn(4)+"='" + INKASSO+ "'";
                ResultSet rs = dbHelper.executeQuery(q);
                while (rs.next()) {
                    int temp = rs.getInt(mahnung_table.getColumn(2));
                    if (temp == userID) {
                        b = true;
                    }
                }
            } catch (Exception e) {
                setError(e.toString());
            }
            return b;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public int addNewStudent(Student student,int loginUser) {
        int returnValue = 0;
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "2.3");
        if(flag){
            try {
                Table table = TableManager.getTable(TableManager.RPS_USER);
                String q = "INSERT INTO "+table.getTableName()+" ("
                        +table.getColumn(1)+","
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
                        +table.getColumn(12)+","
                        +table.getColumn(13)+","
                        +table.getColumn(14)+","
                        +table.getColumn(15)+","
                        +table.getColumn(16)+","
                        +table.getColumn(17)+","
                        +table.getColumn(18)+","
                        +table.getColumn(19)+","
                        +table.getColumn(20)+","
                        +table.getColumn(21)+","
                        +table.getColumn(22)+","
                        +table.getColumn(23)+","
                        +table.getColumn(24)+","
                        +table.getColumn(25)+","
                        +table.getColumn(26)+","
                        +table.getColumn(27)+","
                        +table.getColumn(28)+","
                        +table.getColumn(29)+","
                        +table.getColumn(30)+","
                        +table.getColumn(31)+","
                        +table.getColumn(32)+","
                        +table.getColumn(33)+","
                        +table.getColumn(34)+","
                        +table.getColumn(35)+","
                        +table.getColumn(36)+","
                        +table.getColumn(37)+","
                        +table.getColumn(38)+","
                        +table.getColumn(39)+","
                        +table.getColumn(40)+","
                        +table.getColumn(41)+","
                        +table.getColumn(42)+","
                        +table.getColumn(43)+","
                        +table.getColumn(44)+","
                        +table.getColumn(45)+","
                        +table.getColumn(46)+","
                        +table.getColumn(47)+","
                        +table.getColumn(48)+") VALUES ("
                        + replaceNull(student.getUserFirstName())+ ","
                        + replaceNull(student.getUserLastName())+ ","
                        + replaceNull(student.getUserBirthDate())+ ","
                        + replaceNull(student.getUserGender())+ ","
                        + replaceNull(student.getUserBirthPlace())+ ","
                        + replaceNull(student.getUserNationality())+ ","
                        + replaceNull(student.getUserAddress())+ ","
                        + replaceNull(student.getUserPostCode())+ ","
                        + replaceNull(student.getUserCity())+ ","
                        + replaceNull(student.getUserCountry())+ ","
                        + replaceNull(student.getUserHomePhone())+ ","
                        + replaceNull(student.getUserMobilePhone())+ ","
                        + replaceNull(student.getUserFax())+ ","
                        + replaceNull(student.getUserEmail())+ ","
                        + replaceNull(student.getUserLoginName())+ ","
                        + replaceNull(student.getUserPassword())+ ","
                        + replaceNull(student.getUserRemarks())+ ","
                        + student.getUserActive() + ","
                        + replaceNull(student.getUserCO()) + ","
                        + replaceNull(student.getUserCountryID()) + ","
                        + replaceNull(student.getUserHomeCode()) + ","
                        + replaceNull(student.getUserHomeRegion()) + ","
                        + replaceNull(student.getUserMobileCode()) + ","
                        + replaceNull(student.getUserMobileRegion()) + ","
                        + replaceNull(student.getUserFaxCode()) + ","
                        + replaceNull(student.getUserFaxRegion()) + ","
                        + replaceNull(student.getUserBamfNumber()) + ","
                        + replaceNull(student.getUserBamfChoice()) + ","
                        + replaceNull(student.getUserHours()) + ","
                        + replaceNull(student.getUserLastVisit()) + ","
                        + replaceNull(student.getUserBamfNrSchool()) + ","
                        + replaceNull(student.getUserAcademicPoints()) + ","
                        + replaceNull(student.getUserSchoolingYears()) + ","
                        + replaceNull(student.getUserIntTest()) + ","
                        + replaceNull(student.getUserIntTestCheck()) + ","
                        + replaceNull(student.getUserProficency()) + ","
                        + replaceNull(student.getUserSponsorShip()) + ","
                        + replaceNull(student.getUserIdentityID()) + ","
                        + replaceNull(student.getUserCostSharing()) + ","
                        + replaceNull(student.getUserClassification()) + ","
                        + replaceNull(student.getUserConclusion()) + ","
                        + replaceNull(student.getUserConcCourse()) + ","
                        + replaceNull(student.getUserRegDate()) + ","
                        + replaceNull(student.getUserVerifiedNumber()) + ","
                        + replaceNull(student.getUserGradingDate()) + ","
                        + replaceNull(student.getUserModuleNr()) + ","
                        + replaceNull(student.getUserPassport()) + ","
                        + replaceNull(student.getUserFahrtKosten()) + ")";
                dbHelper.updateQuery(q);
                q = "select LAST_INSERT_ID() as id";
                ResultSet rs = dbHelper.executeQuery(q);
                while (rs.next()) {
                    returnValue = rs.getInt("id");
                }
                return returnValue;
            } catch (Exception e) {
                setError(e.toString());
                return 0;
            }
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return 0;
        }
    }

    public int addNewStudent(Student student) {
        int returnValue = 0;
        try {
            Table table = TableManager.getTable(TableManager.RPS_USER);
            String q = "INSERT INTO " + table.getTableName() + " ("
                    + table.getColumn(1) + ","
                    + table.getColumn(2) + ","
                    + table.getColumn(3) + ","
                    + table.getColumn(4) + ","
                    + table.getColumn(5) + ","
                    + table.getColumn(6) + ","
                    + table.getColumn(7) + ","
                    + table.getColumn(8) + ","
                    + table.getColumn(9) + ","
                    + table.getColumn(10) + ","
                    + table.getColumn(11) + ","
                    + table.getColumn(12) + ","
                    + table.getColumn(13) + ","
                    + table.getColumn(14) + ","
                    + table.getColumn(15) + ","
                    + table.getColumn(16) + ","
                    + table.getColumn(17) + ","
                    + table.getColumn(18) + ","
                    +table.getColumn(19)+","
                    +table.getColumn(20)+","
                    +table.getColumn(21)+","
                    +table.getColumn(22)+","
                    +table.getColumn(23)+","
                    +table.getColumn(24)+","
                    +table.getColumn(25)+","
                    +table.getColumn(26)+","
                    +table.getColumn(27)+","
                    +table.getColumn(28)+","
                    +table.getColumn(29)+","
                    +table.getColumn(30)+","
                    +table.getColumn(31)+","
                    +table.getColumn(32)+","
                    +table.getColumn(33)+","
                    +table.getColumn(34)+","
                    +table.getColumn(35)+","
                    +table.getColumn(36)+","
                    +table.getColumn(37)+","
                    +table.getColumn(38)+","
                    +table.getColumn(39)+","
                    +table.getColumn(40)+","
                    +table.getColumn(41)+","
                    +table.getColumn(42)+","
                    +table.getColumn(43)+","
                    +table.getColumn(44)+","
                    +table.getColumn(45)+","
                    +table.getColumn(46)+","
                    +table.getColumn(47)+","
                    +table.getColumn(48)+") VALUES ("
                    + replaceNull(student.getUserFirstName())+ ","
                    + replaceNull(student.getUserLastName()) + ","
                    + replaceNull(student.getUserBirthDate()) + ","
                    + replaceNull(student.getUserGender()) + ","
                    + replaceNull(student.getUserBirthPlace()) + ","
                    + replaceNull(student.getUserNationality()) + ","
                    + replaceNull(student.getUserAddress()) + ","
                    + replaceNull(student.getUserPostCode()) + ","
                    + replaceNull(student.getUserCity()) + ","
                    + replaceNull(student.getUserCountry()) + ","
                    + replaceNull(student.getUserHomePhone()) + ","
                    + replaceNull(student.getUserMobilePhone()) + ","
                    + replaceNull(student.getUserFax()) + ","
                    + replaceNull(student.getUserEmail()) + ","
                    + replaceNull(student.getUserLoginName()) + ","
                    + replaceNull(student.getUserPassword()) + ","
                    + replaceNull(student.getUserRemarks()) + ","
                    + student.getUserActive() + ","
                    + replaceNull(student.getUserCO()) + ","
                    + replaceNull(student.getUserCountryID()) + ","
                    + replaceNull(student.getUserHomeCode()) + ","
                    + replaceNull(student.getUserHomeRegion()) + ","
                    + replaceNull(student.getUserMobileCode()) + ","
                    + replaceNull(student.getUserMobileRegion()) + ","
                    + replaceNull(student.getUserFaxCode()) + ","
                    + replaceNull(student.getUserFaxRegion()) + ","
                    + replaceNull(student.getUserBamfNumber()) + ","
                    + replaceNull(student.getUserBamfChoice()) + ","
                    + replaceNull(student.getUserHours()) + ","
                    + replaceNull(student.getUserLastVisit()) + ","
                    + replaceNull(student.getUserBamfNrSchool()) + ","
                    + replaceNull(student.getUserAcademicPoints()) + ","
                    + replaceNull(student.getUserSchoolingYears()) + ","
                    + replaceNull(student.getUserIntTest()) + ","
                    + replaceNull(student.getUserIntTestCheck()) + ","
                    + replaceNull(student.getUserProficency()) + ","
                    + replaceNull(student.getUserSponsorShip()) +","
                    + replaceNull(student.getUserIdentityID()) + ","
                    + replaceNull(student.getUserCostSharing()) + ","
                    + replaceNull(student.getUserClassification()) + ","
                    + replaceNull(student.getUserConclusion()) + ","
                    + replaceNull(student.getUserConcCourse()) + ","
                    + replaceNull(student.getUserRegDate()) + ","
                    + replaceNull(student.getUserVerifiedNumber()) + ","
                    + replaceNull(student.getUserGradingDate()) + ","
                    + replaceNull(student.getUserModuleNr()) + ","
                    + replaceNull(student.getUserPassport()) + ","
                    + replaceNull(student.getUserFahrtKosten()) + ")";
           dbHelper.updateQuery(q);
            q = "select LAST_INSERT_ID() as id";
            ResultSet rs = dbHelper.executeQuery(q);
            while (rs.next()) {
                returnValue = rs.getInt("id");
            }
            return returnValue;
        } catch (Exception e) {
            setError(e.toString());
            return 0;
        }
    }

    public Student getMaxStudentID() {
        Student student = new Student();
        Table table=TableManager.getTable(TableManager.RPS_USER);
        try {
            String q = "SELECT max("+table.getColumn(0)+") as a FROM "+table.getTableName();
            ResultSet rs = dbHelper.executeQuery(q);
            while (rs.next()) {
                student.setUserID(rs.getInt("a"));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return student;
    }

    public Student getStudentForSearch(int studentID,int loginUser) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.1");
        if(flag){
            Student student = new Student();
            Table table=TableManager.getTable(TableManager.RPS_USER);
            try {
                String q = "SELECT "+table.getColumn(0)+","
                        +table.getColumn(1)+","
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
                        +table.getColumn(12)+","
                        +table.getColumn(13)+","
                        +table.getColumn(14)+","
                        +table.getColumn(15)+","
                        +table.getColumn(16)+","
                        +table.getColumn(17)+","
                        +table.getColumn(18)+" FROM "
                        +table.getTableName()+" WHERE "
                        +table.getColumn(0)+"='" + studentID + "'";
                ResultSet rs = dbHelper.executeQuery(q);
                while (rs.next()) {
                    student.setUserID(rs.getInt(table.getColumn(0)));
                    student.setUserFirstName(rs.getString(table.getColumn(1)));
                    student.setUserLastName(rs.getString(table.getColumn(2)));
                    student.setUserBirthDate(rs.getDate(table.getColumn(3)));
                }
            } catch (Exception e) {
                setError(e.toString());
                return null;
            }
            return student;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    private boolean isStudentActive(int studentID,int placeID){
        boolean result=false;
        Table student_table=TableManager.getTable(TableManager.RPS_USER);
        Table registration_table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        Table courses_table=TableManager.getTable(TableManager.RPS_COURSES);
        try{
            String q="";
            if(placeID==0){
                q="SELECT a."+student_table.getColumn(0)+" FROM "
                        +student_table.getTableName()+" AS a,"
                        +registration_table.getTableName()+" AS b,"
                        +courses_table.getTableName()+" AS c WHERE a."
                        +student_table.getColumn(0)+"='"+studentID+"' AND b."
                        +registration_table.getColumn(0)+"=c."+courses_table.getColumn(0)+" AND b."
                        +registration_table.getColumn(1)+"=a."+student_table.getColumn(0)+" AND sysDate()>=ADDDATE(c."+courses_table.getColumn(3)+", INTERVAL -12 DAY) AND sysDate()<=c."+courses_table.getColumn(4)+" ORDER BY a."
                        +student_table.getColumn(1);
            }else{
                q="SELECT a."+student_table.getColumn(0)+" FROM "
                        +student_table.getTableName()+" AS a,"
                        +registration_table.getTableName()+" AS b,"
                        +courses_table.getTableName()+" AS c WHERE c."
                        +courses_table.getColumn(6)+"='"+placeID+"' AND a."
                        +student_table.getColumn(0)+"='"+studentID+"' AND b."
                        +registration_table.getColumn(0)+"=c."+courses_table.getColumn(0)+" AND b."
                        +registration_table.getColumn(1)+"=a."+student_table.getColumn(0)+" AND sysDate()>=ADDDATE(c."+courses_table.getColumn(3)+", INTERVAL -12 DAY) AND sysDate()<=c."+courses_table.getColumn(4)+" ORDER BY a."
                        +student_table.getColumn(1);
            }

            ResultSet rs=dbHelper.executeQuery(q);
            while (rs.next()) {
                rs.getInt(student_table.getColumn(0));
                result=true;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    private ArrayList<Student> getActiveStudents(int placeID, String keyWord) {

        ArrayList<Student> studentsList = new ArrayList<Student>();
        Table student_table=TableManager.getTable(TableManager.RPS_USER);
        Table registration_table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        Table courses_table=TableManager.getTable(TableManager.RPS_COURSES);
        try {
            String q="";
            if(placeID==0){
                q = "SELECT DISTINCT a."+student_table.getColumn(0)+",a."
                        +student_table.getColumn(1)+",a."
                        +student_table.getColumn(2)+",a."
                        +student_table.getColumn(3)+" FROM "
                        +student_table.getTableName()+" AS a,"
                        +registration_table.getTableName()+" AS b,"
                        +courses_table.getTableName()+" AS c WHERE b."
                        +registration_table.getColumn(0)+"=c."
                        +courses_table.getColumn(0)+" AND b."
                        +registration_table.getColumn(1)+"=a."
                        +student_table.getColumn(0)+" AND sysDate()>=ADDDATE(c."
                        +courses_table.getColumn(3)+", INTERVAL -12 DAY) AND sysDate()<=c."
                        +courses_table.getColumn(4)+" ORDER BY a."
                        +student_table.getColumn(1);
            }else{
                q = "SELECT DISTINCT a."+student_table.getColumn(0)+",a."
                        +student_table.getColumn(1)+",a."
                        +student_table.getColumn(2)+",a."
                        +student_table.getColumn(3)+" FROM "
                        +student_table.getTableName()+" AS a,"
                        +registration_table.getTableName()+" AS b,"
                        +courses_table.getTableName()+" AS c WHERE a."
                        +student_table.getColumn(1)+" LIKE '%"+ keyWord + "%' AND c."
                        +courses_table.getColumn(6)+"='"+ placeID+ "' AND b."
                        +registration_table.getColumn(0)+"=c."+courses_table.getColumn(0)+" AND b."
                        +registration_table.getColumn(1)+"=a."+student_table.getColumn(0)+" AND sysDate()>=ADDDATE(c."
                        +courses_table.getColumn(3)+", INTERVAL -12 DAY) AND sysDate()<=c."
                        +courses_table.getColumn(4)+" ORDER BY a."
                        +student_table.getColumn(1);
            }
            ResultSet rs = dbHelper.executeQuery(q);
            while(rs.next()) {
                Student student = new Student();
                student.setUserID(rs.getInt(student_table.getColumn(0)));
                student.setUserFirstName(rs.getString(student_table.getColumn(1)));
                student.setUserLastName(rs.getString(student_table.getColumn(2)));
                student.setUserBirthDate(rs.getDate(student_table.getColumn(3)));
                studentsList.add(student);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return studentsList;
    }

    private ArrayList<Student> getNotActiveStudents(int placeID) {
        ArrayList<Student> studentsList = new ArrayList<Student>();
        try {
            ArrayList<Student> students=getAllStudents(placeID);
            Iterator studentsIT=students.iterator();
            while(studentsIT.hasNext()) {
                Student student = new Student();
                student=(Student)studentsIT.next();
                if(!isStudentActive(student.getUserID(),placeID)){
                    studentsList.add(student);
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return studentsList;
    }

    private ArrayList<Student> getAllStudents(int placeID) {
        ArrayList<Student> studentsList = new ArrayList<Student>();
        Table student_table=TableManager.getTable(TableManager.RPS_USER);
        Table registration_table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        Table courses_table=TableManager.getTable(TableManager.RPS_COURSES);
        try {
            String q="";
            if(placeID==0){
                q = "SELECT DISTINCT a."+student_table.getColumn(0)+",a."+student_table.getColumn(1)+",a."+student_table.getColumn(2)+",a."+student_table.getColumn(3)+" FROM "+student_table.getTableName()+" AS a,"+registration_table.getTableName()+" AS b,"+courses_table.getTableName()+" AS c WHERE b."+registration_table.getColumn(0)+"=c."+courses_table.getColumn(0)+" AND b."+registration_table.getColumn(1)+"=a."+student_table.getColumn(0)+" ORDER BY a."+student_table.getColumn(1);
            }else{
                q = "SELECT DISTINCT a."+student_table.getColumn(0)+",a."+student_table.getColumn(1)+",a."+student_table.getColumn(2)+",a."+student_table.getColumn(3)+" FROM "+student_table.getTableName()+" AS a,"+registration_table.getTableName()+" AS b,"+courses_table.getTableName()+" AS c WHERE c."+courses_table.getColumn(6)+"='"+ placeID+ "' AND b."+registration_table.getColumn(0)+"=c."+courses_table.getColumn(0)+" AND b."+registration_table.getColumn(1)+"=a."+student_table.getColumn(0)+" ORDER BY a."+student_table.getColumn(1);
            }
            ResultSet rs = dbHelper.executeQuery(q);
            while (rs.next()) {
                Student student = new Student();
                student.setUserID(rs.getInt(student_table.getColumn(0)));
                student.setUserFirstName(rs.getString(student_table.getColumn(1)));
                student.setUserLastName(rs.getString(student_table.getColumn(2)));
                student.setUserBirthDate(rs.getDate(student_table.getColumn(3)));
                studentsList.add(student);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return studentsList;
    }

    private ArrayList<Student> getStudentsByCriteriaWithoutAll(int criterion,String keyWord, int placeID, int recent) {
        ArrayList<Student> studentsList = new ArrayList<Student>();
        Table student_table = TableManager.getTable(TableManager.RPS_USER);
        Table registration_table = TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        Table courses_table = TableManager.getTable(TableManager.RPS_COURSES);
        Table singleclass_table = TableManager.getTable(TableManager.RPS_EUNTERRICHT);
        try {
            String q = "";
            switch (criterion) {
                case ACTIVE:
                    studentsList = getActiveStudents(placeID, keyWord);
                    break;
                case FIRSTNAME:
                    q = "SELECT a." + student_table.getColumn(0)
                            + ",a." + student_table.getColumn(1) + ",a."
                            + student_table.getColumn(2) + ",a."
                            + student_table.getColumn(3) + " FROM "
                            + student_table.getTableName() + " AS a,"
                            + registration_table.getTableName() + " AS b,"
                            + courses_table.getTableName() + " AS c WHERE c."
                            + courses_table.getColumn(6) + "='" + placeID + "' AND a."
                            + student_table.getColumn(0) + ">" + recent + " AND b."
                            + registration_table.getColumn(0)+ "=c." + courses_table.getColumn(0) + " AND b."
                            + registration_table.getColumn(1) + "=a." + student_table.getColumn(0) + " AND a."
                            + student_table.getColumn(1) + " LIKE '%" + keyWord
                            + "%'"
                            + " UNION "
                            + "SELECT a." + student_table.getColumn(0) + ",a."
                            + student_table.getColumn(1) + ",a." + student_table.getColumn(2)
                            + ",a." + student_table.getColumn(3)
                            + " FROM "+student_table.getTableName()+" AS a,"+singleclass_table.getTableName() +" AS b WHERE a."
                            + student_table.getColumn(0) + "=b." + singleclass_table.getColumn(1) + " AND a."
                            + student_table.getColumn(0) + ">" + recent + " AND a."
                            + student_table.getColumn(1) + " LIKE '%"+keyWord+"%' AND b."
                            + singleclass_table.getColumn(7) + "='"+placeID+"' ORDER BY "
                            + student_table.getColumn(0);
                    break;
                case LASTNAME:
                    q = "SELECT a." + student_table.getColumn(0)
                            + ",a." + student_table.getColumn(1) + ",a."
                            + student_table.getColumn(2) + ",a."
                            + student_table.getColumn(3) + " FROM "
                            + student_table.getTableName() + " AS a,"
                            + registration_table.getTableName() + " AS b,"
                            + courses_table.getTableName() + " AS c WHERE c."
                            + courses_table.getColumn(6) + "='" + placeID + "' AND b."
                            + registration_table.getColumn(0) + "=c." + courses_table.getColumn(0) + " AND b."
                            + registration_table.getColumn(1) + "=a." + student_table.getColumn(0) + " AND a."
                            + student_table.getColumn(0) + ">" + recent + " AND a."
                            + student_table.getColumn(2) + " LIKE '%" + keyWord
                            + "%'"
                            + " UNION "
                            + "SELECT a." + student_table.getColumn(0) + ",a."
                            + student_table.getColumn(1) + ",a." + student_table.getColumn(2)
                            + ",a." + student_table.getColumn(3)
                            + " FROM "+student_table.getTableName()+" AS a,"+singleclass_table.getTableName()+" AS b WHERE a."
                            + student_table.getColumn(0) + "=b." + singleclass_table.getColumn(1) + " AND a."
                            + student_table.getColumn(0) + ">" + recent + " AND a."
                            + student_table.getColumn(2) + " LIKE '%"+keyWord+"%' AND b."
                            + singleclass_table.getColumn(7) + "='"+placeID+"' ORDER BY "
                            + student_table.getColumn(0);
                    break;
                case DATEOFBIRTH:
                    q = "SELECT DISTINCT a."
                            + student_table.getColumn(0)
                            + ",a."
                            + student_table.getColumn(1)
                            + ",a."
                            + student_table.getColumn(2)
                            + ",a."
                            + student_table.getColumn(3)
                            + " FROM "+ student_table.getTableName()
                            + " AS a,"+ registration_table.getTableName()
                            + " AS b,"+ courses_table.getTableName()
                            + " AS c WHERE c."
                            + courses_table.getColumn(6) + "='"+ placeID+ "' AND b."
                            + registration_table.getColumn(0) + "=c."+ courses_table.getColumn(0) + " AND b."
                            + registration_table.getColumn(1) + "=a."+ student_table.getColumn(0) + " AND a."
                            + student_table.getColumn(0) + ">"+ recent + " AND a."
                            + student_table.getColumn(3) + "="+ replaceNull(MyDate.getSQLDateFromDashFormatString(keyWord,MyDate.DEUTSCH)) + " ORDER BY a."
                            + student_table.getColumn(0);
                    break;
                case KUNDENNR:
                    q = "SELECT " + student_table.getColumn(0) + ","
                            + student_table.getColumn(1) + ","
                            + student_table.getColumn(2) + ","
                            + student_table.getColumn(3) + " FROM "
                            + student_table.getTableName() + " WHERE "
                            + student_table.getColumn(0) + ">"+ recent + " AND "
                            + student_table.getColumn(0) + "='" + keyWord + "'ORDER BY "
                            +student_table.getColumn(0);
                    break;
                case NOCRITERION:
                    studentsList = getAllStudents(placeID);
                    break;
                case NOTACTIVE:
                    studentsList = getNotActiveStudents(placeID);
                    break;
            }
            ResultSet rs = dbHelper.executeQuery(q);
            while (rs.next()) {
                Student student = new Student();
                student.setUserID(rs.getInt(student_table.getColumn(0)));
                student.setUserFirstName(rs.getString(student_table.getColumn(1)));
                student.setUserLastName(rs.getString(student_table.getColumn(2)));
                student.setUserBirthDate(rs.getDate(student_table.getColumn(3)));
                studentsList.add(student);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return studentsList;
    }

    private ArrayList<Student> getStudentsByCriteriaWithAll(int criterion, String keyWord, int recent){
        ArrayList<Student> studentsList = new ArrayList<Student>();
        Table student_table=TableManager.getTable(TableManager.RPS_USER);
        try {
            String q = "";
            int placeID=0;
            switch(criterion){
                case ACTIVE:
                    studentsList=getActiveStudents(placeID, keyWord);
                    break;
                case FIRSTNAME:
                    q = "SELECT DISTINCT "+student_table.getColumn(0)+","
                            +student_table.getColumn(1)+","
                            +student_table.getColumn(2)+","
                            +student_table.getColumn(3)+" FROM "
                            +student_table.getTableName()+" WHERE "
                            +student_table.getColumn(0) + ">"+ recent + " AND "
                            +student_table.getColumn(1)+" LIKE '%"+ keyWord + "%' ORDER BY "
                            +student_table.getColumn(0);
                    break;
                case LASTNAME:
                    q = "SELECT DISTINCT "+student_table.getColumn(0)+","
                            +student_table.getColumn(1)+","
                            +student_table.getColumn(2)+","
                            +student_table.getColumn(3)+" FROM "
                            +student_table.getTableName()+" WHERE "
                            + student_table.getColumn(0) + ">"+ recent + " AND "
                            +student_table.getColumn(2)+" LIKE '%"+ keyWord + "%' ORDER BY "
                            +student_table.getColumn(0);
                    break;
                case DATEOFBIRTH:
                    q = "SELECT "+student_table.getColumn(0)+","
                            +student_table.getColumn(1)+","
                            +student_table.getColumn(2)+","
                            +student_table.getColumn(3)+" FROM "
                            +student_table.getTableName()+" WHERE "
                            + student_table.getColumn(0) + ">"+ recent + " AND "
                            +student_table.getColumn(3)+"=" + replaceNull(MyDate.getSQLDateFromDashFormatString(keyWord,MyDate.DEUTSCH))+" ORDER BY "
                            +student_table.getColumn(0);
                    break;
                case KUNDENNR:
                    q = "SELECT "+student_table.getColumn(0)+","
                            +student_table.getColumn(1)+","
                            +student_table.getColumn(2)+","
                            +student_table.getColumn(3)+" FROM "
                            +student_table.getTableName()+" WHERE "
                            + student_table.getColumn(0) + ">"+ recent + " AND "
                            +student_table.getColumn(0)+"='"+keyWord+ "'";
                    break;
                case NOCRITERION:
                    studentsList=getAllStudents(placeID);
                    break;
                case NOTACTIVE:
                    studentsList=getNotActiveStudents(placeID);
                    break;
            }
            ResultSet rs = dbHelper.executeQuery(q);
            while (rs.next()) {
                Student student = new Student();
                student.setUserID(rs.getInt(student_table.getColumn(0)));
                student.setUserFirstName(rs.getString(student_table.getColumn(1)));
                student.setUserLastName(rs.getString(student_table.getColumn(2)));
                student.setUserBirthDate(rs.getDate(student_table.getColumn(3)));
                studentsList.add(student);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return studentsList;
    }

    public ArrayList<Student> getStudentsByCriteria(int criterion, String keyWord,int placeID,int loginUser, int recent){
        boolean flag2_1=PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "2.1");
        boolean flag2_2=PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "2.2");
        if(placeID==0){
            if(flag2_2){
                return getStudentsByCriteriaWithAll(criterion,keyWord, recent);
            }else{
                setError("Ihnen wird nicht erlaubt, das zu tun");
                return null;
            }
        }else{
            if(flag2_1){
                return getStudentsByCriteriaWithoutAll(criterion,keyWord,placeID, recent);
            }else{
                setError("Ihnen wird nicht erlaubt, das zu tun");
                return null;
            }
        }
    }


    public boolean canSeeAgentStudents(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.7");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean saleBooks(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.7");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean payForTheCourse(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.11.9");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean updateCourseRegistration(CourseRegistration cr){
        try{
            RegistrationDao registrationDB=new RegistrationDao();
            boolean reslut=registrationDB.updateSecondTimeRegistration(cr.getCourseID(),cr.getStudentID(),cr.getCourseBalance());
            setError(registrationDB.getError());
            return reslut;
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
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


    public Vector getStudentRelatedToInsurance(int insuranceID) {
        Vector<Student> result = new Vector<Student>();
        Table student_table=TableManager.getTable(TableManager.RPS_USER);
        Table insurance_table=TableManager.getTable(TableManager.RPS_INSURANCERELATED);
        try {
            String q = "SELECT a."+student_table.getColumn(0)+",a."+student_table.getColumn(1)+",a."+student_table.getColumn(2)+" FROM "+student_table.getTableName()+" AS a,"+insurance_table.getTableName()+" AS b WHERE b."+insurance_table.getColumn(0)+"=a."+student_table.getColumn(0)+" AND b."+insurance_table.getColumn(1)+"='"+insuranceID+"' ORDER BY a."+student_table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Student u = new Student();
                u.setUserID(rs.getInt(student_table.getColumn(0)));
                u.setUserFirstName(rs.getString(student_table.getColumn(1)));
                u.setUserLastName(rs.getString(student_table.getColumn(2)));
                result.add(u);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public StudentFinance getStudentFinanceStatus(int studentID) {
        StudentFinance sf=new StudentFinance();
        try {
            ArrayList<CourseRegistration> regis=getRegistrationByStudentIDInternally(studentID);
            Iterator regisIT=regis.iterator();
            while(regisIT.hasNext()){
                CourseRegistration cr=(CourseRegistration)regisIT.next();
                sf.setTotalFee(sf.getTotalFee()+cr.getCourseFee());
                sf.setBalance(sf.getBalance()+cr.getCourseBalance());
            }

        } catch (Exception e) {
            setError(e.toString());
        }
        return sf;
    }

    public boolean canDeleteRegistration(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.11.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean deleteCourseRegistration(int courseID, int studentID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        try {
            if (!isCourseRegistrationPaid(courseID,studentID)) {
                String q = "DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                        + courseID + "' AND "+table.getColumn(1)+"='" + studentID + "'";
                DBHelper.getInstance().updateQuery(q);
                result = true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }

        return result;
    }

    public boolean isCourseRegistrationPaid(int courseID, int studentID) {
        boolean b = false;
        Table table=TableManager.getTable(TableManager.RPS_TRAN);
        try {
            String q = "SELECT DISTINCT tranCourse FROM "+table.getTableName()+" WHERE "+table.getColumn(4)+"='"
                    + studentID + "' AND "+table.getColumn(5)+"='" + courseID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                rs.getInt(table.getColumn(5));
                b = true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean canMakeNullFee(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.11.3");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean makeBalanceNull(int courseID, int studentID) {
        boolean result =false;
        Table table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        try {
            double totalpaid=hasPaidForTheCourse(studentID,courseID);
            double balance=0;
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(4)+"='" +balance
                    + "',"+table.getColumn(5)+"='" + totalpaid + "' WHERE "+table.getColumn(0)+"='" + courseID
                    + "' AND "+table.getColumn(1)+"='" + studentID + "'";
            DBHelper.getInstance().updateQuery(q);
            result= true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }
}
