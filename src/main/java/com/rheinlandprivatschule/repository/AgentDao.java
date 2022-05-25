package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.AgentStudent;
import com.rheinlandprivatschule.model.Course;
import com.rheinlandprivatschule.model.CourseRegistration;
import com.rheinlandprivatschule.model.Table;

import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;

public class AgentDao {

    public boolean addAgentStudent(int agentID,
                                   int werbungID,
                                   int studentID,
                                   int university,
                                   int residence,
                                   Date travel,
                                   String detail,
                                   Date registrationDate){
        boolean result=false;
        Table table=TableManager.getTable(TableManager.RPS_AGENTSTUDENT);
        try{
            String q="INSERT INTO "+table.getTableName()+" ("
                    +table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+") VALUES('"
                    +agentID+"','"
                    +werbungID+"','"
                    +studentID+"','"
                    +university+"','"
                    +residence+"',"
                    +replaceNull(travel)+","
                    +replaceNull(detail)+","
                    +replaceNull(registrationDate)+")";
            DBHelper.getInstance().updateQuery(q);
            result=true;
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public boolean deleteAgentStudent(int studentID){
        boolean result=false;
        Table table=TableManager.getTable(TableManager.RPS_AGENTSTUDENT);
        try{
            String q="DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(2)+"='"+studentID+"'";
            DBHelper.getInstance().updateQuery(q);
            result=true;
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public ArrayList<AgentStudent> getAgentStudents(int agentID, int studentStatus){
        ArrayList<AgentStudent> agnetStudents=new ArrayList<AgentStudent>();
        Table table=TableManager.getTable(TableManager.RPS_AGENTSTUDENT);
        Table werbung_table=TableManager.getTable(TableManager.RPS_WERBUNGRELATED);
        try{
            String q="SELECT a."+table.getColumn(0)+",a."
                    +table.getColumn(1)+",a."
                    +table.getColumn(2)+",a."
                    +table.getColumn(3)+",a."
                    +table.getColumn(4)+",a."
                    +table.getColumn(5)+",a."
                    +table.getColumn(6)+",a."
                    +table.getColumn(7)+" FROM "
                    +table.getTableName()+" AS a,"
                    +werbung_table.getTableName()+" AS b WHERE b."
                    +werbung_table.getColumn(0)+"=a."+table.getColumn(2)+" AND b."
                    +werbung_table.getColumn(1)+"=a."+table.getColumn(1)+" AND b."
                    +werbung_table.getColumn(2)+"="+studentStatus+" AND a."
                    +table.getColumn(0)+"='"+agentID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                AgentStudent agentStudent=new AgentStudent();
                agentStudent.setAgentID(rs.getInt(table.getColumn(0)));
                agentStudent.setWerbungID(rs.getInt(table.getColumn(1)));
                agentStudent.setStudentID(rs.getInt(table.getColumn(2)));
                agentStudent.setUniversity(rs.getInt(table.getColumn(3)));
                agentStudent.setResidence(rs.getInt(table.getColumn(4)));
                agentStudent.setTravel(rs.getDate(table.getColumn(5)));
                agentStudent.setStudentDetail(rs.getString(table.getColumn(6)));
                agentStudent.setRegistrationDate(rs.getDate(table.getColumn(7)));
                agnetStudents.add(agentStudent);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return agnetStudents;
    }

    public ArrayList<AgentStudent> getAllAgentStudents(){
        ArrayList<AgentStudent> agnetStudents=new ArrayList<AgentStudent>();
        Table agent_table= TableManager.getTable(TableManager.RPS_AGENTSTUDENT);
        Table admin_table=TableManager.getTable(TableManager.RPS_SYSTEMUSER);
        Table student_table=TableManager.getTable(TableManager.RPS_USER);
        try{
            String q="SELECT a."+agent_table.getColumn(0)+",a."
                    +agent_table.getColumn(1)+",a."
                    +agent_table.getColumn(2)+",a."
                    +agent_table.getColumn(3)+",a."
                    +agent_table.getColumn(4)+",a."
                    +agent_table.getColumn(5)+",a."
                    +agent_table.getColumn(6)+",a."
                    +agent_table.getColumn(7)+",CONCAT_WS(' ',b."
                    +student_table.getColumn(1)+",b."
                    +student_table.getColumn(2)+") AS studentname,CONCAT_WS(' ',c."
                    +admin_table.getColumn(1)+",c."
                    +admin_table.getColumn(2)+") AS agentname FROM "
                    +agent_table.getTableName()+" AS a,"
                    +student_table.getTableName()+" AS b,"
                    +admin_table.getTableName()+" AS c WHERE a."
                    +agent_table.getColumn(0)+"=c."+admin_table.getColumn(0)+" AND a."
                    +agent_table.getColumn(7)+" >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH) AND a."
                    +agent_table.getColumn(2)+"=b."+student_table.getColumn(0)+" ORDER BY b."
                    +student_table.getColumn(0)+" DESC";
            ResultSet rs= DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                AgentStudent agentStudent=new AgentStudent();
                agentStudent.setAgentID(rs.getInt(agent_table.getColumn(0)));
                agentStudent.setWerbungID(rs.getInt(agent_table.getColumn(1)));
                agentStudent.setStudentID(rs.getInt(agent_table.getColumn(2)));
                agentStudent.setUniversity(rs.getInt(agent_table.getColumn(3)));
                agentStudent.setResidence(rs.getInt(agent_table.getColumn(4)));
                agentStudent.setTravel(rs.getDate(agent_table.getColumn(5)));
                agentStudent.setStudentDetail(rs.getString(agent_table.getColumn(6)));
                agentStudent.setRegistrationDate(rs.getDate(agent_table.getColumn(7)));
                agentStudent.setStudentName(rs.getString("studentname"));
                agentStudent.setAgentName(rs.getString("agentname"));
                agnetStudents.add(agentStudent);
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return agnetStudents;
    }

    public AgentStudent getAgentStudent(int studentID){
        AgentStudent agentStudent=new AgentStudent();
        Table table=TableManager.getTable(TableManager.RPS_AGENTSTUDENT);
        try{
            String q="SELECT "+table.getColumn(0)+","
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(6)+","
                    +table.getColumn(7)+" FROM "
                    +table.getTableName()+" WHERE "
                    +table.getColumn(2)+"='"+studentID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                agentStudent.setAgentID(rs.getInt(table.getColumn(0)));
                agentStudent.setWerbungID(rs.getInt(table.getColumn(1)));
                agentStudent.setStudentID(rs.getInt(table.getColumn(2)));
                agentStudent.setUniversity(rs.getInt(table.getColumn(3)));
                agentStudent.setResidence(rs.getInt(table.getColumn(4)));
                agentStudent.setTravel(rs.getDate(table.getColumn(5)));
                agentStudent.setStudentDetail(rs.getString(table.getColumn(6)));
                agentStudent.setRegistrationDate(rs.getDate(table.getColumn(7)));
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return agentStudent;
    }

    public String getStudentPreferredCity(int studentID){
        String city="";
        try{
            int courseID=0;
            StudentDao studentDB=new StudentDao();
            ArrayList<CourseRegistration> registrations=studentDB.getRegistrationByStudentIDInternally(studentID);
            Iterator registrationsIT=registrations.iterator();
            while(registrationsIT.hasNext()){
                CourseRegistration registration=(CourseRegistration)registrationsIT.next();
                courseID=registration.getCourseID();
                break;
            }
            Course course=(new CourseDao()).getCourse(courseID);
            int placeID=course.getCoursePlace();
            city=(new PlaceDao()).getPlace(placeID).getPlaceName();
            if(city==null){
                city="";
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return city;
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
