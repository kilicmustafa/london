package com.rheinlandprivatschule.model;


import java.util.ArrayList;

public class Table {

    public Table(String tableName){
        this.tableName=tableName;
        columns=new ArrayList<String>();
    }

    public void addColumn(String columnName){
        columns.add(columnName);
    }

    public String getColumn(int index){
        if(index>=getColumnsSize()){
            return null;
        }
        else{
            return columns.get(index);
        }

    }

    public String getTableName(){
        return this.tableName;
    }

    public int getColumnsSize(){
        return columns.size();
    }

    //Instance Variables
    private String tableName;
    private ArrayList<String> columns;
}
