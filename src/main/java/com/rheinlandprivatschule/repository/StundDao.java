package com.rheinlandprivatschule.repository;


import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.*;

import java.sql.*;
import java.util.Vector;
import java.util.Calendar;
import java.util.GregorianCalendar;

public class StundDao {

    public int addCoursePlan(int courseID, int week) {
        int b = 0;
        try {
            Calendar gc = new GregorianCalendar();
            gc.setTime(MyDate.getWeekFirstDateFuture(week,MyDate.DEUTSCH));
            Date temp = new Date(gc.getTime().getTime());
            while (temp.before(MyDate.getWeekLastDateFuture(week,MyDate.DEUTSCH))
                    || MyDate.isEqual(temp, MyDate.getWeekLastDateFuture(week,MyDate.DEUTSCH))) {
                addStundenPlan(temp, courseID,0,0,0,0,null);
                gc.add(Calendar.DATE, 1);
                temp = new Date(gc.getTime().getTime());
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public int addCoursePlanSyncronized(int courseID, int weekNo) {
        int b = 0;
        try {
            CourseDao cdb = new CourseDao();
            Course c = cdb.getCourse(courseID);
            int hours = Integer.parseInt(c.getCourseDailyHrs());
			/*if (c.getCourseTiming().equalsIgnoreCase("8:30-12:00")) {
				hours = Integer.parseInt(c.getCourseDailyHrs());//4
			} else if (c.getCourseTiming().equalsIgnoreCase("12:00-18:00")) {
				hours = 6;
			} else if (c.getCourseTiming().equalsIgnoreCase("18:00-21:00")) {
				hours = 3;
			}*/
            int track = 1;
            Calendar gc = new GregorianCalendar();
            gc.setTime(MyDate.getWeekFirstDateFuture(weekNo,MyDate.DEUTSCH));
            Date temp = new Date(gc.getTime().getTime());
            while (temp.before(MyDate.getWeekLastDateFuture(weekNo,MyDate.DEUTSCH))
                    || MyDate.isEqual(temp,MyDate.getWeekLastDateFuture(weekNo,MyDate.DEUTSCH))) {
                if (track == 1) {
                    if ((temp.after(c.getCourseStartDate()) || MyDate.isEqual(temp,
                            c.getCourseStartDate()))
                            && (temp.before(c.getCourseEndDate()) || MyDate
                            .isEqual(temp, c.getCourseEndDate()))) {
                        int tid = getTeacherNormal(courseID, temp);
                        addStundenPlan(temp,courseID,tid,hours,0,hours,null);
                    } else {
                        addStundenPlan(temp,courseID,0,0,0,0,null);
                    }
                } else if (track == 2) {
                    if ((temp.after(c.getCourseStartDate()) || MyDate.isEqual(temp,
                            c.getCourseStartDate()))
                            && (temp.before(c.getCourseEndDate()) || MyDate
                            .isEqual(temp, c.getCourseEndDate()))) {
                        int tid = getTeacherNormal(courseID, temp);
                        addStundenPlan(temp, courseID,tid,hours,0,hours,null);
                    } else {
                        addStundenPlan(temp,courseID,0,0,0,0,null);
                    }
                } else if (track == 3) {
                    if ((temp.after(c.getCourseStartDate()) || MyDate.isEqual(temp,
                            c.getCourseStartDate()))
                            && (temp.before(c.getCourseEndDate()) || MyDate
                            .isEqual(temp, c.getCourseEndDate()))) {
                        int tid = getTeacherNormal(courseID, temp);
                        addStundenPlan(temp,courseID,tid,hours,0,hours,null);
                    } else {
                        addStundenPlan(temp,courseID,0,0,0,0,null);
                    }
                } else if (track == 4) {
                    if ((temp.after(c.getCourseStartDate()) || MyDate.isEqual(temp,
                            c.getCourseStartDate()))
                            && (temp.before(c.getCourseEndDate()) || MyDate
                            .isEqual(temp, c.getCourseEndDate()))) {
                        int tid = getTeacherNormal(courseID, temp);
                        addStundenPlan(temp,courseID,tid,hours,0,hours,null);
                    } else {
                        addStundenPlan(temp,courseID,0,0,0,0,null);
                    }
                } else if (track == 5) {
                    if ((temp.after(c.getCourseStartDate()) || MyDate.isEqual(temp,
                            c.getCourseStartDate()))
                            && (temp.before(c.getCourseEndDate()) || MyDate
                            .isEqual(temp, c.getCourseEndDate()))) {
                        int tid = getTeacherNormal(courseID, temp);
                        addStundenPlan(temp,courseID,tid,hours,0,hours,null);
                    } else {
                        addStundenPlan(temp,courseID,0,0,0,0,null);
                    }
                } else if (track == 6) {
                    if ((temp.after(c.getCourseStartDate()) || MyDate.isEqual(temp,
                            c.getCourseStartDate()))
                            && (temp.before(c.getCourseEndDate()) || MyDate
                            .isEqual(temp, c.getCourseEndDate()))) {
                        int tid = getTeacherNormal(courseID, temp);
                        addStundenPlan(temp,courseID,tid,hours,0,hours,null);
                    } else {
                        addStundenPlan(temp,courseID,0,0,0,0,null);
                    }
                } else if (track == 7) {
                    if ((temp.after(c.getCourseStartDate()) || MyDate.isEqual(temp,
                            c.getCourseStartDate()))
                            && (temp.before(c.getCourseEndDate()) || MyDate
                            .isEqual(temp, c.getCourseEndDate()))) {
                        int tid = getTeacherNormal(courseID, temp);
                        addStundenPlan(temp,courseID,tid,hours,0,hours,null);
                    } else {
                        addStundenPlan(temp, courseID,0,0,0,0,null);
                    }
                }
                track++;
                gc.add(Calendar.DATE, 1);
                temp = new Date(gc.getTime().getTime());
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean addStundenPlan(Date planDate,int courseID,int teacherID,int stunden,int status,int teacherStunden,String desc) {
        boolean result = false;
        Table table= TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        try {
            String q = "INSERT INTO "+table.getTableName()+" ("+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+") VALUES("
                    + replaceNull(planDate)
                    + ",'"
                    + courseID
                    + "','"
                    + teacherID
                    + "','"
                    + stunden
                    + "','" + status + "','"+teacherStunden+"',"+replaceNull(desc)+")";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public StundenPlan addTeacherInfo(StundenPlan pp) {
        StundenPlan sp = pp;
        int track = 1;
        for (int i = 0; i < 7; i++) {
            if (track == 1) {
                sp.setTeacher1Name(getName(sp.getTeacher1ID()));
            } else if (track == 2) {
                sp.setTeacher2Name(getName(sp.getTeacher2ID()));
            } else if (track == 3) {
                sp.setTeacher3Name(getName(sp.getTeacher3ID()));
            } else if (track == 4) {
                sp.setTeacher4Name(getName(sp.getTeacher4ID()));
            } else if (track == 5) {
                sp.setTeacher5Name(getName(sp.getTeacher5ID()));
            } else if (track == 6) {
                sp.setTeacher6Name(getName(sp.getTeacher6ID()));
            } else if (track == 7) {
                sp.setTeacher7Name(getName(sp.getTeacher7ID()));
            }
            track++;
        }
        return sp;
    }

    public StundenPlan addTeacherInfoForSinglePlan(StundenPlan pp) {
        StundenPlan sp = pp;
        sp.setTeacher1Name(getName(sp.getTeacher1ID()));
        return sp;
    }

    public StundenPlan getCoursePlan(int courseID, Date startDate, Date endDate) {
        StundenPlan sp = new StundenPlan();
        Table table=TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        try {
            sp.setCourseID(courseID);
            String q = "SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(1)+"='"
                    + courseID + "' AND "
                    +table.getColumn(0)+" BETWEEN "
                    + replaceNull(startDate) + " AND "
                    + replaceNull(endDate) + " ORDER BY "
                    +table.getColumn(0);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            int track = 1;
            while (rs.next()) {
                if (track == 1) {
                    sp.setDate1(rs.getDate(table.getColumn(0)));
                    sp.setCourseID(rs.getInt(table.getColumn(1)));
                    sp.setTeacher1ID(rs.getInt(table.getColumn(2)));
                    sp.setStunden1(rs.getInt(table.getColumn(3)));
                    sp.setStundenStatus1(rs.getInt(table.getColumn(4)));
                    sp.setTeacherStunden1(rs.getInt(table.getColumn(5)));
                    sp.setDescription1(rs.getString(table.getColumn(6)));
                } else if (track == 2) {
                    sp.setDate2(rs.getDate(table.getColumn(0)));
                    sp.setCourseID(rs.getInt(table.getColumn(1)));
                    sp.setTeacher2ID(rs.getInt(table.getColumn(2)));
                    sp.setStunden2(rs.getInt(table.getColumn(3)));
                    sp.setStundenStatus2(rs.getInt(table.getColumn(4)));
                    sp.setTeacherStunden2(rs.getInt(table.getColumn(5)));
                    sp.setDescription2(rs.getString(table.getColumn(6)));
                } else if (track == 3) {
                    sp.setDate3(rs.getDate(table.getColumn(0)));
                    sp.setCourseID(rs.getInt(table.getColumn(1)));
                    sp.setTeacher3ID(rs.getInt(table.getColumn(2)));
                    sp.setStunden3(rs.getInt(table.getColumn(3)));
                    sp.setStundenStatus3(rs.getInt(table.getColumn(4)));
                    sp.setTeacherStunden3(rs.getInt(table.getColumn(5)));
                    sp.setDescription3(rs.getString(table.getColumn(6)));
                } else if (track == 4) {
                    sp.setDate4(rs.getDate(table.getColumn(0)));
                    sp.setCourseID(rs.getInt(table.getColumn(1)));
                    sp.setTeacher4ID(rs.getInt(table.getColumn(2)));
                    sp.setStunden4(rs.getInt(table.getColumn(3)));
                    sp.setStundenStatus4(rs.getInt(table.getColumn(4)));
                    sp.setTeacherStunden4(rs.getInt(table.getColumn(5)));
                    sp.setDescription4(rs.getString(table.getColumn(6)));
                } else if (track == 5) {
                    sp.setDate5(rs.getDate(table.getColumn(0)));
                    sp.setCourseID(rs.getInt(table.getColumn(1)));
                    sp.setTeacher5ID(rs.getInt(table.getColumn(2)));
                    sp.setStunden5(rs.getInt(table.getColumn(3)));
                    sp.setStundenStatus5(rs.getInt(table.getColumn(4)));
                    sp.setTeacherStunden5(rs.getInt(table.getColumn(5)));
                    sp.setDescription5(rs.getString(table.getColumn(6)));
                } else if (track == 6) {
                    sp.setDate6(rs.getDate(table.getColumn(0)));
                    sp.setCourseID(rs.getInt(table.getColumn(1)));
                    sp.setTeacher6ID(rs.getInt(table.getColumn(2)));
                    sp.setStunden6(rs.getInt(table.getColumn(3)));
                    sp.setStundenStatus6(rs.getInt(table.getColumn(4)));
                    sp.setTeacherStunden6(rs.getInt(table.getColumn(5)));
                    sp.setDescription6(rs.getString(table.getColumn(6)));
                } else if (track == 7) {
                    sp.setDate7(rs.getDate(table.getColumn(0)));
                    sp.setCourseID(rs.getInt(table.getColumn(1)));
                    sp.setTeacher7ID(rs.getInt(table.getColumn(2)));
                    sp.setStunden7(rs.getInt(table.getColumn(3)));
                    sp.setStundenStatus7(rs.getInt(table.getColumn(4)));
                    sp.setTeacherStunden7(rs.getInt(table.getColumn(5)));
                    sp.setDescription7(rs.getString(table.getColumn(6)));
                }
                track++;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return addTeacherInfo(sp);
    }

    public int getTotalStundenTillDate(int courseID,Date limitDate) {
        int totalStunden=0;
        Table table=TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        try {
            String q="SELECT "+table.getColumn(0)+","+table.getColumn(3)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"+courseID+"' AND "+table.getColumn(0)+"<="+replaceNull(limitDate);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                java.sql.Date tempDate = rs.getDate(table.getColumn(0));
                double stunden = rs.getDouble(table.getColumn(3));
                if(!MyDate.isHoliday(tempDate,1)){
                    totalStunden+=stunden;
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return totalStunden;
    }

    public StundenPlan getCoursePlanForSingleDate(int courseID,Date planDate) {
        StundenPlan sp = new StundenPlan();
        Table table=TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        try {
            sp.setCourseID(courseID);
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"
                    + courseID
                    + "' AND "+table.getColumn(0)+"="+ replaceNull(planDate);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                sp.setDate1(rs.getDate(table.getColumn(0)));
                sp.setCourseID(rs.getInt(table.getColumn(1)));
                sp.setTeacher1ID(rs.getInt(table.getColumn(2)));
                sp.setStunden1(rs.getInt(table.getColumn(3)));
                sp.setStundenStatus1(rs.getInt(table.getColumn(4)));
                sp.setTeacherStunden1(rs.getInt(table.getColumn(5)));
                sp.setDescription1(rs.getString(table.getColumn(6)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return addTeacherInfoForSinglePlan(sp);
    }

    public StundenPlan getCoursePlanForWeek(int courseID, int week) {
        StundenPlan sp = new StundenPlan();
        try {
            sp = getCoursePlan(courseID, MyDate.getWeekFirstDateFuture(week,MyDate.DEUTSCH), MyDate.getWeekLastDateFuture(week,MyDate.DEUTSCH));
        } catch (Exception e) {
            setError(e.toString());
        }
        return sp;
    }

    public String getName(int userID) {
        String name = "Keine Lehrer/in";
        Table table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try{
            String q = "SELECT "+table.getColumn(1)+","+table.getColumn(2)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                    + userID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            String t1 = "";
            String t2 = "";
            while (rs.next()) {
                t1 = rs.getString(table.getColumn(1));
                t2 = rs.getString(table.getColumn(2));
            }
            if (!t1.equalsIgnoreCase("") && !t2.equalsIgnoreCase("")) {
                name = t1 + " " + t2;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return name;
    }

    public Vector<StundenLohn> getStundenLohn(Date startDate, Date endDate, int teacherID) {
        Vector<StundenLohn> v = new Vector<StundenLohn>();
        Table table=TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        Table course_table=TableManager.getTable(TableManager.RPS_COURSES);
        Table place_table=TableManager.getTable(TableManager.RPS_PLACE);
        try {
            String q = "SELECT a."+table.getColumn(0)+",a."+table.getColumn(1)+",a."+table.getColumn(2)+",a."+table.getColumn(3)+",a."+table.getColumn(5)+",b."+course_table.getColumn(1)+",c."+place_table.getColumn(1)+" FROM "+table.getTableName()+" AS a,"+course_table.getTableName()+" AS b,"+place_table.getTableName()+" AS c WHERE a."+table.getColumn(2)+"='"
                    + teacherID
                    +"' AND a."+table.getColumn(1)+"=b."+course_table.getColumn(0)+" AND b."+course_table.getColumn(6)+"=c."+place_table.getColumn(0)
                    + " AND a."+table.getColumn(0)+" BETWEEN "
                    + replaceNull(startDate)
                    + " AND " + replaceNull(endDate) + " AND a."+table.getColumn(0)+" BETWEEN b."+course_table.getColumn(3)+" AND b."+course_table.getColumn(4)+" ORDER BY a."+table.getColumn(0);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()) {
                StundenLohn sl = new StundenLohn();
                sl.setCourseID(rs.getInt(table.getColumn(1)));
                sl.setStundenDate(rs.getDate(table.getColumn(0)));
                sl.setTeacherID(rs.getInt(table.getColumn(2)));
                sl.setTeacherStunden(rs.getInt(table.getColumn(5)));
                sl.setStunden(rs.getInt(table.getColumn(3)));
                sl.setCourseName(rs.getString(course_table.getColumn(1)));
                sl.setCourseCity(rs.getString(place_table.getColumn(1)));

                java.util.Date tempDate = new java.util.Date(sl.getStundenDate().getTime());
                String dayName = tempDate.toString().substring(0, 3);
                int dayNumber = MyDate.getDayNumber(dayName,MyDate.DEUTSCH);
                dayName = MyDate.getDayName(dayNumber,MyDate.DEUTSCH);
                sl.setDay(dayName);

                v.addElement(sl);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<StundenLohn> getCourseStundenDetail(int courseID) {
        Vector<StundenLohn> v = new Vector<StundenLohn>();
        Table table=TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        Table course_table=TableManager.getTable(TableManager.RPS_COURSES);
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "SELECT a."+table.getColumn(0)+",a."+table.getColumn(1)+",a."+table.getColumn(2)+",a."+table.getColumn(3)+",a."+table.getColumn(5)+",b."+course_table.getColumn(1)+",CONCAT_WS(' ',c."+user_table.getColumn(1)+",c."+user_table.getColumn(2)+") AS TeacherName FROM "+table.getTableName()+" AS a,"+course_table.getTableName()+" AS b,"+user_table.getTableName()+" AS c WHERE a."+table.getColumn(1)+"='"
                    + courseID+"' AND a."+table.getColumn(1)+"=b."+course_table.getColumn(0)+" AND a."+table.getColumn(0)+" BETWEEN b."+course_table.getColumn(3)+" AND b."+course_table.getColumn(4)+" AND a."+table.getColumn(2)+"=c."+user_table.getColumn(0)+" ORDER BY a."+table.getColumn(0);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()) {
                StundenLohn sl = new StundenLohn();
                sl.setCourseID(rs.getInt(table.getColumn(1)));
                sl.setStundenDate(rs.getDate(table.getColumn(0)));
                sl.setTeacherID(rs.getInt(table.getColumn(2)));
                sl.setTeacherStunden(rs.getInt(table.getColumn(5)));
                sl.setStunden(rs.getInt(table.getColumn(3)));
                sl.setCourseName(rs.getString(course_table.getColumn(1)));
                sl.setCourseCity(rs.getString("TeacherName"));
                java.util.Date tempDate = new java.util.Date(sl.getStundenDate().getTime());
                String dayName = tempDate.toString().substring(0, 3);
                int dayNumber = MyDate.getDayNumber(dayName,MyDate.DEUTSCH);
                dayName = MyDate.getDayName(dayNumber,MyDate.DEUTSCH);
                sl.setDay(dayName);

                v.addElement(sl);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<StundenLohn> getIntegrationDetail(int courseID) {
        Vector<StundenLohn> v = new Vector<StundenLohn>();
        Table table=TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        Table course_table=TableManager.getTable(TableManager.RPS_COURSES);
        Table user_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        try {
            String q = "SELECT DISTINCT a."+table.getColumn(2) +",c."
                    +user_table.getColumn(1)+" AS firstName ,c."
                    +user_table.getColumn(2)+" AS lastName ,c."
                    +user_table.getColumn(24)+" AS bamfNumber ,c."
                    +user_table.getColumn(3)+" AS birthDate FROM "
                    +table.getTableName()+" AS a,"
                    +course_table.getTableName()+" AS b,"
                    +user_table.getTableName()+" AS c WHERE a."
                    +table.getColumn(1)+"='" + courseID+"' AND a."
                    +table.getColumn(1)+"=b."+course_table.getColumn(0)+" AND a."
                    +table.getColumn(0)+" BETWEEN b."+course_table.getColumn(3)+" AND b."
                    +course_table.getColumn(4)+" AND a."
                    +table.getColumn(2)+"=c."+user_table.getColumn(0)+" AND c."
                    +user_table.getColumn(24)+"!= 'null' AND c."
                    +user_table.getColumn(24)+"!= ISNULL(c."+user_table.getColumn(24)+") ORDER BY a."
                    +table.getColumn(0)+" ASC LIMIT 2";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()) {
                StundenLohn sl = new StundenLohn();
                sl.setTeacherID(rs.getInt(table.getColumn(2)));
                sl.setCourseCity(rs.getString("firstName"));
                sl.setCourseName(rs.getString("lastName"));
                sl.setDay(rs.getString("bamfNumber"));
                sl.setStundenDate(rs.getDate("birthDate"));
                v.addElement(sl);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public int getTeacherNormal(int courseID, Date planDate) {
        int teacherID = 0;
        Table table=TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        try {
            boolean loopControl = true;
            boolean hasMoreRecords = false;
            int stundenPlanStatus = ONLYFORTODAY;
            int tempTeacherID = 0;

            Calendar gc = new GregorianCalendar();
            gc.setTime(planDate);
            Date tempDate = new Date(gc.getTime().getTime());

            while (loopControl) {
                String q = "SELECT "+table.getColumn(0)+","+table.getColumn(2)+","+table.getColumn(4)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"
                        + courseID
                        + "' AND "+table.getColumn(0)+"=ADDDATE("
                        + replaceNull(tempDate) + ", INTERVAL -7 DAY)";
                ResultSet rs = DBHelper.getInstance().executeQuery(q);
                hasMoreRecords = false;
                while (rs.next()) {
                    tempDate = rs.getDate(table.getColumn(0));
                    tempTeacherID = rs.getInt(table.getColumn(2));
                    stundenPlanStatus = rs.getInt(table.getColumn(4));
                    hasMoreRecords = true;
                }

                if (!hasMoreRecords) {
                    loopControl = false;
                    break;
                }
                if (stundenPlanStatus == FOREVER) {
                    teacherID = tempTeacherID;
                    break;
                }

                gc.add(Calendar.DATE, -7);
                tempDate = new Date(gc.getTime().getTime());
                gc.setTime(tempDate);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return teacherID;
    }

    public boolean isAlreadyBusy(int tid, String time, Date d) {
        boolean result = false;
        Table course_table=TableManager.getTable(TableManager.RPS_COURSES);
        Table stunden_table=TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        try {
            String q="SELECT a."+stunden_table.getColumn(2)+" FROM "+stunden_table.getTableName()+" AS a,"+course_table.getTableName()+" AS b WHERE a."+stunden_table.getColumn(2)+"='"+tid+"' AND a."+stunden_table.getColumn(0)+"="+replaceNull(d)+" AND b."+course_table.getColumn(7)+"="+replaceNull(time)+" AND b."+course_table.getColumn(0)+"=a."+stunden_table.getColumn(1)+" AND a."+stunden_table.getColumn(0)+" BETWEEN b."+course_table.getColumn(3)+" AND b."+course_table.getColumn(4);
            int tempid = 0;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                tempid = rs.getInt(stunden_table.getColumn(2));
            }

            if (tempid > 0) {
                result = true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean isCourseExist(int courseID, int week) {
        boolean b = false;
        Table table=TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        try {
            Date tempd = MyDate.getWeekFirstDateFuture(week,MyDate.DEUTSCH);
            String q = "SELECT "+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"
                    + courseID + "' AND "+table.getColumn(0)+"=" + replaceNull(tempd);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            int temp = 0;
            while (rs.next()) {
                temp = rs.getInt(table.getColumn(1));
            }

            if (temp > 0) {
                b = true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean isCourseExist(int courseID) {
        boolean b = false;
        Table table=TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        Date tempd = MyDate.getWeekFirstDate(MyDate.DEUTSCH);
        try {
            String q = "SELECT "+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"
                    + courseID + "' AND "+table.getColumn(0)+"=" + replaceNull(tempd);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            int temp = 0;
            while (rs.next()) {
                temp = rs.getInt(table.getColumn(1));
            }

            if (temp > 0) {
                b = true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean isCourseExist(Date planDate, int courseID) {
        boolean b = false;
        Table table=TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        try {
            String q = "SELECT "+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"
                    + courseID + "' and "+table.getColumn(0)+"=" + replaceNull(planDate);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            int temp = 0;
            while (rs.next()) {
                temp = rs.getInt(table.getColumn(1));
            }

            if (temp > 0) {
                b = true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public String getConflictingDatesForTeacher(Date planDate,int teacherID,String courseTiming){
        String result = "";
        Table stundenplan_table = TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        Table course_table = TableManager.getTable(TableManager.RPS_COURSES);
        try{
            if(teacherID > 0){
                String q = "SELECT st.stdDate FROM "+stundenplan_table.getTableName()+" AS st,"+course_table.getTableName()+" AS co WHERE st."+stundenplan_table.getColumn(0)+" >= "+replaceNull(planDate)+" AND st."+stundenplan_table.getColumn(2)+" ='"+teacherID+"' AND co."+course_table.getColumn(0)+" = st."+stundenplan_table.getColumn(1)+" AND co."+course_table.getColumn(7)+" = "+replaceNull(courseTiming)+" AND st."+stundenplan_table.getColumn(0)+" BETWEEN co."+course_table.getColumn(3)+" AND co."+course_table.getColumn(4)+" ORDER By st."+stundenplan_table.getColumn(0);
                ResultSet rs = DBHelper.getInstance().executeQuery(q);
                boolean firstPositionFlag = true;
                while(rs.next()){
                    Date tempDate = rs.getDate(stundenplan_table.getColumn(0));
                    if(firstPositionFlag){
                        result = result + "'" + tempDate + "'";
                        firstPositionFlag=false;
                    }else{
                        result = result + "," + "'" + tempDate + "'";
                    }
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        if(result.equalsIgnoreCase("")){
            return null;
        }else{
            return result;
        }
    }

    public int updateStundenPlan(Date planDate, int courseID, int teacherID,int stunden, int status, int teacherStunden, String desc) {
        int b = 0;
        Table table = TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        try {
            String courseTiming = (new CourseDao()).getCourse(courseID).getCourseTiming();
            String conflictingDatesForTeacher = getConflictingDatesForTeacher(planDate, teacherID, courseTiming);
            String q = "";
            if (status == 0) {
                if(conflictingDatesForTeacher == null){
                    q = "UPDATE " + table.getTableName() + " SET "
                            + table.getColumn(2) + "='" + teacherID + "', "
                            + table.getColumn(3) + "='" + stunden + "', "
                            + table.getColumn(4) + "='" + status + "',"
                            + table.getColumn(5) + "='" + teacherStunden + "',"
                            + table.getColumn(6) + "=" + replaceNull(desc)
                            + " WHERE " + table.getColumn(0) + ">="
                            + replaceNull(planDate) + " AND " + table.getColumn(1)
                            + "='" + courseID + "' AND DAYOFWEEK("
                            + table.getColumn(0) + ")=DAYOFWEEK("
                            + replaceNull(planDate) + ")";
                }else{
                    q = "UPDATE " + table.getTableName() + " SET "
                            + table.getColumn(2) + "='" + teacherID + "', "
                            + table.getColumn(3) + "='" + stunden + "', "
                            + table.getColumn(4) + "='" + status + "',"
                            + table.getColumn(5) + "='" + teacherStunden + "',"
                            + table.getColumn(6) + "=" + replaceNull(desc)
                            + " WHERE " + table.getColumn(0) + ">="
                            + replaceNull(planDate) + " AND " + table.getColumn(1)
                            + "='" + courseID + "' AND DAYOFWEEK("
                            + table.getColumn(0) + ")=DAYOFWEEK("
                            + replaceNull(planDate) + ") AND "+table.getColumn(0)+" Not In("+conflictingDatesForTeacher+")";
                }
            } else {
                q = "UPDATE " + table.getTableName() + " SET "
                        + table.getColumn(2) + "='" + teacherID + "', "
                        + table.getColumn(3) + "='" + stunden + "', "
                        + table.getColumn(4) + "='" + status + "',"
                        + table.getColumn(5) + "='" + teacherStunden + "',"
                        + table.getColumn(6) + "=" + replaceNull(desc)
                        + " WHERE " + table.getColumn(0) + "="
                        + replaceNull(planDate) + " AND " + table.getColumn(1)
                        + "='" + courseID + "'";
            }
            DBHelper.getInstance().updateQuery(q);
            b = 1;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public int updateStundenPlanNew(Date planDate, int courseID, int teacherID,int stunden, int status, int teacherStunden, String desc) {
        int b = 0;
        Table table = TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        try {
            String courseTiming = (new CourseDao()).getCourse(courseID).getCourseTiming();
            String conflictingDatesForTeacher = getConflictingDatesForTeacher(planDate, teacherID, courseTiming);
            String q = "";
            if (status == 0) {
                if(conflictingDatesForTeacher == null){
                    q = "UPDATE " + table.getTableName() + " SET "
                            + table.getColumn(2) + "='" + teacherID + "', "
                            + table.getColumn(3) + "='" + stunden + "', "
                            + table.getColumn(4) + "='" + status + "',"
                            + table.getColumn(5) + "='" + teacherStunden + "',"
                            + table.getColumn(6) + "=" + replaceNull(desc)
                            + " WHERE " + table.getColumn(0) + ">="
                            + replaceNull(planDate) + " AND " + table.getColumn(1)
                            + "='" + courseID + "' AND WEEKDAY("
                            + table.getColumn(0) + ")=WEEKDAY("
                            + replaceNull(planDate) + ")";
                }else{
                    q = "UPDATE " + table.getTableName() + " SET "
                            + table.getColumn(2) + "='" + teacherID + "', "
                            + table.getColumn(3) + "='" + stunden + "', "
                            + table.getColumn(4) + "='" + status + "',"
                            + table.getColumn(5) + "='" + teacherStunden + "',"
                            + table.getColumn(6) + "=" + replaceNull(desc)
                            + " WHERE " + table.getColumn(0) + ">="
                            + replaceNull(planDate) + " AND " + table.getColumn(1)
                            + "='" + courseID + "' AND WEEKDAY("
                            + table.getColumn(0) + ")=WEEKDAY("
                            + replaceNull(planDate) + ") AND "+table.getColumn(0)+" Not In("+conflictingDatesForTeacher+")";
                }
            } else {
                q = "UPDATE " + table.getTableName() + " SET "
                        + table.getColumn(2) + "='" + teacherID + "', "
                        + table.getColumn(3) + "='" + stunden + "', "
                        + table.getColumn(4) + "='" + status + "',"
                        + table.getColumn(5) + "='" + teacherStunden + "',"
                        + table.getColumn(6) + "=" + replaceNull(desc)
                        + " WHERE " + table.getColumn(0) + "="
                        + replaceNull(planDate) + " AND " + table.getColumn(1)
                        + "='" + courseID + "'";
            }
            DBHelper.getInstance().updateQuery(q);
            b = 1;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public int updateTeacherInPlan(Date planDate, int courseID, int teacherID) {
        int b = 0;
        Table table=TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        try {
            String q = "";
            q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(2)+"='" + teacherID
                    + "' WHERE "+table.getColumn(0)+"=" + replaceNull(planDate) + " AND "+table.getColumn(1)+"='"
                    + courseID + "'";
            DBHelper.getInstance().updateQuery(q);
            b = 1;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean canCourseComeInPlan(Date planDate,Date courseStartDate,Date courseEndDate){
        try{
            if((planDate.after(courseStartDate)|| MyDate.isEqual(planDate,courseStartDate)) && (planDate.before(courseEndDate)||MyDate.isEqual(planDate,courseEndDate))){
                return true;
            }else{
                return false;
            }
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
    }

    public boolean canSeeStundenplan(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"5.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canWorkWithStundenplan(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"5.1.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeeStundenlohn(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"5.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean makeSureRecordExist(int stufeValue){
        boolean result=false;
        int TOTALRECORDS=250;
        Table table=TableManager.getTable(TableManager.RPS_STUNDENDETAIL);
        try{
            String q="SELECT COUNT("+table.getColumn(0)+") AS co FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"+stufeValue+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            int totalRecords=0;
            while(rs.next()){
                totalRecords=(int)rs.getInt("co");
            }
            if(totalRecords==TOTALRECORDS){
                result=true;
            }else{
                result=addStundenDetail(stufeValue);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public boolean addStundenDetail(int stufeValue){
        boolean result=false;
        int TOTALRECORDS=250;
        int track=1;
        Table table=TableManager.getTable(TableManager.RPS_STUNDENDETAIL);
        Vector<StundenDetail> stundenDetails=new Vector<StundenDetail>();
        for(int i=0;i<250;i++){
            StundenDetail stundenDetail=new StundenDetail();
            stundenDetail.setStundenValue(i+1);
            stundenDetail.setStufeValue(stufeValue);
            stundenDetails.add(stundenDetail);
        }
        for(int i=0;i<stundenDetails.size();i++){
            StundenDetail sd=(StundenDetail)stundenDetails.elementAt(i);
            try{
                String q="INSERT INTO "+table.getTableName()+" ("+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+") VALUES('"+sd.getStundenValue()+"','"+sd.getStufeValue()+"',"+replaceNull(sd.getStundenDetail())+")";
                DBHelper.getInstance().updateQuery(q);
                track++;
            }catch(Exception e){
                setError(e.toString());
            }
        }

        if(track==TOTALRECORDS){
            result=true;
        }
        return result;
    }

    public boolean updateStundenDetail(Vector<StundenDetail> stundenDetails){
        boolean result=false;
        Table table=TableManager.getTable(TableManager.RPS_STUNDENDETAIL);
        try{
            for(int i=0;i<stundenDetails.size();i++){
                StundenDetail sd=(StundenDetail)stundenDetails.elementAt(i);
                String q="UPDATE "+table.getTableName()+" SET "+table.getColumn(2)+"="+replaceNull(sd.getStundenDetail())+" WHERE "+table.getColumn(0)+"='"+sd.getStundenValue()+"' AND "+table.getColumn(1)+"='"+sd.getStufeValue()+"'";
                DBHelper.getInstance().updateQuery(q);
            }
            result=true;
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public Vector<StundenDetail> getStundenDetails(int stufeID){
        Vector<StundenDetail>  result=new Vector<StundenDetail>();
        Table table=TableManager.getTable(TableManager.RPS_STUNDENDETAIL);
        try{
            String q="SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"+stufeID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                StundenDetail stundenDetail=new StundenDetail();
                stundenDetail.setStundenValue((int)rs.getInt(table.getColumn(0)));
                stundenDetail.setStufeValue((int)rs.getInt(table.getColumn(1)));
                stundenDetail.setStundenDetail((String)rs.getString(table.getColumn(2)));
                result.add(stundenDetail);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public StundenDetail getStundenDetail(int stundenValue,int stufeValue){
        StundenDetail stundenDetail=new StundenDetail();
        Table table=TableManager.getTable(TableManager.RPS_STUNDENDETAIL);
        try{
            String q="SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+stundenValue+"' AND "+table.getColumn(1)+"='"+stufeValue+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                stundenDetail.setStundenValue((int)rs.getInt(table.getColumn(0)));
                stundenDetail.setStufeValue((int)rs.getInt(table.getColumn(1)));
                stundenDetail.setStundenDetail((String)rs.getString(table.getColumn(2)));
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return stundenDetail;
    }

    public boolean canWorkWithStundenDetails(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"5.3");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    /* Methods Related To Every Method */

    public static void main(String args[]) {
        StundDao sdb=new StundDao();
        sdb.getCourseStundenDetail(184);
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

    /* End Methods Related To Every Method */

    //Instance Variables
    private String error;
    public static final int FOREVER = 0;
    public static final int ONLYFORTODAY = 1;
}
