package com.rheinlandprivatschule.repository;


import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Table;
import com.rheinlandprivatschule.model.TeacherLohn;

import java.sql.Date;
import java.sql.ResultSet;
import java.util.Vector;

public class TeacherLohnDao {

    public static void main(String[] args){
    }

    public boolean addNewTeacherLohn(int userID,Date startDate,Date endDate,double lohn,int LOHNTYPE) {
        boolean result = false;
        Table table_private=TableManager.getTable(TableManager.RPS_PRIVATELOHN);
        Table table_group=TableManager.getTable(TableManager.RPS_GROUPLOHN);
        try {
            String q="";
            if(isDatesValid(userID,startDate, endDate,LOHNTYPE)){
                if(LOHNTYPE == PRIVATELOHN){
                    q ="INSERT INTO "+table_private.getTableName()+" ("+table_private.getColumn(0)+","+table_private.getColumn(1)+","+table_private.getColumn(2)+","+table_private.getColumn(3)+") VALUES ('"+userID+"',"+replaceNull(startDate)+","+replaceNull(endDate)+",'"+lohn+"')";
                }else if(LOHNTYPE == GROUPLOHN){
                    q ="INSERT INTO "+table_group.getTableName()+" ("+table_group.getColumn(0)+","+table_group.getColumn(1)+","+table_group.getColumn(2)+","+table_group.getColumn(3)+") VALUES ('"+userID+"',"+replaceNull(startDate)+","+replaceNull(endDate)+",'"+lohn+"')";
                }
                DBHelper.getInstance().updateQuery(q);
                result = true;
            }else{
                result = false;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    private boolean isDatesValid(int userID,Date startDate,Date endDate,int LOHNTYPE){
        boolean result = false;
        try{
            if(endDate == null){
                result = isGreaterThanLastLohnEndDate(userID,startDate,LOHNTYPE);
            }else{
                if(startDate.before(endDate)){
                    result = isGreaterThanLastLohnEndDate(userID,startDate,LOHNTYPE);
                }else{
                    setError("Starting and Ending Date is invalid.");
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    private boolean isGreaterThanLastLohnEndDate(int userID,Date startDate,int LOHNTYPE){
        boolean result = true;
        try{
            Vector<TeacherLohn> teacherLohnList = getAllTeacherLohn(userID, LOHNTYPE);
            for(int i=0;i<teacherLohnList.size();i++){
                TeacherLohn teacherLohn = (TeacherLohn)teacherLohnList.elementAt(i);
                if(!(startDate.after(teacherLohn.getEndDate()) && teacherLohn.getEndDate().after(teacherLohn.getStartDate()))){
                    result=false;
                    setError("Starting Date is invalid.");
                    break;
                }
            }
        }catch(Exception e){
            setError(e.toString());
            result = false;
        }
        return result;
    }

    public Vector<TeacherLohn> getAllTeacherLohn(int userID,int LOHNTYPE) {
        Vector<TeacherLohn> lohnList = new Vector<TeacherLohn>();
        Table table_private=TableManager.getTable(TableManager.RPS_PRIVATELOHN);
        Table table_group=TableManager.getTable(TableManager.RPS_GROUPLOHN);
        try {
            String q="";
            if(LOHNTYPE == PRIVATELOHN){
                q = "SELECT "+table_private.getColumn(0)+","
                        +table_private.getColumn(1)+","
                        +table_private.getColumn(2)+","
                        +table_private.getColumn(3)+" FROM "
                        +table_private.getTableName()+" WHERE "
                        +table_private.getColumn(0)+"='"+userID+"' ORDER BY "
                        +table_private.getColumn(1);
                ResultSet rs = DBHelper.getInstance().executeQuery(q);
                while (rs.next()) {
                    TeacherLohn teacherLohn = new TeacherLohn();
                    teacherLohn.setUserID(rs.getInt(table_private.getColumn(0)));
                    teacherLohn.setStartDate(rs.getDate(table_private.getColumn(1)));
                    teacherLohn.setEndDate(rs.getDate(table_private.getColumn(2)));
                    teacherLohn.setTeacherLohn(rs.getDouble(table_private.getColumn(3)));
                    lohnList.addElement(teacherLohn);
                }
            }else if(LOHNTYPE == GROUPLOHN){
                q = "SELECT "+table_group.getColumn(0)+","
                        +table_group.getColumn(1)+","
                        +table_group.getColumn(2)+","
                        +table_group.getColumn(3)+" FROM "
                        +table_group.getTableName()+" WHERE "
                        +table_group.getColumn(0)+"='"+userID+"' ORDER BY "
                        +table_group.getColumn(1);
                ResultSet rs = DBHelper.getInstance().executeQuery(q);
                while (rs.next()) {
                    TeacherLohn teacherLohn = new TeacherLohn();
                    teacherLohn.setUserID(rs.getInt(table_group.getColumn(0)));
                    teacherLohn.setStartDate(rs.getDate(table_group.getColumn(1)));
                    teacherLohn.setEndDate(rs.getDate(table_group.getColumn(2)));
                    teacherLohn.setTeacherLohn(rs.getDouble(table_group.getColumn(3)));
                    lohnList.addElement(teacherLohn);
                }
            }

        } catch (Exception e) {
            setError(e.toString());
        }
        return lohnList;
    }

    public TeacherLohn getTeacherLohn(int userID,int LOHNTYPE, Date startDate) {
        TeacherLohn lohn = new TeacherLohn();
        Table table_private=TableManager.getTable(TableManager.RPS_PRIVATELOHN);
        Table table_group=TableManager.getTable(TableManager.RPS_GROUPLOHN);
        try {
            String q="";
            if(LOHNTYPE == PRIVATELOHN){
                q = "SELECT "+table_private.getColumn(0)+","
                        +table_private.getColumn(1)+","
                        +table_private.getColumn(2)+","
                        +table_private.getColumn(3)+" FROM "
                        +table_private.getTableName()+" WHERE "
                        +table_private.getColumn(0)+"='"+userID+"' AND "
                        +table_private.getColumn(1)+"="+startDate+" ORDER BY "
                        +table_private.getColumn(1);
                ResultSet rs = DBHelper.getInstance().executeQuery(q);
                while (rs.next()) {
                    TeacherLohn teacherLohn = new TeacherLohn();
                    teacherLohn.setUserID(rs.getInt(table_private.getColumn(0)));
                    teacherLohn.setStartDate(rs.getDate(table_private.getColumn(1)));
                    teacherLohn.setEndDate(rs.getDate(table_private.getColumn(2)));
                    teacherLohn.setTeacherLohn(rs.getDouble(table_private.getColumn(3)));
                }
            }else if(LOHNTYPE == GROUPLOHN){
                q = "SELECT "+table_group.getColumn(0)+","
                        +table_group.getColumn(1)+","
                        +table_group.getColumn(2)+","
                        +table_group.getColumn(3)+" FROM "
                        +table_group.getTableName()+" WHERE "
                        +table_private.getColumn(0)+"='"+userID+"' AND "
                        +table_private.getColumn(1)+"="+startDate+" ORDER BY "
                        +table_private.getColumn(1);
                ResultSet rs = DBHelper.getInstance().executeQuery(q);
                while (rs.next()) {
                    TeacherLohn teacherLohn = new TeacherLohn();
                    teacherLohn.setUserID(rs.getInt(table_group.getColumn(0)));
                    teacherLohn.setStartDate(rs.getDate(table_group.getColumn(1)));
                    teacherLohn.setEndDate(rs.getDate(table_group.getColumn(2)));
                    teacherLohn.setTeacherLohn(rs.getDouble(table_group.getColumn(3)));
                }
            }

        } catch (Exception e) {
            setError(e.toString());
        }
        return lohn;
    }

    public boolean updateGroupTeacherLohn(TeacherLohn teacher) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_GROUPLOHN);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "
                    +table.getColumn(1)+"="	+ replaceNull(teacher.getStartDate()) + ","
                    +table.getColumn(2)+"="+ replaceNull(teacher.getEndDate()) + ","
                    +table.getColumn(3)+"="+ replaceNull(teacher.getTeacherLohn()) + " WHERE "
                    +table.getColumn(0)+"='"+ teacher.getUserID() + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean updatePrivateTeacherLohn(TeacherLohn teacher, int LOHNTYPE, Date startDate) {
        boolean result = false;
        Table table_private=TableManager.getTable(TableManager.RPS_PRIVATELOHN);
        Table table_group=TableManager.getTable(TableManager.RPS_GROUPLOHN);
        try {
            String q = "";
            if(LOHNTYPE == PRIVATELOHN){
                q = "UPDATE "+table_private.getTableName()+" SET "
                        +table_private.getColumn(1)+"="	+ replaceNull(teacher.getStartDate()) + ","
                        +table_private.getColumn(2)+"="+ replaceNull(teacher.getEndDate()) + ","
                        +table_private.getColumn(3)+"="+ replaceNull(teacher.getTeacherLohn()) + " WHERE "
                        +table_private.getColumn(1)+"="+ replaceNull(startDate) + " AND "
                        +table_private.getColumn(0)+"='"+ teacher.getUserID() + "'";
                DBHelper.getInstance().updateQuery(q);
            }else if(LOHNTYPE == GROUPLOHN){
                q = "UPDATE "+table_group.getTableName()+" SET "
                        +table_group.getColumn(1)+"="	+ replaceNull(teacher.getStartDate()) + ","
                        +table_group.getColumn(2)+"="+ replaceNull(teacher.getEndDate()) + ","
                        +table_group.getColumn(3)+"="+ replaceNull(teacher.getTeacherLohn()) + " WHERE "
                        +table_group.getColumn(1)+"="+ replaceNull(startDate) + " AND "
                        +table_group.getColumn(0)+"='"+ teacher.getUserID() + "'";
                DBHelper.getInstance().updateQuery(q);
            }
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }


    public double getTeacherLohn(int userID,Date processDate,int LOHNTYPE) {
        double returnLohn = 0;
        Vector<TeacherLohn> lohnList = new Vector<TeacherLohn>();
        try {
            lohnList = getAllTeacherLohn(userID, LOHNTYPE);
            for(int i=0;i<lohnList.size();i++){
                TeacherLohn teacherLohn = (TeacherLohn)lohnList.elementAt(i);
                Date startDate = teacherLohn.getStartDate();
                Date endDate = teacherLohn.getEndDate();
                if(teacherLohn.getEndDate()==null){
                    if((processDate.after(startDate) || MyDate.isEqual(processDate,startDate))){
                        returnLohn = teacherLohn.getTeacherLohn();
                    }
                }else{
                    if((processDate.after(startDate) || MyDate.isEqual(processDate,startDate)) && (processDate.before(endDate) || MyDate.isEqual(processDate, endDate))){
                        returnLohn = teacherLohn.getTeacherLohn();
                    }
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return returnLohn;
    }

    public boolean deleteTeacherLohn(int userID,Date startDate,Date endDate,int LOHNTYPE) {
        boolean result = false;
        Table table_private=TableManager.getTable(TableManager.RPS_PRIVATELOHN);
        Table table_group=TableManager.getTable(TableManager.RPS_GROUPLOHN);
        try {
            String q = "";
            if(LOHNTYPE == PRIVATELOHN){
                q="DELETE FROM "+table_private.getTableName()+" WHERE "+table_private.getColumn(0)+"='"+userID+"' AND "+table_private.getColumn(1)+"="+replaceNull(startDate);
                DBHelper.getInstance().updateQuery(q);
            }else if(LOHNTYPE == GROUPLOHN){
                q="DELETE FROM "+table_group.getTableName()+" WHERE "+table_group.getColumn(0)+"='"+userID+"' AND "+table_group.getColumn(1)+"="+replaceNull(startDate);
                DBHelper.getInstance().updateQuery(q);
            }
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public double getTeacherLohnForSpecificDate(Vector<TeacherLohn> teacherLohnList,Date specificDate){
        double lohn = 0;
        try{
            for(int i = 0; i < teacherLohnList.size(); i++){
                TeacherLohn teacherLohn = (TeacherLohn)teacherLohnList.elementAt(i);
                if(teacherLohn.getEndDate() == null || teacherLohn.getStartDate().after(teacherLohn.getEndDate())){
                    if((specificDate.after(teacherLohn.getStartDate()) || MyDate.isEqual(specificDate,teacherLohn.getStartDate()))){
                        lohn = teacherLohn.getTeacherLohn();
                        break;
                    }
                }else{
                    if((specificDate.after(teacherLohn.getStartDate()) || MyDate.isEqual(specificDate,teacherLohn.getStartDate())) && (specificDate.before(teacherLohn.getEndDate()) || MyDate.isEqual(specificDate,teacherLohn.getEndDate())) ){
                        lohn = teacherLohn.getTeacherLohn();
                        break;
                    }
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return lohn;
    }


    /* Methods Related To Every Method */
    private void setError(String errorPara) {
        this.error = errorPara;
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
    public static final int PRIVATELOHN = 1;
    public static final int GROUPLOHN = 2;
}
