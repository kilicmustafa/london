package com.rheinlandprivatschule.model;

public class ExpCategory {

    public ExpCategory() {
        categoryID = 0;
        categoryName = null;
        categoryDesc = null;
    }

    public String getCategoryDesc() {
        return categoryDesc;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryDesc(String code) {
        categoryDesc = code;
    }

    public void setCategoryID(int code) {
        categoryID = code;
    }

    public void setCategoryName(String code) {
        categoryName = code;
    }

    //Instance Variables
    private String categoryDesc;
    private int categoryID;
    private String categoryName;
}
