package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Anwesenheit;
import com.rheinlandprivatschule.model.Course;
import com.rheinlandprivatschule.model.Student;
import com.rheinlandprivatschule.model.Table;

import java.sql.*;
import java.util.Vector;
import java.util.Calendar;
import java.util.GregorianCalendar;


public class AnwesenDao {

    public AnwesenDao() {
        this.error = null;
        this.firstDate = new Date((new java.util.Date()).getTime());
        this.lastDate = new Date((new java.util.Date()).getTime());
    }

    public boolean addAnwesenheit(java.sql.Date d, int courseID, int studentID, int attendance, double percentage, double stunden){
        boolean result = false;
        Table table= TableManager.getTable(TableManager.RPS_ANWESEN);
        try{
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+") VALUES(" + replaceNull(d) + ",'" + courseID + "','" + studentID + "','" + attendance + "','" + percentage + "','" + stunden + "')";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public boolean addAnwesenheit(int cid, int sid, Date d1, Date d2){
        boolean result = false;
        try {
            Calendar gc = new GregorianCalendar();
            gc.setTime(d1);
            Date temp = new Date(gc.getTime().getTime());
            int track = 1;
            while(temp.before(d2) || MyDate.isEqual(temp, d2)){
                if(track == 6 || track == 7 || track == 13 || track == 14){
                    addAnwesenheit(temp, cid, sid, 12, 0.0D, 0.0D);
                }else{
                    addAnwesenheit(temp, cid, sid, 0, 0.0D, 0.0D);
                }
                gc.add(Calendar.DATE, 1);
                temp = new Date(gc.getTime().getTime());
                track++;
            }
            result=true;
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public Anwesenheit getAnwesenheit(int courseID, int studentID, Date startDate, Date endDate){
        Anwesenheit a= new Anwesenheit();
        Table table=TableManager.getTable(TableManager.RPS_ANWESEN);
        a.setCourseID(courseID);
        a.setStudentID(studentID);
        try{
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='" + courseID + "' AND "+table.getColumn(2)+"='" + studentID + "' AND "+table.getColumn(0)+" BETWEEN " + replaceNull(startDate) + " AND " + replaceNull(endDate) + " ORDER BY "+table.getColumn(0);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            int track = 1;
            while(rs.next()){
                if (track == 1){
                    a.setDate1(rs.getDate(table.getColumn(0)));
                    a.setCourseID(rs.getInt(table.getColumn(1)));
                    a.setStudentID(rs.getInt(table.getColumn(2)));
                    a.setAttendance1(rs.getInt(table.getColumn(3)));
                    a.setPercentage1(rs.getDouble(table.getColumn(4)));
                    a.setStunden1(rs.getDouble(table.getColumn(5)));
                }else if (track == 2){
                    a.setDate2(rs.getDate(table.getColumn(0)));
                    a.setCourseID(rs.getInt(table.getColumn(1)));
                    a.setStudentID(rs.getInt(table.getColumn(2)));
                    a.setAttendance2(rs.getInt(table.getColumn(3)));
                    a.setPercentage2(rs.getDouble(table.getColumn(4)));
                    a.setStunden2(rs.getDouble(table.getColumn(5)));
                }else if (track == 3){
                    a.setDate3(rs.getDate(table.getColumn(0)));
                    a.setCourseID(rs.getInt(table.getColumn(1)));
                    a.setStudentID(rs.getInt(table.getColumn(2)));
                    a.setAttendance3(rs.getInt(table.getColumn(3)));
                    a.setPercentage3(rs.getDouble(table.getColumn(4)));
                    a.setStunden3(rs.getDouble(table.getColumn(5)));
                }else if (track == 4){
                    a.setDate4(rs.getDate(table.getColumn(0)));
                    a.setCourseID(rs.getInt(table.getColumn(1)));
                    a.setStudentID(rs.getInt(table.getColumn(2)));
                    a.setAttendance4(rs.getInt(table.getColumn(3)));
                    a.setPercentage4(rs.getDouble(table.getColumn(4)));
                    a.setStunden4(rs.getDouble(table.getColumn(5)));
                }else if (track == 5){
                    a.setDate5(rs.getDate(table.getColumn(0)));
                    a.setCourseID(rs.getInt(table.getColumn(1)));
                    a.setStudentID(rs.getInt(table.getColumn(2)));
                    a.setAttendance5(rs.getInt(table.getColumn(3)));
                    a.setPercentage5(rs.getDouble(table.getColumn(4)));
                    a.setStunden5(rs.getDouble(table.getColumn(5)));
                }else if (track == 6){
                    a.setDate6(rs.getDate(table.getColumn(0)));
                    a.setCourseID(rs.getInt(table.getColumn(1)));
                    a.setStudentID(rs.getInt(table.getColumn(2)));
                    a.setAttendance6(rs.getInt(table.getColumn(3)));
                    a.setPercentage6(rs.getDouble(table.getColumn(4)));
                    a.setStunden6(rs.getDouble(table.getColumn(5)));
                }else if (track == 7){
                    a.setDate7(rs.getDate(table.getColumn(0)));
                    a.setCourseID(rs.getInt(table.getColumn(1)));
                    a.setStudentID(rs.getInt(table.getColumn(2)));
                    a.setAttendance7(rs.getInt(table.getColumn(3)));
                    a.setPercentage7(rs.getDouble(table.getColumn(4)));
                    a.setStunden7(rs.getDouble(table.getColumn(5)));
                }else if (track == 8){
                    a.setDate8(rs.getDate(table.getColumn(0)));
                    a.setCourseID(rs.getInt(table.getColumn(1)));
                    a.setStudentID(rs.getInt(table.getColumn(2)));
                    a.setAttendance8(rs.getInt(table.getColumn(3)));
                    a.setPercentage8(rs.getDouble(table.getColumn(4)));
                    a.setStunden8(rs.getDouble(table.getColumn(5)));
                }else if (track == 9){
                    a.setDate9(rs.getDate(table.getColumn(0)));
                    a.setCourseID(rs.getInt(table.getColumn(1)));
                    a.setStudentID(rs.getInt(table.getColumn(2)));
                    a.setAttendance9(rs.getInt(table.getColumn(3)));
                    a.setPercentage9(rs.getDouble(table.getColumn(4)));
                    a.setStunden9(rs.getDouble(table.getColumn(5)));
                }else if (track == 10){
                    a.setDate10(rs.getDate(table.getColumn(0)));
                    a.setCourseID(rs.getInt(table.getColumn(1)));
                    a.setStudentID(rs.getInt(table.getColumn(2)));
                    a.setAttendance10(rs.getInt(table.getColumn(3)));
                    a.setPercentage10(rs.getDouble(table.getColumn(4)));
                    a.setStunden10(rs.getDouble(table.getColumn(5)));
                }else if (track == 11){
                    a.setDate11(rs.getDate(table.getColumn(0)));
                    a.setCourseID(rs.getInt(table.getColumn(1)));
                    a.setStudentID(rs.getInt(table.getColumn(2)));
                    a.setAttendance11(rs.getInt(table.getColumn(3)));
                    a.setPercentage11(rs.getDouble(table.getColumn(4)));
                    a.setStunden11(rs.getDouble(table.getColumn(5)));
                }else if (track == 12){
                    a.setDate12(rs.getDate(table.getColumn(0)));
                    a.setCourseID(rs.getInt(table.getColumn(1)));
                    a.setStudentID(rs.getInt(table.getColumn(2)));
                    a.setAttendance12(rs.getInt(table.getColumn(3)));
                    a.setPercentage12(rs.getDouble(table.getColumn(4)));
                    a.setStunden12(rs.getDouble(table.getColumn(5)));
                }else if (track == 13){
                    a.setDate13(rs.getDate(table.getColumn(0)));
                    a.setCourseID(rs.getInt(table.getColumn(1)));
                    a.setStudentID(rs.getInt(table.getColumn(2)));
                    a.setAttendance13(rs.getInt(table.getColumn(3)));
                    a.setPercentage13(rs.getDouble(table.getColumn(4)));
                    a.setStunden13(rs.getDouble(table.getColumn(5)));
                }else if (track == 14){
                    a.setDate14(rs.getDate(table.getColumn(0)));
                    a.setCourseID(rs.getInt(table.getColumn(1)));
                    a.setStudentID(rs.getInt(table.getColumn(2)));
                    a.setAttendance14(rs.getInt(table.getColumn(3)));
                    a.setPercentage14(rs.getDouble(table.getColumn(4)));
                    a.setStunden14(rs.getDouble(table.getColumn(5)));
                }
                track++;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return a;
    }

    public Anwesenheit getAnwesenheitOnly(Date queryDate, int studentID, int courseID){
        Anwesenheit a = new Anwesenheit();
        Table table=TableManager.getTable(TableManager.RPS_ANWESEN);
        try{
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='" + courseID + "' AND "+table.getColumn(2)+"='" + studentID + "' AND "+table.getColumn(0)+"=" + replaceNull(queryDate);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while( rs.next()){
                a.setDate1(rs.getDate(table.getColumn(0)));
                a.setCourseID(rs.getInt(table.getColumn(1)));
                a.setStudentID(rs.getInt(table.getColumn(2)));
                a.setAttendance1(rs.getInt(table.getColumn(3)));
                a.setPercentage1(rs.getDouble(table.getColumn(4)));
                a.setStunden1(rs.getDouble(table.getColumn(5)));
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return a;
    }

    public Date getFirstDate(){
        return this.firstDate;
    }

    public Date getLastDate(){
        return this.lastDate;
    }

    public int getLastWeek(int cid){
        int b = 0;
        try{
            CourseDao cdb = new CourseDao();
            Course c = cdb.getCourse(cid);
            Date t1 = MyDate.getWeekFirstDate(c.getCourseEndDate(),MyDate.DEUTSCH);
            Date t2 = MyDate.getWeekLastDate(c.getCourseEndDate(),MyDate.DEUTSCH);
            Date trackDate = MyDate.getWeekLastDate(c.getCourseStartDate(),MyDate.DEUTSCH);

            boolean track = true;
            while(track){

                b++;
                if((trackDate.before(t2) || MyDate.isEqual(trackDate, t2)) && (trackDate.after(t1) || MyDate.isEqual(trackDate, t1))){
                    track = false;
                }
                Calendar gc = new GregorianCalendar();
                gc.setTime(trackDate);
                gc.add(Calendar.DATE, 1);
                trackDate = MyDate.getWeekLastDate(new Date(gc.getTime().getTime()),MyDate.DEUTSCH);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    @SuppressWarnings("rawtypes")
    public Vector<Student> getProperVector(Vector studentList, Vector studentIDSLIST){
        Vector<Student> v=new Vector<Student>();
        StudentDao sdb=new StudentDao();
        try{
            for(int i = 0; i < studentList.size(); i++){
                Student s = (Student)studentList.elementAt(i);
                if(isActive(studentIDSLIST,s.getUserID())){
                    int active = 1;
                    v.addElement(s);
                    sdb.makeStudentActive(active, s.getUserID());
                }else{
                    int active = 0;
                    sdb.makeStudentActive(active, s.getUserID());
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public int getWeek(int courseID){
        int b = 0;
        try{
            CourseDao cdb = new CourseDao();
            Course c = cdb.getCourse(courseID);
            boolean chk1 = MyDate.getCurrentSQLDate().before(c.getCourseEndDate()) || MyDate.isEqual(MyDate.getCurrentSQLDate(), c.getCourseEndDate());
            boolean chk2 = MyDate.getCurrentSQLDate().after(c.getCourseStartDate()) || MyDate.isEqual(MyDate.getCurrentSQLDate(), c.getCourseStartDate());
            boolean chk3 = MyDate.getCurrentSQLDate().after(c.getCourseStartDate()) && MyDate.getCurrentSQLDate().before(c.getCourseEndDate());
            if(chk1 && chk2 && chk3){
                firstDate = MyDate.getWeekFirstDate(c.getCourseStartDate(),MyDate.DEUTSCH);
                lastDate = MyDate.getWeekLastDate(c.getCourseStartDate(),MyDate.DEUTSCH);
                Date tempDate = MyDate.getCurrentSQLDate();
                boolean track = true;
                while(track){
                    b++;
                    Calendar gc;
                    if((tempDate.before(lastDate) || MyDate.isEqual(tempDate, lastDate)) && (tempDate.after(firstDate) || MyDate.isEqual(tempDate, firstDate))){
                        track = false;
                        lastDate = MyDate.getWeekLastDate(firstDate,MyDate.DEUTSCH);
                        gc = new GregorianCalendar();
                        gc.setTime(lastDate);
                        gc.add(Calendar.DATE, 1);
                        lastDate = MyDate.getWeekLastDate(new Date(gc.getTime().getTime()),MyDate.DEUTSCH);
                    }
                    gc = new GregorianCalendar();
                    gc.setTime(lastDate);
                    gc.add(Calendar.DATE, 1);
                    firstDate = MyDate.getWeekFirstDate(new Date(gc.getTime().getTime()),MyDate.DEUTSCH);
                    lastDate = MyDate.getWeekLastDate(new Date(gc.getTime().getTime()),MyDate.DEUTSCH);
                }
            }else{
                b = 1;
                firstDate = MyDate.getWeekFirstDate(c.getCourseStartDate(),MyDate.DEUTSCH);
                lastDate = MyDate.getWeekLastDate(c.getCourseStartDate(),MyDate.DEUTSCH);
                Calendar gc = new GregorianCalendar();
                gc.setTime(lastDate);
                gc.add(Calendar.DATE, 1);
                lastDate = MyDate.getWeekLastDate(new Date(gc.getTime().getTime()),MyDate.DEUTSCH);
            }
        } catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    @SuppressWarnings("rawtypes")
    public boolean isActive(Vector studentIDSLIST, int studentID){
        boolean result = false;
        try{
            for(int i = 0; i < studentIDSLIST.size(); i++){
                String temp = (String)studentIDSLIST.elementAt(i);
                if(studentID == Integer.parseInt(temp)){
                    result = true;
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public boolean isExist(int studentID, int courseID, Date queryDate){
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_ANWESEN);
        try{
            String q = "SELECT "+table.getColumn(2)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(2)+"='" + studentID + "' AND anwCID='" + courseID + "' AND anwDate=" + replaceNull(queryDate);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                int temp = rs.getInt(table.getColumn(2));
                if(temp==studentID){
                    result = true;
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public void setWeek(int weekNo, int courseID){
        CourseDao cdb = new CourseDao();
        Course c = cdb.getCourse(courseID);
        int track = 1;
        firstDate = MyDate.getWeekFirstDate(c.getCourseStartDate(),MyDate.DEUTSCH);
        lastDate = MyDate.getWeekLastDate(c.getCourseStartDate(),MyDate.DEUTSCH);
        Calendar gc;
        while(track != weekNo){
            gc = new GregorianCalendar();
            gc.setTime(lastDate);
            gc.add(Calendar.DATE, 1);
            firstDate = MyDate.getWeekFirstDate(new Date(gc.getTime().getTime()),MyDate.DEUTSCH);
            lastDate = MyDate.getWeekLastDate(new Date(gc.getTime().getTime()),MyDate.DEUTSCH);
            track++;
        }

        gc = new GregorianCalendar();
        gc.setTime(lastDate);

        gc.add(Calendar.DATE, 1);
        lastDate = MyDate.getWeekLastDate(new Date(gc.getTime().getTime()),MyDate.DEUTSCH);
    }

    @SuppressWarnings("rawtypes")
    public int synchronizedAnwesenheit(Vector studentList, int courseID, Date startDate, Date lastDate){
        int b = 0;
        try{
            Calendar gc = new GregorianCalendar();
            gc.setTime(startDate);
            Date temp = new Date(gc.getTime().getTime());
            boolean chk = true;
            for(int i = 0; i < studentList.size(); i++){
                Student s = (Student)studentList.elementAt(i);
                while(temp.before(lastDate) || MyDate.isEqual(temp, lastDate)){
                    chk = isExist(s.getUserID(), courseID, temp);
                    gc.add(Calendar.DATE, 1);
                    temp = new Date(gc.getTime().getTime());
                }

                if(!chk){
                    addAnwesenheit(courseID, s.getUserID(),startDate,lastDate);
                }

                if(temp.after(lastDate)){
                    gc.setTime(startDate);
                    temp = new Date(gc.getTime().getTime());
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean updateAnwesenheit(Date queryDate, int courseID, int studentID, int attendance, double percentage, double stunden){
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_ANWESEN);
        try{
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(3)+"='" + attendance + "', "+table.getColumn(4)+"='" + percentage +
                    "', "+table.getColumn(5)+"='" + stunden + "' WHERE "+table.getColumn(0)+"=" + replaceNull(queryDate) +
                    " AND "+table.getColumn(1)+"='" + courseID + "' AND "+table.getColumn(2)+"='" + studentID + "'";

            DBHelper.getInstance().updateQuery(q);
            result = true;
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public static void main(String args[]){
        //AnwesenDB adb=new AnwesenDB();
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
    private Date firstDate;
    private Date lastDate;
}
