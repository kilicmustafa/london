package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.*;

import java.sql.Date;
import java.sql.ResultSet;
import java.util.Vector;


public class LohnReportDao {

    public SchoolLohnReport getSchoolReportTeacherWise(int schoolID, Date upperDate, Date lowerDate){
        Vector<TeacherLohnReport> teacherReportsTemp = new Vector<TeacherLohnReport>();
        Vector<TeacherLohnReport> teacherReports = new Vector<TeacherLohnReport>();
        SchoolLohnReport schoolReport = new SchoolLohnReport();
        schoolReport.setUpperDate(upperDate);
        schoolReport.setLowerDate(lowerDate);
        selectTeachersForReport(schoolID,schoolReport);

        teacherReportsTemp = schoolReport.getTeacherReports();
        for(int i=0;i<teacherReportsTemp.size();i++){
            TeacherLohnReport teacherLohnReport=(TeacherLohnReport)teacherReportsTemp.elementAt(i);
            getTeacherNormalReport(schoolReport,teacherLohnReport);
            getTeacherPrivateReport(schoolReport,teacherLohnReport);
            if((teacherLohnReport.getTotalHoursWorkedNormal()!=0) || (teacherLohnReport.getTotalHoursWorkedPrivate()!=0)){
                teacherReports.addElement(teacherLohnReport);
            }
        }
        schoolReport.setTeacherReports(teacherReports);

        return schoolReport;
    }

