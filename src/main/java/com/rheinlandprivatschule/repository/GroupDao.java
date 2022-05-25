package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Group;
import com.rheinlandprivatschule.model.Student;
import com.rheinlandprivatschule.model.Table;

import java.sql.*;
import java.util.ArrayList;
import java.util.Vector;

public class GroupDao {

    public boolean addGroup(Group w) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_GROUP);
        try {
            String q = "INSERT INTO " + table.getTableName() + "("
                    + table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+")VALUES("
                    + replaceNull(w.getGroupName())+","
                    +replaceNull(w.getGroupDetail())+",'"
                    +w.getGroupParent()+"')";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean updateGroupParent(int groupParent) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_GROUP);
        try {
            String q = "UPDATE " + table.getTableName() + " SET "
                    + table.getColumn(4) + "="+ 1 + " WHERE "
                    + table.getColumn(0) + "='" + groupParent + "'";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteGroup(int groupID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_GROUP);
        try {
            String q = "DELETE FROM " + table.getTableName() + " WHERE "
                    + table.getColumn(0) + "='" + groupID + "'";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public Group getGroup(int groupID) {
        Group groupClass = new Group();
        Table table = TableManager.getTable(TableManager.RPS_GROUP);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) + ","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+" FROM "
                    + table.getTableName() + " WHERE "
                    + table.getColumn(0)+ "='" + groupID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                groupClass.setGroupID(rs.getInt(table.getColumn(0)));
                groupClass.setGroupName(rs.getString(table.getColumn(1)));
                groupClass.setGroupDetail(rs.getString(table.getColumn(2)));
                groupClass.setGroupParent(rs.getInt(table.getColumn(3)));
                groupClass.setStatus(rs.getInt(table.getColumn(4)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return groupClass;
    }

    public ArrayList<Group> getAllGroups(int parent) {
        ArrayList<Group> groupClassList = new ArrayList<Group>();
        Table table = TableManager.getTable(TableManager.RPS_GROUP);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) +","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+" FROM "
                    + table.getTableName() + " WHERE "
                    +table.getColumn(3)+"='"+parent+"' ORDER BY "
                    + table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Group groupClass = new Group();
                groupClass.setGroupID(rs.getInt(table.getColumn(0)));
                groupClass.setGroupName(rs.getString(table.getColumn(1)));
                groupClass.setGroupDetail(rs.getString(table.getColumn(2)));
                groupClass.setGroupParent(rs.getInt(table.getColumn(3)));
                groupClass.setStatus(rs.getInt(table.getColumn(4)));
                groupClass.setGroupActive(rs.getInt(table.getColumn(5)));
                groupClassList.add(groupClass);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return groupClassList;
    }

    public ArrayList<Group> getAllGroupsStatus(int parent, int status) {
        ArrayList<Group> groupClassList = new ArrayList<Group>();
        Table table = TableManager.getTable(TableManager.RPS_GROUP);
        try {
            String q = "SELECT " + table.getColumn(0) + ","
                    + table.getColumn(1) +","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+" FROM "
                    + table.getTableName() + " WHERE "
                    +table.getColumn(3)+"='"+parent+"' AND "
                    +table.getColumn(5)+"='"+status+"' ORDER BY "
                    + table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Group groupClass = new Group();
                groupClass.setGroupID(rs.getInt(table.getColumn(0)));
                groupClass.setGroupName(rs.getString(table.getColumn(1)));
                groupClass.setGroupDetail(rs.getString(table.getColumn(2)));
                groupClass.setGroupParent(rs.getInt(table.getColumn(3)));
                groupClass.setStatus(rs.getInt(table.getColumn(4)));
                groupClass.setGroupActive(rs.getInt(table.getColumn(5)));
                groupClassList.add(groupClass);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return groupClassList;
    }

    public boolean isGroupClasseDir(int groupID) {
        boolean result=false;
        int count=0;
        Table table = TableManager.getTable(TableManager.RPS_GROUP);
        try {
            String q = "SELECT count(*) AS classcount FROM "
                    + table.getTableName() + " WHERE "+table.getColumn(3)+"='"+groupID+"'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                count=rs.getInt("classcount");
            }
            if(count>0){
                result=true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean updateGroup(Group group) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_GROUP);
        try {
            String q = "UPDATE " + table.getTableName() + " SET "
                    + table.getColumn(1) + "="
                    + replaceNull(group.getGroupName()) + ","+table.getColumn(2)+"="+replaceNull(group.getGroupDetail())+","+table.getColumn(3)+"='"+group.getGroupParent()+"' WHERE "
                    + table.getColumn(0) + "='" + group.getGroupID() + "'";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean addGroupRelatedToClient(int clientID, int groupID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_GROUPRELATED);
        try {
            String q = "INSERT INTO " + table.getTableName() + "("
                    + table.getColumn(0) + "," + table.getColumn(1)
                    + ")VALUES('" + clientID + "','" + groupID + "')";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteGroupRelatedToClient(int clientID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_GROUPRELATED);
        try {
            String q = "DELETE FROM " + table.getTableName() + " WHERE "
                    + table.getColumn(0) + "='" + clientID + "'";
            DBHelper.getInstance().updateQuery(q);
            b = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public Group getGroupRelatedToStudent(int studentID) {
        Group group = new Group();
        Table groupTable = TableManager.getTable(TableManager.RPS_GROUP);
        Table groupRelatedTable = TableManager.getTable(TableManager.RPS_GROUPRELATED);
        try {
            String q = "SELECT a." + groupTable.getColumn(0) + ",a."
                    + groupTable.getColumn(1) + ",a."
                    + groupTable.getColumn(2) + ",a."+groupTable.getColumn(3)+" FROM "
                    + groupTable.getTableName() + " AS a,"
                    + groupRelatedTable.getTableName() + " AS b" + " WHERE a."
                    + groupTable.getColumn(0) + "=b."
                    + groupRelatedTable.getColumn(1) + " AND b."+groupRelatedTable.getColumn(0)+"="+studentID+" ORDER BY a."
                    + groupTable.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                group.setGroupID(rs.getInt(groupTable.getColumn(0)));
                group.setGroupName(rs.getString(groupTable.getColumn(1)));
                group.setGroupDetail(rs.getString(groupTable.getColumn(2)));
                group.setGroupParent(rs.getInt(groupTable.getColumn(3)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return group;
    }

    public int countAssociatedGroups(int groupID) {

        int count = 0;
        Table groupRelatedTable = TableManager
                .getTable(TableManager.RPS_GROUPRELATED);
        try {
            String q = "SELECT count(" + groupRelatedTable.getColumn(1)
                    + ") AS count" + " FROM "
                    + groupRelatedTable.getTableName() + " WHERE "
                    + groupRelatedTable.getColumn(1) + "='" + groupID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return count;
    }

    public boolean isRelatedToClient(int clientID, int groupID) {
        boolean b = false;
        int temp = 0;
        Table table = TableManager.getTable(TableManager.RPS_GROUPRELATED);
        try {
            String q = "SELECT " + table.getColumn(1) + " FROM "
                    + table.getTableName() + " WHERE " + table.getColumn(0)
                    + "='" + clientID + "' AND " + table.getColumn(1) + "='"
                    + groupID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                temp = rs.getInt(table.getColumn(1));
            }
            if (temp > 0) {
                b = true;
            }
        } catch (Exception e) {
            setError(e.toString());
            b = false;
        }
        return b;
    }

    public boolean addRelationToAdmin(int adminID, int groupID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_ADMINWERBUNG);
        try {
            String q = "INSERT INTO " + table.getTableName() + "("
                    + table.getColumn(0) + "," + table.getColumn(1)
                    +")VALUES('"+adminID+"','"
                    + groupID+ "')";
            DBHelper.getInstance().updateQuery(q);
            b=true;
        } catch (Exception e) {
            setError(e.toString());
            b = false;
        }
        return b;
    }

    public boolean updateRelationToAdmin(int adminID, int groupID) {
        boolean b = false;
        Table table = TableManager.getTable(TableManager.RPS_ADMINWERBUNG);
        try {
            if(isRelationToAdminExist(adminID)){
                String q = "UPDATE " + table.getTableName() + " SET "
                        + table.getColumn(1) + "='"
                        + groupID+"' WHERE "
                        + table.getColumn(0) + "='" + adminID+ "'";
                DBHelper.getInstance().updateQuery(q);
                b = true;
            }else{
                b=addRelationToAdmin(adminID,groupID);
            }

        } catch (Exception e) {
            setError(e.toString());
            b = false;
        }
        return b;
    }

    public boolean isRelationToAdminExist(int adminID) {
        boolean b = false;
        int temp = 0;
        Table table = TableManager.getTable(TableManager.RPS_ADMINWERBUNG);
        try {
            String q = "SELECT " + table.getColumn(1) + " FROM "
                    + table.getTableName() + " WHERE " + table.getColumn(0)
                    + "='" + adminID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                temp = rs.getInt(table.getColumn(1));
            }
            if (temp > 0) {
                b = true;
            }
        } catch (Exception e) {
            setError(e.toString());
            b = false;
        }
        return b;
    }

    public int getAdminGroup(int adminID) {
        int groupID=0;
        Table table = TableManager.getTable(TableManager.RPS_ADMINWERBUNG);
        try {
            String q = "SELECT " + table.getColumn(1) + " FROM "
                    + table.getTableName() + " WHERE " + table.getColumn(0)
                    + "='" + adminID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                groupID=rs.getInt(table.getColumn(1));
            }
            return groupID;
        } catch (Exception e) {
            setError(e.toString());
            return 0;
        }
    }

    public int getGroupAgent(int groupID) {
        int agentID=0;
        Table table = TableManager.getTable(TableManager.RPS_ADMINWERBUNG);
        try {
            String q = "SELECT " + table.getColumn(0) + " FROM "
                    + table.getTableName() + " WHERE " + table.getColumn(1)
                    + "='" + groupID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                agentID=rs.getInt(table.getColumn(0));
            }
            return agentID;
        } catch (Exception e) {
            setError(e.toString());
            return 0;
        }
    }

    public Vector getStudentRelatedToGroup(int groupID, int studentStatus) {
        Vector<Student> result = new Vector<Student>();
        Vector<String> ids=new Vector<String>();
        Table student_table=TableManager.getTable(TableManager.RPS_USER);
        Table group_table=TableManager.getTable(TableManager.RPS_GROUPRELATED);

        try {
            String q = "SELECT a."+student_table.getColumn(0)+",a."
                    +student_table.getColumn(1)+",a."
                    +student_table.getColumn(2)+" FROM "
                    +student_table.getTableName()+" AS a,"
                    +group_table.getTableName()+" AS b WHERE b."
                    +group_table.getColumn(0)+"=a."+student_table.getColumn(0)+" AND b."
                    +group_table.getColumn(1)+"='"+groupID+"' ORDER BY a."
                    +student_table.getColumn(1);

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                String temp=""+rs.getInt(student_table.getColumn(0));
                ids.addElement(temp);
            }
            StudentDao sdb=new StudentDao();
            for(int i=0;i<ids.size();i++){
                int tempStudentID=Integer.parseInt((String)ids.elementAt(i));
                int tempStatus=getGroupStudentStatus(tempStudentID);
                if(tempStatus==studentStatus){
                    result.addElement(sdb.getStudentForSubProcess(tempStudentID));
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }


    public int getGroupStudentStatus(int clientID){
        int studentStatus=-1;
        Table table=TableManager.getTable(TableManager.RPS_GROUPRELATED);
        try{
            String q="SELECT "+table.getColumn(2)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+clientID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            int tempStatus=-1;
            while(rs.next()){
                tempStatus=rs.getInt("studentStatus");
            }

            if(tempStatus>=0){
                studentStatus=tempStatus;
            }else{
                insertGroupStudentStatus(clientID,STUDENTACTIVE);
                studentStatus=STUDENTACTIVE;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return studentStatus;
    }

    public int getGroupStatus(int groupID){
        int studentStatus=-1;
        Table table=TableManager.getTable(TableManager.RPS_GROUP);
        try{
            String q="SELECT "+table.getColumn(5)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(0)+"='"+groupID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            int tempStatus=-1;
            while(rs.next()){
                tempStatus=rs.getInt("studentStatus");
            }

            if(tempStatus>=0){
                studentStatus=tempStatus;
            }else{
                insertGroupStatus(groupID,STUDENTACTIVE);
                studentStatus=STUDENTACTIVE;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return studentStatus;
    }

    public boolean insertGroupStudentStatus(int clientID,int studentStatus){
        Table table=TableManager.getTable(TableManager.RPS_GROUPRELATED);
        try{
            String q="INSERT INTO "+table.getTableName()+"("+table.getColumn(0)+","+table.getColumn(2)+") VALUES('"+clientID+"','"+studentStatus+"')";
            DBHelper.getInstance().updateQuery(q);
            return true;
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
    }

    public boolean insertGroupStatus(int groupID,int groupStatus){
        Table table=TableManager.getTable(TableManager.RPS_GROUP);
        try{
            String q="INSERT INTO "+table.getTableName()+"("
                    +table.getColumn(0)+","
                    +table.getColumn(5)+") VALUES('"
                    +groupID+"','"
                    +groupStatus+"')";
            DBHelper.getInstance().updateQuery(q);
            return true;
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
    }

    public boolean setStudentStatus(int clientID,int studentStatus){
        Table table=TableManager.getTable(TableManager.RPS_GROUPRELATED);
        try{
            String q="UPDATE "+table.getTableName()+" SET "+table.getColumn(2)+"='"+studentStatus+"' WHERE "+table.getColumn(0)+"='"+clientID+"'";
            DBHelper.getInstance().updateQuery(q);
            return true;
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
    }

    public boolean setGroupStatus(int groupID,int studentStatus){
        Table table=TableManager.getTable(TableManager.RPS_GROUP);
        try{
            String q="UPDATE "+table.getTableName()+" SET "+table.getColumn(5)+"='"+studentStatus+"' WHERE "
                    +table.getColumn(0)+"='"+groupID+"'";
            DBHelper.getInstance().updateQuery(q);
            return true;
        }catch(Exception e){
            setError(e.toString());
            return false;
        }
    }

    public Vector<Group> getProperVector(Vector groupList, Vector groupIDSLIST){
        Vector<Group> v=new Vector<Group>();
        try{
            for(int i = 0; i < groupList.size(); i++){
                Group s = (Group)groupList.elementAt(i);
                if(isActive(groupIDSLIST,s.getGroupActive())){
                    int active = 1;
                    v.addElement(s);
                    this.makeGroupActive(active, s.getGroupActive());
                }else{
                    int active = 0;
                    this.makeGroupActive(active, s.getGroupActive());
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return v;
    }

    public boolean makeGroupActive(int active, int groupID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_GROUP);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(5)+"='" + active
                    + "' WHERE "+table.getColumn(0)+"='" + groupID + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean isActive(Vector groupIDSLIST, int groupID){
        boolean result = false;
        try{
            for(int i = 0; i < groupIDSLIST.size(); i++){
                String temp = (String)groupIDSLIST.elementAt(i);
                if(groupID == Integer.parseInt(temp)){
                    result = true;
                }
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public boolean canSeeGroupList(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"11.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewGroup(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"11.1.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateGroup(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"11.1.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeeGroupStudents(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"11.1.3");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    //Basic Methods//
    private Object replaceNull(Object o) {
        if (o == null) {
            return null;
        } else {
            return "'" + o + "'";
        }
    }

    private void setError(String error) {
        errorMessage = error;
    }

    public String getError() {
        return errorMessage;
    }

    //Instance Variables//
    private String errorMessage;
    public int STUDENTACTIVE=0;
    public int STUDENTNOTACTIVE=1;
}
