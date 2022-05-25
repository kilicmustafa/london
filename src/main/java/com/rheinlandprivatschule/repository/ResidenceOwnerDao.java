package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.ResidenceOwner;
import com.rheinlandprivatschule.model.Table;

import java.sql.ResultSet;
import java.util.Vector;

public class ResidenceOwnerDao {

    public int addNewResidenceOwner(ResidenceOwner owner) {
        int newOwnerID = 0;
        Table table= TableManager.getTable(TableManager.RPS_RESIDENCEOWNER);
        try {
            String q = "INSERT INTO "+table.getTableName()+" ("+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+","+table.getColumn(7)+","+table.getColumn(8)+","+table.getColumn(9)+","+table.getColumn(10)+","+table.getColumn(11)+","+table.getColumn(12)+","+table.getColumn(13)+","+table.getColumn(14)+","+table.getColumn(15)+","+table.getColumn(16)+","+table.getColumn(17)+","+table.getColumn(18)+","+table.getColumn(19)+") VALUES ("
                    + replaceNull(owner.getResidenceOwnerCompany())
                    + ","
                    + replaceNull(owner.getResidenceOwnerFirstName())
                    + ","
                    + replaceNull(owner.getResidenceOwnerLastName())
                    + ","
                    + replaceNull(owner.getResidenceOwnerBirthDate())
                    + ",'"
                    + owner.getResidenceOwnerGender()
                    + "',"
                    + replaceNull(owner.getResidenceOwnerAddress())
                    + ","
                    + replaceNull(owner.getResidenceOwnerPostCode())
                    + ","
                    + replaceNull(owner.getResidenceOwnerCity())
                    + ","
                    + replaceNull(owner.getResidenceOwnerCountry())
                    + ","
                    + replaceNull(owner.getResidenceOwnerHomePhone())
                    + ","
                    + replaceNull(owner.getResidenceOwnerOfficePhone())
                    + ","
                    + replaceNull(owner.getResidenceOwnerMobilePhone())
                    + ","
                    + replaceNull(owner.getResidenceOwnerFax())
                    + ","
                    + replaceNull(owner.getResidenceOwnerEmail())
                    + ","
                    + replaceNull(owner.getResidenceOwnerAccountNo())
                    + ","
                    + replaceNull(owner.getResidenceOwnerBLZ())
                    + ","
                    + replaceNull(owner.getResidenceOwnerBankName())
                    + ","
                    + replaceNull(owner.getResidenceOwnerLoginName())
                    + ","
                    + replaceNull(owner.getResidenceOwnerPassword())+ ")";
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

    public int updateResidenceOwner(ResidenceOwner owner) {
        int updateStatus = 0;
        Table table=TableManager.getTable(TableManager.RPS_RESIDENCEOWNER);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"="+replaceNull(owner.getResidenceOwnerCompany())+","+table.getColumn(2)+"="+replaceNull(owner.getResidenceOwnerFirstName())+","+table.getColumn(3)+"="+replaceNull(owner.getResidenceOwnerLastName())+","+table.getColumn(4)+"="+replaceNull(owner.getResidenceOwnerBirthDate())+","+table.getColumn(5)+"='"+owner.getResidenceOwnerGender()+"',"+table.getColumn(6)+"="+replaceNull(owner.getResidenceOwnerAddress())+","+table.getColumn(7)+"="+replaceNull(owner.getResidenceOwnerPostCode())+","+table.getColumn(8)+"="+replaceNull(owner.getResidenceOwnerCity())+","+table.getColumn(9)+"="+replaceNull(owner.getResidenceOwnerCountry())+","+table.getColumn(10)+"="+replaceNull(owner.getResidenceOwnerHomePhone())+","+table.getColumn(11)+"="+replaceNull(owner.getResidenceOwnerOfficePhone())+","+table.getColumn(12)+"="+replaceNull(owner.getResidenceOwnerMobilePhone())+","+table.getColumn(13)+"="+replaceNull(owner.getResidenceOwnerFax())+","+table.getColumn(14)+"="+replaceNull(owner.getResidenceOwnerEmail())+","+table.getColumn(15)+"="+replaceNull(owner.getResidenceOwnerAccountNo())+","+table.getColumn(16)+"="+replaceNull(owner.getResidenceOwnerBLZ())+","+table.getColumn(17)+"="+replaceNull(owner.getResidenceOwnerBankName())+","+table.getColumn(18)+"="+replaceNull(owner.getResidenceOwnerLoginName())+","+table.getColumn(19)+"="+replaceNull(owner.getResidenceOwnerPassword())+" WHERE "+table.getColumn(0)+"='"+owner.getResidenceOwnerID()+"'";
            DBHelper.getInstance().updateQuery(q);
            updateStatus = 1;
        } catch (Exception e) {
            setError(e.toString());
        }
        return updateStatus;
    }

    public Vector<ResidenceOwner> getAllResidenceOwners() {
        Vector<ResidenceOwner> ownerList = new Vector<ResidenceOwner>();
        Table owner_table=TableManager.getTable(TableManager.RPS_RESIDENCEOWNER);
        try {
            String q = "SELECT "+owner_table.getColumn(0)+","+owner_table.getColumn(1)+","+owner_table.getColumn(2)+","+owner_table.getColumn(3)+","+owner_table.getColumn(4)+","+owner_table.getColumn(5)+","+owner_table.getColumn(6)+","+owner_table.getColumn(7)+","+owner_table.getColumn(8)+","+owner_table.getColumn(9)+","+owner_table.getColumn(10)+","+owner_table.getColumn(11)+","+owner_table.getColumn(12)+","+owner_table.getColumn(13)+","+owner_table.getColumn(14)+","+owner_table.getColumn(15)+","+owner_table.getColumn(16)+","+owner_table.getColumn(17)+","+owner_table.getColumn(18)+","+owner_table.getColumn(19)+" FROM "+owner_table.getTableName()+" ORDER BY "+owner_table.getColumn(1)+","+owner_table.getColumn(2);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                ResidenceOwner owner = new ResidenceOwner();
                owner.setResidenceOwnerID(rs.getInt(owner_table.getColumn(0)));
                owner.setResidenceOwnerCompany(rs.getString(owner_table.getColumn(1)));
                owner.setResidenceOwnerFirstName(rs.getString(owner_table.getColumn(2)));
                owner.setResidenceOwnerLastName(rs.getString(owner_table.getColumn(3)));
                owner.setResidenceOwnerBirthDate(rs.getDate(owner_table.getColumn(4)));
                owner.setResidenceOwnerGender(rs.getInt(owner_table.getColumn(5)));

                owner.setResidenceOwnerAddress(rs.getString(owner_table.getColumn(6)));
                owner.setResidenceOwnerPostCode(rs.getString(owner_table.getColumn(7)));
                owner.setResidenceOwnerCity(rs.getString(owner_table.getColumn(8)));
                owner.setResidenceOwnerCountry(rs.getString(owner_table.getColumn(9)));
                owner.setResidenceOwnerHomePhone(rs.getString(owner_table.getColumn(10)));
                owner.setResidenceOwnerOfficePhone(rs.getString(owner_table.getColumn(11)));
                owner.setResidenceOwnerMobilePhone(rs.getString(owner_table.getColumn(12)));
                owner.setResidenceOwnerFax(rs.getString(owner_table.getColumn(13)));
                owner.setResidenceOwnerEmail(rs.getString(owner_table.getColumn(14)));

                owner.setResidenceOwnerAccountNo(rs.getString(owner_table.getColumn(15)));
                owner.setResidenceOwnerBLZ(rs.getString(owner_table.getColumn(16)));
                owner.setResidenceOwnerBankName(rs.getString(owner_table.getColumn(17)));

                owner.setResidenceOwnerLoginName(rs.getString(owner_table.getColumn(18)));
                owner.setResidenceOwnerPassword(rs.getString(owner_table.getColumn(19)));
                ownerList.addElement(owner);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return ownerList;
    }

    public ResidenceOwner getResidenceOwner(int ownerID) {
        ResidenceOwner owner = new ResidenceOwner();
        Table owner_table=TableManager.getTable(TableManager.RPS_RESIDENCEOWNER);
        try {
            String q = "SELECT "+owner_table.getColumn(0)+","+owner_table.getColumn(1)+","+owner_table.getColumn(2)+","+owner_table.getColumn(3)+","+owner_table.getColumn(4)+","+owner_table.getColumn(5)+","+owner_table.getColumn(6)+","+owner_table.getColumn(7)+","+owner_table.getColumn(8)+","+owner_table.getColumn(9)+","+owner_table.getColumn(10)+","+owner_table.getColumn(11)+","+owner_table.getColumn(12)+","+owner_table.getColumn(13)+","+owner_table.getColumn(14)+","+owner_table.getColumn(15)+","+owner_table.getColumn(16)+","+owner_table.getColumn(17)+","+owner_table.getColumn(18)+","+owner_table.getColumn(19)+" FROM "+owner_table.getTableName()+" WHERE "+owner_table.getColumn(0)+"='" + ownerID +"'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                owner.setResidenceOwnerID(rs.getInt(owner_table.getColumn(0)));
                owner.setResidenceOwnerCompany(rs.getString(owner_table.getColumn(1)));
                owner.setResidenceOwnerFirstName(rs.getString(owner_table.getColumn(2)));
                owner.setResidenceOwnerLastName(rs.getString(owner_table.getColumn(3)));
                owner.setResidenceOwnerBirthDate(rs.getDate(owner_table.getColumn(4)));
                owner.setResidenceOwnerGender(rs.getInt(owner_table.getColumn(5)));

                owner.setResidenceOwnerAddress(rs.getString(owner_table.getColumn(6)));
                owner.setResidenceOwnerPostCode(rs.getString(owner_table.getColumn(7)));
                owner.setResidenceOwnerCity(rs.getString(owner_table.getColumn(8)));
                owner.setResidenceOwnerCountry(rs.getString(owner_table.getColumn(9)));
                owner.setResidenceOwnerHomePhone(rs.getString(owner_table.getColumn(10)));
                owner.setResidenceOwnerOfficePhone(rs.getString(owner_table.getColumn(11)));
                owner.setResidenceOwnerMobilePhone(rs.getString(owner_table.getColumn(12)));
                owner.setResidenceOwnerFax(rs.getString(owner_table.getColumn(13)));
                owner.setResidenceOwnerEmail(rs.getString(owner_table.getColumn(14)));

                owner.setResidenceOwnerAccountNo(rs.getString(owner_table.getColumn(15)));
                owner.setResidenceOwnerBLZ(rs.getString(owner_table.getColumn(16)));
                owner.setResidenceOwnerBankName(rs.getString(owner_table.getColumn(17)));

                owner.setResidenceOwnerLoginName(rs.getString(owner_table.getColumn(18)));
                owner.setResidenceOwnerPassword(rs.getString(owner_table.getColumn(19)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return owner;
    }

    public boolean canAddNewResidenceOwner(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"16.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateResidenceOwner(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"16.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeeResidenceOwner(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"16.3");
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
}