    private void getTeacherNormalReport(SchoolLohnReport schoolReport,TeacherLohnReport teacherLohnReport){
        Table course_table = TableManager.getTable(TableManager.RPS_COURSES);
        Table stundenplan_table = TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        Table lohn_table = TableManager.getTable(TableManager.RPS_GROUPLOHN);
        try{
            String q1 = "";
            String q2 = "";
            if(schoolReport.getSchoolID()==0){
                //All Schools
                q1 = "SELECT sum(st."+stundenplan_table.getColumn(5)+") AS TotalHoursWorked FROM "+stundenplan_table.getTableName()+" AS st,"+course_table.getTableName()+" AS co WHERE st."+stundenplan_table.getColumn(2)+"='"+teacherLohnReport.getTeacherID()+"' AND st."+stundenplan_table.getColumn(0)+" BETWEEN "+replaceNull(schoolReport.getUpperDate())+" AND "+replaceNull(schoolReport.getLowerDate())+" AND co."+course_table.getColumn(0)+"=st."+stundenplan_table.getColumn(1)+" AND st."+stundenplan_table.getColumn(0)+" BETWEEN co."+course_table.getColumn(3)+" AND co."+course_table.getColumn(4);
                q2 = "SELECT sum(st."+stundenplan_table.getColumn(5)+"*lo."+lohn_table.getColumn(3)+") AS TotalLohn FROM "+stundenplan_table.getTableName()+" AS st,"+course_table.getTableName()+" AS co,"+lohn_table.getTableName()+" AS lo WHERE st."+stundenplan_table.getColumn(2)+"='"+teacherLohnReport.getTeacherID()+"' AND st."+stundenplan_table.getColumn(0)+" BETWEEN "+replaceNull(schoolReport.getUpperDate())+" AND "+replaceNull(schoolReport.getLowerDate())+" AND co."+course_table.getColumn(0)+"=st."+stundenplan_table.getColumn(1)+" AND st."+stundenplan_table.getColumn(0)+" BETWEEN co."+course_table.getColumn(3)+" AND co."+course_table.getColumn(4)+"  AND lo."+lohn_table.getColumn(0)+" = st."+stundenplan_table.getColumn(2)+" AND st."+stundenplan_table.getColumn(0)+" >= lo."+lohn_table.getColumn(1)+" AND (st."+stundenplan_table.getColumn(0)+" <= lo."+lohn_table.getColumn(2)+" OR lo."+lohn_table.getColumn(2)+" IS NULL)";
            }else{
                //Specific School
                q1 = "SELECT sum(st."+stundenplan_table.getColumn(5)+") AS TotalHoursWorked FROM "+stundenplan_table.getTableName()+" AS st,"+course_table.getTableName()+" AS co WHERE st."+stundenplan_table.getColumn(2)+"='"+teacherLohnReport.getTeacherID()+"' AND st."+stundenplan_table.getColumn(0)+" BETWEEN "+replaceNull(schoolReport.getUpperDate())+" AND "+replaceNull(schoolReport.getLowerDate())+" AND co."+course_table.getColumn(0)+"=st."+stundenplan_table.getColumn(1)+" AND co."+course_table.getColumn(6)+"='"+schoolReport.getSchoolID()+"' AND st."+stundenplan_table.getColumn(0)+" BETWEEN co."+course_table.getColumn(3)+" AND co."+course_table.getColumn(4);
                q2 = "SELECT sum(st."+stundenplan_table.getColumn(5)+"*lo."+lohn_table.getColumn(3)+") AS TotalLohn FROM "+stundenplan_table.getTableName()+" AS st,"+course_table.getTableName()+" AS co,"+lohn_table.getTableName()+" AS lo WHERE st."+stundenplan_table.getColumn(2)+"='"+teacherLohnReport.getTeacherID()+"' AND st."+stundenplan_table.getColumn(0)+" BETWEEN "+replaceNull(schoolReport.getUpperDate())+" AND "+replaceNull(schoolReport.getLowerDate())+" AND co."+course_table.getColumn(0)+"=st."+stundenplan_table.getColumn(1)+" AND co."+course_table.getColumn(6)+"='"+schoolReport.getSchoolID()+"' AND st."+stundenplan_table.getColumn(0)+" BETWEEN co."+course_table.getColumn(3)+" AND co."+course_table.getColumn(4)+" AND lo."+lohn_table.getColumn(0)+" = st."+stundenplan_table.getColumn(2)+" AND st."+stundenplan_table.getColumn(0)+" >= lo."+lohn_table.getColumn(1)+" AND (st."+stundenplan_table.getColumn(0)+" <= lo."+lohn_table.getColumn(2)+" OR lo."+lohn_table.getColumn(2)+" IS NULL)";
            }
            ResultSet rs1 = DBHelper.getInstance().executeQuery(q1);
            while(rs1.next()){
                teacherLohnReport.setTotalHoursWorkedNormal(rs1.getInt("TotalHoursWorked"));
            }

            ResultSet rs2 = DBHelper.getInstance().executeQuery(q2);
            while(rs2.next()){
                teacherLohnReport.setAmountPayable(teacherLohnReport.getAmountPayable()+rs2.getDouble("TotalLohn"));
            }
        }catch(Exception e){
            setError(e.toString());
        }
    }

