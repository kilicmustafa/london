package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Residence;
import com.rheinlandprivatschule.model.Resident;
import com.rheinlandprivatschule.model.Student;
import com.rheinlandprivatschule.model.Table;

import java.sql.ResultSet;
import java.util.*;

public class ResidenceDao {

    public int addNewResidence(Residence residence) {
        int newOwnerID = 0;
        Table table= TableManager.getTable(TableManager.RPS_RESIDENCE);
        try {
            String q = "INSERT INTO "+table.getTableName()+" ("+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+","+table.getColumn(7)+","+table.getColumn(8)+","+table.getColumn(9)+","+table.getColumn(10)+","+table.getColumn(11)+","+table.getColumn(12)+","+table.getColumn(13)+","+table.getColumn(14)+","+table.getColumn(15)+","+table.getColumn(16)+","+table.getColumn(17)+","+table.getColumn(18)+","+table.getColumn(19)+") VALUES ("
                    + replaceNull(residence.getResidenceAddress())
                    + ","
                    + replaceNull(residence.getResidencePostCode())
                    + ","
                    + replaceNull(residence.getResidenceCity())
                    + ","
                    + replaceNull(residence.getResidenceCountry())
                    + ","
                    + replaceNull(residence.getResidenceSize())
                    + ","
                    + replaceNull(residence.getResidenceDescription())
                    + ",'"
                    + residence.getResidenceRent()
                    + "','"
                    + residence.getResidenceSideCosts()
                    + "',"
                    + replaceNull(residence.getResidenceMeterNumber())
                    + ",'"
                    + residence.getResidenceStatus()
                    + "','"
                    + residence.getResidenceOwner()
                    + "',"
                    + replaceNull(residence.getResidenceMark())
                    + ",'"
                    + residence.getVermieterWarmMiete()
                    + "','"
                    + residence.getVermieterKation()
                    + "',"
                    + replaceNull(residence.getVermieterKationPaidDate())
                    + ",'"
                    + residence.getResidenceKation()
                    + "',"
                    + replaceNull(residence.getVermieterMietStart())
                    + ","
                    + replaceNull(residence.getVermieterMietEnd())
                    + ","
                    + replaceNull(residence.getResidenceType())
                    + ")";
            DBHelper.getInstance().updateQuery(q);
            q = "SELECT LAST_INSERT_ID() AS id";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                newOwnerID = rs.getInt("id");
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return newOwnerID;
    }

    public int updateResidence(Residence residence) {
        int updateStatus = 0;
        Table table=TableManager.getTable(TableManager.RPS_RESIDENCE);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"="+replaceNull(residence.getResidenceAddress())+","+table.getColumn(2)+"="+replaceNull(residence.getResidencePostCode())+","+table.getColumn(3)+"="+replaceNull(residence.getResidenceCity())+","+table.getColumn(4)+"="+replaceNull(residence.getResidenceCountry())+","+table.getColumn(5)+"="+replaceNull(residence.getResidenceSize())+","+table.getColumn(6)+"="+replaceNull(residence.getResidenceDescription())+","+table.getColumn(7)+"='"+residence.getResidenceRent()+"',"+table.getColumn(8)+"='"+residence.getResidenceSideCosts()+"',"+table.getColumn(9)+"="+replaceNull(residence.getResidenceMeterNumber())+","+table.getColumn(10)+"='"+residence.getResidenceStatus()+"',"+table.getColumn(11)+"='"+residence.getResidenceOwner()+"',"+table.getColumn(12)+"="+replaceNull(residence.getResidenceMark())+","+table.getColumn(13)+"='"+residence.getVermieterWarmMiete()+"',"+table.getColumn(14)+"='"+residence.getVermieterKation()+"',"+table.getColumn(15)+"="+replaceNull(residence.getVermieterKationPaidDate())+","+table.getColumn(16)+"='"+residence.getResidenceKation()+"',"+table.getColumn(17)+"="+replaceNull(residence.getVermieterMietStart())+","+table.getColumn(18)+"="+replaceNull(residence.getVermieterMietEnd())+ "," + table.getColumn(19) + "=" + replaceNull(residence.getResidenceType()) +" WHERE "+table.getColumn(0)+"='"+residence.getResidenceID()+"'";
            DBHelper.getInstance().updateQuery(q);
            updateStatus = 1;
        } catch (Exception e) {
            setError(e.toString());
        }
        return updateStatus;
    }

