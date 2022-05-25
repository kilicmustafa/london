package com.rheinlandprivatschule.repository;


import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.*;

import java.sql.*;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Vector;


public class ExpenseDao {

    public Vector<ExpenseCategory> combineCategories(Date firstDate, Date lastDate){
        Vector<ExpenseCategory> combinedCategories = new Vector<ExpenseCategory>();
        String indent="";
        Vector<ExpenseCategory> catList = this.getAllExpenseCategories(0);
        for(int i=0;i<catList.size();i++){
            ExpenseCategory category = (ExpenseCategory)catList.elementAt(i);
            traverseCategories(category,indent,combinedCategories,firstDate,lastDate);
            combinedCategories.add(new ExpenseCategory());
        }
        return combinedCategories;
    }

    private void traverseCategories(ExpenseCategory category,String indent,Vector<ExpenseCategory> combinedCategories,Date firstDate,Date lastDate){
        try{
            if(this.isExpenseCategoryDirectory(category.getExpenseID())){
                category.setIndentation(indent);
                combinedCategories.add(category);
                Vector<ExpenseCategory> catList = this.getAllExpenseCategories(category.getExpenseID());
                for(int i=0;i<catList.size();i++){
                    ExpenseCategory subCategory = (ExpenseCategory)catList.elementAt(i);
                    String currentIndent="--------"+indent;
                    traverseCategories(subCategory,currentIndent,combinedCategories,firstDate,lastDate);
                }
            }else{
                category.setIndentation(indent);
                if(isExpenseCategoryValid(category,firstDate,lastDate)){
                    combinedCategories.add(category);
                }
            }

        }catch(Exception e){
            setError(e.toString());
        }
    }

