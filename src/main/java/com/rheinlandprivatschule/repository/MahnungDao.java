package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.*;

import java.sql.*;
import java.util.Vector;
public class MahnungDao {

    public Vector getMahnungList(int loginUser) {

        Vector<MahnungElement> v = new Vector<MahnungElement>();
        Table user_table= TableManager.getTable(TableManager.RPS_USER);
        Table courses_table=TableManager.getTable(TableManager.RPS_COURSES);
        Table registration_table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "1.1");

        if(flag){
            Vector<MahnungElement> v1 = new Vector<MahnungElement>();
            Vector<MahnungElement> v2 = new Vector<MahnungElement>();
            Vector<MahnungElement> v3 = new Vector<MahnungElement>();

            try {
                int interval = getMahnungInterval();// 15;
                String q = "SELECT a."+user_table.getColumn(0)+",a."+user_table.getColumn(1)+",a."+user_table.getColumn(2)+",b."+courses_table.getColumn(0)+",b."+courses_table.getColumn(1)+",c."+registration_table.getColumn(4)+" FROM "+user_table.getTableName()+" AS a,"+courses_table.getTableName()+" AS b,"+registration_table.getTableName()+" AS c  WHERE sysDate() > ADDDATE(b."+courses_table.getColumn(3)+", INTERVAL "
                        + interval
                        + " DAY) AND c."+registration_table.getColumn(4)+">0 AND c."+registration_table.getColumn(0)+"=b."+courses_table.getColumn(0)+" and a."+user_table.getColumn(0)+"=c."+registration_table.getColumn(1)+" ORDER BY a."+user_table.getColumn(1)+"";
                ResultSet rs = DBHelper.getInstance().executeQuery(q);
                while (rs.next()) {
                    MahnungElement ele = new MahnungElement();
                    ele.setUserID(rs.getInt(user_table.getColumn(0)));
                    ele.setUserName(rs.getString(user_table.getColumn(1)));
                    ele.setUserLastName(rs.getString(user_table.getColumn(2)));
                    ele.setCourseID(rs.getInt(courses_table.getColumn(0)));
                    ele.setCourseName(rs.getString(courses_table.getColumn(1)));
                    ele.setBalance(rs.getDouble(registration_table.getColumn(4)));
                    v1.addElement(ele);
                }
                for (int i = 0; i < v1.size(); i++) {
                    MahnungElement me = (MahnungElement) v1.elementAt(i);
                    if (!isMahnungUnklar(me.getCourseID(), me.getUserID())) {
                        v3.addElement(me);
                    }
                }
                for (int i = 0; i < v3.size(); i++) {
                    MahnungElement me = (MahnungElement) v3.elementAt(i);
                    if (!isMahnungActive(me.getCourseID(), me.getUserID())) {
                        v2.addElement(me);
                        removeMahnungDatum(me.getCourseID(), me.getUserID());
                    }
                }
                for (int ii = 0; ii < v2.size(); ii++) {
                    MahnungElement me = (MahnungElement) v2.elementAt(ii);
                    if (!isMahnungSend(me.getCourseID(), me.getUserID())) {
                        v.addElement(me);
                    }
                }
            } catch (Exception e) {
                setError(e.toString());
            }
            return v;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    public int addMahnung(int cid, int uid, int admin, double bal) {
        int b=0;
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(admin,"1.1.1");
        if(flag){
            Table table=TableManager.getTable(TableManager.RPS_MAHNUNG);
            try {
                String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+")VALUES('"
                        + cid
                        + "','"
                        + uid
                        + "',"
                        + replaceNull(MyDate.getCurrentSQLDate())
                        + ",'"
                        + b
                        + "','"
                        + admin + "','" + bal + "')";
                DBHelper.getInstance().updateQuery(q);
                q = "SELECT LAST_INSERT_ID() AS id";
                ResultSet rs = DBHelper.getInstance().executeQuery(q);
                while (rs.next()) {
                    b = rs.getInt("id");
                }
            } catch (Exception e) {
                setError(e.toString());
            }
        }
        else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
        }
        if(b<=0){
            return 0;
        }else{
            return b;
        }
    }

