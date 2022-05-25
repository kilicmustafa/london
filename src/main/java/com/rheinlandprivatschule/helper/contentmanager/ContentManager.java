package com.rheinlandprivatschule.helper.contentmanager;


import com.rheinlandprivatschule.model.Activity;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;


public class ContentManager {

    public ModuleManager getModuleManager(File file){
        ModuleManager moduleManager=new ModuleManager();
        try{

            moduleManager=getModuleManagerFromFile(file);
        }
        catch (Exception e) {
            setError(e.toString());
        }
        return moduleManager;
    }

    public void saveModuleManager(ModuleManager moduleManager,File file){
        try{

            saveModuleManagerToFile(moduleManager,file);
        }
        catch (Exception e) {
            setError(e.toString());
        }
    }

    /*----------Read ModuleManager From XML File----------*/

    private ModuleManager getModuleManagerFromFile(File myFile) {

        SAXBuilder builder = new SAXBuilder();
        try {
            Document doc = builder.build(myFile);
            Element root = doc.getRootElement();
            return parseModuleManagerFromFile(root);
        } catch (Exception e) {
            setError(e.toString());
            return null;
        }
    }

    private ModuleManager parseModuleManagerFromFile(Element current) {

        ModuleManager moduleManager = new ModuleManager();
        ArrayList<Module> moduleList=new ArrayList<Module>();

        List<Element> moduleListFromCurrent = current.getChildren();
        Iterator<Element> moduleListFromCurrentIT = moduleListFromCurrent.iterator();
        while(moduleListFromCurrentIT.hasNext()){
            Module module=new Module();
            ArrayList<Activity> activitiesList=new ArrayList<Activity>();
            Element moduleElement = (Element) moduleListFromCurrentIT.next();
            module.setModuleID(moduleElement.getAttributeValue("ModuleID"));
            module.setModuleName(moduleElement.getAttributeValue("ModuleName"));
            List<Element> activityList=moduleElement.getChildren();
            Iterator<Element> activityListIT = activityList.iterator();
            while(activityListIT.hasNext()){
                Element activity=activityListIT.next();
                getActivitiesInside(activitiesList,activity);
            }
            module.setActivityList(activitiesList);
            moduleList.add(module);
        }
        moduleManager.setModuleList(moduleList);
        return moduleManager;
    }


    private void getActivitiesInside(ArrayList<Activity> activitiesList,Element activityElement){

        Activity activity=new Activity();
        ArrayList<Activity> localActivitiesList=new ArrayList<Activity>();
        activity.setActivityID(activityElement.getAttributeValue("ActivityID"));
        activity.setActivityName(activityElement.getAttributeValue("ActivityName"));
        List<Element> subTaskAndActivity = activityElement.getChildren();
        Iterator<Element> subTaskAndActivityIT = subTaskAndActivity.iterator();
        while(subTaskAndActivityIT.hasNext()){
            Element subTaskAndActivityElement = (Element) subTaskAndActivityIT.next();
            String chk=subTaskAndActivityElement.getName();
            if(chk.equalsIgnoreCase("Activity")){
                getActivitiesInside(localActivitiesList,subTaskAndActivityElement);
            }
        }
        activity.setSubActivities(localActivitiesList);
        activitiesList.add(activity);
    }
    /*----------End Read ModuleManager From XML File----------*/


    /* Write ModuleManager To XML File*/

    private void saveModuleManagerToFile(ModuleManager mManager,File myFile) {

        try {
            FileOutputStream os = new FileOutputStream(myFile);
            XMLOutputter serializer = new XMLOutputter();
            Format f = serializer.getFormat();
            f.setIndent("  ");
            serializer.setFormat(f);
            Document doc = parseModuleManagerToFile(mManager);
            serializer.output(doc, os);
        } catch (IOException e) {
            setError(e.toString());
        }
    }

    private Document parseModuleManagerToFile(ModuleManager mm) {

        Document doc;
        Element  moduleManager= new Element("ModuleManager");
        ArrayList<Module> modules=mm.getModuleList();
        Iterator<Module> modulesIT=modules.iterator();
        while(modulesIT.hasNext()){
            Module module=(Module)modulesIT.next();
            Element moduleElement=new Element("Module");
            moduleElement.setAttribute("ModuleID",module.getModuleID());
            moduleElement.setAttribute("Name",module.getModuleName());
            ArrayList<Activity> activityList=module.getActivityList();
            Iterator<Activity> activityListIT=activityList.iterator();
            while(activityListIT.hasNext()){
                Activity activity=(Activity)activityListIT.next();
                parseModuleManagerToFileRecursive(moduleElement,activity);
            }
            moduleManager.addContent(moduleElement);
        }
        doc = new Document(moduleManager);
        return doc;

    }

    private void parseModuleManagerToFileRecursive(Element moduleElement,Activity activity){

        Element activityElement=new Element("Activity");
        activityElement.setAttribute("ActivityID",activity.getActivityID());
        activityElement.setAttribute("ActivityName",activity.getActivityName());
        ArrayList<Activity> inActivityList=activity.getSubActivities();
        Iterator<Activity> inActivityListIT=inActivityList.iterator();
        while(inActivityListIT.hasNext()){
            Activity ac=(Activity)inActivityListIT.next();
            parseModuleManagerToFileRecursive(activityElement,ac);
        }
        moduleElement.addContent(activityElement);
    }
    /* End Write ModuleManager To XML File*/


    public static String getError(){
        return error;
    }
    private static void setError(String errorPara){
        error=errorPara;
    }

    //Instance Variables
    private static String error;
}
