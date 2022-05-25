package com.rheinlandprivatschule.model;


import java.util.ArrayList;

public class Activity {

    public Activity(String activityid, String name, ArrayList<Activity> activities, ArrayList<String> taskIDS) {
        super();
        activityID = activityid;
        activityName = name;
        subActivities = activities;
    }

    public Activity() {
        super();
        activityID = null;
        activityName = null;
        subActivities = null;
    }

    public String getActivityID() {
        return activityID;
    }

    public void setActivityID(String activityID) {
        this.activityID = activityID;
    }

    public String getActivityName() {
        return activityName;
    }

    public void setActivityName(String activityName) {
        this.activityName = activityName;
    }

    public ArrayList<Activity> getSubActivities() {
        return subActivities;
    }

    public void setSubActivities(ArrayList<Activity> subActivities) {
        this.subActivities = subActivities;
    }

    //Instace Variables
    public String activityID;
    public String activityName;
    public ArrayList<Activity> subActivities;
}
