package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Table;

import java.sql.*;
import java.util.Date;
import java.util.Vector;

public class EmployeeHours{

    public static void main(String[] args){

    }

    public EmployeeHours(){
        this.error=null;

        this.userID=0;
        this.month=0;
        this.year=0;
        this.loginDate=null;
        this.loginTime=null;
        this.logoutTime=null;
        this.breakStartTime=null;
        this.breakStartTime=null;
        this.totalHours=null;
        this.totalTime=0;
        this.totalMinutes=0;

        this.timeAdjustTo =null;
        this.totalTimeAdjust=null;
        this.totalHoursAdjust=0;
        this.totalMinutesAdjust=0;

        this.stdDay=null;
        this.userName=null;
        this.placeName=null;
        this.placeID=0;
        this.count=0;
    }

    public int addEmployeeInformation(int userID, int placeID){
        int chk=0;
        Table table= TableManager.getTable(TableManager.RPS_EMPLOYEESTUNDEN);
        try{
            Date d1 = new Date();
            Time t1 = new Time(d1.getTime());
            String q =
                    "INSERT INTO "+table.getTableName()+"("
                            +table.getColumn(0)+","
                            +table.getColumn(1)+","
                            +table.getColumn(4)+","
                            +table.getColumn(8)+") VALUES("
                            + userID + ", CURDATE(),"
                            + replaceNull(t1)+ ","
                            + placeID + ")";
            DBHelper.getInstance().updateQuery(q);
            chk = 1;
        }catch(Exception e){
            setError(e.toString());
        }
        return chk;
    }

