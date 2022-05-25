package com.rheinlandprivatschule.model;


public class Resident extends User{

    public Resident(){
        super();
        this.isStudent = 0;
        this.student = null;
    }

    public int isStudent() {
        return isStudent;
    }
    public Student getStudentReference() {
        return student;
    }

    public void setStudent(int isStudent) {
        this.isStudent = isStudent;
    }
    public void setStudentReference(Student student) {
        this.student = student;
    }

    //Instance Variables
    private int isStudent;
    private Student student;
}
