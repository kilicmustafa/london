package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.*;

import java.sql.*;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Vector;

public class InventorDao {

    public Vector<InventorCategory> combineCategories(Date firstDate, Date lastDate){
        Vector<InventorCategory> combinedCategories = new Vector<InventorCategory>();
        String indent="";
        Vector<InventorCategory> catList = this.getAllInventorCategories(0);
        for(int i=0;i<catList.size();i++){
            InventorCategory category = (InventorCategory)catList.elementAt(i);
            traverseCategories(category,indent,combinedCategories,firstDate,lastDate);
            combinedCategories.add(new InventorCategory());
        }
        return combinedCategories;
    }

    private void traverseCategories(InventorCategory category,String indent,Vector<InventorCategory> combinedCategories,Date firstDate,Date lastDate){
        try{
            if(this.isInventorCategoryDirectory(category.getInventorID())){
                category.setIndentation(indent);
                combinedCategories.add(category);
                Vector<InventorCategory> catList = this.getAllInventorCategories(category.getInventorID());
                for(int i=0;i<catList.size();i++){
                    InventorCategory subCategory = (InventorCategory)catList.elementAt(i);
                    String currentIndent="--------"+indent;
                    traverseCategories(subCategory,currentIndent,combinedCategories,firstDate,lastDate);
                }
            }else{
                category.setIndentation(indent);
                if(isInventorCategoryValid(category,firstDate,lastDate)){
                    combinedCategories.add(category);
                }
            }

        }catch(Exception e){
            setError(e.toString());
        }
    }

