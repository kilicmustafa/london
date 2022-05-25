package com.rheinlandprivatschule.model;


import java.util.Vector;

public class Lecture {
    public Lecture() {
        this.lectureID = 0;
        this.lectureName = null;
        this.vocabal = null;
    }

    //Setters

    public void setLectureID(int code) {
        this.lectureID = code;
    }

    public void setLectureName(String code) {
        this.lectureName = code;
    }

    public void setVocabal(Vector code) {
        this.vocabal = code;
    }

    //Getters

    public int getLectureID() {
        return this.lectureID;
    }

    public String getLectureName() {
        return this.lectureName;
    }

    public Vector getVocabal() {
        return this.vocabal;
    }

    public static void main(String[] args) {
        //Lecture lecture1 = new Lecture();
    }

    //Instacne Variables
    private int lectureID;

    private String lectureName;

    private Vector vocabal;

}
