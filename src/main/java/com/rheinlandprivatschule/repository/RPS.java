package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Place;
import com.rheinlandprivatschule.model.SystemUser;
import com.rheinlandprivatschule.model.Table;

import java.sql.ResultSet;


public class RPS {

    public void setLoginUser(SystemUser loginUser) {
        this.loginUser = loginUser;
    }

    public SystemUser getLoginUser() {
        return loginUser;
    }

    public void setLoginPlace(Place loginPlace) {
        this.loginPlace = loginPlace;
    }

    public Place getLoginPlace() {
        return loginPlace;
    }

    public boolean isValidConnection(){
        Table table= TableManager.getTable(TableManager.RPS_PLACE);
        try{
            String q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName();
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            int placeCount=0;
            while (rs.next()) {
                rs.getInt(table.getColumn(0));
                placeCount++;
            }

            if(placeCount>0){
                return true;
            }else{
                return false;
            }
        }catch(Exception e){
            return false;
        }
    }

    public void validateConnection(){
        if(!isValidConnection()){
            DBHelper.getInstance();
        }
    }

    //Instance Variables
    private SystemUser loginUser;
    private Place loginPlace;
}