    public EmployeeHours updateEmployeeAbmeldung(int userID){
        EmployeeHours p = new EmployeeHours();
        Table table=TableManager.getTable(TableManager.RPS_EMPLOYEESTUNDEN);
        try{
            Date d1 = new Date();
            Time t1 = new Time(d1.getTime());


            String q = "UPDATE "+table.getTableName()+" SET "
                    +table.getColumn(5)+"= "+ replaceNull(t1)+ " WHERE "
                    +table.getColumn(0)+"="+ userID +" AND "
                    +table.getColumn(1)+"= curdate()";
            DBHelper.getInstance().updateQuery(q);

        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return p;
    }

    public EmployeeHours updateEmployeeBreak(int userID){
        EmployeeHours p = new EmployeeHours();
        Table table=TableManager.getTable(TableManager.RPS_EMPLOYEESTUNDEN);
        try{
            Date d1 = new Date();
            Time t1 = new Time(d1.getTime());

            String q = "UPDATE "+table.getTableName()+" SET "
                    +table.getColumn(6)+"= "+ replaceNull(t1)+ " WHERE "
                    +table.getColumn(0)+"="+ userID +" AND "
                    +table.getColumn(1)+"= curdate()";
            DBHelper.getInstance().updateQuery(q);

        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return p;
    }

    public EmployeeHours updateEmployeeBreakEnd(int userID){
        EmployeeHours p = new EmployeeHours();
        Table table=TableManager.getTable(TableManager.RPS_EMPLOYEESTUNDEN);
        try{
            Date d1 = new Date();
            Time t1 = new Time(d1.getTime());

            String q = "UPDATE "+table.getTableName()+" SET "
                    +table.getColumn(7)+"= "+ replaceNull(t1)+ " WHERE "
                    +table.getColumn(0)+"="+ userID +" AND "
                    +table.getColumn(1)+"= curdate()";
            DBHelper.getInstance().updateQuery(q);

        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return p;
    }

    public EmployeeHours updateEmployeeCount(int placeID){
        int counter=1;
        EmployeeHours p = new EmployeeHours();
        Table table=TableManager.getTable(TableManager.RPS_EMPLOYEESTUNDEN);
        try{

            String q = "UPDATE "+table.getTableName()+" SET "
                    +table.getColumn(9)+"= "+ counter + " WHERE "
                    +table.getColumn(8)+"="+ placeID +" AND "
                    +table.getColumn(1)+"= curdate()";
            DBHelper.getInstance().updateQuery(q);

        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return p;
    }

    public Vector<EmployeeHours> getMonthlyEmployeeHours(int userID, int month, int year){
        Vector<EmployeeHours> v = new Vector<EmployeeHours>();
        Table table=TableManager.getTable(TableManager.RPS_EMPLOYEESTUNDEN);
        try{
            String q = "SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+ " FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+"="+ userID +" AND "
                    +table.getColumn(2)+"="+ month +" AND "
                    +table.getColumn(3)+"="+ year +" ORDER BY "
                    + table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                EmployeeHours p = new EmployeeHours();
                p.setUserID(rs.getInt(table.getColumn(0)));
                p.setLoginDate(rs.getDate(table.getColumn(1)));
                p.setMonth(rs.getInt(table.getColumn(2)));
                p.setYear(rs.getInt(table.getColumn(3)));
                p.setLoginTime(rs.getTime(table.getColumn(4)));
                p.setLogoutTime(rs.getTime(table.getColumn(5)));
                p.setBreakStartTime(rs.getTime(table.getColumn(6)));
                p.setBreakEndTime(rs.getTime(table.getColumn(7)));
                v.add(p);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public EmployeeHours getEmployeeHours(int userID){
        EmployeeHours p = new EmployeeHours();
        Table table=TableManager.getTable(TableManager.RPS_EMPLOYEESTUNDEN);
        try{
            String q = "SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+ " FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+"="+ userID +" AND "
                    +table.getColumn(1)+"= curdate()";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                p.setUserID(rs.getInt(table.getColumn(0)));
                p.setLoginDate(rs.getDate(table.getColumn(1)));
                p.setMonth(rs.getInt(table.getColumn(2)));
                p.setYear(rs.getInt(table.getColumn(3)));
                p.setLoginTime(rs.getTime(table.getColumn(4)));
                p.setLogoutTime(rs.getTime(table.getColumn(5)));
                p.setBreakStartTime(rs.getTime(table.getColumn(6)));
                p.setBreakEndTime(rs.getTime(table.getColumn(7)));
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return p;
    }

    public Vector<EmployeeHours> getEmployeeSameOffice(int placeID){
        Vector<EmployeeHours> v = new Vector<EmployeeHours>();
        Table table=TableManager.getTable(TableManager.RPS_EMPLOYEESTUNDEN);
        try{
            String q = "SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+ " FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(8)+"="+ placeID +" AND "
                    +table.getColumn(1)+"= curdate()";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                EmployeeHours p = new EmployeeHours();
                p.setUserID(rs.getInt(table.getColumn(0)));
                p.setLoginDate(rs.getDate(table.getColumn(1)));
                p.setMonth(rs.getInt(table.getColumn(2)));
                p.setYear(rs.getInt(table.getColumn(3)));
                p.setLoginTime(rs.getTime(table.getColumn(4)));
                p.setLogoutTime(rs.getTime(table.getColumn(5)));
                p.setBreakStartTime(rs.getTime(table.getColumn(6)));
                p.setBreakEndTime(rs.getTime(table.getColumn(7)));

                v.add(p);
            }
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
        return v;
    }

    public Vector<EmployeeHours> EmployeeTimeSheet(int month, int year, int userID) {
        Vector<EmployeeHours> v = new Vector<EmployeeHours>();
        String Time="18:00:00";
        try {
            //String q = "select rent.rentMonth AS rentMonth,rent.rentYear AS rentYear,rent.amountPaid AS amountPaid,rent.rentDate AS rentDate,rent.rentIncomingID AS rentIncomingID, rent.amountBalance AS amountBalance, residence.residenceRent AS residenceRent,residence.residenceMark AS residenceMark,CONCAT_WS(' ', stu.userFirstName, res.userFirstName) AS userFirstName,CONCAT_WS(' ', stu.userLastName, res.userLastName) AS userLastName,CONCAT_WS(' ', stu.userAddress, res.userAddress) AS userAddress,CONCAT_WS(' ', stu.userPostCode, res.userPostCode) AS userPostCode,CONCAT_WS(' ', stu.userCity, res.userCity) AS userCity FROM rps_rentincoming AS rent,rps_residencemieten AS miet,rps_residence AS residence,rps_resident res LEFT JOIN rps_user stu ON res.studentReference = stu.userID WHERE rent.residenceID = miet.residenceID AND miet.residentID = res.userID AND residence.residenceID = rent.residenceID AND rent.rentincomingID ="+rentIncomingID;
            String q = "select userID AS userID,workDate AS workDate,timeStart AS timeStart,timeEnd AS timeEnd,breakTimeStart AS breakTimeStart,breakTimeEnd AS breakTimeEnd, sec_to_time((time_to_sec(sec_to_time(time_to_sec(timeEnd) - time_to_sec(timeStart))))- (time_to_sec(sec_to_time(time_to_sec(breakTimeEnd) - time_to_sec(breakTimeStart))))) AS totalTime, HOUR(sec_to_time((time_to_sec(sec_to_time(time_to_sec(timeEnd) - time_to_sec(timeStart))))- (time_to_sec(sec_to_time(time_to_sec(breakTimeEnd) - time_to_sec(breakTimeStart)))))) AS totalHours, MINUTE(sec_to_time((time_to_sec(sec_to_time(time_to_sec(timeEnd) - time_to_sec(timeStart))))- (time_to_sec(sec_to_time(time_to_sec(breakTimeEnd) - time_to_sec(breakTimeStart)))))) AS totalMinutes,IF(timeEnd>'" +Time+ "','" +Time+ "',timeEnd) AS timeAdjustTo,sec_to_time((time_to_sec(sec_to_time(time_to_sec(IF(timeEnd>'" +Time+ "','" +Time+ "',timeEnd) ) - time_to_sec(timeStart))))- (time_to_sec(sec_to_time(time_to_sec(breakTimeEnd) - time_to_sec(breakTimeStart))))) AS totalTimeAdjust, HOUR(sec_to_time((time_to_sec(sec_to_time(time_to_sec(IF(timeEnd>'" +Time+ "','" +Time+ "',timeEnd) ) - time_to_sec(timeStart))))- (time_to_sec(sec_to_time(time_to_sec(breakTimeEnd) - time_to_sec(breakTimeStart)))))) AS totalHoursAdjust, MINUTE(sec_to_time((time_to_sec(sec_to_time(time_to_sec(IF(timeEnd>'" +Time+ "','" +Time+ "',timeEnd) ) - time_to_sec(timeStart))))- (time_to_sec(sec_to_time(time_to_sec(breakTimeEnd) - time_to_sec(breakTimeStart)))))) AS totalMinutesAdjust from rps_employeestunden WHERE month(workDate) ='" +month+ "' AND year(workDate) ='" +year+ "' AND userID ="+userID;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
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
                employee.setTimeAdjustTo(rs.getTime("timeAdjustTo"));
                employee.setTotalTimeAdjust(rs.getTime("totalTimeAdjust"));
                employee.setTotalHoursAdjust(rs.getInt("totalHoursAdjust"));
                employee.setTotalMinutesAdjust(rs.getInt("totalMinutesAdjust"));


                java.util.Date tempDate = new java.util.Date(employee.getLoginDate().getTime());
                String dayName = tempDate.toString().substring(0, 3);
                int dayNumber = MyDate.getDayNumber(dayName,MyDate.DEUTSCH);
                dayName = MyDate.getDayName(dayNumber,MyDate.DEUTSCH);
                employee.setDay(dayName);

                v.addElement(employee);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;


    }

    public Vector<EmployeeHours> EmployeeTimeSheetSearch(int criteria, int adminID, Date startDate, Date endDate, int placeID, int tranNo) {
        Vector<EmployeeHours> v = new Vector<EmployeeHours>();
        try {
            String q = "select a.userID AS userID,a.workDate AS workDate,a.timeStart AS timeStart,a.timeEnd AS timeEnd,a.breakTimeStart AS breakTimeStart,a.breakTimeEnd AS breakTimeEnd, sec_to_time((time_to_sec(sec_to_time(time_to_sec(a.timeEnd) - time_to_sec(a.timeStart))))- (time_to_sec(sec_to_time(time_to_sec(a.breakTimeEnd) - time_to_sec(a.breakTimeStart))))) AS totalTime, HOUR(sec_to_time((time_to_sec(sec_to_time(time_to_sec(a.timeEnd) - time_to_sec(a.timeStart))))- (time_to_sec(sec_to_time(time_to_sec(a.breakTimeEnd) - time_to_sec(a.breakTimeStart)))))) AS totalHours, MINUTE(sec_to_time((time_to_sec(sec_to_time(time_to_sec(a.timeEnd) - time_to_sec(a.timeStart))))- (time_to_sec(sec_to_time(time_to_sec(a.breakTimeEnd) - time_to_sec(a.breakTimeStart)))))) AS totalMinutes,CONCAT_WS(' ',c.userFirstName,c.userLastName) AS loginUserName,b.placeName AS placeName, a.count AS count from rps_employeestunden a, rps_place b, rps_systemuser c where a.placeID = b.placeID and a.userID =c.userID";
            if (criteria == SPECIFICDATE) {
                if (adminID > 0 && placeID > 0) {
                    q = q + " AND a.userID=" + adminID + " AND a.placeID=" + placeID + "' AND a.workDate=" + replaceNull(startDate);
                } else if (adminID == 0 && placeID > 0) {
                    q = q + " AND a.placeID=" + placeID + " AND a.workDate=" + replaceNull(startDate);
                } else if (adminID > 0 && placeID == 0) {
                    q = q + " AND a.userID=" + adminID + " AND a.workDate=" + replaceNull(startDate);
                } else if (adminID == 0 && placeID == 0) {
                    q = q + " AND a.workDate="	+ replaceNull(startDate);
                }
            } else if (criteria == DATELIMIT) {
                if (adminID > 0 && placeID > 0) {
                    q = q + " AND a.userID=" + adminID + " AND a.placeID="	+ placeID + " AND a.workDate>=" + replaceNull(startDate) + " AND a.workDate <=" + replaceNull(endDate);
                } else if (adminID == 0 && placeID > 0) {
                    q = q + " AND a.placeID=" + placeID + " AND a.workDate >=" + replaceNull(startDate) + " AND a.workDate <=" + replaceNull(endDate);
                } else if (adminID > 0 && placeID == 0) {
                    q = q + " AND a.userID ='" + adminID + "' AND a.workDate >=" + replaceNull(startDate) + " AND a.workDate <=" + replaceNull(endDate);
                } else if (adminID == 0 && placeID == 0) {
                    q = q + " AND a.workDate >=" + replaceNull(startDate) + " AND a.workDate <=" + replaceNull(endDate);
                }
            } else if (criteria == TRANSACTIONNO) {
                q = q + " AND a.workDate ='" + tranNo + "'";
            }
            q = q + " ORDER BY a.workDate";

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
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
                employee.setCount(rs.getInt("count"));

                java.util.Date tempDate = new java.util.Date(employee.getLoginDate().getTime());
                String dayName = tempDate.toString().substring(0, 3);
                int dayNumber = MyDate.getDayNumber(dayName,MyDate.DEUTSCH);
                dayName = MyDate.getDayName(dayNumber,MyDate.DEUTSCH);
                employee.setDay(dayName);

                v.addElement(employee);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;

    }

    public boolean canAddEmployeeHours(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"18.1.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeeEmployeeHours(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"18.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateEmployeeHours(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"18.1.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public void setUserID(int code){
        userID = code;
    }
    public int getUserID(){
        return userID;
    }

    public void setMonth(int code){
        month = code;
    }
    public int getMonth(){
        return month;
    }

    public void setYear(int code){
        month = code;
    }
    public int getYear(){
        return year;
    }


    public void setLoginDate(java.sql.Date code){
        loginDate = code;
    }
    public java.sql.Date getLoginDate(){
        return loginDate;
    }

    public void setLoginTime(Time code){
        loginTime = code;
    }
    public Time getLoginTime(){
        return loginTime;
    }

    public void setLogoutTime(Time code){
        logoutTime = code;
    }
    public Time getLogoutTime(){
        return logoutTime;
    }

    public void setTotalHours(Time code){
        totalHours = code;
    }
    public Time getTotalHours(){
        return totalHours;
    }

    public void setBreakStartTime(Time code){
        breakStartTime = code;
    }
    public Time getBreakStartTime(){
        return breakStartTime;
    }

    public void setBreakEndTime(Time code){
        breakEndTime = code;
    }
    public Time getBreakEndTime(){
        return breakEndTime;
    }



    public void setTotalTime(int code){
        totalTime = code;
    }
    public int getTotalTime(){
        return totalTime;
    }

    public void setTotalMinutes(int code){
        totalMinutes = code;
    }
    public int getTotalMinutes(){
        return totalMinutes;
    }

    public void setTimeAdjustTo(Time code){
        timeAdjustTo = code;
    }
    public Time getTimeAdjustTo(){
        return timeAdjustTo;
    }

    public void setTotalTimeAdjust(Time code){
        totalTimeAdjust = code;
    }
    public Time getTotalTimeAdjust(){
        return totalTimeAdjust;
    }

    public void setTotalHoursAdjust(int code){
        totalHoursAdjust = code;
    }
    public int getTotalHoursAdjust(){
        return totalHoursAdjust;
    }

    public void setTotalMinutesAdjust(int code){
        totalMinutesAdjust = code;
    }
    public int getTotalMinutesAdjust(){
        return totalMinutesAdjust;
    }

    public String getDay() {
        return this.stdDay;
    }

    public void setDay(String code) {
        this.stdDay = code;
    }

    public int getPlaceID() {
        return placeID;
    }

    public void setPlaceID(int code) {
        placeID = code;
    }

    public String getUserName() {
        return this.userName;
    }

    public void setUserName(String code) {
        this.userName = code;
    }

    public String getPlaceName() {
        return this.placeName;
    }

    public void setPlaceName(String code) {
        this.placeName = code;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int code) {
        count = code;
    }

    /*Utility Methods*/
    public Object replaceNull(Object o){
        if(o == null){
            return null;
        }else{
            return "'" + o + "'";
        }
    }



    public String getError(){
        return error;
    }

    public void setError(String errorString){
        error=errorString;
    }

    //Instance Variables
    private String error;

    private int userID;
    private java.sql.Date loginDate;
    private Time loginTime;
    private Time logoutTime;
    private Time breakStartTime;
    private Time breakEndTime;
    private Time totalHours;
    private int totalTime;
    private int totalMinutes;

    private Time timeAdjustTo;
    private Time totalTimeAdjust;
    private int totalHoursAdjust;
    private int totalMinutesAdjust;

    private int month;
    private int year;
    private String stdDay;
    private String userName;
    private String placeName;
    private int placeID;
    private int count;

    public static int BARTYPE=0;
    public static int UEBERWEISENTYPE=1;
    public static int ONLINETYPE=2;

    public static int SPECIFICDATE=1;
    public static int DATELIMIT=2;
    public static int TRANSACTIONNO=3;


}