    public Vector<Residence> getAllResidences() {
        Vector<Residence> residencesList = new Vector<Residence>();
        Table residence_table=TableManager.getTable(TableManager.RPS_RESIDENCE);
        try {
            String q = "SELECT "+residence_table.getColumn(0)+","
                    +residence_table.getColumn(1)+","
                    +residence_table.getColumn(2)+","
                    +residence_table.getColumn(3)+","
                    +residence_table.getColumn(4)+","
                    +residence_table.getColumn(5)+","
                    +residence_table.getColumn(6)+","
                    +residence_table.getColumn(7)+","
                    +residence_table.getColumn(8)+","
                    +residence_table.getColumn(9)+","
                    +residence_table.getColumn(10)+","
                    +residence_table.getColumn(11)+","
                    +residence_table.getColumn(12)+","
                    +residence_table.getColumn(13)+","
                    +residence_table.getColumn(14)+","
                    +residence_table.getColumn(15)+","
                    +residence_table.getColumn(16)+","
                    +residence_table.getColumn(17)+","
                    +residence_table.getColumn(18)+","
                    +residence_table.getColumn(19)+" FROM "
                    +residence_table.getTableName()+" WHERE ISNULL("
                    +residence_table.getColumn(18)+" ) UNION SELECT "
                    +residence_table.getColumn(0)+","
                    +residence_table.getColumn(1)+","
                    +residence_table.getColumn(2)+","
                    +residence_table.getColumn(3)+","
                    +residence_table.getColumn(4)+","
                    +residence_table.getColumn(5)+","
                    +residence_table.getColumn(6)+","
                    +residence_table.getColumn(7)+","
                    +residence_table.getColumn(8)+","
                    +residence_table.getColumn(9)+","
                    +residence_table.getColumn(10)+","
                    +residence_table.getColumn(11)+","
                    +residence_table.getColumn(12)+","
                    +residence_table.getColumn(13)+","
                    +residence_table.getColumn(14)+","
                    +residence_table.getColumn(15)+","
                    +residence_table.getColumn(16)+","
                    +residence_table.getColumn(17)+","
                    +residence_table.getColumn(18)+","
                    +residence_table.getColumn(19)+" FROM "
                    +residence_table.getTableName()+" WHERE "
                    +residence_table.getColumn(18)+">= CURDATE() ORDER BY "
                    +residence_table.getColumn(12);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Residence residence = new Residence();
                residence.setResidenceID(rs.getInt(residence_table.getColumn(0)));
                residence.setResidenceAddress(rs.getString(residence_table.getColumn(1)));
                residence.setResidencePostCode(rs.getString(residence_table.getColumn(2)));
                residence.setResidenceCity(rs.getString(residence_table.getColumn(3)));
                residence.setResidenceCountry(rs.getString(residence_table.getColumn(4)));
                residence.setResidenceSize(rs.getString(residence_table.getColumn(5)));
                residence.setResidenceDescription(rs.getString(residence_table.getColumn(6)));
                residence.setResidenceRent(rs.getDouble(residence_table.getColumn(7)));
                residence.setResidenceSideCosts(rs.getDouble(residence_table.getColumn(8)));
                residence.setResidenceMeterNumber(rs.getString(residence_table.getColumn(9)));
                residence.setResidenceStatus(rs.getInt(residence_table.getColumn(10)));
                residence.setResidenceOwner(rs.getInt(residence_table.getColumn(11)));
                residence.setResidenceMark(rs.getString(residence_table.getColumn(12)));
                residence.setVermieterWarmMiete(rs.getDouble(residence_table.getColumn(13)));
                residence.setVermieterKation(rs.getDouble(residence_table.getColumn(14)));
                residence.setVermieterKationPaidDate(rs.getDate(residence_table.getColumn(15)));
                residence.setResidenceKation(rs.getDouble(residence_table.getColumn(16)));
                residence.setVermieterMietStart(rs.getDate(residence_table.getColumn(17)));
                residence.setVermieterMietEnd(rs.getDate(residence_table.getColumn(18)));
                residence.setResidenceType(rs.getString(residence_table.getColumn(19)));
                residencesList.addElement(residence);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residencesList;
    }

    public Vector<Residence> getAllResidencesNotActive() {
        Vector<Residence> residencesList = new Vector<Residence>();
        Table residence_table=TableManager.getTable(TableManager.RPS_RESIDENCE);
        try {
            String q = "SELECT "+residence_table.getColumn(0)+","
                    +residence_table.getColumn(1)+","
                    +residence_table.getColumn(2)+","
                    +residence_table.getColumn(3)+","
                    +residence_table.getColumn(4)+","
                    +residence_table.getColumn(5)+","
                    +residence_table.getColumn(6)+","
                    +residence_table.getColumn(7)+","
                    +residence_table.getColumn(8)+","
                    +residence_table.getColumn(9)+","
                    +residence_table.getColumn(10)+","
                    +residence_table.getColumn(11)+","
                    +residence_table.getColumn(12)+","
                    +residence_table.getColumn(13)+","
                    +residence_table.getColumn(14)+","
                    +residence_table.getColumn(15)+","
                    +residence_table.getColumn(16)+","
                    +residence_table.getColumn(17)+","
                    +residence_table.getColumn(18)+" FROM "
                    +residence_table.getTableName()+" WHERE "
                    +residence_table.getColumn(18)+"<= CURDATE() ORDER BY "
                    +residence_table.getColumn(12);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Residence residence = new Residence();
                residence.setResidenceID(rs.getInt(residence_table.getColumn(0)));
                residence.setResidenceAddress(rs.getString(residence_table.getColumn(1)));
                residence.setResidencePostCode(rs.getString(residence_table.getColumn(2)));
                residence.setResidenceCity(rs.getString(residence_table.getColumn(3)));
                residence.setResidenceCountry(rs.getString(residence_table.getColumn(4)));
                residence.setResidenceSize(rs.getString(residence_table.getColumn(5)));
                residence.setResidenceDescription(rs.getString(residence_table.getColumn(6)));
                residence.setResidenceRent(rs.getDouble(residence_table.getColumn(7)));
                residence.setResidenceSideCosts(rs.getDouble(residence_table.getColumn(8)));
                residence.setResidenceMeterNumber(rs.getString(residence_table.getColumn(9)));
                residence.setResidenceStatus(rs.getInt(residence_table.getColumn(10)));
                residence.setResidenceOwner(rs.getInt(residence_table.getColumn(11)));
                residence.setResidenceMark(rs.getString(residence_table.getColumn(12)));
                residence.setVermieterWarmMiete(rs.getDouble(residence_table.getColumn(13)));
                residence.setVermieterKation(rs.getDouble(residence_table.getColumn(14)));
                residence.setVermieterKationPaidDate(rs.getDate(residence_table.getColumn(15)));
                residence.setResidenceKation(rs.getDouble(residence_table.getColumn(16)));
                residence.setVermieterMietStart(rs.getDate(residence_table.getColumn(17)));
                residence.setVermieterMietEnd(rs.getDate(residence_table.getColumn(18)));
                residencesList.addElement(residence);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residencesList;
    }

    public Vector<Residence> getAllResidencesByOwner( int ownerID) {
        Vector<Residence> residencesList = new Vector<Residence>();
        Table residence_table=TableManager.getTable(TableManager.RPS_RESIDENCE);
        try {
            String q = "SELECT "+residence_table.getColumn(0)+","+residence_table.getColumn(1)+","+residence_table.getColumn(2)+","+residence_table.getColumn(3)+","+residence_table.getColumn(4)+","+residence_table.getColumn(5)+","+residence_table.getColumn(6)+","+residence_table.getColumn(7)+","+residence_table.getColumn(8)+","+residence_table.getColumn(9)+","+residence_table.getColumn(10)+","+residence_table.getColumn(11)+","+residence_table.getColumn(12)+","+residence_table.getColumn(13)+","+residence_table.getColumn(14)+","+residence_table.getColumn(15)+","+residence_table.getColumn(16)+","+residence_table.getColumn(17)+","+residence_table.getColumn(18)+ "," + residence_table.getColumn(19) + " FROM "+residence_table.getTableName()+" WHERE "+residence_table.getColumn(11)+"='" + ownerID + "' ORDER BY "+residence_table.getColumn(12);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Residence residence = new Residence();
                residence.setResidenceID(rs.getInt(residence_table.getColumn(0)));
                residence.setResidenceAddress(rs.getString(residence_table.getColumn(1)));
                residence.setResidencePostCode(rs.getString(residence_table.getColumn(2)));
                residence.setResidenceCity(rs.getString(residence_table.getColumn(3)));
                residence.setResidenceCountry(rs.getString(residence_table.getColumn(4)));
                residence.setResidenceSize(rs.getString(residence_table.getColumn(5)));
                residence.setResidenceDescription(rs.getString(residence_table.getColumn(6)));
                residence.setResidenceRent(rs.getDouble(residence_table.getColumn(7)));
                residence.setResidenceSideCosts(rs.getDouble(residence_table.getColumn(8)));
                residence.setResidenceMeterNumber(rs.getString(residence_table.getColumn(9)));
                residence.setResidenceStatus(rs.getInt(residence_table.getColumn(10)));
                residence.setResidenceOwner(rs.getInt(residence_table.getColumn(11)));
                residence.setResidenceMark(rs.getString(residence_table.getColumn(12)));
                residence.setVermieterWarmMiete(rs.getDouble(residence_table.getColumn(13)));
                residence.setVermieterKation(rs.getDouble(residence_table.getColumn(14)));
                residence.setVermieterKationPaidDate(rs.getDate(residence_table.getColumn(15)));
                residence.setResidenceKation(rs.getDouble(residence_table.getColumn(16)));
                residence.setVermieterMietStart(rs.getDate(residence_table.getColumn(17)));
                residence.setVermieterMietEnd(rs.getDate(residence_table.getColumn(18)));
                residence.setResidenceType(rs.getString(residence_table.getColumn(19)));
                residencesList.addElement(residence);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residencesList;
    }

    public Vector<Residence> getAllResidencesByStatus( int residenceStatus) {
        Vector<Residence> residencesList = new Vector<Residence>();
        Table residence_table=TableManager.getTable(TableManager.RPS_RESIDENCE);
        try {
            String q = "SELECT "+residence_table.getColumn(0)+","+residence_table.getColumn(1)+","+residence_table.getColumn(2)+","+residence_table.getColumn(3)+","+residence_table.getColumn(4)+","+residence_table.getColumn(5)+","+residence_table.getColumn(6)+","+residence_table.getColumn(7)+","+residence_table.getColumn(8)+","+residence_table.getColumn(9)+","+residence_table.getColumn(10)+","+residence_table.getColumn(11)+","+residence_table.getColumn(12)+","+residence_table.getColumn(13)+","+residence_table.getColumn(14)+","+residence_table.getColumn(15)+","+residence_table.getColumn(16)+","+residence_table.getColumn(17)+","+residence_table.getColumn(18)+" FROM "+residence_table.getTableName()+" WHERE "+residence_table.getColumn(18)+"='" + residenceStatus + "' ORDER BY "+residence_table.getColumn(12);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Residence residence = new Residence();
                residence.setResidenceID(rs.getInt(residence_table.getColumn(0)));
                residence.setResidenceAddress(rs.getString(residence_table.getColumn(1)));
                residence.setResidencePostCode(rs.getString(residence_table.getColumn(2)));
                residence.setResidenceCity(rs.getString(residence_table.getColumn(3)));
                residence.setResidenceCountry(rs.getString(residence_table.getColumn(4)));
                residence.setResidenceSize(rs.getString(residence_table.getColumn(5)));
                residence.setResidenceDescription(rs.getString(residence_table.getColumn(6)));
                residence.setResidenceRent(rs.getDouble(residence_table.getColumn(7)));
                residence.setResidenceSideCosts(rs.getDouble(residence_table.getColumn(8)));
                residence.setResidenceMeterNumber(rs.getString(residence_table.getColumn(9)));
                residence.setResidenceStatus(rs.getInt(residence_table.getColumn(10)));
                residence.setResidenceOwner(rs.getInt(residence_table.getColumn(11)));
                residence.setResidenceMark(rs.getString(residence_table.getColumn(12)));
                residence.setVermieterWarmMiete(rs.getDouble(residence_table.getColumn(13)));
                residence.setVermieterKation(rs.getDouble(residence_table.getColumn(14)));
                residence.setVermieterKationPaidDate(rs.getDate(residence_table.getColumn(15)));
                residence.setResidenceKation(rs.getDouble(residence_table.getColumn(16)));
                residence.setVermieterMietStart(rs.getDate(residence_table.getColumn(17)));
                residence.setVermieterMietEnd(rs.getDate(residence_table.getColumn(18)));
                residencesList.addElement(residence);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residencesList;
    }

    public Residence getResidence( int residenceID) {
        Residence residence = new Residence();
        Table residence_table=TableManager.getTable(TableManager.RPS_RESIDENCE);
        try {
            String q = "SELECT "+residence_table.getColumn(0)+","+residence_table.getColumn(1)+","+residence_table.getColumn(2)+","+residence_table.getColumn(3)+","+residence_table.getColumn(4)+","+residence_table.getColumn(5)+","+residence_table.getColumn(6)+","+residence_table.getColumn(7)+","+residence_table.getColumn(8)+","+residence_table.getColumn(9)+","+residence_table.getColumn(10)+","+residence_table.getColumn(11)+","+residence_table.getColumn(12)+","+residence_table.getColumn(13)+","+residence_table.getColumn(14)+","+residence_table.getColumn(15)+","+residence_table.getColumn(16)+","+residence_table.getColumn(17)+","+residence_table.getColumn(18)+ "," + residence_table.getColumn(19) +" FROM "+residence_table.getTableName()+" WHERE "+residence_table.getColumn(0)+"='" + residenceID+"'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                residence.setResidenceID(rs.getInt(residence_table.getColumn(0)));
                residence.setResidenceAddress(rs.getString(residence_table.getColumn(1)));
                residence.setResidencePostCode(rs.getString(residence_table.getColumn(2)));
                residence.setResidenceCity(rs.getString(residence_table.getColumn(3)));
                residence.setResidenceCountry(rs.getString(residence_table.getColumn(4)));
                residence.setResidenceSize(rs.getString(residence_table.getColumn(5)));
                residence.setResidenceDescription(rs.getString(residence_table.getColumn(6)));
                residence.setResidenceRent(rs.getDouble(residence_table.getColumn(7)));
                residence.setResidenceSideCosts(rs.getDouble(residence_table.getColumn(8)));
                residence.setResidenceMeterNumber(rs.getString(residence_table.getColumn(9)));
                residence.setResidenceStatus(rs.getInt(residence_table.getColumn(10)));
                residence.setResidenceOwner(rs.getInt(residence_table.getColumn(11)));
                residence.setResidenceMark(rs.getString(residence_table.getColumn(12)));
                residence.setVermieterWarmMiete(rs.getDouble(residence_table.getColumn(13)));
                residence.setVermieterKation(rs.getDouble(residence_table.getColumn(14)));
                residence.setVermieterKationPaidDate(rs.getDate(residence_table.getColumn(15)));
                residence.setResidenceKation(rs.getDouble(residence_table.getColumn(16)));
                residence.setVermieterMietStart(rs.getDate(residence_table.getColumn(17)));
                residence.setVermieterMietEnd(rs.getDate(residence_table.getColumn(18)));
                residence.setResidenceType(rs.getString(residence_table.getColumn(19)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residence;
    }

    public int addNewRentIn(Residence residence) {
        int transactionNo=-1;
        Table table=TableManager.getTable(TableManager.RPS_RENTINCOMING);
        try{
            String q = "INSERT INTO "+table.getTableName()+" ("
                    +table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(8)+","
                    +table.getColumn(9)+","
                    +table.getColumn(10)+","
                    +table.getColumn(11)+","
                    +table.getColumn(12)+") VALUES ("
                    + residence.getResidenceID()+ ","
                    + residence.getRentMonth()+ ","
                    + residence.getRentYear()+ ","
                    + residence.getAmountPaid()+ ","
                    + residence.getDeleteFunction()+ ","
                    + replaceNull(residence.getRentDate())+","
                    + replaceNull(residence.getPaymentModeID())+ ","
                    + replaceNull(residence.getLoginName())+ ","
                    + replaceNull(residence.getPlaceName())+ ","
                    + replaceNull(residence.getAmountBalance())+ ","
                    + replaceNull(residence.getRentPlaceID())+ ","
                    + replaceNull(residence.getRentLoginID())+ ")";
            // TODO: remove redundant select query for getting last inserted transaction no id
            int tranno = DBHelper.getInstance().updateQueryGetPrimary(q);
            q = "SELECT "+table.getColumn(7)+" FROM "+table.getTableName();
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            int value=0;
            while(rs.next()){
                value = rs.getInt(table.getColumn(7));
            }
            if(value>0){
                transactionNo=value;
            }
            transactionNo = tranno;
        }catch(Exception e){
            setError(e.toString());
        }
        return transactionNo;
    }

    public int deleteRentIn(Residence residence) {
        int chk=0;
        Table table=TableManager.getTable(TableManager.RPS_RENTINCOMING);
        try{

            String q1 = "DELETE FROM " +table.getTableName()+ " WHERE "
                    + table.getColumn(4) + "='" + residence.getDeleteFunction()+ "'";

            DBHelper.getInstance().updateQuery(q1);

            chk = 1;
        }catch(Exception e){
            setError(e.toString());
        }
        return chk;
    }

    public HashMap<Integer, Double> getRentInAsDouble(List<Integer> residences, int month, int year) {
        HashMap<Integer, Double> rents = new HashMap<>();

        StringBuilder ids = new StringBuilder("(");
        for (int i = 0; i < residences.size(); i++) {
            ids.append(residences.get(i));
            if(i+1 == residences.size()) {
                ids.append(")");
            } else {
                ids.append(", ");
            }
            rents.put(residences.get(i), 0.0);
        }


        Table residence_table=TableManager.getTable(TableManager.RPS_RENTINCOMING);
        try {
            String q = "SELECT residenceID, sum("
                    +residence_table.getColumn(3)+") AS AmoutPaid FROM "
                    +residence_table.getTableName()+" WHERE "
                    +residence_table.getColumn(0)+" IN " + ids.toString() +" AND "
                    +residence_table.getColumn(1)+"=" + month+" AND "
                    +residence_table.getColumn(2)+"=" +year+" GROUP BY "
                    +residence_table.getColumn(0);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                double found = rs.getDouble("AmountPaid");
                rents.put(rs.getInt("residenceID"), found);
            }
        } catch (Exception e) {
            setError(e.toString());
        }


        return rents;
    }

    public double getRentInAsDouble( int residenceID, int month, int year) {
        double foundRentIn = 0;
        Table residence_table=TableManager.getTable(TableManager.RPS_RENTINCOMING);
        try {
            String q = "SELECT sum("
                    +residence_table.getColumn(3)+") AS AmoutPaid FROM "
                    +residence_table.getTableName()+" WHERE "
                    +residence_table.getColumn(0)+"='" + residenceID+"' AND "
                    +residence_table.getColumn(1)+"=" + month+" AND "
                    +residence_table.getColumn(2)+"=" +year+" GROUP BY "
                    +residence_table.getColumn(0);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                foundRentIn = rs.getDouble("AmoutPaid");
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return foundRentIn;
    }

    public Residence getRentIn( int residenceID, int month, int year) {
        Residence residence = new Residence();
        Table residence_table=TableManager.getTable(TableManager.RPS_RENTINCOMING);
        try {
            String q = "SELECT "+residence_table.getColumn(0)+","
                    +residence_table.getColumn(1)+","
                    +residence_table.getColumn(2)+", sum("
                    +residence_table.getColumn(3)+") AS AmoutPaid,"
                    +residence_table.getColumn(4)+","
                    +residence_table.getColumn(5)+","
                    +residence_table.getColumn(6)+","
                    +residence_table.getColumn(7)+","
                    +residence_table.getColumn(8)+","
                    +residence_table.getColumn(9)+","
                    +residence_table.getColumn(10)+" FROM "
                    +residence_table.getTableName()+" WHERE "
                    +residence_table.getColumn(0)+"='" + residenceID+"' AND "
                    +residence_table.getColumn(1)+"=" + month+" AND "
                    +residence_table.getColumn(2)+"=" +year+" GROUP BY "
                    +residence_table.getColumn(0);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                residence.setResidenceID(rs.getInt(residence_table.getColumn(0)));
                residence.setRentMonth(rs.getInt(residence_table.getColumn(1)));
                residence.setRentYear(rs.getInt(residence_table.getColumn(2)));
                residence.setAmountPaid(rs.getDouble("AmoutPaid"));
                residence.setDeleteFunction(rs.getInt(residence_table.getColumn(4)));
                residence.setRentDate(rs.getDate(residence_table.getColumn(5)));
                residence.setPaymentModeID(rs.getInt(residence_table.getColumn(6)));
                residence.setRentIncomingID(rs.getInt(residence_table.getColumn(7)));
                residence.setLoginName(rs.getString(residence_table.getColumn(8)));
                residence.setPlaceName(rs.getString(residence_table.getColumn(9)));
                residence.setAmountBalance(rs.getDouble(residence_table.getColumn(10)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residence;
    }

    public Vector<Residence> getRentInActive(){
        Vector<Residence> residencesList = new Vector<Residence>();
        Table residence_table=TableManager.getTable(TableManager.RPS_RESIDENCE);
        Table rent_table=TableManager.getTable(TableManager.RPS_RENTINCOMING);
        Table resident_table=TableManager.getTable(TableManager.RPS_RESIDENT);
        try {
            String q = "SELECT a."+residence_table.getColumn(0)+",a."+residence_table.getColumn(19)+",a."
                    +residence_table.getColumn(12)+",a."
                    +residence_table.getColumn(7)+",sum(c."
                    +rent_table.getColumn(3)+") AS rentAmount,sum(d."
                    +rent_table.getColumn(3)+") AS rentAmount1,sum(e."
                    +rent_table.getColumn(3)+") AS rentAmount2,sum(f."
                    +rent_table.getColumn(3)+") AS rentAmount3,sum(g."
                    +rent_table.getColumn(3)+") AS rentAmount4,sum(h."
                    +rent_table.getColumn(3)+") AS rentAmount5, IF(ISNULL(b."
                    +resident_table.getColumn(1)+"),NULL,b."+resident_table.getColumn(1)+") AS FirstName,IF(ISNULL(b."
                    +resident_table.getColumn(2)+"),NULL,b."+resident_table.getColumn(2)+") AS LastName,IF(curdate()>b."
                    +resident_table.getColumn(23)+"," + "'Frei',DATE_FORMAT(b." +resident_table.getColumn(23)+",'%d-%m-%Y')) AS LastDate FROM "
                    +residence_table.getTableName()+" AS a LEFT JOIN "
                    +resident_table.getTableName()+" AS b ON b."
                    +resident_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" AND (b."
                    +resident_table.getColumn(23)+" >= curdate() OR isnull(b."+resident_table.getColumn(23)+")) LEFT JOIN "
                    +rent_table.getTableName()+" AS c ON MONTH(DATE_SUB(curdate(),INTERVAL 0 month))= (c."
                    +rent_table.getColumn(1)+") AND c."
                    +rent_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" LEFT JOIN "
                    +rent_table.getTableName()+" AS d ON MONTH(DATE_SUB(curdate(),INTERVAL 1 month))= (d."
                    +rent_table.getColumn(1)+") AND d."
                    +rent_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" LEFT JOIN "
                    +rent_table.getTableName()+" AS e ON MONTH(DATE_SUB(curdate(),INTERVAL 2 month))= (e."
                    +rent_table.getColumn(1)+") AND e."
                    +rent_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" LEFT JOIN "
                    +rent_table.getTableName()+" AS f ON MONTH(DATE_SUB(curdate(),INTERVAL 3 month))= (f."
                    +rent_table.getColumn(1)+") AND f."
                    +rent_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" LEFT JOIN "
                    +rent_table.getTableName()+" AS g ON MONTH(DATE_SUB(curdate(),INTERVAL 4 month))= (g."
                    +rent_table.getColumn(1)+") AND g."
                    +rent_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" LEFT JOIN "
                    +rent_table.getTableName()+" AS h ON MONTH(DATE_SUB(curdate(),INTERVAL 5 month))= (h."
                    +rent_table.getColumn(1)+") AND h."
                    +rent_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" WHERE (a."
                    +residence_table.getColumn(18)+" >= curdate() OR isnull(a."+residence_table.getColumn(18)+")) GROUP BY a."
                    +residence_table.getColumn(0)+" ORDER BY a."
                    +residence_table.getColumn(12);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            System.out.println(q);
            while (rs.next()) {
                Residence residence = new Residence();
                residence.setResidenceID(rs.getInt(residence_table.getColumn(0)));
                residence.setResidenceMark(rs.getString(residence_table.getColumn(12)));
                residence.setResidenceRent(rs.getDouble(residence_table.getColumn(7)));
                residence.setAmountPaid(rs.getDouble("rentAmount"));
                residence.setPaidAmtCurr1(rs.getDouble("rentAmount1"));
                residence.setPaidAmtCurr2(rs.getDouble("rentAmount2"));
                residence.setPaidAmtCurr3(rs.getDouble("rentAmount3"));
                residence.setPaidAmtCurr4(rs.getDouble("rentAmount4"));
                residence.setPaidAmtCurr5(rs.getDouble("rentAmount5"));
                residence.setUserFirstName(rs.getString("FirstName"));
                residence.setUserLastName(rs.getString("LastName"));
                residence.setUserAddress(rs.getString("LastDate"));
                residence.setResidenceType(rs.getString(residence_table.getColumn(19)));
                //residence.setPaidAmtCurr1(rs.getDouble(residence_table.getColumn(4)));
                //residence.setPaidAmtCurr2(rs.getDouble(residence_table.getColumn(5)));
                //residence.setPaidAmtCurr3(rs.getDouble(residence_table.getColumn(6)));
                //residence.setPaidAmtCurr4(rs.getDouble(residence_table.getColumn(7)));
                //residence.setPaidAmtCurr5(rs.getDouble(residence_table.getColumn(8)));
                residencesList.addElement(residence);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residencesList;
    }

    public Vector<Residence> getRentInActive1(){
        Vector<Residence> residencesList = new Vector<Residence>();
        Table residence_table=TableManager.getTable(TableManager.RPS_RESIDENCE);
        Table rent_table=TableManager.getTable(TableManager.RPS_RENTINCOMING);
        Table resident_table=TableManager.getTable(TableManager.RPS_RESIDENT);
        try {
            String q = "SELECT a."+residence_table.getColumn(0)+",a."
                    +residence_table.getColumn(12)+",a."
                    +residence_table.getColumn(7)+",sum(c."
                    +rent_table.getColumn(3)+") AS rentAmount, IF(ISNULL(b."
                    +resident_table.getColumn(1)+"),' ',b."+resident_table.getColumn(1)+") AS FirstName,IF(ISNULL(b."
                    +resident_table.getColumn(2)+"),' ',b."+resident_table.getColumn(2)+") AS LastName,IF(curdate()>b."
                    +resident_table.getColumn(23)+",'Frei',DATE_FORMAT(b."+resident_table.getColumn(23)+",'%d-%m-%Y')) AS LastDate FROM "
                    +residence_table.getTableName()+" AS a LEFT JOIN "
                    +resident_table.getTableName()+" AS b ON b."
                    +resident_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" AND (b."
                    +resident_table.getColumn(23)+" >= curdate() OR isnull(b."+resident_table.getColumn(23)+")) LEFT JOIN "
                    +rent_table.getTableName()+" AS c ON MONTH(DATE_SUB(curdate(),INTERVAL 0 month))= (c."
                    +rent_table.getColumn(1)+") AND c."
                    +rent_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" WHERE (a."
                    +residence_table.getColumn(18)+" >= curdate() OR isnull(a."+residence_table.getColumn(18)+")) GROUP BY a."
                    +residence_table.getColumn(0)+" ORDER BY a."
                    +residence_table.getColumn(12);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Residence residence = new Residence();
                residence.setResidenceID(rs.getInt(residence_table.getColumn(0)));
                residence.setResidenceMark(rs.getString(residence_table.getColumn(12)));
                residence.setResidenceRent(rs.getDouble(residence_table.getColumn(7)));
                residence.setAmountPaid(rs.getDouble("rentAmount"));
                residence.setUserFirstName(rs.getString("FirstName"));
                residence.setUserLastName(rs.getString("LastName"));
                residence.setUserAddress(rs.getString("LastDate"));
                //residence.setPaidAmtCurr1(rs.getDouble(residence_table.getColumn(4)));
                //residence.setPaidAmtCurr2(rs.getDouble(residence_table.getColumn(5)));
                //residence.setPaidAmtCurr3(rs.getDouble(residence_table.getColumn(6)));
                //residence.setPaidAmtCurr4(rs.getDouble(residence_table.getColumn(7)));
                //residence.setPaidAmtCurr5(rs.getDouble(residence_table.getColumn(8)));
                residencesList.addElement(residence);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residencesList;
    }

    public Vector<Residence> getRentInNotActive(){
        Vector<Residence> residencesList = new Vector<Residence>();
        Table residence_table=TableManager.getTable(TableManager.RPS_RESIDENCE);
        Table rent_table=TableManager.getTable(TableManager.RPS_RENTINCOMING);
        try {
            String q = "SELECT a."+residence_table.getColumn(0)+",a."
                    +residence_table.getColumn(12)+",a."
                    +residence_table.getColumn(7)+",sum(c."
                    +rent_table.getColumn(3)+") AS rentAmount FROM "
                    +residence_table.getTableName()+" AS a LEFT JOIN "
                    +rent_table.getTableName()+" AS c ON MONTH(DATE_SUB(curdate(),INTERVAL 0 month))= (c."
                    +rent_table.getColumn(1)+") AND c."
                    +rent_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" WHERE a."
                    +residence_table.getColumn(18)+" <= curdate()  GROUP BY a."
                    +residence_table.getColumn(0)+" ORDER BY a."
                    +residence_table.getColumn(12);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Residence residence = new Residence();
                residence.setResidenceID(rs.getInt(residence_table.getColumn(0)));
                residence.setResidenceMark(rs.getString(residence_table.getColumn(12)));
                residence.setResidenceRent(rs.getDouble(residence_table.getColumn(7)));
                residence.setAmountPaid(rs.getDouble("rentAmount"));
                //residence.setPaidAmtCurr1(rs.getDouble(residence_table.getColumn(4)));
                //residence.setPaidAmtCurr2(rs.getDouble(residence_table.getColumn(5)));
                //residence.setPaidAmtCurr3(rs.getDouble(residence_table.getColumn(6)));
                //residence.setPaidAmtCurr4(rs.getDouble(residence_table.getColumn(7)));
                //residence.setPaidAmtCurr5(rs.getDouble(residence_table.getColumn(8)));
                residencesList.addElement(residence);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residencesList;
    }

    public Vector<Residence> getRentInSeparate(int residenceID){
        Vector<Residence> residencesList = new Vector<Residence>();
        Table rent_table=TableManager.getTable(TableManager.RPS_RENTINCOMING);
        Table residence_table=TableManager.getTable(TableManager.RPS_RESIDENCE);
        try {
            String q = "SELECT a."+rent_table.getColumn(0)+",a."
                    +rent_table.getColumn(1)+",a."
                    +rent_table.getColumn(2)+",a."
                    +rent_table.getColumn(3)+",a."
                    +rent_table.getColumn(4)+",a."
                    +rent_table.getColumn(5)+",a."
                    +rent_table.getColumn(6)+",a."
                    +rent_table.getColumn(7)+",a."
                    +rent_table.getColumn(8)+",a."
                    +rent_table.getColumn(9)+",b."
                    +residence_table.getColumn(12)+",b."
                    +residence_table.getColumn(18)+" FROM "
                    +rent_table.getTableName()+" AS a,"
                    +residence_table.getTableName()+" AS b WHERE a."
                    +rent_table.getColumn(0)+"='" + residenceID+"' AND b."
                    +rent_table.getColumn(0)+"= a."+residence_table.getColumn(0)+" ORDER BY a."
                    +rent_table.getColumn(7);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Residence residence = new Residence();
                residence.setResidenceID(rs.getInt(rent_table.getColumn(0)));
                residence.setRentMonth(rs.getInt(rent_table.getColumn(1)));
                residence.setRentYear(rs.getInt(rent_table.getColumn(2)));
                residence.setAmountPaid(rs.getDouble(rent_table.getColumn(3)));
                residence.setDeleteFunction(rs.getInt(rent_table.getColumn(4)));
                residence.setRentDate(rs.getDate(rent_table.getColumn(5)));
                residence.setPaymentModeID(rs.getInt(rent_table.getColumn(6)));
                residence.setRentIncomingID(rs.getInt(rent_table.getColumn(7)));
                residence.setLoginName(rs.getString(rent_table.getColumn(8)));
                residence.setPlaceName(rs.getString(rent_table.getColumn(9)));
                residence.setResidenceMark(rs.getString(residence_table.getColumn(12)));
                residence.setVermieterMietEnd(rs.getDate(residence_table.getColumn(18)));
                residencesList.addElement(residence);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residencesList;
    }

    public Vector<Residence> getRentInFirstPrint(int residenceID){
        Vector<Residence> residencesList = new Vector<Residence>();
        Table rent_table=TableManager.getTable(TableManager.RPS_RENTINCOMING);
        Table residence_table=TableManager.getTable(TableManager.RPS_RESIDENCE);
        try {
            String q = "SELECT a."+rent_table.getColumn(0)+",a."
                    +rent_table.getColumn(1)+",a."
                    +rent_table.getColumn(2)+",a."
                    +rent_table.getColumn(3)+",a."
                    +rent_table.getColumn(4)+",a."
                    +rent_table.getColumn(5)+",a."
                    +rent_table.getColumn(6)+",a."
                    +rent_table.getColumn(7)+",a."
                    +rent_table.getColumn(8)+",a."
                    +rent_table.getColumn(9)+",b."
                    +residence_table.getColumn(12)+",b."
                    +residence_table.getColumn(18)+" FROM "
                    +rent_table.getTableName()+" AS a,"
                    +residence_table.getTableName()+" AS b WHERE a."
                    +rent_table.getColumn(0)+"='" + residenceID+"' AND b."
                    +rent_table.getColumn(0)+"= a."+residence_table.getColumn(0)+" ORDER BY a."
                    +rent_table.getColumn(7)+" DESC limit 1";

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Residence residence = new Residence();
                residence.setResidenceID(rs.getInt(rent_table.getColumn(0)));
                residence.setRentMonth(rs.getInt(rent_table.getColumn(1)));
                residence.setRentYear(rs.getInt(rent_table.getColumn(2)));
                residence.setAmountPaid(rs.getDouble(rent_table.getColumn(3)));
                residence.setDeleteFunction(rs.getInt(rent_table.getColumn(4)));
                residence.setRentDate(rs.getDate(rent_table.getColumn(5)));
                residence.setPaymentModeID(rs.getInt(rent_table.getColumn(6)));
                residence.setRentIncomingID(rs.getInt(rent_table.getColumn(7)));
                residence.setLoginName(rs.getString(rent_table.getColumn(8)));
                residence.setPlaceName(rs.getString(rent_table.getColumn(9)));
                residence.setResidenceMark(rs.getString(residence_table.getColumn(12)));
                residence.setVermieterMietEnd(rs.getDate(residence_table.getColumn(18)));
                residencesList.addElement(residence);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residencesList;
    }

    public Residence getRentInPrint(int rentIncomingID) {
        Residence residence = new Residence();
        try {
            //String q = "select rent.rentMonth AS rentMonth,rent.rentYear AS rentYear,rent.amountPaid AS amountPaid,rent.rentDate AS rentDate,rent.rentIncomingID AS rentIncomingID, rent.amountBalance AS amountBalance, residence.residenceRent AS residenceRent,residence.residenceMark AS residenceMark,CONCAT_WS(' ', stu.userFirstName, res.userFirstName) AS userFirstName,CONCAT_WS(' ', stu.userLastName, res.userLastName) AS userLastName,CONCAT_WS(' ', stu.userAddress, res.userAddress) AS userAddress,CONCAT_WS(' ', stu.userPostCode, res.userPostCode) AS userPostCode,CONCAT_WS(' ', stu.userCity, res.userCity) AS userCity FROM rps_rentincoming AS rent,RPS_residencemieten AS miet,RPS_residence AS residence,RPS_resident res LEFT JOIN RPS_user stu ON res.studentReference = stu.userID WHERE rent.residenceID = miet.residenceID AND miet.residentID = res.userID AND residence.residenceID = rent.residenceID AND rent.rentincomingID ="+rentIncomingID;
            String q = "select rent.rentMonth AS rentMonth,rent.rentYear AS rentYear,rent.amountPaid AS amountPaid,rent.rentDate AS rentDate,rent.rentIncomingID AS rentIncomingID, rent.amountBalance AS amountBalance, residence.residenceRent AS residenceRent,residence.residenceMark AS residenceMark,CONCAT_WS(' ', stu.userFirstName, res.userFirstName) AS userFirstName,CONCAT_WS(' ', stu.userLastName, res.userLastName) AS userLastName,residence.residenceAddress AS userAddress,residence.residencePostCode AS userPostCode,residence.residenceCity AS userCity FROM rps_rentincoming AS rent,rps_residence AS residence,RPS_resident res LEFT JOIN RPS_user stu ON res.studentReference = stu.userID WHERE rent.residenceID = res.userID AND residence.residenceID = rent.residenceID AND rent.rentincomingID ="+rentIncomingID;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                residence.setRentMonth(rs.getInt("rentMonth"));
                residence.setRentYear(rs.getInt("rentYear"));
                residence.setAmountPaid(rs.getDouble("amountPaid"));
                residence.setRentDate(rs.getDate("rentDate"));
                residence.setRentIncomingID(rs.getInt("rentIncomingID"));
                residence.setAmountBalance(rs.getDouble("amountBalance"));
                residence.setResidenceRent(rs.getDouble("residenceRent"));
                residence.setResidenceMark(rs.getString("residenceMark"));
                residence.setUserFirstName(rs.getString("userFirstName"));
                residence.setUserLastName(rs.getString("userLastName"));
                residence.setUserAddress(rs.getString("userAddress"));
                residence.setUserPostCode(rs.getString("userPostCode"));
                residence.setUserCity(rs.getString("userCity"));

            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residence;
    }

    public Vector<Residence> getRentInPrintMain(String rentIncomingID) {
        Vector<Residence> residencesList = new Vector<Residence>();
        try {
            //String q = "select rent.rentMonth AS rentMonth,rent.rentYear AS rentYear,rent.amountPaid AS amountPaid,rent.rentDate AS rentDate,rent.rentIncomingID AS rentIncomingID, rent.amountBalance AS amountBalance, residence.residenceRent AS residenceRent,residence.residenceMark AS residenceMark,CONCAT_WS(' ', stu.userFirstName, res.userFirstName) AS userFirstName,CONCAT_WS(' ', stu.userLastName, res.userLastName) AS userLastName,CONCAT_WS(' ', stu.userAddress, res.userAddress) AS userAddress,CONCAT_WS(' ', stu.userPostCode, res.userPostCode) AS userPostCode,CONCAT_WS(' ', stu.userCity, res.userCity) AS userCity FROM rps_rentincoming AS rent,RPS_residencemieten AS miet,RPS_residence AS residence,RPS_resident res LEFT JOIN RPS_user stu ON res.studentReference = stu.userID WHERE rent.residenceID = miet.residenceID AND miet.residentID = res.userID AND residence.residenceID = rent.residenceID AND rent.rentincomingID ="+rentIncomingID;
            String q = "select rent.rentMonth AS rentMonth,rent.rentYear AS rentYear,rent.amountPaid AS amountPaid,rent.rentDate AS rentDate,rent.rentIncomingID AS rentIncomingID, rent.amountBalance AS amountBalance, residence.residenceRent AS residenceRent,residence.residenceMark AS residenceMark,CONCAT_WS(' ', stu.userFirstName, res.userFirstName) AS userFirstName,CONCAT_WS(' ', stu.userLastName, res.userLastName) AS userLastName,residence.residenceAddress AS userAddress,residence.residencePostCode AS userPostCode,residence.residenceCity AS userCity FROM rps_rentincoming AS rent,rps_residence AS residence LEFT JOIN rps_resident AS res ON residence.residenceID = res.userID and (res.mietEnd >= curdate() OR isnull(res.mietEnd)) LEFT JOIN rps_user stu ON res.studentReference = stu.userID  WHERE residence.residenceID = rent.residenceID AND rent.rentincomingID ="+rentIncomingID;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Residence residence = new Residence();
                residence.setRentMonth(rs.getInt("rentMonth"));
                residence.setRentYear(rs.getInt("rentYear"));
                residence.setAmountPaid(rs.getDouble("amountPaid"));
                residence.setRentDate(rs.getDate("rentDate"));
                residence.setRentIncomingID(rs.getInt("rentIncomingID"));
                residence.setAmountBalance(rs.getDouble("amountBalance"));
                residence.setResidenceRent(rs.getDouble("residenceRent"));
                residence.setResidenceMark(rs.getString("residenceMark"));
                residence.setUserFirstName(rs.getString("userFirstName"));
                residence.setUserLastName(rs.getString("userLastName"));
                residence.setUserAddress(rs.getString("userAddress"));
                residence.setUserPostCode(rs.getString("userPostCode"));
                residence.setUserCity(rs.getString("userCity"));
                residencesList.addElement(residence);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residencesList;
    }

    public int addNewRentOut(Residence residence) {
        int transactionNo=-1;
        Table table=TableManager.getTable(TableManager.RPS_RENTOUTGOING);
        try{
            String q = "INSERT INTO "+table.getTableName()+" ("
                    +table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(8)+","
                    +table.getColumn(9)+","
                    +table.getColumn(10)+") VALUES ("
                    + residence.getResidenceID()+ ","
                    + residence.getRentMonth()+ ","
                    + residence.getRentYear()+ ","
                    + residence.getAmountPaid()+ ","
                    + residence.getDeleteFunction()+ ","
                    + replaceNull(residence.getRentDate())+","
                    + replaceNull(residence.getPaymentModeID())+ ","
                    + replaceNull(residence.getLoginName())+ ","
                    + replaceNull(residence.getPlaceName())+ ","
                    + replaceNull(residence.getAmountBalance())+ ")";
            DBHelper.getInstance().updateQuery(q);
            q = "SELECT "+table.getColumn(7)+" FROM "+table.getTableName();
            ResultSet rs= DBHelper.getInstance().executeQuery(q);
            int value=0;
            while(rs.next()){
                value = rs.getInt(table.getColumn(7));
            }
            if(value>0){
                transactionNo=value;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return transactionNo;
    }

    public int deleteRentOut(Residence residence) {
        int chk=0;
        Table table=TableManager.getTable(TableManager.RPS_RENTOUTGOING);
        try{

            String q1 = "DELETE FROM " +table.getTableName()+ " WHERE "
                    + table.getColumn(4) + "='" + residence.getDeleteFunction()+ "'";

            DBHelper.getInstance().updateQuery(q1);

            chk = 1;
        }catch(Exception e){
            setError(e.toString());
        }
        return chk;
    }

    public Residence getRentOut( int residenceID, int month, int year) {
        Residence residence = new Residence();
        Table residence_table=TableManager.getTable(TableManager.RPS_RENTOUTGOING);
        try {
            String q = "SELECT "+residence_table.getColumn(0)+","
                    +residence_table.getColumn(1)+","
                    +residence_table.getColumn(2)+", sum("
                    +residence_table.getColumn(3)+") AS AmoutPaid,"
                    +residence_table.getColumn(4)+","
                    +residence_table.getColumn(5)+","
                    +residence_table.getColumn(6)+","
                    +residence_table.getColumn(7)+","
                    +residence_table.getColumn(8)+","
                    +residence_table.getColumn(9)+","
                    +residence_table.getColumn(10)+" FROM "
                    +residence_table.getTableName()+" WHERE "
                    +residence_table.getColumn(0)+"='" + residenceID+"' AND "
                    +residence_table.getColumn(1)+"=" + month+" AND "
                    +residence_table.getColumn(2)+"=" +year+" GROUP BY "
                    +residence_table.getColumn(0);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                residence.setResidenceID(rs.getInt(residence_table.getColumn(0)));
                residence.setRentMonth(rs.getInt(residence_table.getColumn(1)));
                residence.setRentYear(rs.getInt(residence_table.getColumn(2)));
                residence.setAmountPaid(rs.getDouble("AmoutPaid"));
                residence.setDeleteFunction(rs.getInt(residence_table.getColumn(4)));
                residence.setRentDate(rs.getDate(residence_table.getColumn(5)));
                residence.setPaymentModeID(rs.getInt(residence_table.getColumn(6)));
                residence.setRentIncomingID(rs.getInt(residence_table.getColumn(7)));
                residence.setLoginName(rs.getString(residence_table.getColumn(8)));
                residence.setPlaceName(rs.getString(residence_table.getColumn(9)));
                residence.setAmountBalance(rs.getDouble(residence_table.getColumn(10)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residence;
    }

    public Vector<Residence> getRentOutActive(){
        Vector<Residence> residencesList = new Vector<Residence>();
        Table residence_table=TableManager.getTable(TableManager.RPS_RESIDENCE);
        Table rent_table=TableManager.getTable(TableManager.RPS_RENTOUTGOING);
        Table resident_table=TableManager.getTable(TableManager.RPS_RESIDENCEOWNER);
        try {
            String q = "SELECT a."+residence_table.getColumn(0)+",a."
                    +residence_table.getColumn(12)+",a."
                    +residence_table.getColumn(13)+",sum(c."
                    +rent_table.getColumn(3)+") AS rentAmount,sum(d."
                    +rent_table.getColumn(3)+") AS rentAmount1,sum(e."
                    +rent_table.getColumn(3)+") AS rentAmount2,sum(f."
                    +rent_table.getColumn(3)+") AS rentAmount3,sum(g."
                    +rent_table.getColumn(3)+") AS rentAmount4,sum(h."
                    +rent_table.getColumn(3)+") AS rentAmount5, IF(ISNULL(b."
                    +resident_table.getColumn(2)+"),NULL,b."+resident_table.getColumn(2)+") AS FirstName,IF(ISNULL(b."
                    +resident_table.getColumn(3)+"),NULL,b."+resident_table.getColumn(3)+") AS LastName,IF(curdate()>a."
                    +residence_table.getColumn(18)+"," + "'Frei',DATE_FORMAT(a." +residence_table.getColumn(18)+",'%d-%m-%Y')) AS LastDate FROM "
                    +residence_table.getTableName()+" AS a LEFT JOIN "
                    +resident_table.getTableName()+" AS b ON b."
                    +resident_table.getColumn(0)+" = a."+residence_table.getColumn(11)+" AND (a."
                    +residence_table.getColumn(18)+" >= curdate() OR isnull(a."+residence_table.getColumn(18)+")) LEFT JOIN "
                    +rent_table.getTableName()+" AS c ON MONTH(DATE_SUB(curdate(),INTERVAL 0 month))= (c."
                    +rent_table.getColumn(1)+") AND c."
                    +rent_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" LEFT JOIN "
                    +rent_table.getTableName()+" AS d ON MONTH(DATE_SUB(curdate(),INTERVAL 1 month))= (d."
                    +rent_table.getColumn(1)+") AND d."
                    +rent_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" LEFT JOIN "
                    +rent_table.getTableName()+" AS e ON MONTH(DATE_SUB(curdate(),INTERVAL 2 month))= (e."
                    +rent_table.getColumn(1)+") AND e."
                    +rent_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" LEFT JOIN "
                    +rent_table.getTableName()+" AS f ON MONTH(DATE_SUB(curdate(),INTERVAL 3 month))= (f."
                    +rent_table.getColumn(1)+") AND f."
                    +rent_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" LEFT JOIN "
                    +rent_table.getTableName()+" AS g ON MONTH(DATE_SUB(curdate(),INTERVAL 4 month))= (g."
                    +rent_table.getColumn(1)+") AND g."
                    +rent_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" LEFT JOIN "
                    +rent_table.getTableName()+" AS h ON MONTH(DATE_SUB(curdate(),INTERVAL 5 month))= (h."
                    +rent_table.getColumn(1)+") AND h."
                    +rent_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" WHERE (a."
                    +residence_table.getColumn(18)+" >= curdate() OR isnull(a."+residence_table.getColumn(18)+")) GROUP BY a."
                    +residence_table.getColumn(0)+" ORDER BY a."
                    +residence_table.getColumn(12);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Residence residence = new Residence();
                residence.setResidenceID(rs.getInt(residence_table.getColumn(0)));
                residence.setResidenceMark(rs.getString(residence_table.getColumn(12)));
                residence.setResidenceRent(rs.getDouble(residence_table.getColumn(13)));
                residence.setAmountPaid(rs.getDouble("rentAmount"));
                residence.setPaidAmtCurr1(rs.getDouble("rentAmount1"));
                residence.setPaidAmtCurr2(rs.getDouble("rentAmount2"));
                residence.setPaidAmtCurr3(rs.getDouble("rentAmount3"));
                residence.setPaidAmtCurr4(rs.getDouble("rentAmount4"));
                residence.setPaidAmtCurr5(rs.getDouble("rentAmount5"));
                residence.setUserFirstName(rs.getString("FirstName"));
                residence.setUserLastName(rs.getString("LastName"));
                residence.setUserAddress(rs.getString("LastDate"));
                //residence.setPaidAmtCurr1(rs.getDouble(residence_table.getColumn(4)));
                //residence.setPaidAmtCurr2(rs.getDouble(residence_table.getColumn(5)));
                //residence.setPaidAmtCurr3(rs.getDouble(residence_table.getColumn(6)));
                //residence.setPaidAmtCurr4(rs.getDouble(residence_table.getColumn(7)));
                //residence.setPaidAmtCurr5(rs.getDouble(residence_table.getColumn(8)));
                residencesList.addElement(residence);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residencesList;
    }

    public Vector<Residence> getRentOutActive1(){
        Vector<Residence> residencesList = new Vector<Residence>();
        Table residence_table=TableManager.getTable(TableManager.RPS_RESIDENCE);
        Table rent_table=TableManager.getTable(TableManager.RPS_RENTOUTGOING);
        Table resident_table=TableManager.getTable(TableManager.RPS_RESIDENT);
        try {
            String q = "SELECT a."+residence_table.getColumn(0)+",a."
                    +residence_table.getColumn(12)+",a."
                    +residence_table.getColumn(7)+",sum(c."
                    +rent_table.getColumn(3)+") AS rentAmount, IF(ISNULL(b."
                    +resident_table.getColumn(1)+"),' ',b."+resident_table.getColumn(1)+") AS FirstName,IF(ISNULL(b."
                    +resident_table.getColumn(2)+"),' ',b."+resident_table.getColumn(2)+") AS LastName,IF(curdate()>b."
                    +resident_table.getColumn(23)+",'Frei',DATE_FORMAT(b."+resident_table.getColumn(23)+",'%d-%m-%Y')) AS LastDate FROM "
                    +residence_table.getTableName()+" AS a LEFT JOIN "
                    +resident_table.getTableName()+" AS b ON b."
                    +resident_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" AND (b."
                    +resident_table.getColumn(23)+" >= curdate() OR isnull(b."+resident_table.getColumn(23)+")) LEFT JOIN "
                    +rent_table.getTableName()+" AS c ON MONTH(DATE_SUB(curdate(),INTERVAL 0 month))= (c."
                    +rent_table.getColumn(1)+") AND c."
                    +rent_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" WHERE (a."
                    +residence_table.getColumn(18)+" >= curdate() OR isnull(a."+residence_table.getColumn(18)+")) GROUP BY a."
                    +residence_table.getColumn(0)+" ORDER BY a."
                    +residence_table.getColumn(12);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Residence residence = new Residence();
                residence.setResidenceID(rs.getInt(residence_table.getColumn(0)));
                residence.setResidenceMark(rs.getString(residence_table.getColumn(12)));
                residence.setResidenceRent(rs.getDouble(residence_table.getColumn(7)));
                residence.setAmountPaid(rs.getDouble("rentAmount"));
                residence.setUserFirstName(rs.getString("FirstName"));
                residence.setUserLastName(rs.getString("LastName"));
                residence.setUserAddress(rs.getString("LastDate"));
                residencesList.addElement(residence);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residencesList;
    }

    public Vector<Residence> getRentOutNotActive(){
        Vector<Residence> residencesList = new Vector<Residence>();
        Table residence_table=TableManager.getTable(TableManager.RPS_RESIDENCE);
        Table rent_table=TableManager.getTable(TableManager.RPS_RENTOUTGOING);
        try {
            String q = "SELECT a."+residence_table.getColumn(0)+",a."
                    +residence_table.getColumn(12)+",a."
                    +residence_table.getColumn(7)+",sum(c."
                    +rent_table.getColumn(3)+") AS rentAmount FROM "
                    +residence_table.getTableName()+" AS a LEFT JOIN "
                    +rent_table.getTableName()+" AS c ON MONTH(DATE_SUB(curdate(),INTERVAL 0 month))= (c."
                    +rent_table.getColumn(1)+") AND c."
                    +rent_table.getColumn(0)+" = a."+residence_table.getColumn(0)+" WHERE a."
                    +residence_table.getColumn(18)+" <= curdate()  GROUP BY a."
                    +residence_table.getColumn(0)+" ORDER BY a."
                    +residence_table.getColumn(12);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Residence residence = new Residence();
                residence.setResidenceID(rs.getInt(residence_table.getColumn(0)));
                residence.setResidenceMark(rs.getString(residence_table.getColumn(12)));
                residence.setResidenceRent(rs.getDouble(residence_table.getColumn(7)));
                residence.setAmountPaid(rs.getDouble("rentAmount"));
                residencesList.addElement(residence);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residencesList;
    }

    public Vector<Residence> getRentOutSeparate(int residenceID){
        Vector<Residence> residencesList = new Vector<Residence>();
        Table rent_table=TableManager.getTable(TableManager.RPS_RENTOUTGOING);
        Table residence_table=TableManager.getTable(TableManager.RPS_RESIDENCE);
        try {
            String q = "SELECT a."+rent_table.getColumn(0)+",a."
                    +rent_table.getColumn(1)+",a."
                    +rent_table.getColumn(2)+",a."
                    +rent_table.getColumn(3)+",a."
                    +rent_table.getColumn(4)+",a."
                    +rent_table.getColumn(5)+",a."
                    +rent_table.getColumn(6)+",a."
                    +rent_table.getColumn(7)+",a."
                    +rent_table.getColumn(8)+",a."
                    +rent_table.getColumn(9)+",b."
                    +residence_table.getColumn(12)+",b."
                    +residence_table.getColumn(18)+" FROM "
                    +rent_table.getTableName()+" AS a,"
                    +residence_table.getTableName()+" AS b WHERE a."
                    +rent_table.getColumn(0)+"='" + residenceID+"' AND b."
                    +rent_table.getColumn(0)+"= a."+residence_table.getColumn(0)+" ORDER BY a."
                    +rent_table.getColumn(7);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Residence residence = new Residence();
                residence.setResidenceID(rs.getInt(rent_table.getColumn(0)));
                residence.setRentMonth(rs.getInt(rent_table.getColumn(1)));
                residence.setRentYear(rs.getInt(rent_table.getColumn(2)));
                residence.setAmountPaid(rs.getDouble(rent_table.getColumn(3)));
                residence.setDeleteFunction(rs.getInt(rent_table.getColumn(4)));
                residence.setRentDate(rs.getDate(rent_table.getColumn(5)));
                residence.setPaymentModeID(rs.getInt(rent_table.getColumn(6)));
                residence.setRentIncomingID(rs.getInt(rent_table.getColumn(7)));
                residence.setLoginName(rs.getString(rent_table.getColumn(8)));
                residence.setPlaceName(rs.getString(rent_table.getColumn(9)));
                residence.setResidenceMark(rs.getString(residence_table.getColumn(12)));
                residence.setVermieterMietEnd(rs.getDate(residence_table.getColumn(18)));
                residencesList.addElement(residence);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residencesList;
    }

    public Vector<Residence> getRentOutFirstPrint(int residenceID){
        Vector<Residence> residencesList = new Vector<Residence>();
        Table rent_table=TableManager.getTable(TableManager.RPS_RENTOUTGOING);
        Table residence_table=TableManager.getTable(TableManager.RPS_RESIDENCE);
        try {
            String q = "SELECT a."+rent_table.getColumn(0)+",a."
                    +rent_table.getColumn(1)+",a."
                    +rent_table.getColumn(2)+",a."
                    +rent_table.getColumn(3)+",a."
                    +rent_table.getColumn(4)+",a."
                    +rent_table.getColumn(5)+",a."
                    +rent_table.getColumn(6)+",a."
                    +rent_table.getColumn(7)+",a."
                    +rent_table.getColumn(8)+",a."
                    +rent_table.getColumn(9)+",b."
                    +residence_table.getColumn(12)+",b."
                    +residence_table.getColumn(18)+" FROM "
                    +rent_table.getTableName()+" AS a,"
                    +residence_table.getTableName()+" AS b WHERE a."
                    +rent_table.getColumn(0)+"='" + residenceID+"' AND b."
                    +rent_table.getColumn(0)+"= a."+residence_table.getColumn(0)+" ORDER BY a."
                    +rent_table.getColumn(7)+" DESC limit 1";

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Residence residence = new Residence();
                residence.setResidenceID(rs.getInt(rent_table.getColumn(0)));
                residence.setRentMonth(rs.getInt(rent_table.getColumn(1)));
                residence.setRentYear(rs.getInt(rent_table.getColumn(2)));
                residence.setAmountPaid(rs.getDouble(rent_table.getColumn(3)));
                residence.setDeleteFunction(rs.getInt(rent_table.getColumn(4)));
                residence.setRentDate(rs.getDate(rent_table.getColumn(5)));
                residence.setPaymentModeID(rs.getInt(rent_table.getColumn(6)));
                residence.setRentIncomingID(rs.getInt(rent_table.getColumn(7)));
                residence.setLoginName(rs.getString(rent_table.getColumn(8)));
                residence.setPlaceName(rs.getString(rent_table.getColumn(9)));
                residence.setResidenceMark(rs.getString(residence_table.getColumn(12)));
                residence.setVermieterMietEnd(rs.getDate(residence_table.getColumn(18)));
                residencesList.addElement(residence);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residencesList;
    }

    public Residence getRentOutPrint(int rentIncomingID) {
        Residence residence = new Residence();
        try {
            //String q = "select rent.rentMonth AS rentMonth,rent.rentYear AS rentYear,rent.amountPaid AS amountPaid,rent.rentDate AS rentDate,rent.rentIncomingID AS rentIncomingID, rent.amountBalance AS amountBalance, residence.residenceRent AS residenceRent,residence.residenceMark AS residenceMark,CONCAT_WS(' ', stu.userFirstName, res.userFirstName) AS userFirstName,CONCAT_WS(' ', stu.userLastName, res.userLastName) AS userLastName,CONCAT_WS(' ', stu.userAddress, res.userAddress) AS userAddress,CONCAT_WS(' ', stu.userPostCode, res.userPostCode) AS userPostCode,CONCAT_WS(' ', stu.userCity, res.userCity) AS userCity FROM rps_rentincoming AS rent,RPS_residencemieten AS miet,RPS_residence AS residence,RPS_resident res LEFT JOIN RPS_user stu ON res.studentReference = stu.userID WHERE rent.residenceID = miet.residenceID AND miet.residentID = res.userID AND residence.residenceID = rent.residenceID AND rent.rentincomingID ="+rentIncomingID;
            String q = "select rent.rentMonth AS rentMonth,rent.rentYear AS rentYear,rent.amountPaid AS amountPaid,rent.rentDate AS rentDate,rent.rentOutID AS rentIncomingID, rent.amountBalance AS amountBalance, residence.residenceRent AS residenceRent,residence.residenceMark AS residenceMark,CONCAT_WS(' ', stu.userFirstName, res.userFirstName) AS userFirstName,CONCAT_WS(' ', stu.userLastName, res.userLastName) AS userLastName,residence.residenceAddress AS userAddress,residence.residencePostCode AS userPostCode,residence.residenceCity AS userCity FROM rps_rentincoming AS rent,rps_residence AS residence,RPS_resident res LEFT JOIN RPS_user stu ON res.studentReference = stu.userID WHERE rent.residenceID = res.userID AND residence.residenceID = rent.residenceID AND rent.rentincomingID ="+rentIncomingID;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                residence.setRentMonth(rs.getInt("rentMonth"));
                residence.setRentYear(rs.getInt("rentYear"));
                residence.setAmountPaid(rs.getDouble("amountPaid"));
                residence.setRentDate(rs.getDate("rentDate"));
                residence.setRentIncomingID(rs.getInt("rentIncomingID"));
                residence.setAmountBalance(rs.getDouble("amountBalance"));
                residence.setResidenceRent(rs.getDouble("residenceRent"));
                residence.setResidenceMark(rs.getString("residenceMark"));
                residence.setUserFirstName(rs.getString("userFirstName"));
                residence.setUserLastName(rs.getString("userLastName"));
                residence.setUserAddress(rs.getString("userAddress"));
                residence.setUserPostCode(rs.getString("userPostCode"));
                residence.setUserCity(rs.getString("userCity"));

            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residence;
    }

    public Vector<Residence> getRentOutPrintMain(String rentIncomingID) {
        Vector<Residence> residencesList = new Vector<Residence>();
        try {
            //String q = "select rent.rentMonth AS rentMonth,rent.rentYear AS rentYear,rent.amountPaid AS amountPaid,rent.rentDate AS rentDate,rent.rentIncomingID AS rentIncomingID, rent.amountBalance AS amountBalance, residence.residenceRent AS residenceRent,residence.residenceMark AS residenceMark,CONCAT_WS(' ', stu.userFirstName, res.userFirstName) AS userFirstName,CONCAT_WS(' ', stu.userLastName, res.userLastName) AS userLastName,CONCAT_WS(' ', stu.userAddress, res.userAddress) AS userAddress,CONCAT_WS(' ', stu.userPostCode, res.userPostCode) AS userPostCode,CONCAT_WS(' ', stu.userCity, res.userCity) AS userCity FROM rps_rentincoming AS rent,RPS_residencemieten AS miet,RPS_residence AS residence,RPS_resident res LEFT JOIN RPS_user stu ON res.studentReference = stu.userID WHERE rent.residenceID = miet.residenceID AND miet.residentID = res.userID AND residence.residenceID = rent.residenceID AND rent.rentincomingID ="+rentIncomingID;
            String q = "select rent.rentMonth AS rentMonth,rent.rentYear AS rentYear,rent.amountPaid AS amountPaid,rent.rentDate AS rentDate,rent.rentOutID AS rentIncomingID,rent.amountBalance AS amountBalance,residence.residenceVWM AS residenceRent,residence.residenceMark AS residenceMark,res.resOwnFirstName AS userFirstName,res.resOwnerLastName AS userLastName,res.resOwnerAddress AS userAddress,res.resOwnerPostCode AS userPostCode,res.resOwnerCity AS userCity FROM rps_rentoutgoing AS rent,rps_residence AS residence LEFT JOIN rps_residenceownner AS res ON residence.residenceOwner = res.resOwnerID and (residence.residenceMietEnd >= curdate() OR isnull(residence.residenceMietEnd)) WHERE residence.residenceID = rent.residenceID AND rent.rentOutID ="+rentIncomingID;
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Residence residence = new Residence();
                residence.setRentMonth(rs.getInt("rentMonth"));
                residence.setRentYear(rs.getInt("rentYear"));
                residence.setAmountPaid(rs.getDouble("amountPaid"));
                residence.setRentDate(rs.getDate("rentDate"));
                residence.setRentIncomingID(rs.getInt("rentIncomingID"));
                residence.setAmountBalance(rs.getDouble("amountBalance"));
                residence.setResidenceRent(rs.getDouble("residenceRent"));
                residence.setResidenceMark(rs.getString("residenceMark"));
                residence.setUserFirstName(rs.getString("userFirstName"));
                residence.setUserLastName(rs.getString("userLastName"));
                residence.setUserAddress(rs.getString("userAddress"));
                residence.setUserPostCode(rs.getString("userPostCode"));
                residence.setUserCity(rs.getString("userCity"));
                residencesList.addElement(residence);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residencesList;
    }


    public Vector<Residence> getAllPayModes() {
        Vector<Residence> i = new Vector<Residence>();
        Table table=TableManager.getTable(TableManager.RPS_RENTPAYMODE);
        try {
            String q = "SELECT "+table.getColumn(0)
                    +","+table.getColumn(1)
                    +" FROM "+table.getTableName()
                    +" ORDER BY " +table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Residence ut = new Residence();
                ut.setPaymentModeID(rs.getInt(table.getColumn(0)));
                ut.setPaymentModeDesc(rs.getString(table.getColumn(1)));;
                i.addElement(ut);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return i;
    }

    /*public ArrayList downloadVertrag(int residenceID,int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.1");
        if(flag){
            ArrayList vertrags=new ArrayList();
            vertrags=(new VertragResidenceTraker()).getVertrags(residenceID);
            return vertrags;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    public boolean uploadVertrag(int residenceID,String fileName,int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.2");
        if(flag){
            return (new VertragResidenceTraker()).addVertrag(residenceID,fileName);
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }*/

    public boolean canMakeVertrag(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.4");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canMakeVertragManuall(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"2.6.4.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewResidence(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"16.4");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateResidence(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"16.5");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeeResidence(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"16.6");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    /* Methods Related To Every Method */
    private void setError(String errorPara) {
        this.error=errorPara;
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

    // Instance Variables
    private String error;

    public static int RESIDENCEBUSY = 1;
    public static int RESIDENCEFREE = 0;

    public Vector<Resident> getAllResidentWithoutReference() {
        Vector<Resident> residentsList = new Vector<Resident>();
        Table table = TableManager.getTable(TableManager.RPS_RESIDENT);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + "," + table.getColumn(2) + ","
                    + table.getColumn(3) + "," + table.getColumn(4) + ","
                    + table.getColumn(5) + "," + table.getColumn(6) + ","
                    + table.getColumn(7) + "," + table.getColumn(8) + ","
                    + table.getColumn(9) + "," + table.getColumn(10) + ","
                    + table.getColumn(11) + "," + table.getColumn(12) + ","
                    + table.getColumn(13) + "," + table.getColumn(14) + ","
                    + table.getColumn(15) + "," + table.getColumn(16) + ","
                    + table.getColumn(17) + "," + table.getColumn(18) + ","
                    + table.getColumn(19) + " FROM " + table.getTableName()
                    + " WHERE " + table.getColumn(20) + "='" + false+ "' ORDER BY " + table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Resident resident = new Resident();
                resident.setUserID(rs.getInt(table.getColumn(0)));
                resident.setUserFirstName(rs.getString(table.getColumn(1)));
                resident.setUserLastName(rs.getString(table.getColumn(2)));
                resident.setUserBirthDate(rs.getDate(table.getColumn(3)));
                resident.setUserGender(rs.getInt(table.getColumn(4)));
                resident.setUserBirthPlace(rs.getString(table.getColumn(5)));
                resident.setUserNationality(rs.getString(table.getColumn(6)));
                resident.setUserAddress(rs.getString(table.getColumn(7)));
                resident.setUserPostCode(rs.getString(table.getColumn(8)));
                resident.setUserCity(rs.getString(table.getColumn(9)));
                resident.setUserCountry(rs.getString(table.getColumn(10)));
                resident.setUserHomePhone(rs.getString(table.getColumn(11)));
                resident.setUserMobilePhone(rs.getString(table.getColumn(12)));
                resident.setUserFax(rs.getString(table.getColumn(13)));
                resident.setUserEmail(rs.getString(table.getColumn(14)));
                resident.setUserLoginName(rs.getString(table.getColumn(15)));
                resident.setUserPassword(rs.getString(table.getColumn(16)));
                resident.setUserRemarks(rs.getString(table.getColumn(17)));
                resident.setUserActive(rs.getInt(table.getColumn(18)));
                resident.setUserCO(rs.getString(table.getColumn(19)));

                resident.setStudent(0);
                resident.setStudentReference(null);
                residentsList.add(resident);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return residentsList;
    }

    public Vector<Resident> getAllResidentbyStudentReference() {
        StudentDao studentDB = new StudentDao();
        int isStudent = 1;
        Vector<Resident> residentsList = new Vector<Resident>();
        Table table = TableManager.getTable(TableManager.RPS_RESIDENT);
        try {
            String q = "SELECT " + table.getColumn(0)
                    + "," + table.getColumn(20) + ","
                    + table.getColumn(21) + " FROM " + table.getTableName()
                    + " WHERE " + table.getColumn(20) + "='" + isStudent + "' ORDER BY " + table.getColumn(0);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Resident resident = new Resident();
                resident.setUserID(rs.getInt(table.getColumn(0)));
                resident.setStudent(rs.getInt(table.getColumn(20)));
                int tempStudentID = rs.getInt(table.getColumn(21));
                Student student = new Student();
                student.setUserID(tempStudentID);
                resident.setStudentReference(student);
                residentsList.add(resident);
            }
            for(int i = 0; i < residentsList.size(); i++){
                Resident resident = (Resident)residentsList.elementAt(i);
                Student student = studentDB.getStudentForSubProcess(resident.getStudentReference().getUserID());
                resident.setStudentReference(student);
            }

        } catch (Exception e) {
            setError(e.toString());
        }
        return residentsList;
    }

    public boolean canAddNewResident(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"16.7");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateResident(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"16.8");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

}

