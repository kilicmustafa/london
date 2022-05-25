package com.rheinlandprivatschule.repository;


import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Hours;
import com.rheinlandprivatschule.model.Table;

import java.sql.*;
import java.util.Vector;

public class HoursDao {

    public int addNewHours(Hours hours){
        int chk=0;
        Table table= TableManager.getTable(TableManager.RPS_UNTERRICHTSTUNDEN);
        try{
            String q = "INSERT INTO "+table.getTableName()+" ("
                    +table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+","
                    +table.getColumn(8)+","
                    +table.getColumn(9)+","
                    +table.getColumn(10)+","
                    +table.getColumn(11)+") VALUES (" +
                    replaceNull(hours.getMorFrom()) + "," +
                    replaceNull(hours.getMorTo()) + "," +
                    replaceNull(hours.getMorFirstBreakFrom()) + "," +
                    replaceNull(hours.getMorFirstBreakTo()) + "," +
                    replaceNull(hours.getMoreSecBreakFrom()) + "," +
                    replaceNull(hours.getMorSecBreakTo()) + "," +
                    replaceNull(hours.getEveFrom()) + "," +
                    replaceNull(hours.getEveTo()) + "," +
                    replaceNull(hours.getEveFirstBreakFrom()) + "," +
                    replaceNull(hours.getEveFirstBreakTo()) + "," +
                    replaceNull(hours.getEveSecBreakFrom()) + "," +
                    replaceNull(hours.getEveSecBreakTo()) + ")";
            DBHelper.getInstance().updateQuery(q);
            chk = 1;
        }catch(Exception e){
            setError(e.toString());
        }
        return chk;
    }

    public int deleteHours(){
        int chk=0;
        Table table=TableManager.getTable(TableManager.RPS_UNTERRICHTSTUNDEN);
        try{
            String q = "DELETE FROM "+table.getTableName();
            DBHelper.getInstance().updateQuery(q);
            chk = 1;
        }catch(Exception e){
            setError(e.toString());
        }
        return chk;
    }

    public Vector<Hours> getAllHours(){
        Vector<Hours> v = new Vector<Hours>();
        Table table=TableManager.getTable(TableManager.RPS_PLACE);
        try{
            String q = "SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+","
                    +table.getColumn(8)+","
                    +table.getColumn(9)+","
                    +table.getColumn(10)+","
                    +table.getColumn(11)+","
                    +table.getColumn(12)+ " FROM "
                    +table.getTableName()+" ORDER BY "
                    +table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                Hours p = new Hours();
                p.setMorFrom(rs.getString(table.getColumn(0)));
                p.setMorTo(rs.getString(table.getColumn(1)));
                p.setMorFirstBreakFrom(rs.getString(table.getColumn(2)));
                p.setMorFirstBreakTo(rs.getString(table.getColumn(3)));
                p.setMoreSecBreakFrom(rs.getString(table.getColumn(4)));
                p.setMorSecBreakTo(rs.getString(table.getColumn(5)));
                p.setEveFrom(rs.getString(table.getColumn(6)));
                p.setEveTo(rs.getString(table.getColumn(7)));
                p.setEveFirstBreakFrom(rs.getString(table.getColumn(8)));
                p.setEveFirstBreakTo(rs.getString(table.getColumn(9)));
                p.setEveSecBreakFrom(rs.getString(table.getColumn(10)));
                p.setEveSecBreakTo(rs.getString(table.getColumn(11)));
                v.add(p);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public Hours getHours(){
        Hours p = new Hours();
        Table table=TableManager.getTable(TableManager.RPS_UNTERRICHTSTUNDEN);
        try{
            String q = "SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+","
                    +table.getColumn(8)+","
                    +table.getColumn(9)+","
                    +table.getColumn(10)+","
                    +table.getColumn(11)+" FROM "
                    +table.getTableName();
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                p.setMorFrom(rs.getString(table.getColumn(0)));
                p.setMorTo(rs.getString(table.getColumn(1)));
                p.setMorFirstBreakFrom(rs.getString(table.getColumn(2)));
                p.setMorFirstBreakTo(rs.getString(table.getColumn(3)));
                p.setMoreSecBreakFrom(rs.getString(table.getColumn(4)));
                p.setMorSecBreakTo(rs.getString(table.getColumn(5)));
                p.setEveFrom(rs.getString(table.getColumn(6)));
                p.setEveTo(rs.getString(table.getColumn(7)));
                p.setEveFirstBreakFrom(rs.getString(table.getColumn(8)));
                p.setEveFirstBreakTo(rs.getString(table.getColumn(9)));
                p.setEveSecBreakFrom(rs.getString(table.getColumn(10)));
                p.setEveSecBreakTo(rs.getString(table.getColumn(11)));
            }
        } catch(Exception e){
            setError(e.toString());
        }
        return p;
    }

    public int updateHours(Hours p){
        int chk=0;
        Table table=TableManager.getTable(TableManager.RPS_UNTERRICHTSTUNDEN);
        try{
            String q = "UPDATE "+table.getTableName()+" SET "
                    +table.getColumn(0)+"=" + replaceNull(p.getMorFrom()) +", "
                    +table.getColumn(1)+"=" + replaceNull(p.getMorTo()) +", "
                    +table.getColumn(2)+"=" + replaceNull(p.getMorFirstBreakFrom()) +","
                    +table.getColumn(3)+"=" + replaceNull(p.getMorFirstBreakTo()) +","
                    +table.getColumn(4)+"=" + replaceNull(p.getMoreSecBreakFrom()) + ","
                    +table.getColumn(5)+"=" + replaceNull(p.getMorSecBreakTo()) + ","
                    +table.getColumn(6)+"=" + replaceNull(p.getEveFrom()) + ","
                    +table.getColumn(7)+"=" + replaceNull(p.getEveTo()) + ","
                    +table.getColumn(8)+"=" + replaceNull(p.getEveFirstBreakFrom()) + ","
                    +table.getColumn(9)+"=" + replaceNull(p.getEveFirstBreakTo()) + ","
                    +table.getColumn(10)+"=" + replaceNull(p.getEveSecBreakFrom()) + ","
                    +table.getColumn(11)+"=" + replaceNull(p.getEveSecBreakTo());
            DBHelper.getInstance().updateQuery(q);
            chk = 1;
        }catch(Exception e){
            setError(e.toString());
        }
        return chk;
    }

    public boolean canAddNewSchool(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"6.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeeSchoolList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"6.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateSchool(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"6.2.1");
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

    //Instance Variables
    private String error;
}

