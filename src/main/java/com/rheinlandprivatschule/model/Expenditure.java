package com.rheinlandprivatschule.model;


import java.sql.Date;
import java.util.Vector;



public class Expenditure {

    public Expenditure() {
        this.expenditureID = 0;
        this.expDesc = null;
        this.firstDate = null;
        this.enterDate = null;
        this.bill = 0.0D;
        this.places = null;
        this.expCategory = 0;
        this.expAdmin = 0;
        this.placeName = null;
        this.categoryName = null;
    }

    public Expenditure(
            int expenditureID,
            String expDesc,
            Date firstDate,
            Date enterDate,
            double bill,
            Vector places,
            int expCategory,
            int expAdmin,
            String placeName,
            String categoryName
    ){
        this.expenditureID = expenditureID;
        this.expDesc = expDesc;
        this.firstDate = firstDate;
        this.enterDate = enterDate;
        this.bill = bill;
        this.places = places;
        this.expCategory = expCategory;
        this.expAdmin = expAdmin;
        this.placeName = placeName;
        this.categoryName = categoryName;
    }

    //Getters

    public int getAdmin() {
        return expAdmin;
    }

    public double getBill() {
        return bill;
    }

    public int getCategory() {
        return expCategory;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public Date getEnterDate() {
        return enterDate;
    }

    public String getExpenditureDesc() {
        return expDesc;
    }

    public int getExpenditureID() {
        return expenditureID;
    }

    public Date getFirstDate() {
        return firstDate;
    }

    public String getPlaceName() {
        return placeName;
    }

    public Vector<Place> getPlaces() {
        return places;
    }

    //Setters

    public void setAdmin(int code) {
        expAdmin = code;
    }

    public void setBill(double code) {
        bill = code;
    }

    public void setCategory(int code) {
        expCategory = code;
    }

    public void setCategoryName(String code) {
        categoryName = code;
    }

    public void setEnterDate(Date code) {
        enterDate = code;
    }

    public void setExpenditureDesc(String code) {
        expDesc = code;
    }

    public void setExpenditureID(int code) {
        expenditureID = code;
    }

    public void setFirstDate(Date code) {
        firstDate = code;
    }

    public void setPlaces(Vector<Place> code) {
        places = code;
    }

    public void setPlaceName(String code) {
        placeName = code;
    }

    //Instance Variables
    private double bill;
    private Date enterDate;
    private int expAdmin;
    private int expCategory;
    private String expDesc;
    private int expenditureID;
    private Date firstDate;
    private Vector<Place> places;
    private String placeName;
    private String categoryName;
}