    public boolean addInventorCategory(InventorCategory category) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_INVENTORCATEGORY);
        try {
            String q = "INSERT INTO " + table.getTableName() + "("
                    + table.getColumn(1) + ","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+")VALUES("+ replaceNull(category.getInventorName())+",'"+category.getInventorPaymentType()+"',"+replaceNull(category.getInventorStartDate())+","+replaceNull(category.getInventorEndDate())+",'"+category.getInventorAmount()+"','"+category.getInventorParent()+"')";
            DBHelper.getInstance().updateQuery(q);
            q = "select LAST_INSERT_ID() as id";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            int newInventorCategoryID = 0;
            while (rs.next()) {
                newInventorCategoryID = rs.getInt("id");
            }
            if (newInventorCategoryID > 0) {
                addPlacesToInventorCategory(newInventorCategoryID,category.getSchoolID());
            }
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean addPlacesToInventorCategory(int inventorCategoryID,Vector<Integer> places) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_INVENTORCATEGORYCITY);
        try {
            for(int i=0;i<places.size();i++){
                int placeID=((Integer)places.elementAt(i)).intValue();
                String q = "INSERT INTO " + table.getTableName() + "("
                        + table.getColumn(0) + ","+table.getColumn(1)+")VALUES('"+inventorCategoryID+"','"+placeID+"')";
                DBHelper.getInstance().updateQuery(q);
            }
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deletePlacesToInventorCategory(int inventorCategoryID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_INVENTORCATEGORYCITY);
        try {
            String q = "DELETE FROM " + table.getTableName()+ " WHERE "+table.getColumn(0)+"='"+inventorCategoryID+"'";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteInventorCategory(int inventorCategoryID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_INVENTORCATEGORY);
        try {
            String q = "DELETE FROM " + table.getTableName() + " WHERE "
                    + table.getColumn(0) + "='" + inventorCategoryID + "'";
            DBHelper.getInstance().updateQuery(q);
            deletePlacesToInventorCategory(inventorCategoryID);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public InventorCategory getInventorCategory(int inventorCategoryID) {
        InventorCategory inventorCategory = new InventorCategory();
        Table table = TableManager.getTable(TableManager.RPS_INVENTORCATEGORY);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + ","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+" FROM "
                    + table.getTableName() + " WHERE " + table.getColumn(0)
                    + "='" + inventorCategoryID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                inventorCategory.setInventorID(rs.getInt(table.getColumn(0)));
                inventorCategory.setInventorName(rs.getString(table.getColumn(1)));
                inventorCategory.setInventorPaymentType(rs.getInt(table.getColumn(2)));
                inventorCategory.setInventorStartDate(rs.getDate(table.getColumn(3)));
                inventorCategory.setInventorEndDate(rs.getDate(table.getColumn(4)));
                inventorCategory.setInventorAmount(rs.getDouble(table.getColumn(5)));
                inventorCategory.setInventorParent(rs.getInt(table.getColumn(6)));
            }
            inventorCategory.setSchoolID(getInventorCategoryPlaces(inventorCategory.getInventorID()));
        } catch (Exception e) {
            setError(e.toString());
        }
        return inventorCategory;
    }

    public Vector<Integer> getInventorCategoryPlaces(int inventorCategoryID) {
        Vector<Integer> places = new Vector<Integer>();
        Table table = TableManager.getTable(TableManager.RPS_INVENTORCATEGORYCITY);
        try {
            String q = "SELECT " + table.getColumn(1)+" FROM "
                    + table.getTableName() + " WHERE " + table.getColumn(0)
                    + "='" + inventorCategoryID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                places.addElement(rs.getInt(table.getColumn(1)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return places;
    }

    public Vector<InventorCategory> getAllInventorCategories(int inventorParent) {
        Vector<InventorCategory> inventorCategories = new Vector<InventorCategory>();
        Table table = TableManager.getTable(TableManager.RPS_INVENTORCATEGORY);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) +","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+" FROM "
                    + table.getTableName() + " WHERE "+table.getColumn(6)+"='"+inventorParent+"' ORDER BY " + table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                InventorCategory inventorCategory = new InventorCategory();
                inventorCategory.setInventorID(rs.getInt(table.getColumn(0)));
                inventorCategory.setInventorName(rs.getString(table.getColumn(1)));
                inventorCategory.setInventorPaymentType(rs.getInt(table.getColumn(2)));
                inventorCategory.setInventorStartDate(rs.getDate(table.getColumn(3)));
                inventorCategory.setInventorEndDate(rs.getDate(table.getColumn(4)));
                inventorCategory.setInventorAmount(rs.getDouble(table.getColumn(5)));
                inventorCategory.setInventorParent(rs.getInt(table.getColumn(6)));
                inventorCategories.add(inventorCategory);
            }
            for(int i=0;i<inventorCategories.size();i++){
                InventorCategory tempInventorCategory = (InventorCategory)inventorCategories.elementAt(i);
                tempInventorCategory.setSchoolID(getInventorCategoryPlaces(tempInventorCategory.getInventorID()));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return inventorCategories;
    }

    public boolean isInventorCategoryDirectory(int inventorCategoryID) {
        boolean result=false;
        int count=0;
        Table table = TableManager.getTable(TableManager.RPS_INVENTORCATEGORY);
        try {
            String q = "SELECT count(*) AS InventorCount FROM "
                    + table.getTableName() + " WHERE "+table.getColumn(6)+"='"+inventorCategoryID+"'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                count=rs.getInt("InventorCount");
            }
            if(count>0){
                result=true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean updateInventorCategory(InventorCategory inventorCategory) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_INVENTORCATEGORY);
        try {
            String q = "UPDATE " + table.getTableName() + " SET "
                    + table.getColumn(1) + "="
                    + replaceNull(inventorCategory.getInventorName()) + ","+table.getColumn(2)+"='"+inventorCategory.getInventorPaymentType()+"',"+table.getColumn(3)+"="+replaceNull(inventorCategory.getInventorStartDate())+","+table.getColumn(4)+"="+replaceNull(inventorCategory.getInventorEndDate())+","+table.getColumn(5)+"='"+inventorCategory.getInventorAmount()+"',"+table.getColumn(6)+"='"+inventorCategory.getInventorParent()+"' WHERE "
                    + table.getColumn(0) + "='" + inventorCategory.getInventorID() + "'";
            DBHelper.getInstance().updateQuery(q);
            deletePlacesToInventorCategory(inventorCategory.getInventorID());
            addPlacesToInventorCategory(inventorCategory.getInventorID(),inventorCategory.getSchoolID());
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean isInventorCategoryValid(InventorCategory category,Date firstDate,Date lastDate){
        boolean flag = false;
        try{
            boolean firstFlag = false;
            boolean lastFlag = false;
            if(category.getInventorEndDate() == null){
                firstFlag = (MyDate.isEqual(firstDate,category.getInventorStartDate()) || firstDate.after(category.getInventorStartDate())) && (true || true);
                lastFlag = (MyDate.isEqual(lastDate,category.getInventorStartDate()) || lastDate.after(category.getInventorStartDate())) && (true || true);
            }else{
                firstFlag = (MyDate.isEqual(firstDate,category.getInventorStartDate()) || firstDate.after(category.getInventorStartDate())) && (MyDate.isEqual(firstDate,category.getInventorEndDate()) || firstDate.before(category.getInventorEndDate()));
                lastFlag = (MyDate.isEqual(lastDate,category.getInventorStartDate()) || lastDate.after(category.getInventorStartDate())) && (MyDate.isEqual(lastDate,category.getInventorEndDate()) || lastDate.before(category.getInventorEndDate()));
            }
            if(firstFlag || lastFlag){
                flag = true;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return flag;
    }

    public int countDaysWithSupposition(InventorCategory category,Date firstDate,Date lastDate,int supposeMonthDays){
        int days = 0;
        try{
            boolean flag = true;
            boolean flagControl = false;
            int leapYearCheck = 0;

            Calendar calendar = new GregorianCalendar();
            calendar.setTime(firstDate);
            Date conditionDate = new Date(calendar.getTime().getTime());
            int windCurrent = Integer.parseInt(MyDate.getDay(conditionDate));
            int februaryCount = 0;
            while(flag){
                if(windCurrent <= 30){
                    if(Integer.parseInt(MyDate.getMonth(conditionDate)) == 2){
                        februaryCount++;
                        if(leapYearCheck == 0){
                            leapYearCheck =Integer.parseInt(MyDate.getYear(conditionDate));
                        }
                    }
                    //days++;
                    //Valid Dates//
                    boolean dateValidityFlag = false;
                    if(category.getInventorEndDate() == null){
                        dateValidityFlag = (MyDate.isEqual(conditionDate,category.getInventorStartDate()) || conditionDate.after(category.getInventorStartDate())) && (true|| true);
                    }else{
                        dateValidityFlag = (MyDate.isEqual(conditionDate,category.getInventorStartDate()) || conditionDate.after(category.getInventorStartDate())) && (MyDate.isEqual(conditionDate,category.getInventorEndDate()) || conditionDate.before(category.getInventorEndDate()));
                    }

                    if(dateValidityFlag){
                        days++;
                    }
                }
                calendar.add(Calendar.DATE,1);
                conditionDate = new Date(calendar.getTime().getTime());
                windCurrent = Integer.parseInt(MyDate.getDay(conditionDate));
                if(flagControl){
                    flag = false;
                }
                calendar.add(Calendar.DATE,-1);
                Date sameDateCase = new Date(calendar.getTime().getTime());
                calendar.add(Calendar.DATE,1);
                if(MyDate.isEqual(sameDateCase,lastDate)){
                    break;
                }
                if(MyDate.isEqual(conditionDate,lastDate)){
                    flagControl = true;
                }
            }
            if(februaryCount == 28){
                if(!MyDate.isLeapYear(leapYearCheck)){
                    days++;
                    days++;
                }
            }else if(februaryCount == 29){
                days++;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return days;
    }

    public double paymentToTeachers(int schoolID,Date firstDate,Date lastDate){
        double result = 0;
        try{
            LohnReportDao lrDB = new LohnReportDao();
            SchoolLohnReport report = lrDB.getSchoolReportTeacherWise(schoolID,firstDate,lastDate);
            Vector<TeacherLohnReport> teacherReport = report.getTeacherReports();
            for(int i=0;i<teacherReport.size();i++){
                TeacherLohnReport tempReport = (TeacherLohnReport)teacherReport.elementAt(i);
                result += tempReport.getAmountPayable();
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public double incomeOfSchool(int schoolID,Date firstDate,Date lastDate){
        double result = 0;
        CourseDao courseDB = new CourseDao();
        LohnReportDao lrDB = new LohnReportDao();
        try{
            SchoolLohnReport report = lrDB.getSchoolReportCourseWise(schoolID,firstDate,lastDate);
            for(int i=0;i<report.getCourseReports().size();i++){
                CourseLohnReport courseLohnReport=(CourseLohnReport)report.getCourseReports().elementAt(i);
                double income = courseDB.getTotalAngenomen(courseLohnReport.getCourseID());
                double totalHours = courseDB.getCourseTotalHours(courseLohnReport.getCourseID());
                double hoursCompleted = courseLohnReport.getTotalHoursWorkedForCourse();

                Course tempCourse = courseDB.getCourse(courseLohnReport.getCourseID());
                if(hoursCompleted > totalHours || firstDate.after(tempCourse.getCourseEndDate())){
                    hoursCompleted = totalHours;
                }
                result += (hoursCompleted*income/totalHours);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public boolean canWorkWithInventorCategory(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"14.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public static void main(String[] args){
    }

    //Basic Methods//
    private Object replaceNull(Object o) {
        if (o == null) {
            return null;
        } else {
            return "'" + o + "'";
        }
    }

    private void setError(String error) {
        errorMessage = error;
    }

    public String getError() {
        return errorMessage;
    }

    //Instance Variables//
    private String errorMessage;

    public static int HOURLY = 1; //St�ndliche
    public static int DAILY = 2; //T�glich
    public static int WEEKLY = 3; //W�chentlich
    public static int FORTNIGHTLY = 4; //Vierzehnt�gig
    public static int MONTHLY = 5; //Monatlich
    public static int QUARTERLY = 6; //Viertelj�hrlich
    public static int YEARLY = 7; //J�hrlich
}
