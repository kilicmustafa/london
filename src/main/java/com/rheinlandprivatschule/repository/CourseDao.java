package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Course;
import com.rheinlandprivatschule.model.CourseRegistration;
import com.rheinlandprivatschule.model.Student;
import com.rheinlandprivatschule.model.Table;

import java.sql.Date;
import java.sql.ResultSet;
import java.util.*;

public class CourseDao{

    public CourseDao(){
    }

    public boolean addNewCourse(Course course){
        boolean result=false;
        Table table=TableManager.getTable(TableManager.RPS_COURSES);
        try{
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
                    +table.getColumn(13)+","
                    +table.getColumn(14)+","
                    +table.getColumn(16)+") VALUES ("
                    + replaceNull(course.getCourseName()) + ","
                    + replaceNull(course.getCourseDesc()) + ","
                    + replaceNull(course.getCourseStartDate()) + ","
                    + replaceNull(course.getCourseEndDate()) + ",'"
                    + course.getCourseFee() + "','"
                    + course.getCoursePlace() + "',"
                    + replaceNull(course.getCourseTiming()) + ",'"
                    + course.getCourseStrength() +  "',"
                    + replaceNull(course.getCourseHours()) + ",'"
                    + course.getCourseType() + "',"
                    + replaceNull(course.getCourseTotalHours()) + ","
                    + replaceNull(course.getCourseBamfNr()) + ","
                    + replaceNull(course.getCourseDailyHrs()) + ","
                    + replaceNull(course.getCourseInit()) + ")";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        }
        catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public Vector<Course> arrangeMyVector(Vector<Course> ve, int code){
        Vector<Course> v=new Vector<Course>();
        Vector<Course> finalV=new Vector<Course>();
        int track=code;
        try{
            while(track <= 7){
                for(int i = 0; i < ve.size(); i++){
                    Course c = (Course)ve.elementAt(i);
                    if(c.getCourseType() == track){
                        v.addElement(c);
                    }
                }
                track++;
            }
            track=code;
            while(track<=7){
                Vector<Course> tempV = new Vector<Course>();
                for(int y = 0; y < v.size(); y++){
                    Course cf = (Course)v.elementAt(y);
                    if(cf.getCourseType() == track){
                        tempV.addElement(cf);
                    }
                }

                tempV = getArrangeVectorByDate(tempV);
                for(int h = 0; h < tempV.size(); h++){
                    finalV.addElement(tempV.elementAt(h));
                }
                track++;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return finalV;
    }

    public boolean deleteCourse(int courseID){
        boolean result=false;
        Table table=TableManager.getTable(TableManager.RPS_COURSES);
        try{
            String q = "DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='" + courseID + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public Vector<Course> getAllCourses(){
        Vector<Course> v = new Vector<Course>();
        Table table=TableManager.getTable(TableManager.RPS_COURSES);
        try{
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
                    +table.getColumn(16)+" FROM "
                    +table.getTableName()+" ORDER BY "
                    +table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                Course c = new Course();
                c.setCourseID(rs.getInt(table.getColumn(0)));
                c.setCourseName(rs.getString(table.getColumn(1)));
                c.setCourseDesc(rs.getString(table.getColumn(2)));
                c.setCourseStartDate(rs.getDate(table.getColumn(3)));
                c.setCourseEndDate(rs.getDate(table.getColumn(4)));
                c.setCourseFee(rs.getDouble(table.getColumn(5)));
                c.setCoursePlace(rs.getInt(table.getColumn(6)));
                c.setCourseTiming(rs.getString(table.getColumn(7)));
                c.setCourseStrength(rs.getInt(table.getColumn(8)));
                c.setCourseHours(rs.getString(table.getColumn(9)));
                c.setCourseType(rs.getInt(table.getColumn(10)));
                c.setCourseTotalHours(rs.getString(table.getColumn(11)));
                c.setCourseDuration(rs.getDouble(table.getColumn(12)));
                c.setCourseBamfNr(rs.getString(table.getColumn(13)));
                c.setCourseDailyHrs(rs.getString(table.getColumn(14)));
                c.setCourseInit(rs.getString(table.getColumn(16)));
                v.add(c);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public Vector<Course> getAllCoursesByPlace(int placeID){
        Vector<Course> v = new Vector<Course>();
        Table table=TableManager.getTable(TableManager.RPS_COURSES);
        try{
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
                    +table.getColumn(16)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(6)+"='" + placeID + "' ORDER BY "+table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                Course c = new Course();
                c.setCourseID(rs.getInt(table.getColumn(0)));
                c.setCourseName(rs.getString(table.getColumn(1)));
                c.setCourseDesc(rs.getString(table.getColumn(2)));
                c.setCourseStartDate(rs.getDate(table.getColumn(3)));
                c.setCourseEndDate(rs.getDate(table.getColumn(4)));
                c.setCourseFee(rs.getDouble(table.getColumn(5)));
                c.setCoursePlace(rs.getInt(table.getColumn(6)));
                c.setCourseTiming(rs.getString(table.getColumn(7)));
                c.setCourseStrength(rs.getInt(table.getColumn(8)));
                c.setCourseHours(rs.getString(table.getColumn(9)));
                c.setCourseType(rs.getInt(table.getColumn(10)));
                c.setCourseTotalHours(rs.getString(table.getColumn(11)));
                c.setCourseDuration(rs.getDouble(table.getColumn(12)));
                c.setCourseBamfNr(rs.getString(table.getColumn(13)));
                c.setCourseDailyHrs(rs.getString(table.getColumn(14)));
                c.setCourseInit(rs.getString(table.getColumn(16)));
                v.add(c);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public Vector<Course> getAllCoursesByPlace(int placeID, int limit, int offset){
        Vector<Course> v = new Vector<Course>();
        Table table=TableManager.getTable(TableManager.RPS_COURSES);
        try{
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
                    +table.getColumn(16)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(6)+"='" + placeID + "' ORDER BY "+table.getColumn(1) + " LIMIT " + limit + " OFFSET " +  offset;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                Course c = new Course();
                c.setCourseID(rs.getInt(table.getColumn(0)));
                c.setCourseName(rs.getString(table.getColumn(1)));
                c.setCourseDesc(rs.getString(table.getColumn(2)));
                c.setCourseStartDate(rs.getDate(table.getColumn(3)));
                c.setCourseEndDate(rs.getDate(table.getColumn(4)));
                c.setCourseFee(rs.getDouble(table.getColumn(5)));
                c.setCoursePlace(rs.getInt(table.getColumn(6)));
                c.setCourseTiming(rs.getString(table.getColumn(7)));
                c.setCourseStrength(rs.getInt(table.getColumn(8)));
                c.setCourseHours(rs.getString(table.getColumn(9)));
                c.setCourseType(rs.getInt(table.getColumn(10)));
                c.setCourseTotalHours(rs.getString(table.getColumn(11)));
                c.setCourseDuration(rs.getDouble(table.getColumn(12)));
                c.setCourseBamfNr(rs.getString(table.getColumn(13)));
                c.setCourseDailyHrs(rs.getString(table.getColumn(14)));
                c.setCourseInit(rs.getString(table.getColumn(16)));
                v.add(c);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public Vector<Course> getAllCoursesByPlaceActive(int placeID, Date d1, Date d2){
        Vector<Course> v = new Vector<Course>();
        Date chkD = d1;
        Date chkD2 = d2;
        try{
            Calendar gc = new GregorianCalendar();
            Vector<Course> tempV = getAllCoursesByPlace(placeID);
            for(int i = 0; i < tempV.size(); i++){
                Course co = (Course)tempV.elementAt(i);
                gc.setTime(co.getCourseStartDate());
                if((chkD.after(co.getCourseStartDate()) || chkD.compareTo(co.getCourseStartDate()) == 0) && (chkD.before(co.getCourseEndDate()) || chkD.compareTo(co.getCourseEndDate()) == 0) || (chkD2.after(co.getCourseStartDate()) || chkD2.compareTo(co.getCourseStartDate()) == 0) && (chkD2.before(co.getCourseEndDate()) || chkD2.compareTo(co.getCourseEndDate()) == 0)){
                    v.addElement(co);
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public Vector<Course> getAllCoursesByPlaceActive(int placeID){
        Vector<Course> v = new Vector<Course>();
        try{
            Date chkD = MyDate.getCurrentSQLDate();
            Calendar gc = new GregorianCalendar();
            Vector<Course> tempV = this.getAllCoursesByPlace(placeID);
            for(int i = 0; i < tempV.size(); i++){
                Course co = (Course)tempV.elementAt(i);
                gc.setTime(co.getCourseStartDate());
                gc.add(Calendar.DATE, -12);
                Date tempdate = new Date(gc.getTime().getTime());
                if(chkD.after(tempdate) && chkD.before(co.getCourseEndDate())){
                    v.addElement(co);
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public Vector<Course> getAllCoursesByPlaceFuture(int placeID){
        Vector<Course> v = new Vector<Course>();
        try{
            Date chkD = MyDate.getCurrentSQLDate();
            Vector<Course> tempV = getAllCoursesByPlace(placeID);
            for(int i = 0; i < tempV.size(); i++){
                Course co = (Course)tempV.elementAt(i);
                if(co.getCourseStartDate().after(chkD) && !isCourseActive(co)){
                    v.addElement(co);
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public Vector<Course> getAllCoursesFAByPlace(int placeID){
        Vector<Course> v = new Vector<Course>();
        try{
            Vector<Course> tempV = getAllCoursesByPlace(placeID);
            for(int i = 0; i < tempV.size(); i++){
                Course co = (Course)tempV.elementAt(i);
                boolean active = this.isCourseActive(co);
                boolean future = this.isCourseFuture(co);
                if(active || future){
                    v.addElement(co);
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public Vector<Course> getAllFutureCoursesByPlace(int placeID){
        Vector<Course> v=new Vector<Course>();
        try{

            Vector<Course> tempV = getAllCoursesByPlace(placeID);
            for(int ii = 0; ii < tempV.size(); ii++){
                Course tcc = (Course)tempV.elementAt(ii);
                if(tcc.getCourseStartDate().after(MyDate.getCurrentSQLDate())){
                    if(!this.isCourseActive(tcc))
                    {
                        v.addElement(tcc);
                    }
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public Vector<Course> getAllOberstufeByPlace(int placeID){
        Vector<Course> v = new Vector<Course>();
        Table table=TableManager.getTable(TableManager.RPS_COURSES);
        try{
            int OBERSTUFE= 5;
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
                    +table.getColumn(16)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(6)+"='" + placeID + "' AND "
                    +table.getColumn(10)+"='" + OBERSTUFE + "' ORDER BY "+table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                Course c = new Course();
                c.setCourseID(rs.getInt(table.getColumn(0)));
                c.setCourseName(rs.getString(table.getColumn(1)));
                c.setCourseDesc(rs.getString(table.getColumn(2)));
                c.setCourseStartDate(rs.getDate(table.getColumn(3)));
                c.setCourseEndDate(rs.getDate(table.getColumn(4)));
                c.setCourseFee(rs.getDouble(table.getColumn(5)));
                c.setCoursePlace(rs.getInt(table.getColumn(6)));
                c.setCourseTiming(rs.getString(table.getColumn(7)));
                c.setCourseStrength(rs.getInt(table.getColumn(8)));
                c.setCourseHours(rs.getString(table.getColumn(9)));
                c.setCourseType(rs.getInt(table.getColumn(10)));
                c.setCourseTotalHours(rs.getString(table.getColumn(11)));
                c.setCourseDuration(rs.getDouble(table.getColumn(12)));
                c.setCourseBamfNr(rs.getString(table.getColumn(13)));
                c.setCourseDailyHrs(rs.getString(table.getColumn(14)));
                c.setCourseInit(rs.getString(table.getColumn(16)));
                v.add(c);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    //MOA D0006 STK START
    public Vector<Course> getAllSTKByPlace(int placeID){
        Vector<Course> v = new Vector<Course>();
        Table table=TableManager.getTable(TableManager.RPS_COURSES);
        try{
            int STK= 7;
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
                    +table.getColumn(16)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(6)+"='" + placeID + "' AND "
                    +table.getColumn(10)+"='" + STK + "' ORDER BY "+table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                Course c = new Course();
                c.setCourseID(rs.getInt(table.getColumn(0)));
                c.setCourseName(rs.getString(table.getColumn(1)));
                c.setCourseDesc(rs.getString(table.getColumn(2)));
                c.setCourseStartDate(rs.getDate(table.getColumn(3)));
                c.setCourseEndDate(rs.getDate(table.getColumn(4)));
                c.setCourseFee(rs.getDouble(table.getColumn(5)));
                c.setCoursePlace(rs.getInt(table.getColumn(6)));
                c.setCourseTiming(rs.getString(table.getColumn(7)));
                c.setCourseStrength(rs.getInt(table.getColumn(8)));
                c.setCourseHours(rs.getString(table.getColumn(9)));
                c.setCourseType(rs.getInt(table.getColumn(10)));
                c.setCourseTotalHours(rs.getString(table.getColumn(11)));
                c.setCourseDuration(rs.getDouble(table.getColumn(12)));
                c.setCourseBamfNr(rs.getString(table.getColumn(13)));
                c.setCourseDailyHrs(rs.getString(table.getColumn(14)));
                c.setCourseInit(rs.getString(table.getColumn(16)));
                v.add(c);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }
//MOA D0006 STK END

    public Vector<CourseRegistration> getAllRegistrationByCourse(int courseID){
        Vector<CourseRegistration> v = new Vector<CourseRegistration>();
        Table registration_table = TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        try{
            String q = "SELECT " + registration_table.getColumn(0) + ","
                    + registration_table.getColumn(1) + ","
                    + registration_table.getColumn(2) + ","
                    + registration_table.getColumn(3) + ","
                    + registration_table.getColumn(4) + ","
                    + registration_table.getColumn(5) + ","
                    + registration_table.getColumn(6) + ","
                    + registration_table.getColumn(7) + " FROM "
                    + registration_table.getTableName() + " WHERE "
                    + registration_table.getColumn(0) + "='" + courseID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                CourseRegistration registration = new CourseRegistration();
                registration.setCourseID(rs.getInt(registration_table.getColumn(0)));
                registration.setStudentID(rs.getInt(registration_table.getColumn(1)));
                registration.setRegistrationDate(rs.getDate(registration_table.getColumn(2)));
                registration.setRegistrationType(rs.getInt(registration_table.getColumn(3)));
                registration.setCourseBalance(rs.getDouble(registration_table.getColumn(4)));
                registration.setCourseFee(rs.getDouble(registration_table.getColumn(5)));
                registration.setFirstPayDate(rs.getDate(registration_table.getColumn(6)));
                registration.setRegistrationStatus(rs.getInt(registration_table.getColumn(7)));
                v.add(registration);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public Vector<Student> getAllStudentsByCourse(int courseID){
        Vector<Student> v=new Vector<Student>();
        Table registration_table = TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        Table user_table = TableManager.getTable(TableManager.RPS_USER);
        try{
            Vector<String> temp=new Vector<String>();
            StudentDao sdb= new StudentDao();
            String q = "SELECT a."+registration_table.getColumn(1)+" FROM "+registration_table.getTableName()+" AS a,"+user_table.getTableName()+" AS b WHERE a."+registration_table.getColumn(0)+" ='" + courseID + "' AND "+registration_table.getColumn(7)+" NOT IN (2) AND b."+user_table.getColumn(0)+"=a."+registration_table.getColumn(1)+" ORDER BY b."+user_table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                int tempStudentID = rs.getInt(registration_table.getColumn(1));
                temp.addElement("" + tempStudentID);
            }

            for(int g = 0; g < temp.size(); g++){
                int tempNu = Integer.parseInt((String)temp.elementAt(g));
                if(tempNu > 0){
                    v.addElement(sdb.getStudentForSubProcess(tempNu));
                }
            }
        }
        catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public Vector<Student> getAllStudentsAuszahlung(int courseID){
        Vector<Student> v=new Vector<Student>();
        Table registration_table = TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        Table user_table = TableManager.getTable(TableManager.RPS_USER);
        try{
            Vector<String> temp=new Vector<String>();
            StudentDao sdb= new StudentDao();
            String q = "SELECT a."+registration_table.getColumn(1)+" FROM "+registration_table.getTableName()+" AS a,"+user_table.getTableName()+" AS b WHERE a."+registration_table.getColumn(0)+" ='" + courseID + "' AND "+registration_table.getColumn(7)+" NOT IN (2) AND b."+user_table.getColumn(0)+"=a."+registration_table.getColumn(1)+" ORDER BY b."+user_table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                int tempStudentID = rs.getInt(registration_table.getColumn(1));
                temp.addElement("" + tempStudentID);
            }

            for(int g = 0; g < temp.size(); g++){
                int tempNu = Integer.parseInt((String)temp.elementAt(g));
                if(tempNu > 0){
                    v.addElement(sdb.getStudentForIntAuszahl(tempNu));
                }
            }
        }
        catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public int countStudentsByCourse(int courseID){
        int v=0;
        Table registration_table = TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        Table user_table = TableManager.getTable(TableManager.RPS_USER);
        try{
            Vector<String> temp=new Vector<String>();
            String q = "SELECT a."+registration_table.getColumn(1)+" FROM "+registration_table.getTableName()+" AS a,"+user_table.getTableName()+" AS b WHERE a."+registration_table.getColumn(0)+" ='" + courseID + "' AND "+registration_table.getColumn(7)+" NOT IN (2) AND b."+user_table.getColumn(0)+"=a."+registration_table.getColumn(1)+" ORDER BY b."+user_table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                int cv = rs.getInt(registration_table.getColumn(1));
                temp.addElement("" + cv);
            }

            for(int g = 0; g < temp.size(); g++){
                int tempNu = Integer.parseInt((String)temp.elementAt(g));
                if(tempNu > 0){
                    v=v+1;
                }
            }
        }catch(Exception e){
            this.error=e.toString();
        }
        return v;
    }

    public Vector<Student> getAllStudentsByCourseAb(int courseID){
        Vector<Student> v=new Vector<Student>();
        Table registration_table = TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        try {
            Vector<String> temp=new Vector<String>();
            StudentDao sdb = new StudentDao();
            String q = "SELECT "+registration_table.getColumn(1)+" FROM "+registration_table.getTableName()+" WHERE "+registration_table.getColumn(0)+" ='" + courseID + "' AND "+registration_table.getColumn(7)+"='" + 2 + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                int cv = rs.getInt(registration_table.getColumn(1));
                temp.addElement("" + cv);
            }

            for(int g = 0; g < temp.size(); g++){
                int tempNu = Integer.parseInt((String)temp.elementAt(g));
                if(tempNu > 0)
                {
                    v.addElement(sdb.getStudentForSubProcess(tempNu));
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public Vector<Course> getArrangeVectorByDate(Vector<Course> vv){
        Vector<Course> v = new Vector<Course>();
        Vector<Course> tempv = vv;
        int value = vv.size();
        try {
            int track = 0;
            if(vv.size() > 1) {
                while(value != v.size()){
                    Course cs = (Course)tempv.elementAt(track);
                    for(int i = 0; i < tempv.size(); i++){
                        Course cb = (Course)tempv.elementAt(i);
                        if(!cs.getCourseStartDate().before(cb.getCourseStartDate())){
                            cs = cb;
                        }
                    }
                    v.addElement(cs);
                    tempv.remove(cs);
                }
            }else {
                v = vv;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public Course getCourse(int courseID){
        Course c = new Course();
        Table table=TableManager.getTable(TableManager.RPS_COURSES);
        try{
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
                    +table.getColumn(16)+", LPAD("
                    +table.getColumn(1)+",4,'') AS module FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+"='" + courseID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                c.setCourseID(rs.getInt(table.getColumn(0)));
                c.setCourseName(rs.getString(table.getColumn(1)));
                c.setCourseDesc(rs.getString(table.getColumn(2)));
                c.setCourseStartDate(rs.getDate(table.getColumn(3)));
                c.setCourseEndDate(rs.getDate(table.getColumn(4)));
                c.setCourseFee(rs.getDouble(table.getColumn(5)));
                c.setCoursePlace(rs.getInt(table.getColumn(6)));
                c.setCourseTiming(rs.getString(table.getColumn(7)));
                c.setCourseStrength(rs.getInt(table.getColumn(8)));
                c.setCourseHours(rs.getString(table.getColumn(9)));
                c.setCourseType(rs.getInt(table.getColumn(10)));
                c.setCourseTotalHours(rs.getString(table.getColumn(11)));
                c.setCourseDuration(rs.getDouble(table.getColumn(12)));
                c.setCourseBamfNr(rs.getString(table.getColumn(13)));
                c.setCourseDailyHrs(rs.getString(table.getColumn(14)));
                c.setRemarks(rs.getString(table.getColumn(15)));
                c.setCourseInit(rs.getString(table.getColumn(16)));
                c.setCourseModule(rs.getString("module"));
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return c;
    }

    public String getCourseNameOnly(int courseID){
        String courseName = null;
        Table table=TableManager.getTable(TableManager.RPS_COURSES);
        try{
            String q = "SELECT "+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='" + courseID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                courseName=rs.getString(table.getColumn(1));
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return courseName;
    }

    public double getNochOffen(Course c) {
        double noch = 0;
        Table registration_table = TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        try{
            String q = "SELECT "+registration_table.getColumn(4)+" FROM "+registration_table.getTableName()+" WHERE "+registration_table.getColumn(4)+" >'0' AND "+registration_table.getColumn(0)+"='" + c.getCourseID() + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                noch =noch+rs.getDouble(registration_table.getColumn(4));
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return noch;
    }

    public int getStundenForTeacher(int teacherID, int courseID){
        int code = 0;
        Table table=TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        try{
            String q = "SELECT SUM("+table.getColumn(3)+") AS a FROM "+table.getTableName()+" WHERE "+table.getColumn(2)+"='" + teacherID + "' AND "+table.getColumn(1)+"='" + courseID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                code = rs.getInt("a");
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return code;
    }

    public Vector<String> getTeacherForCourse(int courseID){
        Vector<String> v = new Vector<String>();
        Table table=TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        try {
            String q = "SELECT DISTINCT "+table.getColumn(2)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='" + courseID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                v.addElement("" + rs.getInt(table.getColumn(2)));
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public double getTotalAngenomen(int courseID){
        double noch = 0;
        Table table=TableManager.getTable(TableManager.RPS_TRAN);
        try {
            String q = "SELECT SUM("+table.getColumn(1)+") AS a FROM "+table.getTableName()+" WHERE "+table.getColumn(5)+"='" + courseID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                noch = noch+rs.getDouble("a");
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return noch;
    }

    public Vector<Course> getVertragByPlaceActiveF(int placeID, int courseType){
        Vector<Course> v=new Vector<Course>();
        try{
            Vector<Course> tempV = getAllCoursesByPlaceActive(placeID);
            for(int i = 0; i < tempV.size(); i++){
                Course tc = (Course)tempV.elementAt(i);
                //if(tc.getCourseType() == courseType){
                v.addElement(tc);
                //}
            }

            tempV = getAllCoursesByPlace(placeID);
            for(int ii = 0; ii < tempV.size(); ii++){
                Course tcc = (Course)tempV.elementAt(ii);
                if(tcc.getCourseStartDate().after(MyDate.getCurrentSQLDate()) && tcc.getCourseType() >= courseType){
                    if(!isCourseActive(tcc)){
                        v.addElement(tcc);
                    }
                }
            }
            v = arrangeMyVector(v,courseType);
        }catch(Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<Course> getVertragByPlace(int placeID, int courseType){
        Vector<Course> v=new Vector<Course>();
        try{
            Vector<Course> tempV = getAllCoursesByPlace(placeID);
            for(int i = 0; i < tempV.size(); i++){
                Course tc = (Course)tempV.elementAt(i);
                if(tc.getCourseType() == courseType){
                    v.addElement(tc);
                }
            }

            tempV = getAllCoursesByPlace(placeID);
            for(int ii = 0; ii < tempV.size(); ii++){
                Course tcc = (Course)tempV.elementAt(ii);
                if(tcc.getCourseType() >= courseType){
                    v.addElement(tcc);
                }
            }
            v = arrangeMyVector(v,courseType);
        }catch(Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public boolean isCourseActive(Course c){
        boolean b = false;
        Date chkD = MyDate.getCurrentSQLDate();
        Calendar gc = new GregorianCalendar();
        gc.setTime(c.getCourseStartDate());

        gc.add(Calendar.DATE, -12);
        Date tempdate = new Date(gc.getTime().getTime());
        if(chkD.after(tempdate) && chkD.before(c.getCourseEndDate())){
            b = true;
        }else{
            b = false;
        }
        return b;
    }

    public boolean isCourseAlt(Course c){
        boolean b = false;
        try{
            if(!isCourseFuture(c) && !isCourseActive(c)){
                b = true;
            }
        }catch(Exception e){
            b = false;
            setError(e.toString());
        }
        return b;
    }

    public boolean isCourseFuture(Course c){
        boolean b = false;
        try{
            Date chkD = MyDate.getCurrentSQLDate();
            if(c.getCourseStartDate().after(chkD) && !isCourseActive(c)) {
                b = true;
            }
        }catch(Exception e){
            setError(e.toString());
            b = false;
        }
        return b;
    }

    public boolean isCourseUsed(int courseID){
        boolean b = false;
        Table table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        try {
            String q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='" + courseID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                int temp=rs.getInt(table.getColumn(0));
                if(temp==courseID){
                    b = true;
                }
            }
        }catch(Exception e){
            setError(e.toString());
            b=false;
        }
        return b;
    }

    public boolean updateCourse(Course c){
        boolean result=false;
        Table table=TableManager.getTable(TableManager.RPS_COURSES);
        try{
            String q = "UPDATE "+table.getTableName()+" SET "
                    +table.getColumn(1)+"=" + replaceNull(c.getCourseName()) + ", "
                    +table.getColumn(2)+"=" + replaceNull(c.getCourseDesc()) + ", "
                    +table.getColumn(3)+"=" + replaceNull(c.getCourseStartDate()) + ", "
                    +table.getColumn(4)+"=" + replaceNull(c.getCourseEndDate()) + ", "
                    +table.getColumn(5)+"='" + c.getCourseFee() + "', "
                    +table.getColumn(6)+"='" + c.getCoursePlace() + "', "
                    +table.getColumn(7)+"=" + replaceNull(c.getCourseTiming()) + ","
                    +table.getColumn(8)+"='" + c.getCourseStrength() + "',"
                    +table.getColumn(9)+"=" + replaceNull(c.getCourseHours()) + ", "
                    +table.getColumn(10)+"='" + c.getCourseType() + "', "
                    +table.getColumn(11)+"=" + replaceNull(c.getCourseTotalHours()) + ", "
                    +table.getColumn(12)+"=" + c.getCourseDuration() + ", "
                    +table.getColumn(13)+"=" + replaceNull(c.getCourseBamfNr()) + ", "
                    +table.getColumn(14)+"=" + replaceNull(c.getCourseDailyHrs()) + ", "
                    +table.getColumn(16)+"=" + replaceNull(c.getCourseInit()) + " WHERE "
                    +table.getColumn(0)+"='" + c.getCourseID() + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public boolean isEliteCourses(String courseName){
        boolean b=false;
        try{
            StringTokenizer st=new StringTokenizer(courseName);
            while(st.hasMoreTokens()){
                String temp=st.nextToken();
                if(temp.toLowerCase().equalsIgnoreCase("elite")){
                    b=true;
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public double getCourseTotalHours(int courseID){
        double result = 200;
        try{
            Table table=TableManager.getTable(TableManager.RPS_COURSES);
            String q = "SELECT "+table.getColumn(11)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='" + courseID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            String resultValue = "";
            while(rs.next()){
                resultValue = rs.getString(table.getColumn(11));
            }
            result = Integer.parseInt(resultValue);
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public Vector<Course> getProperVector(Vector<Course> courseList, String bamf){
        Vector<Course> v=new Vector<Course>();
        try{
            for(int i = 0; i < courseList.size(); i++){
                Course s = (Course)courseList.elementAt(i);
                v.addElement(s);
                makeStudentActive(bamf, s.getCourseID());
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public boolean makeStudentActive(String bamf, int courseID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_COURSES);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "
                    +table.getColumn(13)+"=" + replaceNull(bamf) + " WHERE "
                    +table.getColumn(0)+"='" + courseID + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean updateRemarks(int courseID,String rem,int loginUser) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.10");
        if(flag){
            Table table=TableManager.getTable(TableManager.RPS_COURSES);
            try {
                String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(15)+"=" + replaceNull(rem)
                        + " WHERE " +table.getColumn(0)+"='" + courseID + "'";
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


    public Course getMaxCourseEndDate(int studentID) {
        Course courses = new Course();
        Table table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        Table course=TableManager.getTable(TableManager.RPS_COURSES);
        try {
            String q = "SELECT max(b."+course.getColumn(4)+") AS endDate FROM "
                    + table.getTableName() + " AS a,"
                    + course.getTableName() + " AS b WHERE a."
                    + table.getColumn(0) + "=b."+ course.getColumn(0) +" AND a."
                    + table.getColumn(1)+ "=" +studentID ;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                courses.setCourseEndDate(rs.getDate("endDate"));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return courses;
    }

    public Course isFreigegeben(int studentID){
        Course courses = new Course();
        Table table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        Table course=TableManager.getTable(TableManager.RPS_COURSES);
        try {
            String q = "SELECT max(b."+course.getColumn(4)+") AS endDate FROM "
                    + table.getTableName() + " AS a,"
                    + course.getTableName() + " AS b WHERE a."
                    + table.getColumn(0) + "=b."+ course.getColumn(0) +" AND b."
                    + course.getColumn(4) + ">= SYSDATE() AND a."
                    + table.getColumn(1)+ "=" +studentID ;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                courses.setCourseEndDate(rs.getDate("endDate"));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return courses;
    }

    public boolean canAddNewCourse(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"4.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canViewActiveAndFutureCourses(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"4.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canViewAllCourses(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"4.2.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canViewStudentListofCourse(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"4.2.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSaveStudentList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"4.2.2.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateAndViewCourseDetail(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"4.2.2.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canViewCourseBericht(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"4.2.2.3");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canDeleteCourse(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"4.2.2.4");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canViewCourseAttendanceList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"4.2.2.5");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateCourseAttendanceList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"4.2.2.5.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canPrintCourseAttendanceList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"4.2.2.5.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public ArrayList<String> downloadVertrag(int courseID, int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.1");
        if(flag){
            ArrayList<String> vertrags=new ArrayList<String>();
            vertrags=(new VertragCourseTraker()).getVertrags(courseID);
            return vertrags;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    public boolean uploadVertrag(int courseID,String fileName,int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.2");
        if(flag){
            return (new VertragCourseTraker()).addVertrag(courseID,fileName);
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

    public boolean canMakeVertragManuall(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.4.1");
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
}
