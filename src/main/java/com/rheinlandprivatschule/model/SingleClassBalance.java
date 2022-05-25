package com.rheinlandprivatschule.model;

import java.util.Vector;


public class SingleClassBalance {


    public double getBalance() {
        return balance;
    }
    public void setBalance(double balance) {
        this.balance = balance;
    }

    public int getStudentID() {
        return studentID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }

    public Vector getTransactions() {
        return transactions;
    }

    public void setTransactions(Vector transactions) {
        this.transactions = transactions;
    }

    //Instance Variables
    private int studentID;
    private Vector transactions;
    private double balance;
}
