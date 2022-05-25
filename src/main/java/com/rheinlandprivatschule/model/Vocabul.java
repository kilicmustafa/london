package com.rheinlandprivatschule.model;


public class Vocabul {
    public Vocabul() {
        this.srNo = 0;
        this.word = null;
        this.desc = null;
        this.sprachID = 0;
        this.lectureID = 0;
        this.wordTrack = 0;
    }

    //Setters

    public void setSerialNo(int code) {
        this.srNo = code;
    }

    public void setWord(String code) {
        this.word = code;
    }

    public void setDesc(String code) {
        this.desc = code;
    }

    public void setSprachID(int code) {
        this.sprachID = code;
    }

    public void setLectureID(int code) {
        this.lectureID = code;
    }

    public void setWordTrack(int code) {
        this.wordTrack = code;
    }

    //Getters

    public int getSerialNo() {
        return this.srNo;
    }

    public String getWord() {
        return this.word;
    }

    public String getDesc() {
        return this.desc;
    }

    public int getSprachID() {
        return this.sprachID;
    }

    public int getLectureID() {
        return this.lectureID;
    }

    public int getWordTrack() {
        return this.wordTrack;
    }

    //Instacnce Variables
    private int srNo;

    private String word;

    private String desc;

    private int sprachID;

    private int lectureID;

    private int wordTrack;
}
