package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Place;
import com.rheinlandprivatschule.model.Table;

import java.sql.ResultSet;
import java.util.Vector;

public class PlaceDao {

    public int addNewPlace(Place place) {
        int chk = 0;
        Table table = TableManager.getTable(TableManager.RPS_PLACE);
        try {
            String q = "INSERT INTO " + table.getTableName() + " ("
                    + table.getColumn(1) + ","
                    + table.getColumn(2) + ","
                    + table.getColumn(3) + ","
                    + table.getColumn(4) + ","
                    + table.getColumn(5) + ","
                    + table.getColumn(6) + ","
                    + table.getColumn(7) + ","
                    + table.getColumn(8) + ","
                    + table.getColumn(9) + ","
                    + table.getColumn(10) + ","
                    + table.getColumn(11) + ","
                    + table.getColumn(12) + ","
                    + table.getColumn(13) + ","
                    + table.getColumn(14) + ","
                    + table.getColumn(15) + ","
                    + table.getColumn(16) + ","
                    + table.getColumn(17) + ","
                    + table.getColumn(18) + ","
                    + table.getColumn(19) + ","
                    + table.getColumn(20) + ","
                    + table.getColumn(21) + ","
                    + table.getColumn(22) + ","
                    + table.getColumn(23) + ") VALUES (" +
                    replaceNull(place.getPlaceName()) + "," +
                    replaceNull(place.getPlaceAddress()) + "," +
                    replaceNull(place.getPlacePostCode()) + "," +
                    replaceNull(place.getPlaceCity()) + "," +
                    replaceNull(place.getPlaceCountry()) + "," +
                    replaceNull(place.getPlaceTelephone()) + "," +
                    replaceNull(place.getPlaceFax()) + "," +
                    replaceNull(place.getPlaceEmail()) + "," +
                    replaceNull(place.getBamfNumber()) + "," +
                    replaceNull(place.getBusinessNumber()) + "," +
                    replaceNull(place.getTaxNumber()) + "," +
                    replaceNull(place.getFirmaName()) + "," +
                    replaceNull(place.getBillSchool()) + "," +
                    replaceNull(place.getBillURL()) + "," +
                    replaceNull(place.getBillAddress()) + "," +
                    replaceNull(place.getComment1()) + "," +
                    replaceNull(place.getComment2()) + "," +
                    replaceNull(place.getComment3()) + "," +
                    replaceNull(place.getComment4()) + "," +
                    replaceNull(place.getComment5()) + "," +
                    replaceNull(place.getComment6()) + "," +
                    replaceNull(place.getComment7()) + "," +
                    replaceNull(place.getComment8()) + ")";
            DBHelper.getInstance().updateQuery(q);
            chk = 1;
        } catch (Exception e) {
            setError(e.toString());
        }
        return chk;
    }

    public int deletePlace(int placeID) {
        int chk = 0;
        Table table = TableManager.getTable(TableManager.RPS_PLACE);
        try {
            String q = "DELETE FROM " + table.getTableName() + " WHERE " + table.getColumn(0) + "='" + placeID + "'";
            DBHelper.getInstance().updateQuery(q);
            chk = 1;
        } catch (Exception e) {
            setError(e.toString());
        }
        return chk;
    }

