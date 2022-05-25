package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Expenditure;
import com.rheinlandprivatschule.model.Place;
import com.rheinlandprivatschule.model.Table;

import java.sql.*;
import java.util.StringTokenizer;
import java.util.Vector;


public class ExpenditureDao {

    public boolean addExpenditure(Expenditure ee) {
        boolean result = false;
        Table table= TableManager.getTable(TableManager.RPS_EXPENDITURE);
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+","+table.getColumn(7)+")VALUES("
                    + replaceNull(ee.getExpenditureDesc())
                    + ","
                    + replaceNull(ee.getFirstDate())
                    + ","
                    + replaceNull(ee.getEnterDate())
                    + ",'"
                    + ee.getBill()
                    + "',"
                    + replaceNull(getPlaceString(ee.getPlaces()))
                    + ",'"
                    + ee.getCategory() + "','" + ee.getAdmin() + "')";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean deleteExpenditure(int expenditureID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_EXPENDITURE);
        try {
            String q = "DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='" + expenditureID + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public Vector<Expenditure> getAllExpenditures() {
        Vector<Expenditure> v = new Vector<Expenditure>();
        Vector<Expenditure> vv = new Vector<Expenditure>();
        Vector<String> temp = new Vector<String>();
        Table exp_table=TableManager.getTable(TableManager.RPS_EXPENDITURE);
        Table place_table=TableManager.getTable(TableManager.RPS_PLACE);
        try {
            String q = "SELECT a." + exp_table.getColumn(0) + ",a."
                    + exp_table.getColumn(1) + ",a."
                    + exp_table.getColumn(2) + ",a."
                    + exp_table.getColumn(3) + ",a."
                    + exp_table.getColumn(4) + ",a."
                    + exp_table.getColumn(5) + ",a."
                    + exp_table.getColumn(6) + ",b.placeName"
                    + " FROM "
                    + exp_table.getTableName() + " AS a,"
                    + place_table.getTableName()+" AS b";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            String place = "";
            while (rs.next()) {
                Expenditure expenditure = new Expenditure();
                expenditure.setExpenditureID(rs.getInt(exp_table.getColumn(0)));
                expenditure.setExpenditureDesc(rs.getString(exp_table.getColumn(1)));
                expenditure.setFirstDate(rs.getDate(exp_table.getColumn(2)));
                expenditure.setEnterDate(rs.getDate(exp_table.getColumn(3)));
                expenditure.setBill(rs.getDouble(exp_table.getColumn(4)));
                place = rs.getString(place_table.getColumn(1));
                temp.addElement(place);
                expenditure.setCategory(rs.getInt(exp_table.getColumn(6)));
                expenditure.setAdmin(rs.getInt(exp_table.getColumn(7)));
                vv.addElement(expenditure);
            }
            for (int i = 0; i < vv.size(); i++) {
                String tempStr = (String) temp.elementAt(i);
                Expenditure tempExp = (Expenditure) vv.elementAt(i);
                tempExp.setPlaces(getPlaceVector(tempStr));
                v.addElement(tempExp);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Expenditure getLastExpenditure() {
        Expenditure expenditure = new Expenditure();
        Table table=TableManager.getTable(TableManager.RPS_EXPENDITURE);
        try {
            String q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName();
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            int tempid = 0;
            while (rs.next()) {
                tempid = rs.getInt(table.getColumn(0));
            }
            expenditure = getExpenditure(tempid);
        } catch (Exception e) {
            setError(e.toString());
        }
        return expenditure;
    }

    public Expenditure getExpenditure(int expenditureID) {
        Expenditure expenditure = new Expenditure();
        Table table=TableManager.getTable(TableManager.RPS_EXPENDITURE);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+","+table.getColumn(7)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                    + expenditureID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            String place = "";
            while (rs.next()) {
                expenditure.setExpenditureID(rs.getInt(table.getColumn(0)));
                expenditure.setExpenditureDesc(rs.getString(table.getColumn(1)));
                expenditure.setFirstDate(rs.getDate(table.getColumn(2)));
                expenditure.setEnterDate(rs.getDate(table.getColumn(3)));
                expenditure.setBill(rs.getDouble(table.getColumn(4)));
                place = rs.getString(table.getColumn(5));
                expenditure.setCategory(rs.getInt(table.getColumn(6)));
                expenditure.setAdmin(rs.getInt(table.getColumn(7)));
            }
            expenditure.setPlaces(getPlaceVector(place));
        } catch (Exception e) {
            setError(e.toString());
        }
        return expenditure;
    }

    public Vector<Expenditure> getExpendituresByCategory(int expCategoryID) {
        Vector<Expenditure> v = new Vector<Expenditure>();
        Vector<Expenditure> vv = new Vector<Expenditure>();
        Vector<String> temp = new Vector<String>();
        Table table=TableManager.getTable(TableManager.RPS_EXPENDITURE);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+","+table.getColumn(7)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(6)+"='"
                    + expCategoryID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            String place = "";
            while (rs.next()) {
                Expenditure expenditure = new Expenditure();
                expenditure.setExpenditureID(rs.getInt(table.getColumn(0)));
                expenditure.setExpenditureDesc(rs.getString(table.getColumn(1)));
                expenditure.setFirstDate(rs.getDate(table.getColumn(2)));
                expenditure.setEnterDate(rs.getDate(table.getColumn(3)));
                expenditure.setBill(rs.getDouble(table.getColumn(4)));
                place = rs.getString(table.getColumn(5));
                temp.addElement(place);
                expenditure.setCategory(rs.getInt(table.getColumn(6)));
                expenditure.setAdmin(rs.getInt(table.getColumn(7)));
                vv.addElement(expenditure);
            }

            for (int i = 0; i < vv.size(); i++) {
                String tempStr = (String) temp.elementAt(i);
                Expenditure tempExp = (Expenditure) vv.elementAt(i);
                tempExp.setPlaces(getPlaceVector(tempStr));
                v.addElement(tempExp);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector getExpendituresByCriteria(String criteria, Date firstDate, Date enterDate,Vector<Place> places, int expCategoryID) {
        Vector<Expenditure> v = new Vector<Expenditure>();
        Vector<Expenditure> vv = new Vector<Expenditure>();
        Vector<String> temp = new Vector<String>();
        Table table=TableManager.getTable(TableManager.RPS_EXPENDITURE);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+","+table.getColumn(7)+" FROM "+table.getTableName();
            if (criteria.equalsIgnoreCase("Datum Limit")) {
                q = q + " WHERE "+table.getColumn(2)+">=" + replaceNull(firstDate)
                        + " AND "+table.getColumn(2)+"<=" + replaceNull(enterDate);
                if (expCategoryID > 0)
                    q = q + " AND "+table.getColumn(6)+"='" + expCategoryID + "'";
            } else {
                q = q + " WHERE "+table.getColumn(2)+"=" + replaceNull(enterDate);
                if (expCategoryID > 0)
                    q = q + " AND "+table.getColumn(6)+"='" + expCategoryID + "'";
            }
            q = q + " ORDER BY "+table.getColumn(2);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            String place = "";
            while (rs.next()) {
                Expenditure expenditure = new Expenditure();
                expenditure.setExpenditureID(rs.getInt(table.getColumn(0)));
                expenditure.setExpenditureDesc(rs.getString(table.getColumn(1)));
                expenditure.setFirstDate(rs.getDate(table.getColumn(2)));
                expenditure.setEnterDate(rs.getDate(table.getColumn(3)));
                expenditure.setBill(rs.getDouble(table.getColumn(4)));
                place = rs.getString(table.getColumn(5));
                temp.addElement(place);
                expenditure.setCategory(rs.getInt(table.getColumn(6)));
                expenditure.setAdmin(rs.getInt(table.getColumn(7)));
                vv.addElement(expenditure);
            }
            if (places.size() > 0) {
                for (int i = 0; i < vv.size(); i++) {
                    String tempStr = (String) temp.elementAt(i);
                    if (matchPlaces(places, tempStr)) {
                        Expenditure tempExp = (Expenditure) vv.elementAt(i);
                        tempExp.setPlaces(getPlaceVector(tempStr));
                        v.addElement(tempExp);
                    }
                }
            } else {
                for (int i = 0; i < vv.size(); i++) {
                    String tempStr = (String) temp.elementAt(i);
                    Expenditure tempExp = (Expenditure) vv.elementAt(i);
                    tempExp.setPlaces(getPlaceVector(tempStr));
                    v.addElement(tempExp);
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public String getPlaceString(Vector<Place> v) {
        String result = "";
        try {
            for (int i = 0; i < v.size(); i++) {
                Place place = (Place) v.elementAt(i);
                result = result + " " + place.getPlaceID();
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public Vector<Place> getPlaceVector(String code) {
        Vector<Place> v = new Vector<Place>();
        try {
            StringTokenizer st = new StringTokenizer(code, " ");
            while (st.hasMoreTokens()) {
                Place place = (new PlaceDao()).getPlace(Integer.parseInt(st
                        .nextToken()));
                if (place.getPlaceID() > 0) {
                    v.addElement(place);
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public boolean matchPlaces(Vector<Place> v, String placeIDS) {
        boolean b = false;
        try {
            StringTokenizer st = new StringTokenizer(placeIDS, " ");
            while (st.hasMoreTokens()) {
                int tempID = Integer.parseInt(st.nextToken());
                for (int i = 0; i < v.size(); i++) {
                    Place place = (Place) v.elementAt(i);
                    if (place.getPlaceID() == tempID) {
                        b = true;
                        break;
                    }
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean updateExpenditure(Expenditure expenditure) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_EXPENDITURE);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"="
                    + replaceNull(expenditure.getExpenditureDesc()) + ", "+table.getColumn(2)+"="
                    + replaceNull(expenditure.getFirstDate()) + ","+table.getColumn(3)+"="
                    + replaceNull(expenditure.getEnterDate()) + ", "+table.getColumn(4)+"='"
                    + expenditure.getBill() + "', "+table.getColumn(5)+"="
                    + replaceNull(getPlaceString(expenditure.getPlaces()))
                    + ", "+table.getColumn(6)+"='" + expenditure.getCategory() + "', "+table.getColumn(7)+"='"
                    + expenditure.getAdmin() + "' WHERE "+table.getColumn(0)+"='" + expenditure.getExpenditureID()
                    + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean canSearchAusgabe(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"8.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewAusgabe(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"8.2.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateAusgabe(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"8.2.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canPrintAusgabe(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"8.2.3");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
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
