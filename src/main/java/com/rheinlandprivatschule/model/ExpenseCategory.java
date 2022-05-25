package com.rheinlandprivatschule.model;

import com.rheinlandprivatschule.helper.MyCurrency;
import com.rheinlandprivatschule.repository.ExpenseDao;

import java.sql.Date;
import java.util.Vector;

public class ExpenseCategory {

    public ExpenseCategory(){
        this.expenseID = 0;
        this.expenseName = "Summe";
        this.expensePaymentType = 0;
        this.expenseStartDate = null;
        this.expenseEndDate = null;
        this.expenseAmount = 0;
        this.schoolID=new Vector<Integer>();
        this.expenseParent = 0;
        this.indentation = "";
    }

    public void setExpenseID(int expenseID) {
        this.expenseID = expenseID;
    }
    public int getExpenseID() {
        return expenseID;
    }

    public void setExpenseName(String expenseName) {
        this.expenseName = expenseName;
    }
    public String getExpenseName() {
        return expenseName;
    }

    public void setExpensePaymentType(int expensePaymentType) {
        this.expensePaymentType = expensePaymentType;
    }
    public int getExpensePaymentType() {
        return expensePaymentType;
    }

    public void setExpenseStartDate(Date expenseStartDate) {
        this.expenseStartDate = expenseStartDate;
    }
    public Date getExpenseStartDate() {
        return this.expenseStartDate;
    }

    public void setExpenseEndDate(Date expenseEndDate) {
        this.expenseEndDate = expenseEndDate;
    }
    public Date getExpenseEndDate() {
        return this.expenseEndDate;
    }

    public void setExpenseAmount(double expenseAmount) {
        this.expenseAmount = expenseAmount;
    }
    public double getExpenseAmount() {
        return expenseAmount;
    }

    public void setSchoolID(Vector<Integer> schoolID) {
        this.schoolID = schoolID;
    }
    public Vector<Integer> getSchoolID() {
        return schoolID;
    }

    public void setExpenseParent(int expenseParent) {
        this.expenseParent = expenseParent;
    }
    public int getExpenseParent() {
        return expenseParent;
    }

    public void setIndentation(String indentation) {
        this.indentation = indentation;
    }
    public String getIndentation() {
        return indentation;
    }

    public String getAmountForSchool(int schoolID,Date firstDate,Date lastDate){
        String amount = "";
        ExpenseDao ExpenseDao = new ExpenseDao();
        try{
            int days = ExpenseDao.countDaysWithSupposition(this,firstDate,lastDate,30);
            int schoolCount = this.schoolID.size();
            double amountPart = 0;
            if(schoolCount>0){
                amountPart = (getPerDayAmount()*days)/schoolCount;
            }
            boolean schoolExist = false;
            for(int i=0;i<this.schoolID.size();i++){
                Integer tempSchoolID = (Integer)this.schoolID.elementAt(i);
                if(tempSchoolID.intValue() == schoolID){
                    schoolExist = true;
                }
            }
            if(schoolExist){
                amount = MyCurrency.getDisplayString(amountPart);
            }
        }catch(Exception e){
        }
        return amount;
    }

    private double getPerDayAmount(){
        double result = 0;
        if(this.expensePaymentType == ExpenseDao.HOURLY){
            result = this.expenseAmount*24;
        }else if(this.expensePaymentType == ExpenseDao.DAILY){
            result = this.expenseAmount;
        }else if(this.expensePaymentType == ExpenseDao.WEEKLY){
            result = this.expenseAmount/7;
        }else if(this.expensePaymentType == ExpenseDao.FORTNIGHTLY){
            result = this.expenseAmount/15;
        }else if(this.expensePaymentType == ExpenseDao.MONTHLY){
            result = this.expenseAmount/30;
        }else if(this.expensePaymentType == ExpenseDao.QUARTERLY){
            result = this.expenseAmount/120;
        }else if(this.expensePaymentType == ExpenseDao.YEARLY){
            result = this.expenseAmount/360;
        }
        return result;
    }

    //Instance Variables
    private int expenseID;
    private String expenseName;
    private int expensePaymentType;
    private Date expenseStartDate;
    private Date expenseEndDate;
    private double expenseAmount;
    private Vector<Integer> schoolID=new Vector<Integer>();
    private int expenseParent;
    private String indentation;
}