    public Vector getVertragsForMahnungList(int sid) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(1,"1.1.2");
        Table table=TableManager.getTable(TableManager.RPS_VERTRAGLIST);
        if(flag){
            Vector<String> v = new Vector<String>();
            try {
                String q = "SELECT "+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                        + sid + "'";
                ResultSet rs = DBHelper.getInstance().executeQuery(q);
                while (rs.next()) {
                    v.addElement((String) rs.getString(table.getColumn(1)));
                }
            } catch (Exception e) {
                setError(e.toString());
            }
            return v;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }

    }

    public boolean sendMahung(int courseID, int studentID,int loginUser) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"1.1.3");
        if(flag){
            boolean b = false;
            try {
                StudentDao sdb = new StudentDao();
                Table table=TableManager.getTable(TableManager.RPS_MAHNUNG);
                CourseRegistration cr = sdb.getRegistrationByStudent(courseID, studentID);
                String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(4)+"='" + SENTMAHNUNG+ "', "+table.getColumn(7)+"="
                        + replaceNull(MyDate.getCurrentSQLDate())
                        + " WHERE "+table.getColumn(1)+"='" + courseID + "' AND "+table.getColumn(2)+"='" + studentID + "'";
                int value=DBHelper.getInstance().updateQuery(q);
                if(value>0){
                    cr.setCourseBalance(cr.getCourseBalance() + 7.5D);
                    b=sdb.updateCourseRegistration(cr);
                }else{
                    b=false;
                }
            } catch (Exception e) {
                setError(e.toString());
                b=false;
            }
            return b;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean unklarMahnung(int cid, int uid, int catid,int loginID) {
        boolean b = false;
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginID,"1.1.4");
        if(flag){
            try {
                String q = "INSERT INTO rps_unklar(userID,courseID,catID)VALUES('"
                        + uid + "','" + cid + "','" + catid + "')";
                int value=DBHelper.getInstance().updateQuery(q);
                if(value>0){
                    b = true;
                }
            } catch (Exception e) {
                setError(e.toString());
                b = false;
            }
            return b;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return b;
        }
    }

    public Vector<UnklarCat> getAllUnklarCategoriesForUnklar(int loginID) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginID,"1.1.4");
        if(flag){
            return getAllCat();
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    public Vector getMahnungListWithDatum(int loginID) {
        Vector<MahnungElement> v = new Vector<MahnungElement>();
        Table user_table=TableManager.getTable(TableManager.RPS_USER);
        Table courses_table=TableManager.getTable(TableManager.RPS_COURSES);
        Table registration_table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        Table mahndatum_table=TableManager.getTable(TableManager.RPS_MAHNDATUM);

        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginID, "1.2");
        if(flag){
            try {
                int interval = getMahnungInterval();// 15;
                String q = "SELECT a."+user_table.getColumn(0)+",a."+user_table.getColumn(1)+",a."+user_table.getColumn(2)+",b."+courses_table.getColumn(0)+",b."+courses_table.getColumn(1)+",c."+registration_table.getColumn(4)+" FROM "+user_table.getTableName()+" AS a,"+courses_table.getTableName()+" AS b,"+registration_table.getTableName()+" AS c,"+mahndatum_table.getTableName()+" AS d  WHERE sysDate() > ADDDATE(b."+courses_table.getColumn(3)+", INTERVAL "
                        + interval
                        + " DAY) AND c."+registration_table.getColumn(4)+">0 AND c."+registration_table.getColumn(0)+"=b."+courses_table.getColumn(0)+" AND a."+user_table.getColumn(0)+"=c."+registration_table.getColumn(1)+" and c."+registration_table.getColumn(1)+"=d."+mahndatum_table.getColumn(1)+" and c."+registration_table.getColumn(0)+"=d."+mahndatum_table.getColumn(0)+" ORDER BY a."+user_table.getColumn(1);
                ResultSet rs = DBHelper.getInstance().executeQuery(q);
                while (rs.next()) {
                    MahnungElement ele = new MahnungElement();
                    ele.setUserID(rs.getInt(user_table.getColumn(0)));
                    ele.setUserName(rs.getString(user_table.getColumn(1)));
                    ele.setUserLastName(rs.getString(user_table.getColumn(2)));
                    ele.setCourseID(rs.getInt(courses_table.getColumn(0)));
                    ele.setCourseName(rs.getString(courses_table.getColumn(1)));
                    ele.setBalance(rs.getDouble(registration_table.getColumn(4)));
                    v.addElement(ele);
                }
            } catch (Exception e) {
                setError(e.toString());
            }
            return v;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    public Vector getVersendMahnungList(int loginID) {
        Vector<MahnungElement> v = new Vector<MahnungElement>();
        Table user_table=TableManager.getTable(TableManager.RPS_USER);
        Table courses_table=TableManager.getTable(TableManager.RPS_COURSES);
        Table registration_table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        Table mahnung_table=TableManager.getTable(TableManager.RPS_MAHNUNG);
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginID, "1.3");
        if(flag){
            try {
                String q = "SELECT a."+user_table.getColumn(0)+",a."+user_table.getColumn(1)+",a."+user_table.getColumn(2)+",b."+courses_table.getColumn(0)+",b."+courses_table.getColumn(1)+",c."+registration_table.getColumn(4)+" FROM "+user_table.getTableName()+" AS a,"+courses_table.getTableName()+" AS b,"+registration_table.getTableName()+" AS c,"+mahnung_table.getTableName()+" AS d WHERE c."+registration_table.getColumn(4)+">0 AND c."+registration_table.getColumn(0)+"=b."+courses_table.getColumn(0)+" and a."+user_table.getColumn(0)+"=c."+registration_table.getColumn(1)+" and a."+user_table.getColumn(0)+"=d."+mahnung_table.getColumn(2)+" and b."+courses_table.getColumn(0)+"=d."+mahnung_table.getColumn(1)+" and d."+mahnung_table.getColumn(4)+"='"
                        + SENTMAHNUNG + "' ORDER BY a."+user_table.getColumn(1);
                ResultSet rs = DBHelper.getInstance().executeQuery(q);
                while (rs.next()) {
                    MahnungElement ele = new MahnungElement();
                    ele.setUserID(rs.getInt(user_table.getColumn(0)));
                    ele.setUserName(rs.getString(user_table.getColumn(1)));
                    ele.setUserLastName(rs.getString(user_table.getColumn(2)));
                    ele.setCourseID(rs.getInt(courses_table.getColumn(0)));
                    ele.setCourseName(rs.getString(courses_table.getColumn(1)));
                    ele.setBalance(rs.getDouble(registration_table.getColumn(4)));
                    v.addElement(ele);
                }
            } catch (Exception e) {
                setError(e.toString());
            }
            return v;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    public boolean sendImKaso(int userID, int courseID,int loginID) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginID, "1.3.1");
        Table mahnung_table=TableManager.getTable(TableManager.RPS_MAHNUNG);
        if(flag){
            boolean b = false;
            try {
                String q = "UPDATE "+mahnung_table.getTableName()+" SET "+mahnung_table.getColumn(4)+"='" + IMKASSO
                        + "' WHERE "+mahnung_table.getColumn(2)+"='" + userID + "' AND "+mahnung_table.getColumn(1)+"='"
                        + courseID + "'";
                DBHelper.getInstance().updateQuery(q);
                b = true;
            } catch (Exception e) {
                setError(e.toString());
            }
            return b;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public Vector getKasoMahnungList(int loginUser) {
        Vector<MahnungElement> v = new Vector<MahnungElement>();
        Table user_table=TableManager.getTable(TableManager.RPS_USER);
        Table courses_table=TableManager.getTable(TableManager.RPS_COURSES);
        Table registration_table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        Table mahnung_table=TableManager.getTable(TableManager.RPS_MAHNUNG);
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "1.4");
        if(flag){
            try {
                String q = "SELECT a."+user_table.getColumn(0)+",a."+user_table.getColumn(1)+",a."+user_table.getColumn(2)+",b."+courses_table.getColumn(0)+",b."+courses_table.getColumn(1)+",c."+registration_table.getColumn(4)+" FROM "+user_table.getTableName()+" AS a,"+courses_table.getTableName()+" AS b,"+registration_table.getTableName()+" AS c,"+mahnung_table.getTableName()+" AS d  WHERE c."+registration_table.getColumn(4)+">0 AND c."+registration_table.getColumn(0)+"=b."+courses_table.getColumn(0)+" and a."+user_table.getColumn(0)+"=c."+registration_table.getColumn(1)+" and a."+user_table.getColumn(0)+"=d."+mahnung_table.getColumn(2)+" and b."+courses_table.getColumn(0)+"=d."+mahnung_table.getColumn(1)+" and d."+mahnung_table.getColumn(4)+"='"
                        + IMKASSO + "' ORDER BY a."+user_table.getColumn(1);
                ResultSet rs = DBHelper.getInstance().executeQuery(q);
                while (rs.next()) {
                    MahnungElement ele = new MahnungElement();
                    ele.setUserID(rs.getInt(user_table.getColumn(0)));
                    ele.setUserName(rs.getString(user_table.getColumn(1)));
                    ele.setUserLastName(rs.getString(user_table.getColumn(2)));
                    ele.setCourseID(rs.getInt(courses_table.getColumn(0)));
                    ele.setCourseName(rs.getString(courses_table.getColumn(1)));
                    ele.setBalance(rs.getDouble(registration_table.getColumn(4)));
                    v.addElement(ele);
                }
            } catch (Exception e) {
                setError(e.toString());
            }
            return v;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    public Vector<UnklarCat> getAllUnklarCategoriesForList(int loginID) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginID, "1.5");
        if(flag){
            return getAllCat();
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }

    }

    public Vector getUnklarMahnungList(int catid,int loginID) {
        Vector<MahnungElement> v = new Vector<MahnungElement>();
        Table user_table=TableManager.getTable(TableManager.RPS_USER);
        Table courses_table=TableManager.getTable(TableManager.RPS_COURSES);
        Table registration_table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);

        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginID, "1.5");
        if(flag){
            try {
                String q = "SELECT a."+user_table.getColumn(0)+",a."+user_table.getColumn(1)+",a."+user_table.getColumn(2)+",b."+courses_table.getColumn(0)+",b."+courses_table.getColumn(1)+",c."+registration_table.getColumn(4)+" FROM "+user_table.getTableName()+" AS a,"+courses_table.getTableName()+" AS b,"+registration_table.getTableName()+" AS c,rps_unklar AS d  WHERE c."+registration_table.getColumn(4)+">0 AND c."+registration_table.getColumn(0)+"=b."+courses_table.getColumn(0)+" AND a."+user_table.getColumn(0)+"=c."+registration_table.getColumn(1)+" AND c."+registration_table.getColumn(1)+"=d.userID  AND c."+registration_table.getColumn(0)+"=d.courseID AND d.catID='"
                        + catid + "' ORDER BY a."+user_table.getColumn(0)+"";
                ResultSet rs = DBHelper.getInstance().executeQuery(q);
                while (rs.next()) {
                    MahnungElement ele = new MahnungElement();
                    ele.setUserID(rs.getInt(user_table.getColumn(0)));
                    ele.setUserName(rs.getString(user_table.getColumn(1)));
                    ele.setUserLastName(rs.getString(user_table.getColumn(2)));
                    ele.setCourseID(rs.getInt(courses_table.getColumn(0)));
                    ele.setCourseName(rs.getString(courses_table.getColumn(1)));
                    ele.setBalance(rs.getDouble(registration_table.getColumn(4)));
                    v.addElement(ele);
                }
            } catch (Exception e) {
                setError(e.toString());
            }
            this.refineUnklar();
            return v;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    public boolean klarMahnung(int cid, int uid,int loginUser) {
        boolean b = false;
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "1.5.1");
        if(flag){
            try {
                String q = "DELETE FROM rps_unklar WHERE userID='" + uid
                        + "' AND courseID='" + cid + "'";

                if(DBHelper.getInstance().updateQuery(q)>0){
                    b = true;
                }
            } catch (Exception e) {
                setError(e.toString());
                b = false;
            }
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            b=true;
        }
        return b;
    }

    public boolean addNewCat(String code,int loginID) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(1, "1.5.3");
        if(flag){
            boolean b = false;
            try {
                String q = "INSERT INTO rps_unklarcat(catName)VALUES("
                        + this.replaceNull(code) + ")";
                if(DBHelper.getInstance().updateQuery(q)>0){
                    b=true;
                }
            } catch (Exception e) {
                setError(e.toString());
            }
            return b;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean updateCat(int code, String text,int loginUser) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "1.5.4");
        if(flag){
            boolean b = false;
            try {
                String q = "UPDATE rps_unklarcat SET catName="
                        + this.replaceNull(text) + " WHERE catID='" + code + "'";
                if(DBHelper.getInstance().updateQuery(q)>=0){
                    b=true;
                }
            } catch (Exception e) {
                setError(e.toString());
            }
            return b;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public UnklarCat getUnklarCat(int code,int loginUser) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser, "1.5.4");
        if(flag){
            UnklarCat uc = null;
            try {
                String q = "SELECT catID,catName FROM rps_unklarcat WHERE catID='"
                        + code + "'";
                ResultSet rs = DBHelper.getInstance().executeQuery(q);
                while (rs.next()) {
                    int tempID = rs.getInt("catID");
                    String tempName = rs.getString("catName");
                    uc=new UnklarCat();
                    uc.setCatID(tempID);
                    uc.setCatName(tempName);
                }
            } catch (Exception e) {
                setError(e.toString());
            }
            return uc;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return null;
        }
    }

    private boolean setIntervals(int mahnungDays, int inkassoDays) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(1, "1.6");
        if(flag){
            boolean b = false;
            int intervalID = 1;
            Table table = TableManager.getTable(TableManager.RPS_MAHNUNGINTERVAL);
            try {
                String q = "INSERT INTO " + table.getTableName() + "("
                        + table.getColumn(0) + "," + table.getColumn(1) + ","
                        + table.getColumn(2) + ")VALUES('" + intervalID + "','"
                        + mahnungDays + "','" + inkassoDays + "')";
                int value=DBHelper.getInstance().updateQuery(q);
                if(value>0){
                    b = true;
                }
            } catch (Exception e) {
                setError(e.toString());
            }
            return b;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean setMahnungInterval(int days,int loginID) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginID, "1.6");
        if(flag){
            boolean b = false;
            Table table = TableManager.getTable(TableManager.RPS_MAHNUNGINTERVAL);
            int intervalID = 1;
            try {
                String q = "UPDATE " + table.getTableName() + " SET "
                        + table.getColumn(1) + "='" + days + "' WHERE "
                        + table.getColumn(0) + "='" + intervalID + "'";
                if(DBHelper.getInstance().updateQuery(q) >= 0) {
                    b = true;
                } else {
                    setIntervals(0,0);
                }
            } catch (Exception e) {
                setError(e.toString());
            }
            return b;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean setInkassoInterval(int days,int loginID) {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginID, "1.6");
        if(flag){
            boolean b = false;
            Table table = TableManager.getTable(TableManager.RPS_MAHNUNGINTERVAL);
            int intervalID = 1;
            try {
                String q = "UPDATE " + table.getTableName() + " SET "
                        + table.getColumn(2) + "='" + days + "' WHERE "
                        + table.getColumn(0) + "='" + intervalID + "'";
                DBHelper.getInstance().updateQuery(q);
                if (DBHelper.getInstance().updateQuery(q)>=0) {
                    b = true;
                } else {
                    setIntervals(0, 0);
                }
            } catch (Exception e) {
                setError(e.toString());
            }
            return b;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public int getMahnungInterval() {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(1, "1.6");
        if(flag){
            int interval = -1;
            Table table = TableManager.getTable(TableManager.RPS_MAHNUNGINTERVAL);
            int intervalID = 1;
            try {
                String q = "SELECT " + table.getColumn(1) + " FROM "
                        + table.getTableName() + " WHERE " + table.getColumn(0)
                        + "='" + intervalID + "'";
                ResultSet rs = DBHelper.getInstance().executeQuery(q);
                while (rs.next()) {
                    interval = rs.getInt(table.getColumn(1));
                }
            } catch (Exception e) {
                setError(e.toString());
            }
            return interval;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return -1;
        }
    }

    public int getInkassoInterval() {
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(1, "1.6");
        if(flag){
            int interval = 0;
            Table table = TableManager.getTable(TableManager.RPS_MAHNUNGINTERVAL);
            int intervalID = 1;
            try {
                String q = "SELECT " + table.getColumn(2) + " FROM "
                        + table.getTableName() + " WHERE " + table.getColumn(0)
                        + "='" + intervalID + "'";
                ResultSet rs = DBHelper.getInstance().executeQuery(q);
                while (rs.next()) {
                    interval = rs.getInt(table.getColumn(2));
                }
            } catch (Exception e) {
                setError(e.toString());
            }
            return interval;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return 0;
        }
    }

    private Vector<UnklarCat> getAllCat() {
        Vector<UnklarCat> v = new Vector<UnklarCat>();
        try {
            String q = "SELECT catID,catName FROM rps_unklarcat";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                int tempID = rs.getInt("catID");
                String tempName = rs.getString("catName");
                UnklarCat uc = new UnklarCat();
                uc.setCatID(tempID);
                uc.setCatName(tempName);
                v.addElement(uc);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public int addMahnungDatum(int cid, int uid, Date d, String desc) {
        int b = 0;
        Table mahndatum_table=TableManager.getTable(TableManager.RPS_MAHNDATUM);
        try {
            String q = "INSERT INTO "+mahndatum_table.getTableName()+"("+mahndatum_table.getColumn(0)+","+mahndatum_table.getColumn(1)+","+mahndatum_table.getColumn(2)+","+mahndatum_table.getColumn(3)+")VALUES('"
                    + cid
                    + "','"
                    + uid
                    + "',"
                    + replaceNull(d)
                    + ","
                    + replaceNull(desc) + ")";
            DBHelper.getInstance().updateQuery(q);
            b = 1;
        } catch (Exception e) {
            setError(e.toString());
        }

        return b;
    }

    public Mahnung getGedruckMahnung(int cid, int uid) {
        Mahnung m = new Mahnung();
        Table table=TableManager.getTable(TableManager.RPS_MAHNUNG);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"
                    + cid + "' AND "+table.getColumn(2)+"='" + uid + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                m.setMahnungID(rs.getInt(table.getColumn(0)));
                m.setCourseID(rs.getInt(table.getColumn(1)));
                m.setUserID(rs.getInt(table.getColumn(2)));
                m.setMahnungDate(rs.getDate(table.getColumn(3)));
                m.setStatus(rs.getInt(table.getColumn(4)));
                m.setAdminID(rs.getInt(table.getColumn(5)));
                m.setBalance(rs.getDouble(table.getColumn(6)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }

        return m;
    }

    public MahnungElement getMahnung(int cid, int uid) {
        MahnungElement ele = new MahnungElement();
        Table user_table=TableManager.getTable(TableManager.RPS_USER);
        Table courses_table=TableManager.getTable(TableManager.RPS_COURSES);
        Table registration_table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);

        try {
            String q = "SELECT a."+user_table.getColumn(0)+",a."+user_table.getColumn(1)+",a."+user_table.getColumn(2)+",b."+courses_table.getColumn(0)+",b."+courses_table.getColumn(1)+",c."+registration_table.getColumn(4)+" FROM "+user_table.getTableName()+" AS a,"+courses_table.getTableName()+" AS b,"+registration_table.getTableName()+" AS c  WHERE a."+user_table.getColumn(0)+"='"
                    + uid
                    + "' AND a."+user_table.getColumn(0)+"=c."+registration_table.getColumn(1)+" AND b."+courses_table.getColumn(0)+"='"
                    + cid
                    + "' AND b."+courses_table.getColumn(0)+"=c."+registration_table.getColumn(0)+" ORDER BY a."+user_table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                ele.setUserID(rs.getInt(user_table.getColumn(0)));
                ele.setUserName(rs.getString(user_table.getColumn(1)));
                ele.setUserLastName(rs.getString(user_table.getColumn(2)));
                ele.setCourseID(rs.getInt(courses_table.getColumn(0)));
                ele.setCourseName(rs.getString(courses_table.getColumn(1)));
                ele.setBalance(rs.getDouble(registration_table.getColumn(4)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }

        return ele;
    }

    public MahnungDatum getMahnungDatum(int cid, int uid) {
        MahnungDatum m = new MahnungDatum();
        Table table=TableManager.getTable(TableManager.RPS_MAHNDATUM);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                    + cid + "' AND "+table.getColumn(1)+"='" + uid + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                m.setCourseID(rs.getInt(table.getColumn(0)));
                m.setUserID(rs.getInt(table.getColumn(1)));
                m.setMahnungDate(rs.getDate(table.getColumn(2)));
                m.setDesc(rs.getString(table.getColumn(3)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }

        return m;
    }

    private boolean refineUnklar() {
        boolean b = false;
        Table registration_table=TableManager.getTable(TableManager.RPS_COURSEREGISTRATION);
        try {
            String q = "SELECT a.userID,a.courseID FROM rps_unklar AS a,"+registration_table.getTableName()+" AS b WHERE a.userID=b."+registration_table.getColumn(1)+" AND a.courseID=b."+registration_table.getColumn(0)+" AND b."+registration_table.getColumn(4)+"<=0";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                DBHelper.getInstance().updateQuery(
                        "DELETE FROM rps_unklar WHERE userID='"
                                + rs.getInt("userID") + "' AND courseID='"
                                + rs.getInt("courseID") + "'");
            }
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean isMahnungActive(int cid, int uid) {
        boolean b = false;
        Table table=TableManager.getTable(TableManager.RPS_MAHNDATUM);
        try {
            String q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                    + cid + "' AND "+table.getColumn(1)+"='" + uid + "' AND sysDate()<"+table.getColumn(2);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                int temp = rs.getInt("courseID");
                if (temp > 0) {
                    b = true;
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }

        return b;
    }

    public boolean isMahnungUnklar(int cid, int uid) {
        boolean b = false;
        try {
            String q = "SELECT courseID FROM rps_unklar WHERE courseID='" + cid
                    + "' AND userID='" + uid + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                int temp = rs.getInt("courseID");
                if (temp > 0) {
                    b = true;
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }

        return b;
    }

    public boolean isMahnungDatumExist(int cid, int uid) {
        boolean b = false;
        Table table=TableManager.getTable(TableManager.RPS_MAHNDATUM);
        try {
            String q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                    + cid + "' AND "+table.getColumn(1)+"='" + uid + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                rs.getInt(table.getColumn(0));
                b = true;
            }
        } catch (Exception e) {
            setError(e.toString());
            b = false;
        }
        return b;
    }

    public boolean isMahnungGeDruck(int cid, int uid) {
        boolean b = false;
        Table table=TableManager.getTable(TableManager.RPS_MAHNUNG);
        try {
            String q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"
                    + cid + "' AND "+table.getColumn(2)+"='" + uid + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                int temp = rs.getInt(table.getColumn(0));
                if (temp > 0) {
                    b = true;
                }
            }
        } catch (Exception e) {

        }

        return b;
    }

    public boolean isMahnungSend(int cid, int uid) {
        boolean b = false;
        Table table=TableManager.getTable(TableManager.RPS_MAHNUNG);
        try {
            String q = "SELECT "+table.getColumn(4)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='" + cid
                    + "' AND "+table.getColumn(2)+"='" + uid + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                int sta = rs.getInt(table.getColumn(4));
                if (sta == SENTMAHNUNG || sta == IMKASSO) {
                    b = true;
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean isMahnungCanKaso(int userID, int courseID) {
        boolean b = false;
        Table table=TableManager.getTable(TableManager.RPS_MAHNUNG);
        try {
            int interval = getInkassoInterval();// 15;
            String q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName()+" WHERE sysDate() >= ADDDATE("+table.getColumn(7)+",INTERVAL "
                    + interval
                    + " DAY) AND "+table.getColumn(4)+"='"
                    + SENTMAHNUNG
                    + "' AND "+table.getColumn(2)+"='"
                    + userID + "' AND "+table.getColumn(1)+"='" + courseID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                int temp = rs.getInt(table.getColumn(0));
                if (temp > 0) {
                    b = true;
                }
            }
        } catch (Exception e) {
            b = false;
            setError(e.toString());
        }
        return b;
    }

    public int removeMahnungDatum(int cid, int uid) {
        int m = 0;
        Table table=TableManager.getTable(TableManager.RPS_MAHNDATUM);
        try {
            String q = "DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='" + cid
                    + "' AND "+table.getColumn(1)+"='" + uid + "'";
            DBHelper.getInstance().updateQuery(q);
            m = 1;
        } catch (Exception e) {
            setError(e.toString());
        }

        return m;
    }

    public double getMahnungFee(int userID, int courseID) {
        double b = 0;
        Table table=TableManager.getTable(TableManager.RPS_MAHNUNG);
        try {
            String q = "SELECT "+table.getColumn(2)+","+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(2)+"='"
                    + userID + "' AND "+table.getColumn(1)+"='" + courseID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            int track = 0;
            while (rs.next()) {
                rs.getInt(table.getColumn(2));
                rs.getInt(table.getColumn(1));
                track++;
            }
            b = track * 7.5;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public int updateMahnungDatum(int cid, int uid, Date d, String des) {
        int m = 0;
        Table table=TableManager.getTable(TableManager.RPS_MAHNDATUM);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(2)+"=" + replaceNull(d)
                    + ", "+table.getColumn(3)+"=" + replaceNull(des) + " WHERE "+table.getColumn(0)+"='"
                    + cid + "' AND "+table.getColumn(1)+"='" + uid + "'";
            DBHelper.getInstance().updateQuery(q);
            m = 1;
        } catch (Exception e) {
            setError(e.toString());
        }

        return m;
    }

    public boolean updateChangeCourseInMahnung(int studentID,int oldCourseID,int newCourseID){
        boolean result = false;
        Table md_table = TableManager.getTable(TableManager.RPS_MAHNDATUM);
        Table m_table = TableManager.getTable(TableManager.RPS_MAHNUNG);
        try{
            String q = "UPDATE "+m_table.getTableName()+" SET "+m_table.getColumn(1)+"='"+newCourseID+"' WHERE "+m_table.getColumn(2)+"='"+studentID+"' AND "+m_table.getColumn(1)+"='"+oldCourseID+"'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        }catch(Exception e){
            setError(e.toString());
        }
        try{
            String q = "UPDATE "+md_table.getTableName()+" SET "+m_table.getColumn(0)+"='"+newCourseID+"' WHERE "+m_table.getColumn(1)+"='"+studentID+"' AND "+m_table.getColumn(0)+"='"+oldCourseID+"'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    /* End Methods Related To Mahnung */

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

    /* End Methods Related To Every Method */

    // Instance Variables
    private String error;

    // Content Management
    public static int MODULEID = 1;

    public static String MODULENAME = "Mahnung";

    public static int SENTMAHNUNG=1;
    public static int IMKASSO=2;
}
