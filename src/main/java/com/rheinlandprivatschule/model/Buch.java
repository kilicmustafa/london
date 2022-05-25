package com.rheinlandprivatschule.model;

public class Buch {

    public Buch() {
        this.bookID = 0;
        this.bookName = null;
        this.isbn = null;
        this.price = 0;
        this.stufeID = 0;
        this.bookTrack = 0;
        this.schule = 0;
        this.status = 0;
        this.studentID = 0;
        this.studentName = null;
        this.bookRech = 0;
    }

    public void setBookID(int code) {
        this.bookID = code;
    }

    public void setBookName(String code) {
        this.bookName = code;
    }

    public void setStudentName(String code) {
        this.studentName = code;
    }

    public void setISBN(String code) {
        this.isbn = code;
    }

    public void setPrice(double code) {
        this.price = code;
    }

    public void setStufe(int code) {
        this.stufeID = code;
    }

    public void setBookTrack(int code) {
        this.bookTrack = code;
    }

    public void setSchule(int code) {
        this.schule = code;
    }

    public void setStatus(int code) {
        this.status = code;
    }

    public void setStudentID(int code) {
        this.studentID = code;
    }

    public void setBookRechnungID(int code) {
        this.bookRech = code;
    }

    public int getBookID() {
        return this.bookID;
    }

    public String getBookName() {
        return this.bookName;
    }

    public String getStudentName() {
        return this.studentName;
    }

    public String getISBN() {
        return this.isbn;
    }

    public double getPrice() {
        return this.price;
    }

    public int getStufe() {
        return this.stufeID;
    }

    public int getBookTrack() {
        return this.bookTrack;
    }

    public int getSchule() {
        return this.schule;
    }

    public int getStatus() {
        return this.status;
    }

    public int getStudentID() {
        return this.studentID;
    }

    public int getBookRechnungID() {
        return this.bookRech;
    }

    //Instance Variables
    private int bookID;
    private String bookName;
    private String studentName;
    private String isbn;
    private double price;
    private int stufeID;
    private int bookTrack;
    private int schule;
    private int status;
    private int studentID;
    private int bookRech;
}