    private void getTeacherPrivateReport(SchoolLohnReport schoolReport,TeacherLohnReport teacherLohnReport){
        Table singleclass_table = TableManager.getTable(TableManager.RPS_EUNTERRICHT);
        Table lohn_table = TableManager.getTable(TableManager.RPS_PRIVATELOHN);
        try{
            String q1 = "";
            String q2 = "";
            if(schoolReport.getSchoolID()==0){
                //All Schools
                q1 = "SELECT sum(eu."+singleclass_table.getColumn(5)+") AS TotalHoursWorked FROM "+singleclass_table.getTableName()+" AS eu WHERE eu."+singleclass_table.getColumn(4)+" BETWEEN "+replaceNull(schoolReport.getUpperDate())+" AND "+replaceNull(schoolReport.getLowerDate())+" AND eu."+singleclass_table.getColumn(3)+"='"+teacherLohnReport.getTeacherID()+"'";
                q2 = "SELECT sum(eu."+singleclass_table.getColumn(5)+"*lo."+lohn_table.getColumn(3)+") AS TotalLohn FROM "+singleclass_table.getTableName()+" AS eu,"+lohn_table.getTableName()+" AS lo WHERE eu."+singleclass_table.getColumn(4)+" BETWEEN "+replaceNull(schoolReport.getUpperDate())+" AND "+replaceNull(schoolReport.getLowerDate())+" AND eu."+singleclass_table.getColumn(3)+"='"+teacherLohnReport.getTeacherID()+"' AND lo."+lohn_table.getColumn(0)+"=eu."+singleclass_table.getColumn(3)+" AND eu."+singleclass_table.getColumn(4)+" >= lo."+lohn_table.getColumn(1)+" AND (eu."+singleclass_table.getColumn(4)+" <= lo."+lohn_table.getColumn(2)+" OR lo."+lohn_table.getColumn(2)+" IS NULL)";
            }else{
                //Specific School
                q1 = "SELECT sum(eu."+singleclass_table.getColumn(5)+") AS TotalHoursWorked FROM "+singleclass_table.getTableName()+" AS eu WHERE eu."+singleclass_table.getColumn(4)+" BETWEEN "+replaceNull(schoolReport.getUpperDate())+" AND "+replaceNull(schoolReport.getLowerDate())+" AND eu."+singleclass_table.getColumn(7)+"='"+schoolReport.getSchoolID()+"' AND eu."+singleclass_table.getColumn(3)+"='"+teacherLohnReport.getTeacherID()+"'";
                q2 = "SELECT sum(eu."+singleclass_table.getColumn(5)+"*lo."+lohn_table.getColumn(3)+") AS TotalLohn FROM "+singleclass_table.getTableName()+" AS eu,"+lohn_table.getTableName()+" AS lo WHERE eu."+singleclass_table.getColumn(4)+" BETWEEN "+replaceNull(schoolReport.getUpperDate())+" AND "+replaceNull(schoolReport.getLowerDate())+" AND eu."+singleclass_table.getColumn(7)+"='"+schoolReport.getSchoolID()+"' AND eu."+singleclass_table.getColumn(3)+"='"+teacherLohnReport.getTeacherID()+"' AND lo."+lohn_table.getColumn(0)+"=eu."+singleclass_table.getColumn(3)+" AND eu."+singleclass_table.getColumn(4)+" >= lo."+lohn_table.getColumn(1)+" AND (eu."+singleclass_table.getColumn(4)+" <= lo."+lohn_table.getColumn(2)+" OR lo."+lohn_table.getColumn(2)+" IS NULL)";
            }
            ResultSet rs1 = DBHelper.getInstance().executeQuery(q1);
            while(rs1.next()){
                teacherLohnReport.setTotalHoursWorkedPrivate(rs1.getInt("TotalHoursWorked"));
            }

            ResultSet rs2 = DBHelper.getInstance().executeQuery(q2);
            while(rs2.next()){
                teacherLohnReport.setAmountPayable(teacherLohnReport.getAmountPayable()+rs2.getDouble("TotalLohn"));
            }
        }catch(Exception e){
            setError(e.toString());
        }
    }