    public boolean addExpenseCategory(ExpenseCategory category) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_EXPENSECATEGORY);
        try {
            String q = "INSERT INTO " + table.getTableName() + "("
                    + table.getColumn(1) + ","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+")VALUES("+ replaceNull(category.getExpenseName())+",'"+category.getExpensePaymentType()+"',"+replaceNull(category.getExpenseStartDate())+","+replaceNull(category.getExpenseEndDate())+",'"+category.getExpenseAmount()+"','"+category.getExpenseParent()+"')";
            DBHelper.getInstance().updateQuery(q);
            q = "select LAST_INSERT_ID() as id";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            int newExpenseCategoryID = 0;
            while (rs.next()) {
                newExpenseCategoryID = rs.getInt("id");
            }
            if (newExpenseCategoryID > 0) {
                addPlacesToExpenseCategory(newExpenseCategoryID,category.getSchoolID());
            }
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean addPlacesToExpenseCategory(int expenseCategoryID,Vector<Integer> places) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_EXPENSECATEGORYCITY);
        try {
            for(int i=0;i<places.size();i++){
                int placeID=((Integer)places.elementAt(i)).intValue();
                String q = "INSERT INTO " + table.getTableName() + "("
                        + table.getColumn(0) + ","+table.getColumn(1)+")VALUES('"+expenseCategoryID+"','"+placeID+"')";
                DBHelper.getInstance().updateQuery(q);
            }
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deletePlacesToExpenseCategory(int expenseCategoryID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_EXPENSECATEGORYCITY);
        try {
            String q = "DELETE FROM " + table.getTableName()+ " WHERE "+table.getColumn(0)+"='"+expenseCategoryID+"'";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteExpenseCategory(int expenseCategoryID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_EXPENSECATEGORY);
        try {
            String q = "DELETE FROM " + table.getTableName() + " WHERE "
                    + table.getColumn(0) + "='" + expenseCategoryID + "'";
            DBHelper.getInstance().updateQuery(q);
            deletePlacesToExpenseCategory(expenseCategoryID);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public ExpenseCategory getExpenseCategory(int expenseCategoryID) {
        ExpenseCategory expenseCategory = new ExpenseCategory();
        Table table = TableManager.getTable(TableManager.RPS_EXPENSECATEGORY);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + ","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+" FROM "
                    + table.getTableName() + " WHERE " + table.getColumn(0)
                    + "='" + expenseCategoryID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                expenseCategory.setExpenseID(rs.getInt(table.getColumn(0)));
                expenseCategory.setExpenseName(rs.getString(table.getColumn(1)));
                expenseCategory.setExpensePaymentType(rs.getInt(table.getColumn(2)));
                expenseCategory.setExpenseStartDate(rs.getDate(table.getColumn(3)));
                expenseCategory.setExpenseEndDate(rs.getDate(table.getColumn(4)));
                expenseCategory.setExpenseAmount(rs.getDouble(table.getColumn(5)));
                expenseCategory.setExpenseParent(rs.getInt(table.getColumn(6)));
            }
            expenseCategory.setSchoolID(getExpenseCategoryPlaces(expenseCategory.getExpenseID()));
        } catch (Exception e) {
            setError(e.toString());
        }
        return expenseCategory;
    }

    public Vector<Integer> getExpenseCategoryPlaces(int expenseCategoryID) {
        Vector<Integer> places = new Vector<Integer>();
        Table table = TableManager.getTable(TableManager.RPS_EXPENSECATEGORYCITY);
        try {
            String q = "SELECT " + table.getColumn(1)+" FROM "
                    + table.getTableName() + " WHERE " + table.getColumn(0)
                    + "='" + expenseCategoryID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                places.addElement(rs.getInt(table.getColumn(1)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return places;
    }

    public Vector<ExpenseCategory> getAllExpenseCategories(int expenseParent) {
        Vector<ExpenseCategory> expenseCategories = new Vector<ExpenseCategory>();
        Table table = TableManager.getTable(TableManager.RPS_EXPENSECATEGORY);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) +","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+" FROM "
                    + table.getTableName() + " WHERE "+table.getColumn(6)+"='"+expenseParent+"' ORDER BY " + table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                ExpenseCategory expenseCategory = new ExpenseCategory();
                expenseCategory.setExpenseID(rs.getInt(table.getColumn(0)));
                expenseCategory.setExpenseName(rs.getString(table.getColumn(1)));
                expenseCategory.setExpensePaymentType(rs.getInt(table.getColumn(2)));
                expenseCategory.setExpenseStartDate(rs.getDate(table.getColumn(3)));
                expenseCategory.setExpenseEndDate(rs.getDate(table.getColumn(4)));
                expenseCategory.setExpenseAmount(rs.getDouble(table.getColumn(5)));
                expenseCategory.setExpenseParent(rs.getInt(table.getColumn(6)));
                expenseCategories.add(expenseCategory);
            }
            for(int i=0;i<expenseCategories.size();i++){
                ExpenseCategory tempExpenseCategory = (ExpenseCategory)expenseCategories.elementAt(i);
                tempExpenseCategory.setSchoolID(getExpenseCategoryPlaces(tempExpenseCategory.getExpenseID()));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return expenseCategories;
    }

    public boolean isExpenseCategoryDirectory(int expenseCategoryID) {
        boolean result=false;
        int count=0;
        Table table = TableManager.getTable(TableManager.RPS_EXPENSECATEGORY);
        try {
            String q = "SELECT count(*) AS ExpenseCount FROM "
                    + table.getTableName() + " WHERE "+table.getColumn(6)+"='"+expenseCategoryID+"'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                count=rs.getInt("ExpenseCount");
            }
            if(count>0){
                result=true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean updateExpenseCategory(ExpenseCategory expenseCategory) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_EXPENSECATEGORY);
        try {
            String q = "UPDATE " + table.getTableName() + " SET "
                    + table.getColumn(1) + "="
                    + replaceNull(expenseCategory.getExpenseName()) + ","+table.getColumn(2)+"='"+expenseCategory.getExpensePaymentType()+"',"+table.getColumn(3)+"="+replaceNull(expenseCategory.getExpenseStartDate())+","+table.getColumn(4)+"="+replaceNull(expenseCategory.getExpenseEndDate())+","+table.getColumn(5)+"='"+expenseCategory.getExpenseAmount()+"',"+table.getColumn(6)+"='"+expenseCategory.getExpenseParent()+"' WHERE "
                    + table.getColumn(0) + "='" + expenseCategory.getExpenseID() + "'";
            DBHelper.getInstance().updateQuery(q);
            deletePlacesToExpenseCategory(expenseCategory.getExpenseID());
            addPlacesToExpenseCategory(expenseCategory.getExpenseID(),expenseCategory.getSchoolID());
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean isExpenseCategoryValid(ExpenseCategory category,Date firstDate,Date lastDate){
        boolean flag = false;
        try{
            boolean firstFlag = false;
            boolean lastFlag = false;
            if(category.getExpenseEndDate() == null){
                firstFlag = (MyDate.isEqual(firstDate,category.getExpenseStartDate()) || firstDate.after(category.getExpenseStartDate())) && (true || true);
                lastFlag = (MyDate.isEqual(lastDate,category.getExpenseStartDate()) || lastDate.after(category.getExpenseStartDate())) && (true || true);
            }else{
                firstFlag = (MyDate.isEqual(firstDate,category.getExpenseStartDate()) || firstDate.after(category.getExpenseStartDate())) && (MyDate.isEqual(firstDate,category.getExpenseEndDate()) || firstDate.before(category.getExpenseEndDate()));
                lastFlag = (MyDate.isEqual(lastDate,category.getExpenseStartDate()) || lastDate.after(category.getExpenseStartDate())) && (MyDate.isEqual(lastDate,category.getExpenseEndDate()) || lastDate.before(category.getExpenseEndDate()));
            }
            if(firstFlag || lastFlag){
                flag = true;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return flag;
    }

    public int countDaysWithSupposition(ExpenseCategory category,Date firstDate,Date lastDate,int supposeMonthDays){
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
                    if(category.getExpenseEndDate() == null){
                        dateValidityFlag = (MyDate.isEqual(conditionDate,category.getExpenseStartDate()) || conditionDate.after(category.getExpenseStartDate())) && (true|| true);
                    }else{
                        dateValidityFlag = (MyDate.isEqual(conditionDate,category.getExpenseStartDate()) || conditionDate.after(category.getExpenseStartDate())) && (MyDate.isEqual(conditionDate,category.getExpenseEndDate()) || conditionDate.before(category.getExpenseEndDate()));
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

    public boolean canWorkWithExpenseCategory(int loginUser){
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
