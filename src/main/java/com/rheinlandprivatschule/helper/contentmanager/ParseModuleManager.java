package com.rheinlandprivatschule.helper.contentmanager;

import com.rheinlandprivatschule.model.Activity;

import java.util.ArrayList;
import java.util.Iterator;

public class ParseModuleManager {

    public ParseModuleManager(){
        error=null;
        this.preModule=new ArrayList<String>();
        this.preActivity=new ArrayList<String>();
    }

    public void displayModuleManager(ModuleManager mManager){
        int depth=0;
        try{
            printSpaces(depth);
            System.out.println("ModuleManager :");
            ArrayList<Module> modules=mManager.getModuleList();
            Iterator<Module> modulesIT=modules.iterator();
            while(modulesIT.hasNext()){
                Module module=(Module)modulesIT.next();
                printSpaces(depth+3);
                System.out.println("Module ID : "+module.getModuleID()+" Module Name : "+module.getModuleName());
                ArrayList<Activity> activityList=module.getActivityList();
                Iterator<Activity> activityListIT=activityList.iterator();
                while(activityListIT.hasNext()){
                    Activity activity=(Activity)activityListIT.next();
                    displayActivitiesInside(activity,depth+3);
                }
            }
        }
        catch (Exception e) {
            setError(e.toString());
        }
    }

    private void displayActivitiesInside(Activity activity,int depth){
        printSpaces(depth+3);
        System.out.println("Activity ID : "+activity.getActivityID()+" Activity Name : "+activity.getActivityName());
        ArrayList<Activity> inActivityList=activity.getSubActivities();
        Iterator<Activity> inActivityListIT=inActivityList.iterator();
        while(inActivityListIT.hasNext()){
            Activity ac=(Activity)inActivityListIT.next();
            displayActivitiesInside(ac,depth+3);
        }
    }

    private void parseActivity(ModuleManager mManager,String activityID){
        try{
            ArrayList<Module> modules=mManager.getModuleList();
            Iterator<Module> modulesIT=modules.iterator();
            while(modulesIT.hasNext()){
                Module module=(Module)modulesIT.next();
                ArrayList<Activity> activityList=module.getActivityList();
                Iterator<Activity> activityListIT=activityList.iterator();
                while(activityListIT.hasNext()){
                    Activity activity=(Activity)activityListIT.next();
                    parseActivityInside(activity,activityID);
                }
            }
        }
        catch (Exception e) {
            setError(e.toString());
        }
    }

    private void parseActivityInside(Activity activity,String activityID){
        if(activity.getActivityID().equalsIgnoreCase(activityID)){
            parsedActivity=activity;
        }
        ArrayList<Activity> inActivityList=activity.getSubActivities();
        Iterator<Activity> inActivityListIT=inActivityList.iterator();
        while(inActivityListIT.hasNext()){
            Activity ac=(Activity)inActivityListIT.next();
            parseActivityInside(ac,activityID);
        }
    }

    private void parseModule(ModuleManager mManager,String moduleName){
        ArrayList<Module> modules=mManager.getModuleList();
        Iterator<Module> modulesIT=modules.iterator();
        while(modulesIT.hasNext()){
            Module module=(Module)modulesIT.next();
            if(module.getModuleID().equalsIgnoreCase(moduleName)){
                parsedModule=module;
            }
        }
    }

    public Module getModule(ModuleManager moduleManager,String moduleID){
        parseModule(moduleManager,moduleID);
        return this.parsedModule;
    }

    public Activity getActivity(ModuleManager moduleManager,String activityID){
        parseActivity(moduleManager,activityID);
        return this.parsedActivity;
    }

    public ArrayList<String> getModulePredecessorIDS(ModuleManager moduleManager,String moduleID){
        try{
            Module module=getModule(moduleManager,moduleID);
            ArrayList<Activity> activities=module.getActivityList();
            if(activities.size()>0){
                preModule=new ArrayList<String>();
                preModule.add(moduleID);
            }
            Iterator<Activity> activitiesIT=activities.iterator();
            while(activitiesIT.hasNext()){
                Activity activity=(Activity)activitiesIT.next();
                ArrayList tempArray=getActivityPredecessorIDS(moduleManager,activity.getActivityID());
                Iterator tempArrayIT=tempArray.iterator();
                while(tempArrayIT.hasNext()){
                    preModule.add((String)tempArrayIT.next());
                }

            }

        }
        catch (Exception e) {
            setError(e.toString());
        }
        return preModule;
    }

    public ArrayList<String> getActivityPredecessorIDS(ModuleManager moduleManager,String activityID){
        preActivity=new ArrayList<String>();
        Activity activity=getActivity(moduleManager,activityID);
        parseIDSActivityInside(activity,activityID);
        return preActivity;
    }

    private void parseIDSActivityInside(Activity activity,String activityID){
        if(activity.getActivityID().equalsIgnoreCase(activityID)){
            parsedActivity=activity;
        }
        preActivity.add(activity.activityID);
        ArrayList<Activity> inActivityList=activity.getSubActivities();
        Iterator<Activity> inActivityListIT=inActivityList.iterator();
        while(inActivityListIT.hasNext()){
            Activity ac=(Activity)inActivityListIT.next();
            parseIDSActivityInside(ac,activityID);
        }
    }



    private static void printSpaces(int n) {

        for (int i = 0; i < n; i++) {
            System.out.print(' ');
        }
    }

    public static String getError(){
        return error;
    }

    private static void setError(String errorPara){
        error=errorPara;
    }

    //	Instance Variables
    private static String error;
    private Module parsedModule=null;
    private Activity parsedActivity=null;
    private ArrayList<String> preModule=null;
    private ArrayList<String> preActivity=null;

}