    public Place getPlace(int placeID) {
        Place p = new Place();
        Table table = TableManager.getTable(TableManager.RPS_PLACE);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + ","
                    + table.getColumn(2) + ","
                    + table.getColumn(3) + ","
                    + table.getColumn(4) + ","
                    + table.getColumn(5) + ","
                    + table.getColumn(6) + ","
                    + table.getColumn(7) + ","
                    + table.getColumn(8) + ","
                    + table.getColumn(9) + ","
                    + table.getColumn(10) + ","
                    + table.getColumn(11) + ","
                    + table.getColumn(12) + ","
                    + table.getColumn(13) + ","
                    + table.getColumn(14) + ","
                    + table.getColumn(15) + ","
                    + table.getColumn(16) + ","
                    + table.getColumn(17) + ","
                    + table.getColumn(18) + ","
                    + table.getColumn(19) + ","
                    + table.getColumn(20) + ","
                    + table.getColumn(21) + ","
                    + table.getColumn(22) + ","
                    + table.getColumn(23) + " FROM "
                    + table.getTableName() + " WHERE "
                    + table.getColumn(0) + "='" + placeID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                p.setPlaceID(rs.getInt(table.getColumn(0)));
                p.setPlaceName(rs.getString(table.getColumn(1)));
                p.setPlaceAddress(rs.getString(table.getColumn(2)));
                p.setPlacePostCode(rs.getString(table.getColumn(3)));
                p.setPlaceCity(rs.getString(table.getColumn(4)));
                p.setPlaceCountry(rs.getString(table.getColumn(5)));
                p.setPlaceTelephone(rs.getString(table.getColumn(6)));
                p.setPlaceFax(rs.getString(table.getColumn(7)));
                p.setPlaceEmail(rs.getString(table.getColumn(8)));
                p.setBamfNumber(rs.getString(table.getColumn(9)));
                p.setBusinessNumber(rs.getString(table.getColumn(10)));
                p.setTaxNumber(rs.getString(table.getColumn(11)));
                p.setFirmaName(rs.getString(table.getColumn(12)));
                p.setBillSchool(rs.getString(table.getColumn(13)));
                p.setBillURL(rs.getString(table.getColumn(14)));
                p.setBillAddress(rs.getString(table.getColumn(15)));
                p.setComment1(rs.getString(table.getColumn(16)));
                p.setComment2(rs.getString(table.getColumn(17)));
                p.setComment3(rs.getString(table.getColumn(18)));
                p.setComment4(rs.getString(table.getColumn(19)));
                p.setComment5(rs.getString(table.getColumn(20)));
                p.setComment6(rs.getString(table.getColumn(21)));
                p.setComment7(rs.getString(table.getColumn(22)));
                p.setComment8(rs.getString(table.getColumn(23)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return p;
    }

    public Vector<Place> getAllPlaces() {
        Vector<Place> v = new Vector<Place>();
        Table table = TableManager.getTable(TableManager.RPS_PLACE);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + ","
                    + table.getColumn(2) + ","
                    + table.getColumn(3) + ","
                    + table.getColumn(4) + ","
                    + table.getColumn(5) + ","
                    + table.getColumn(6) + ","
                    + table.getColumn(7) + ","
                    + table.getColumn(8) + ","
                    + table.getColumn(9) + ","
                    + table.getColumn(10) + ","
                    + table.getColumn(11) + ","
                    + table.getColumn(12) + ","
                    + table.getColumn(13) + ","
                    + table.getColumn(14) + ","
                    + table.getColumn(15) + ","
                    + table.getColumn(16) + ","
                    + table.getColumn(17) + ","
                    + table.getColumn(18) + ","
                    + table.getColumn(19) + ","
                    + table.getColumn(20) + ","
                    + table.getColumn(21) + ","
                    + table.getColumn(22) + ","
                    + table.getColumn(23) + " FROM "
                    + table.getTableName() + " ORDER BY "
                    + table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Place p = new Place();
                p.setPlaceID(rs.getInt(table.getColumn(0)));
                p.setPlaceName(rs.getString(table.getColumn(1)));
                p.setPlaceAddress(rs.getString(table.getColumn(2)));
                p.setPlacePostCode(rs.getString(table.getColumn(3)));
                p.setPlaceCity(rs.getString(table.getColumn(4)));
                p.setPlaceCountry(rs.getString(table.getColumn(5)));
                p.setPlaceTelephone(rs.getString(table.getColumn(6)));
                p.setPlaceFax(rs.getString(table.getColumn(7)));
                p.setPlaceEmail(rs.getString(table.getColumn(8)));
                p.setBamfNumber(rs.getString(table.getColumn(9)));
                p.setBusinessNumber(rs.getString(table.getColumn(10)));
                p.setTaxNumber(rs.getString(table.getColumn(11)));
                p.setFirmaName(rs.getString(table.getColumn(12)));
                p.setBillSchool(rs.getString(table.getColumn(13)));
                p.setBillURL(rs.getString(table.getColumn(14)));
                p.setBillAddress(rs.getString(table.getColumn(15)));
                p.setComment1(rs.getString(table.getColumn(16)));
                p.setComment2(rs.getString(table.getColumn(17)));
                p.setComment3(rs.getString(table.getColumn(18)));
                p.setComment4(rs.getString(table.getColumn(19)));
                p.setComment5(rs.getString(table.getColumn(20)));
                p.setComment6(rs.getString(table.getColumn(21)));
                p.setComment7(rs.getString(table.getColumn(22)));
                p.setComment8(rs.getString(table.getColumn(23)));
                v.add(p);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public boolean canAddNewSchool(int loginUser) {
        boolean flag = PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "6.1");
        if (flag) {
            return true;
        } else {
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeeSchoolList(int loginUser) {
        boolean flag = PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "6.2");
        if (flag) {
            return true;
        } else {
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateSchool(int loginUser) {
        boolean flag = PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "6.2.1");
        if (flag) {
            return true;
        } else {
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public int updatePlace(Place p) {
        int chk = 0;
        Table table = TableManager.getTable(TableManager.RPS_PLACE);
        try {
            String q = "UPDATE " + table.getTableName() + " SET "
                    + table.getColumn(1) + "=" + replaceNull(p.getPlaceName()) + ", "
                    + table.getColumn(2) + "=" + replaceNull(p.getPlaceAddress()) + ","
                    + table.getColumn(3) + "=" + replaceNull(p.getPlacePostCode()) + ","
                    + table.getColumn(4) + "=" + replaceNull(p.getPlaceCity()) + ","
                    + table.getColumn(5) + "=" + replaceNull(p.getPlaceCountry()) + ","
                    + table.getColumn(6) + "=" + replaceNull(p.getPlaceTelephone()) + ","
                    + table.getColumn(7) + "=" + replaceNull(p.getPlaceFax()) + ","
                    + table.getColumn(8) + "=" + replaceNull(p.getPlaceEmail()) + ","
                    + table.getColumn(9) + "=" + replaceNull(p.getBamfNumber()) + ","
                    + table.getColumn(10) + "=" + replaceNull(p.getBusinessNumber()) + ","
                    + table.getColumn(11) + "=" + replaceNull(p.getTaxNumber()) + ","
                    + table.getColumn(12) + "=" + replaceNull(p.getFirmaName()) + ","
                    + table.getColumn(13) + "=" + replaceNull(p.getBillSchool()) + ","
                    + table.getColumn(14) + "=" + replaceNull(p.getBillURL()) + ","
                    + table.getColumn(15) + "=" + replaceNull(p.getBillAddress()) + ","
                    + table.getColumn(16) + "=" + replaceNull(p.getComment1()) + ","
                    + table.getColumn(17) + "=" + replaceNull(p.getComment2()) + ","
                    + table.getColumn(18) + "=" + replaceNull(p.getComment3()) + ","
                    + table.getColumn(19) + "=" + replaceNull(p.getComment4()) + ","
                    + table.getColumn(20) + "=" + replaceNull(p.getComment5()) + ","
                    + table.getColumn(21) + "=" + replaceNull(p.getComment6()) + ","
                    + table.getColumn(22) + "=" + replaceNull(p.getComment7()) + ","
                    + table.getColumn(23) + "=" + replaceNull(p.getComment8()) + " WHERE "
                    + table.getColumn(0) + "='" + p.getPlaceID() + "'";
            DBHelper.getInstance().updateQuery(q);
            chk = 1;
        } catch (Exception e) {
            setError(e.toString());
        }
        return chk;
    }

    /* Methods Related To Every Method */
    private void setError(String errorPara) {
        this.error = errorPara;
    }

    public String getError() {
        return error;
    }

    public Object replaceNull(Object o) {
        if (o == null) {
            return null;
        } else {
            return "'" + o + "'";
        }
    }

    //Instance Variables
    private String error;
}
