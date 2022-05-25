package com.rheinlandprivatschule.model;

import java.sql.Date;

public class Transaction{

    public Transaction(){

        this.transactionNo=0;

        this.courseID=0;
        this.courseName=null;

        this.studentID=0;
        this.studentCompleteName=null;

        this.paid=-1;
        this.paymentDate=null;
        this.paymentType=-1;

        this.placeID=0;
        this.placeName=null;

        this.loginUserID=0;
        this.loginUserCompleteName=null;
        this.bookName=null;
        this.initialTest=0;
        this.month=0;
        this.year=0;

        this.kasseNo=0;
        this.kassePay=-1;
        this.kasseDate=null;
    }

    public Transaction(int transactionNo,
                       int courseID,
                       String courseName,
                       int studentID,
                       String studentCompleteName,
                       double paid,
                       Date paymentDate,
                       int paymentType,
                       int placeID,
                       String placeName,
                       int loginUserID,
                       String loginUserCompleteName,
                       String bookName,
                       int initialTest,
                       int month,
                       int year,
                       int kasseNo,
                       double kassePay,
                       Date kasseDate){
        this.transactionNo=transactionNo;

        this.courseID=courseID;
        this.courseName=courseName;

        this.studentID=studentID;
        this.studentCompleteName=studentCompleteName;

        this.paid=paid;
        this.paymentDate=paymentDate;
        this.paymentType=paymentType;

        this.placeID=placeID;
        this.placeName=placeName;

        this.loginUserID=loginUserID;
        this.loginUserCompleteName=loginUserCompleteName;
        this.bookName=bookName;
        this.initialTest=initialTest;
        this.month=month;
        this.year=year;

        this.kasseNo=kasseNo;
        this.kassePay=kassePay;
        this.kasseDate=kasseDate;
    }

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getLoginUserCompleteName() {
        return loginUserCompleteName;
    }

    public void setLoginUserCompleteName(String loginUserCompleteName) {
        this.loginUserCompleteName = loginUserCompleteName;
    }

    public int getLoginUserID() {
        return loginUserID;
    }

    public void setLoginUserID(int loginUserID) {
        this.loginUserID = loginUserID;
    }

    public double getPaid() {
        return paid;
    }

    public void setPaid(double paid) {
        this.paid = paid;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public int getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(int paymentType) {
        this.paymentType = paymentType;
    }

    public int getPlaceID() {
        return placeID;
    }

    public void setPlaceID(int placeID) {
        this.placeID = placeID;
    }

    public String getPlaceName() {
        return placeName;
    }

    public void setPlaceName(String placeName) {
        this.placeName = placeName;
    }

    public String getStudentCompleteName() {
        return studentCompleteName;
    }

    public void setStudentCompleteName(String studentCompleteName) {
        this.studentCompleteName = studentCompleteName;
    }

    public int getStudentID() {
        return studentID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }

    public int getTransactionNo() {
        return transactionNo;
    }

    public void setTransactionNo(int transactionNo) {
        this.transactionNo = transactionNo;
    }

    public int getInitialTest() {
        return initialTest;
    }

    public void setInitialTest(int initialTest) {
        this.initialTest = initialTest;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public double getKassePay() {
        return kassePay;
    }

    public void setKassePay(double kassePay) {
        this.kassePay = kassePay;
    }

    public int getKasseNo() {
        return kasseNo;
    }

    public void setKasseNo(int kasseNo) {
        this.kasseNo = kasseNo;
    }

    public Date getKasseDate() {
        return kasseDate;
    }

    public void setKasseDate(Date kasseDate) {
        this.kasseDate = kasseDate;
    }


    //Instance Variables
    private int transactionNo;

    private int courseID;
    private String courseName;

    private int studentID;
    private String studentCompleteName;

    private double paid;
    private Date paymentDate;
    private int paymentType;

    private int placeID;
    private String placeName;

    private int loginUserID;
    private String loginUserCompleteName;
    private String bookName;
    private int initialTest;
    private int month;
    private int year;

    private int kasseNo;
    private double kassePay;
    private Date kasseDate;
}
