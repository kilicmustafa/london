package com.rheinlandprivatschule.helper.contentmanager;


import com.rheinlandprivatschule.model.Activity;

import java.util.ArrayList;

public class ModuleManager {

    public ModuleManager(ArrayList<Module> moduleList) {
        super();
        this.moduleList = moduleList;
    }

    public ModuleManager() {
        super();
        moduleList = null;
    }

    public ArrayList<Module> getModuleList() {
        return this.moduleList;
    }

    public void setModuleList(ArrayList<Module> moduleList) {
        this.moduleList = moduleList;
    }

    public boolean isModuleHasPredecessor(String moduleID){
        boolean result=false;
        try{
            ParseModuleManager pmm=new ParseModuleManager();
            Module module=pmm.getModule(this,moduleID);
            ArrayList<Activity> activitList=module.getActivityList();
            if(activitList.size()>0){
                result=true;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public boolean isActivityHasPredecessor(String activityID){
        boolean result=false;
        try{
            ParseModuleManager pmm=new ParseModuleManager();
            Activity activity=pmm.getActivity(this,activityID);
            ArrayList<Activity> activitList=activity.getSubActivities();
            if(activitList.size()>0){
                result=true;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public ArrayList getPredecessor(String currentID,int type){
        ArrayList<Activity> result=new ArrayList<Activity>();
        ParseModuleManager pmm=new ParseModuleManager();
        try{
            if(type==ModuleManager.MODULE){
                Module module=pmm.getModule(this,currentID);
                result=module.getActivityList();
            }else if(type==ModuleManager.ACTIVITY){
                Activity activity=pmm.getActivity(this,currentID);
                result=activity.getSubActivities();
            }else{
                result=null;
            }

        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

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

    //Instance Variables
    private String error;


    //Instace Variables
    private ArrayList<Module> moduleList;
    public static int MODULE=1;
    public static int ACTIVITY=2;
}
