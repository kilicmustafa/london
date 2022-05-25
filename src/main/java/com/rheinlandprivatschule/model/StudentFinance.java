package com.rheinlandprivatschule.model;

public class StudentFinance {

    public StudentFinance() {
        super();
        this.studentID=0;
        this.totalFee=0;
        this.balance=0;
    }

    public int getStudentID() {
        return studentID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }
    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public double getTotalFee() {
        return totalFee;
    }

    public void setTotalFee(double totalFee) {
        this.totalFee = totalFee;
    }

    // Instance Variables
    private int studentID;
    private double totalFee;
    private double balance;
}