    private void selectTeachersForReport(int schoolID,SchoolLohnReport schoolReport){
        Table teacher_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        Table teacherplaces_table=TableManager.getTable(TableManager.RPS_SYSTEMUSERPLACES);
        Vector<TeacherLohnReport> teacherReports = new Vector<TeacherLohnReport>();
        try{
            String q="";
            if(schoolID==0){
                //All Schools
                schoolReport.setSchoolID(schoolID);
                schoolReport.setSchoolName("Alle Schulen");
                q="SELECT u."+teacher_table.getColumn(0)+" AS TeacherID,CONCAT_WS(' ',u."+teacher_table.getColumn(1)+",u."+teacher_table.getColumn(2)+") AS TeacherName,u."+teacher_table.getColumn(22)+" AS LohnPerHour FROM "+teacher_table.getTableName()+" AS u WHERE u."+teacher_table.getColumn(18)+"='4' ORDER BY u."+teacher_table.getColumn(1);
            }else{
                //Specific School
                Place place=(new PlaceDao()).getPlace(schoolID);
                schoolReport.setSchoolID(schoolID);
                schoolReport.setSchoolName(place.getPlaceName());
                q="SELECT u."+teacher_table.getColumn(0)+" AS TeacherID,CONCAT_WS(' ',u."+teacher_table.getColumn(1)+",u."+teacher_table.getColumn(2)+") AS TeacherName,u."+teacher_table.getColumn(22)+" AS LohnPerHour FROM "+teacher_table.getTableName()+" AS u,"+teacherplaces_table.getTableName()+" AS up WHERE u."+teacher_table.getColumn(18)+"='4' AND u."+teacher_table.getColumn(0)+" = up."+teacherplaces_table.getColumn(0)+" AND up."+teacherplaces_table.getColumn(1)+"='"+schoolID+"' ORDER BY u."+teacher_table.getColumn(1);
            }
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                TeacherLohnReport teacherReport=new TeacherLohnReport();
                teacherReport.setTeacherID(rs.getInt("TeacherID"));
                teacherReport.setTeacherName(rs.getString("TeacherName"));
                teacherReport.setLohnPerHour(rs.getDouble("LohnPerHour"));
                teacherReport.setTotalHoursWorkedNormal(0);
                teacherReport.setTotalHoursWorkedPrivate(0);
                teacherReport.setAmountPayable(0);
                teacherReports.addElement(teacherReport);
            }
            schoolReport.setTeacherReports(teacherReports);
        }catch(Exception e){
            setError(e.toString());
        }
    }

    public SchoolLohnReport getSchoolReportCourseWise(int schoolID,Date upperDate,Date lowerDate){
        SchoolLohnReport schoolReport = new SchoolLohnReport();
        schoolReport.setUpperDate(upperDate);
        schoolReport.setLowerDate(lowerDate);
        Vector<CourseLohnReport> courseReports = new Vector<CourseLohnReport>();
        Table course_table = TableManager.getTable(TableManager.RPS_COURSES);
        Table stundenplan_table = TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        Table place_table = TableManager.getTable(TableManager.RPS_PLACE);
        try{
            String q = "";
            if(schoolID==0){
                //All Schools
                schoolReport.setSchoolID(schoolID);
                schoolReport.setSchoolName("Alle Schulen");
                q = "SELECT st."+stundenplan_table.getColumn(1)+" AS CourseID,co."+course_table.getColumn(1)+" AS CourseName,sum(st."+stundenplan_table.getColumn(5)+") AS TotalHoursWorked,p."+place_table.getColumn(1)+" AS CoursePlace FROM "+stundenplan_table.getTableName()+" AS st,"+course_table.getTableName()+" AS co,"+place_table.getTableName()+" AS p WHERE st."+stundenplan_table.getColumn(0)+" BETWEEN "+replaceNull(upperDate)+" AND "+replaceNull(lowerDate)+" AND st."+stundenplan_table.getColumn(2)+">0 AND co."+course_table.getColumn(0)+"=st."+stundenplan_table.getColumn(1)+" AND st."+stundenplan_table.getColumn(0)+" BETWEEN co."+course_table.getColumn(3)+" AND co."+course_table.getColumn(4)+" AND co."+course_table.getColumn(6)+"=p."+place_table.getColumn(0)+" GROUP BY st."+stundenplan_table.getColumn(1)+" ORDER BY co."+course_table.getColumn(1);
            }else{
                //Specific School
                Place place=(new PlaceDao()).getPlace(schoolID);
                schoolReport.setSchoolID(schoolID);
                schoolReport.setSchoolName(place.getPlaceName());
                q = "SELECT st."+stundenplan_table.getColumn(1)+" AS CourseID,co."+course_table.getColumn(1)+" AS CourseName,sum(st."+stundenplan_table.getColumn(5)+") AS TotalHoursWorked,p."+place_table.getColumn(1)+" AS CoursePlace FROM "+stundenplan_table.getTableName()+" AS st,"+course_table.getTableName()+" AS co,"+place_table.getTableName()+" AS p WHERE st."+stundenplan_table.getColumn(0)+" BETWEEN "+replaceNull(upperDate)+" AND "+replaceNull(lowerDate)+" AND st."+stundenplan_table.getColumn(2)+">0 AND co."+course_table.getColumn(0)+"=st."+stundenplan_table.getColumn(1)+" AND co."+course_table.getColumn(6)+"='"+schoolID+"' AND st."+stundenplan_table.getColumn(0)+" BETWEEN co."+course_table.getColumn(3)+" AND co."+course_table.getColumn(4)+" AND co."+course_table.getColumn(6)+"=p."+place_table.getColumn(0)+" GROUP BY st."+stundenplan_table.getColumn(1)+" ORDER BY co."+course_table.getColumn(1);
            }

            ResultSet rs1 = DBHelper.getInstance().executeQuery(q);
            while(rs1.next()){
                CourseLohnReport courseReport=new CourseLohnReport();
                courseReport.setCourseID(rs1.getInt("CourseID"));
                courseReport.setCourseName(rs1.getString("CourseName"));
                courseReport.setCoursePlace(rs1.getString("CoursePlace"));
                courseReport.setTotalHoursWorkedNormal(rs1.getInt("TotalHoursWorked"));
                courseReports.addElement(courseReport);
            }

            for(int i = 0; i < courseReports.size(); i++){
                CourseLohnReport courseLohnReport = (CourseLohnReport)courseReports.elementAt(i);
                courseLohnReport.setAmountPayable(getGroupCourseTotalAmountPayable(courseLohnReport.getCourseID(), upperDate, lowerDate));
            }

            for(int track = 0;track < courseReports.size();track++){
                CourseLohnReport courseLohnReport=(CourseLohnReport)courseReports.elementAt(track);
                courseLohnReport.setTotalHoursWorkedForCourse(getTotalCourseStundenCompletede(courseLohnReport.getCourseID(), upperDate, lowerDate));
                courseLohnReport.setTeacherLohnReport(this.getCourseReportTeacherWise(courseLohnReport.getCourseID(),upperDate,lowerDate));
            }
            schoolReport.setCourseReports(courseReports);
        }catch(Exception e){
            setError(e.toString());
        }
        return schoolReport;
    }

    private double getGroupCourseTotalAmountPayable(int courseID,Date upperDate,Date lowerDate){
        Table course_table = TableManager.getTable(TableManager.RPS_COURSES);
        Table lohn_table = TableManager.getTable(TableManager.RPS_GROUPLOHN);
        Table stundenplan_table = TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        double amount = 0;
        try{
            String q = "SELECT sum(st."+stundenplan_table.getColumn(5)+"*lo."+lohn_table.getColumn(3)+") AS AmountPayable FROM "+stundenplan_table.getTableName()+" AS st,"+course_table.getTableName()+" AS co,"+lohn_table.getTableName()+" AS lo WHERE st."+stundenplan_table.getColumn(0)+" BETWEEN "+replaceNull(upperDate)+" AND "+replaceNull(lowerDate)+" AND st."+stundenplan_table.getColumn(2)+" > 0 AND co."+course_table.getColumn(0)+"=st."+stundenplan_table.getColumn(1)+" AND st."+stundenplan_table.getColumn(2)+"=lo."+lohn_table.getColumn(0)+" AND st."+stundenplan_table.getColumn(0)+" BETWEEN co."+course_table.getColumn(3)+" AND co."+course_table.getColumn(4)+" AND co."+course_table.getColumn(0)+"='"+courseID+"' AND st."+stundenplan_table.getColumn(0)+" >= lo."+lohn_table.getColumn(1)+" AND (st."+stundenplan_table.getColumn(0)+" <= lo."+lohn_table.getColumn(2)+" OR "+lohn_table.getColumn(2)+" IS NULL)";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                amount = rs.getDouble("AmountPayable");
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return amount;
    }

    private Vector<TeacherLohnReport> getCourseReportTeacherWise(int courseID,Date upperDate,Date lowerDate){
        Vector<TeacherLohnReport> teacherReports = new Vector<TeacherLohnReport>();
        Table course_table = TableManager.getTable(TableManager.RPS_COURSES);
        Table teacher_table = TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        Table lohn_table = TableManager.getTable(TableManager.RPS_GROUPLOHN);
        Table stundenplan_table = TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        try{
            String q="SELECT st."+stundenplan_table.getColumn(2)+" AS TeacherID,CONCAT_WS(' ',su."+teacher_table.getColumn(1)+",su."+teacher_table.getColumn(2)+") AS TeacherName,lo."+lohn_table.getColumn(3)+" AS LohnPerHour,sum(st."+stundenplan_table.getColumn(5)+") AS TotalHoursWorked,sum(st."+stundenplan_table.getColumn(5)+"*lo."+lohn_table.getColumn(3)+") AS AmountPayable FROM "+stundenplan_table.getTableName()+" AS st,"+course_table.getTableName()+" AS co,"+teacher_table.getTableName()+" AS su,"+lohn_table.getTableName()+" AS lo WHERE st."+stundenplan_table.getColumn(0)+" BETWEEN "+replaceNull(upperDate)+" AND "+replaceNull(lowerDate)+" AND st."+stundenplan_table.getColumn(2)+">0 AND co."+course_table.getColumn(0)+"=st."+stundenplan_table.getColumn(1)+" AND st."+stundenplan_table.getColumn(0)+" BETWEEN co."+course_table.getColumn(3)+" AND co."+course_table.getColumn(4)+" AND st."+stundenplan_table.getColumn(2)+"=su."+teacher_table.getColumn(0)+" AND st."+stundenplan_table.getColumn(1)+"='"+courseID+"' AND st."+stundenplan_table.getColumn(2)+"=lo."+lohn_table.getColumn(0)+" AND st."+stundenplan_table.getColumn(0)+" >= lo."+lohn_table.getColumn(1)+" AND (st."+stundenplan_table.getColumn(0)+" <= lo."+lohn_table.getColumn(2)+" OR lo."+lohn_table.getColumn(2)+" IS NULL) GROUP BY st."+stundenplan_table.getColumn(2)+" ORDER BY su."+teacher_table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                TeacherLohnReport teacherReport=new TeacherLohnReport();
                teacherReport.setTeacherID(rs.getInt("TeacherID"));
                teacherReport.setTeacherName(rs.getString("TeacherName"));
                teacherReport.setLohnPerHour(rs.getDouble("LohnPerHour"));
                teacherReport.setTotalHoursWorkedNormal(rs.getInt("TotalHoursWorked"));
                teacherReport.setAmountPayable(rs.getDouble("AmountPayable"));
                teacherReports.addElement(teacherReport);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return teacherReports;
    }

    public int getTotalCourseStundenCompletede(int courseID,Date startDate,Date lastDate) {
        int totalStunden=0;
        Table table=TableManager.getTable(TableManager.RPS_STUNDENPLAN);
        try {
            String q="SELECT "+table.getColumn(0)+","+table.getColumn(3)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"+courseID+"' AND "+table.getColumn(0)+" BETWEEN "+replaceNull(startDate)+" AND "+replaceNull(lastDate);
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

    public boolean canSeeLohnRechnung(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"3.4");
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

    private Object replaceNull(Object o) {
        if (o == null) {
            return null;
        } else {
            return "'" + o + "'";
        }
    }

    //Instance Variables
    private String error;
}
