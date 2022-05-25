package com.rheinlandprivatschule.helper.contentmanager;

import com.rheinlandprivatschule.model.Activity;

import java.util.ArrayList;

public class Module {

    public Module() {
        super();
        this.moduleID=null;
        this.moduleName = null;
        activityList = null;
    }
    public void setModuleID(String id) {
        this.moduleID = id;
    }

    public String getModuleID() {
        return this.moduleID;
    }

    public void setModuleName(String name) {
        this.moduleName = name;
    }

    public String getModuleName() {
        return this.moduleName;
    }

    public void setActivityList(ArrayList<Activity> activityList) {
        this.activityList = activityList;
    }

    public ArrayList<Activity> getActivityList() {
        return activityList;
    }

    //Instace Variables
    private String moduleID;
    private String moduleName;
    private ArrayList<Activity> activityList;
}
