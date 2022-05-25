package com.rheinlandprivatschule.repository;


import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Country;
import com.rheinlandprivatschule.model.Table;

import java.sql.ResultSet;
import java.util.Vector;



public class CountryDao {

    //public static void main(String[] args){
    //CountryDB db = new CountryDB();
    //countrydb db= new countrydb();
    //Vector a= db.getCountry();
    //System.out.println(a.size());
    //}

    public boolean addCountry(Country country) {
        boolean result = false;
        Table table= TableManager.getTable(TableManager.RPS_COUNTRIES);
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(1)+")VALUES("
                    + replaceNull(country.getUserCountryName())  + ")";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean deleteCountry(int countryID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_COUNTRIES);
        try {
            String q = "DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='" + countryID + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public Country getAllCountries(int countryID) {
        Country v = new Country();
        Table table=TableManager.getTable(TableManager.RPS_COUNTRIES);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)
                    +" FROM "+table.getTableName()
                    +" WHERE "+table.getColumn(0)+"='"+ countryID + "'"
                    +" ORDER BY " +table.getColumn(1) ;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Country c = new Country();
                c.setUserCountryID(rs.getInt(table.getColumn(0)));
                c.setUserCountryName(rs.getString(table.getColumn(1)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<Country> getAllCountries() {
        Vector<Country> v = new Vector<Country>();
        Table table=TableManager.getTable(TableManager.RPS_COUNTRIES);
        try {
            String q = "SELECT "+table.getColumn(0)
                    +","+table.getColumn(1)
                    +" FROM "+table.getTableName()
                    +" ORDER BY " +table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Country c = new Country();
                c.setUserCountryID(rs.getInt(table.getColumn(0)));
                c.setUserCountryName(rs.getString(table.getColumn(1)));
                v.addElement(c);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public boolean updateCountry(Country c) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_COUNTRIES);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"="
                    + replaceNull(c.getUserCountryName())  + " WHERE "+table.getColumn(0)+"='"
                    + c.getUserCountryID() + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean canSeeCountryList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"8.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewCountry(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"8.1.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateCountry(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"8.1.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public Country getCountry(int countryID) {
        Country u = new Country();
        Table table=TableManager.getTable(TableManager.RPS_COUNTRIES);
        try {
            String q = "SELECT "+table.getColumn(0)+", "
                    +table.getColumn(1)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+"='"
                    + countryID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                u.setUserCountryID(rs.getInt(table.getColumn(0)));
                u.setUserCountryName(rs.getString(table.getColumn(1)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return u;
    }

    public int Country(int ctyID) {
        int countryID = 0;
        Table table=TableManager.getTable(TableManager.RPS_COUNTRIES);
        try {
            String q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                    + ctyID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                countryID = rs.getInt(table.getColumn(0));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return countryID;
    }

    public String getError(){
        return error;
    }

    public void setError(String errorMessage){
        error=errorMessage;
    }

    public Object replaceNull(Object o){
        if(o == null){
            return null;
        }else{
            return "'" + o + "'";
        }
    }

    //Instance Variables
    private String error;
}
