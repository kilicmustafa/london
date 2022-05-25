package com.rheinlandprivatschule.repository;


import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Resident;
import com.rheinlandprivatschule.model.Student;
import com.rheinlandprivatschule.model.Table;

import java.sql.ResultSet;
import java.util.Vector;

public class ResidentDao {

    public int addNewResident(Resident resident) {
        int newResidentID = 0;
        try{
            if(resident.isStudent()==1){

                newResidentID = addNewResidentByStudentReference(resident);
            }else{
                newResidentID = addNewResidentWithoutReference(resident);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return newResidentID;
    }

    private int addNewResidentWithoutReference(Resident resident) {
        int newResidentID = 0;
        try {
            Table table = TableManager.getTable(TableManager.RPS_RESIDENT);
            String q = "INSERT INTO " + table.getTableName() + " ("
                    + table.getColumn(1) + "," + table.getColumn(2) + ","
                    + table.getColumn(3) + "," + table.getColumn(4) + ","
                    + table.getColumn(5) + "," + table.getColumn(6) + ","
                    + table.getColumn(7) + "," + table.getColumn(8) + ","
                    + table.getColumn(9) + "," + table.getColumn(10) + ","
                    + table.getColumn(11) + "," + table.getColumn(12) + ","
                    + table.getColumn(13) + "," + table.getColumn(14) + ","
                    + table.getColumn(15) + "," + table.getColumn(16) + ","
                    + table.getColumn(17) + "," + table.getColumn(18) + ","
                    + table.getColumn(19) + "," +table.getColumn(20)+ "," +table.getColumn(21)+ ") VALUES ("
                    + replaceNull(resident.getUserFirstName()) + ","
                    + replaceNull(resident.getUserLastName()) + ","
                    + replaceNull(resident.getUserBirthDate()) + ","
                    + replaceNull(resident.getUserGender()) + ","
                    + replaceNull(resident.getUserBirthPlace()) + ","
                    + replaceNull(resident.getUserNationality()) + ","
                    + replaceNull(resident.getUserAddress()) + ","
                    + replaceNull(resident.getUserPostCode()) + ","
                    + replaceNull(resident.getUserCity()) + ","
                    + replaceNull(resident.getUserCountry()) + ","
                    + replaceNull(resident.getUserHomePhone()) + ","
                    + replaceNull(resident.getUserMobilePhone()) + ","
                    + replaceNull(resident.getUserFax()) + ","
                    + replaceNull(resident.getUserEmail()) + ","
                    + replaceNull(resident.getUserLoginName()) + ","
                    + replaceNull(resident.getUserPassword()) + ","
                    + replaceNull(resident.getUserRemarks()) + ",'"
                    + resident.getUserActive() + "',"
                    + replaceNull(resident.getUserCO()) + ",'" +resident.isStudent()+ "','" +resident.getStudentReference()+ "')";
            DBHelper.getInstance().updateQuery(q);
            q = "select LAST_INSERT_ID() as id";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                newResidentID = rs.getInt("id");
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return newResidentID;
    }

    private int addNewResidentByStudentReference(Resident resident) {
        int newResidentID = 0;
        try {
            Table table = TableManager.getTable(TableManager.RPS_RESIDENT);
            String q = "INSERT INTO " + table.getTableName() + " (" + table.getColumn(20) + "," + table.getColumn(21) + ") VALUES ('"+resident.isStudent()+"','"+resident.getStudentReference().getUserID()+"')";
            DBHelper.getInstance().updateQuery(q);
            q = "select LAST_INSERT_ID() as id";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                newResidentID = rs.getInt("id");
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return newResidentID;
    }

    public boolean isResidentStudnet(int residentID) {
        boolean result = false;
        int isResident = 0;
        Table table = TableManager.getTable(TableManager.RPS_RESIDENT);
        try {
            String q = "SELECT " + table.getColumn(20) + " FROM "+table.getTableName()+" WHERE " + table.getColumn(0) + "='" + residentID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                isResident = rs.getInt(table.getColumn(20));
            }
            if(isResident==1){
                result = true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

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

    public Resident getResident(int residentID) {
        Resident resident = new Resident();
        try {
            if(isResidentStudnet(residentID)){
                resident = getResidentByStudentReference(residentID);
            }else{
                resident = getResidentWithoutReference(residentID);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return resident;
    }

    private Resident getResidentWithoutReference(int residentID) {
        Resident resident = new Resident();
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
                    + " WHERE " + table.getColumn(0) + "='" + residentID
                    + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
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
            }

        } catch (Exception e) {
            setError(e.toString());
        }
        return resident;
    }

    private Resident getResidentByStudentReference(int residentID) {
        StudentDao studentDB =new StudentDao();
        Resident resident = new Resident();
        int studentID = 0;
        Table table = TableManager.getTable(TableManager.RPS_RESIDENT);
        try {
            String q = "SELECT " +table.getColumn(0)+ "," +table.getColumn(17)+ ","+ table.getColumn(20)+ "," +table.getColumn(21)+ " FROM " + table.getTableName()
                    + " WHERE " + table.getColumn(0) + "='" + residentID
                    + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                resident.setUserID(rs.getInt(table.getColumn(0)));
                resident.setUserRemarks(rs.getString(table.getColumn(17)));
                resident.setStudent(rs.getInt(table.getColumn(20)));
                studentID = rs.getInt(table.getColumn(21));
            }
            resident.setStudentReference(studentDB.getStudentForSubProcess(studentID));
        } catch (Exception e) {
            setError(e.toString());
        }
        return resident;
    }

    public int updateResident(Resident resident) {
        int updateStatus = 0;
        try {
            if(resident.isStudent()==1){
                updateStatus = updateResidentByStudentReference(resident);
            }else{
                updateStatus = updateResidentWithoutReference(resident);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return updateStatus;
    }

    private int updateResidentWithoutReference(Resident resident) {
        int updateStatus = 0;
        try {
            boolean defaultStudent = false;
            int defaultStudentReference = 0;
            Table table = TableManager.getTable(TableManager.RPS_RESIDENT);
            String q = "UPDATE " + table.getTableName() + " SET "
                    + table.getColumn(1) + "="
                    + replaceNull(resident.getUserFirstName()) + ","
                    + table.getColumn(2) + "="
                    + replaceNull(resident.getUserLastName()) + ","
                    + table.getColumn(3) + "="
                    + replaceNull(resident.getUserBirthDate()) + ","
                    + table.getColumn(4) + "="
                    + replaceNull(resident.getUserGender()) + ","
                    + table.getColumn(5) + "="
                    + replaceNull(resident.getUserBirthPlace()) + ", "
                    + table.getColumn(6) + "="
                    + replaceNull(resident.getUserNationality()) + ","
                    + table.getColumn(7) + "="
                    + replaceNull(resident.getUserAddress()) + ","
                    + table.getColumn(8) + "="
                    + replaceNull(resident.getUserPostCode()) + ","
                    + table.getColumn(9) + "="
                    + replaceNull(resident.getUserCity()) + ","
                    + table.getColumn(10) + "="
                    + replaceNull(resident.getUserCountry()) + ","
                    + table.getColumn(11) + "="
                    + replaceNull(resident.getUserHomePhone()) + ","
                    + table.getColumn(12) + "="
                    + replaceNull(resident.getUserMobilePhone()) + ","
                    + table.getColumn(13) + "="
                    + replaceNull(resident.getUserFax()) + ","
                    + table.getColumn(14) + "="
                    + replaceNull(resident.getUserEmail()) + ","
                    + table.getColumn(19) + "="
                    + replaceNull(resident.getUserCO()) + "," +table.getColumn(20) + "='" + defaultStudent + "'," +table.getColumn(21)+ "='" + defaultStudentReference + "' WHERE "
                    + table.getColumn(0) + "='" + resident.getUserID() + "'";
            DBHelper.getInstance().updateQuery(q);
            updateStatus = 1;
        } catch (Exception e) {
            setError(e.toString());
        }
        return updateStatus;
    }

    public int updateResidentRemark(Resident resident) {
        int updateStatus = 0;
        try {
            Table table = TableManager.getTable(TableManager.RPS_RESIDENT);
            String q = "UPDATE " + table.getTableName() + " SET "
                    + table.getColumn(17) + "="
                    + replaceNull(resident.getUserRemarks()) + " WHERE "
                    + table.getColumn(0) + "='" + resident.getUserID() + "'";
            DBHelper.getInstance().updateQuery(q);
            updateStatus = 1;
        } catch (Exception e) {
            setError(e.toString());
        }
        return updateStatus;
    }

    private int updateResidentByStudentReference(Resident resident) {
        int updateStatus = 0;
        try {
            int defaultStudent = 1;
            int defaultStudentReference = resident.getStudentReference().getUserID();
            Table table = TableManager.getTable(TableManager.RPS_RESIDENT);
            String q = "UPDATE " + table.getTableName() + " SET "
                    + table.getColumn(20) + "='" + defaultStudent + "'," +table.getColumn(21)+ "='" + defaultStudentReference + "' WHERE "
                    + table.getColumn(0) + "='" + resident.getUserID() + "'";
            DBHelper.getInstance().updateQuery(q);
            updateStatus = 1;
        } catch (Exception e) {
            setError(e.toString());
        }
        return updateStatus;
    }

    public int updateStudentToResident(int studentID){
        int residentID = 0;
        StudentDao studentDB = new StudentDao();
        try{
            Student student = studentDB.getStudentForSubProcess(studentID);
            if(student.getUserID() != 0){
                Resident resident = new Resident();
                resident.setStudent(1);
                resident.setStudentReference(student);
                residentID = addNewResident(resident);
            }else{
                setError("Es gibt keinen Kursteilnehmer mit dieser Kennummer");
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return residentID;
    }

    public int updateResidentToStudent(int residentID){
        int studentID = 0;
        StudentDao studentDB = new StudentDao();
        try{
            Resident resident = getResident(residentID);
            Student student = new Student();
            student.setUserFirstName(resident.getUserFirstName());
            student.setUserLastName(resident.getUserLastName());
            student.setUserBirthDate(resident.getUserBirthDate());
            student.setUserGender(resident.getUserGender());
            student.setUserBirthPlace(resident.getUserBirthPlace());
            student.setUserNationality(resident.getUserNationality());
            student.setUserCO(resident.getUserCO());
            student.setUserAddress(resident.getUserAddress());
            student.setUserPostCode(resident.getUserPostCode());
            student.setUserCity(resident.getUserCity());
            student.setUserCountry(resident.getUserCountry());
            student.setUserHomePhone(resident.getUserHomePhone());
            student.setUserMobilePhone(resident.getUserMobilePhone());
            student.setUserFax(resident.getUserFax());
            student.setUserEmail(resident.getUserEmail());
            student.setUserLoginName(resident.getUserLoginName());
            student.setUserPassword(resident.getUserPassport());
            student.setUserRemarks(resident.getUserRemarks());
            student.setUserActive(resident.getUserActive());

            studentID = studentDB.addNewStudent(student);
            if(studentID != 0){
                resident.setUserFirstName(null);
                resident.setUserLastName(null);
                resident.setUserBirthDate(null);
                resident.setUserGender(0);
                resident.setUserBirthPlace(null);
                resident.setUserNationality(null);
                resident.setUserAddress(null);
                resident.setUserPostCode(null);
                resident.setUserCity(null);
                resident.setUserCountry(null);
                resident.setUserHomePhone(null);
                resident.setUserMobilePhone(null);
                resident.setUserFax(null);
                resident.setUserEmail(null);
                resident.setUserCO(null);

                student.setUserID(studentID);
                resident.setStudent(1);
                resident.setStudentReference(student);
                updateResident(resident);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return studentID;
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

    public boolean canSeeResident(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"16.9");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
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

    /* End Methods Related To Every Method */

    // Instance Variables
    private String error;
}
