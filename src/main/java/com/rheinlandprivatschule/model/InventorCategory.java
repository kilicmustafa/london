package com.rheinlandprivatschule.model;

import com.rheinlandprivatschule.helper.MyCurrency;
import com.rheinlandprivatschule.repository.InventorDao;

import java.sql.Date;
import java.util.Vector;

public class InventorCategory {

    public InventorCategory(){
        this.inventorID = 0;
        this.inventorName = "Summe";
        this.inventorPaymentType = 0;
        this.inventorStartDate = null;
        this.inventorEndDate = null;
        this.inventorAmount = 0;
        this.schoolID=new Vector<Integer>();
        this.inventorParent = 0;
        this.indentation = "";
    }

    public void setInventorID(int inventorID) {
        this.inventorID = inventorID;
    }
    public int getInventorID() {
        return inventorID;
    }

    public void setInventorName(String inventorName) {
        this.inventorName = inventorName;
    }
    public String getInventorName() {
        return inventorName;
    }

    public void setInventorPaymentType(int inventorPaymentType) {
        this.inventorPaymentType = inventorPaymentType;
    }
    public int getInventorPaymentType() {
        return inventorPaymentType;
    }

    public void setInventorStartDate(Date inventorStartDate) {
        this.inventorStartDate = inventorStartDate;
    }
    public Date getInventorStartDate() {
        return this.inventorStartDate;
    }

    public void setInventorEndDate(Date inventorEndDate) {
        this.inventorEndDate = inventorEndDate;
    }
    public Date getInventorEndDate() {
        return this.inventorEndDate;
    }

    public void setInventorAmount(double inventorAmount) {
        this.inventorAmount = inventorAmount;
    }
    public double getInventorAmount() {
        return inventorAmount;
    }

    public void setSchoolID(Vector<Integer> schoolID) {
        this.schoolID = schoolID;
    }
    public Vector<Integer> getSchoolID() {
        return schoolID;
    }

    public void setInventorParent(int inventorParent) {
        this.inventorParent = inventorParent;
    }
    public int getInventorParent() {
        return inventorParent;
    }

    public void setIndentation(String indentation) {
        this.indentation = indentation;
    }
    public String getIndentation() {
        return indentation;
    }

    public String getAmountForSchool(int schoolID,Date firstDate,Date lastDate){
        String amount = "";
        InventorDao InventorDao = new InventorDao();
        try{
            int days = InventorDao.countDaysWithSupposition(this,firstDate,lastDate,30);
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
        if(this.inventorPaymentType == InventorDao.HOURLY){
            result = this.inventorAmount*24;
        }else if(this.inventorPaymentType == InventorDao.DAILY){
            result = this.inventorAmount;
        }else if(this.inventorPaymentType == InventorDao.WEEKLY){
            result = this.inventorAmount/7;
        }else if(this.inventorPaymentType == InventorDao.FORTNIGHTLY){
            result = this.inventorAmount/15;
        }else if(this.inventorPaymentType == InventorDao.MONTHLY){
            result = this.inventorAmount/30;
        }else if(this.inventorPaymentType == InventorDao.QUARTERLY){
            result = this.inventorAmount/120;
        }else if(this.inventorPaymentType == InventorDao.YEARLY){
            result = this.inventorAmount/360;
        }
        return result;
    }

    //Instance Variables
    private int inventorID;
    private String inventorName;
    private int inventorPaymentType;
    private Date inventorStartDate;
    private Date inventorEndDate;
    private double inventorAmount;
    private Vector<Integer> schoolID=new Vector<Integer>();
    private int inventorParent;
    private String indentation;
}
