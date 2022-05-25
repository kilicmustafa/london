package com.rheinlandprivatschule.model;


public class Module {

    public Module() {
        moduleID = 0;
        moduleName = null;
    }


    public int getModuleID() {
        return moduleID;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleID(int code) {
        moduleID = code;
    }

    public void setModuleName(String code) {
        moduleName = code;
    }

    //Instance Variables
    private int moduleID;
    private String moduleName;
}
