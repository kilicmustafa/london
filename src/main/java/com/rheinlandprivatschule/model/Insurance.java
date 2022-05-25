package com.rheinlandprivatschule.model;

public class Insurance{

    public Insurance(){
        insuranceID = 0;
        insuranceName = null;
        insuranceDescription = null;

        studentID=0;
        studentInsuranceDescription=null;
    }

    public int getInsuranceID(){
        return insuranceID;
    }
    public void setInsuranceID(int code){
        insuranceID = code;
    }

    public void setInsuranceName(String code){
        insuranceName = code;
    }
    public String getInsuranceName(){
        return insuranceName;
    }

    public void setInsuranceDescription(String code){
        insuranceDescription = code;
    }
    public String getInsuranceDescription(){
        return insuranceDescription;
    }


    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }
    public int getStudentID() {
        return studentID;
    }

    public void setStudentInsuranceDescription(String studentInsuranceDescription) {
        this.studentInsuranceDescription = studentInsuranceDescription;
    }
    public String getStudentInsuranceDescription() {
        return studentInsuranceDescription;
    }

    //Instance Variables
    private int insuranceID;
    private String insuranceName;
    private String insuranceDescription;

    private int studentID;
    private String studentInsuranceDescription;
}
