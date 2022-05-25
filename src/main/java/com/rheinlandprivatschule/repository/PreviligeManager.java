package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.helper.contentmanager.ModuleManager;
import com.rheinlandprivatschule.helper.contentmanager.ParseModuleManager;
import com.rheinlandprivatschule.model.Table;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;

public class PreviligeManager {

    public PreviligeManager(){
        error=null;
    }

    private ArrayList<String> getModuleIDSList(ModuleManager moduleManager, String moduleID){
        ArrayList<String> result=new ArrayList<String>();
        try{
            ParseModuleManager pmm=new ParseModuleManager();
            result=pmm.getModulePredecessorIDS(moduleManager,moduleID);
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    private ArrayList<String> getActivityIDSList(ModuleManager moduleManager,String activityID){
        ArrayList<String> result=new ArrayList<String>();
        try{
            ParseModuleManager pmm=new ParseModuleManager();
            result=pmm.getActivityPredecessorIDS(moduleManager,activityID);
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public boolean allowCompleteModule(int systemUser,String moduleID,ModuleManager moduleManager){
        boolean b=false;
        try{
            ArrayList<String> ids=getModuleIDSList(moduleManager,moduleID);
            Iterator<String> idsIT=ids.iterator();
            while(idsIT.hasNext()){
                addPrivilageToSystemUser(systemUser,(String)idsIT.next());
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean allowCompleteActivity(int systemUser,String activityID,ModuleManager moduleManager){
        boolean b=false;
        try{
            ArrayList<String> ids=getActivityIDSList(moduleManager,activityID);
            Iterator<String> idsIT=ids.iterator();
            while(idsIT.hasNext()){
                addPrivilageToSystemUser(systemUser,(String)idsIT.next());
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean disAllowCompleteModule(int systemUser,String moduleID,ModuleManager moduleManager){
        boolean b=false;
        try{
            ArrayList<String> ids=getModuleIDSList(moduleManager,moduleID);
            Iterator<String> idsIT=ids.iterator();
            while(idsIT.hasNext()){
                removePrivilageOfSystemUser(systemUser,(String)idsIT.next());
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean disAllowCompleteActivity(int systemUser,String activityID,ModuleManager moduleManager){
        boolean b=false;
        try{
            ArrayList<String> ids=getActivityIDSList(moduleManager,activityID);
            Iterator<String> idsIT=ids.iterator();
            while(idsIT.hasNext()){
                removePrivilageOfSystemUser(systemUser,(String)idsIT.next());
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean addPrivilageToSystemUser(int userID,String activityID){
        boolean b=false;
        Table table=TableManager.getTable(TableManager.RPS_USERPREVILIGE);
        try{
            int chk=0;
            String q="INSERT INTO "+table.getTableName()+"("+table.getColumn(0)+","+table.getColumn(1)+")VALUES('"+userID+"','"+activityID+"')";
            chk=DBHelper.getInstance().updateQuery(q);
            if(chk>0){
                b=true;
            }
        }
        catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean removePrivilageOfSystemUser(int userID,String activityID){
        boolean b=false;
        Table table=TableManager.getTable(TableManager.RPS_USERPREVILIGE);
        try{
            int chk=0;
            String q="DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+userID+"' AND "+table.getColumn(1)+"='"+activityID+"'";
            chk=DBHelper.getInstance().updateQuery(q);
            if(chk>0){
                b=true;
            }
        }
        catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public boolean removeAllPrivilagesOfSystemUser(int userID){
        boolean b=false;
        Table table=TableManager.getTable(TableManager.RPS_USERPREVILIGE);
        try{
            int chk=0;
            String q="DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+userID+"'";
            chk=DBHelper.getInstance().updateQuery(q);
            if(chk>0){
                b=true;
            }
        }
        catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public ArrayList<String> getAllPrivilagesOfSystemUser(int userID){
        ArrayList<String> previliges=new ArrayList<String>();
        Table table=TableManager.getTable(TableManager.RPS_USERPREVILIGE);
        try{
            String q="SELECT "+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+userID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                previliges.add((String)rs.getString(table.getColumn(1)));
            }
        }
        catch(Exception e){
            setError(e.toString());
        }
        return previliges;
    }

    public static boolean isSystemUserHasThisPrivilage(int userID,String activityID){
        boolean b=false;
        Table table=TableManager.getTable(TableManager.RPS_USERPREVILIGE);
        try{
            String q="SELECT "+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+userID+"' AND "+table.getColumn(1)+"='"+activityID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                rs.getString(table.getColumn(1));
                b=true;
            }
        }
        catch(Exception e){
            PreviligeManager.setError(e.toString());
        }
        return b;
    }

    public boolean isBefugnisAllowed(int systemUserID){
        boolean b=false;
        Table table=TableManager.getTable(TableManager.RPS_ALLOWEDBEFUGNIS);
        try{
            String q="SELECT "+table.getColumn(0)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"+systemUserID+"'";
            ResultSet rs=DBHelper.getInstance().executeQuery(q);
            while(rs.next()){
                rs.getInt(table.getColumn(0));
                b=true;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return b;
    }

    public static String getError(){
        return error;
    }
    private static void setError(String errorPara){
        error=errorPara;
    }

    //Instance Variables
    private static String error;
}
