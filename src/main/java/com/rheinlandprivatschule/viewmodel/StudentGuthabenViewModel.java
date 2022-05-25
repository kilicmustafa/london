package com.rheinlandprivatschule.viewmodel;

import com.rheinlandprivatschule.model.SingleClassBalance;
import com.rheinlandprivatschule.model.Student;

public class StudentGuthabenViewModel {
    private SingleClassBalance singleClassBalance;
    private Student student;
    private String formatedDate;
    private String formatedCurrency;

    public StudentGuthabenViewModel(SingleClassBalance singleClassBalance, Student student, String formatedDate, String formatedCurrency) {
        this.singleClassBalance = singleClassBalance;
        this.student = student;
        this.formatedDate = formatedDate;
        this.formatedCurrency = formatedCurrency;
    }

    public SingleClassBalance getSingleClassBalance() {
        return singleClassBalance;
    }

    public void setSingleClassBalance(SingleClassBalance singleClassBalance) {
        this.singleClassBalance = singleClassBalance;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public String getFormatedDate() {
        return formatedDate;
    }

    public void setFormatedDate(String formatedDate) {
        this.formatedDate = formatedDate;
    }

    public String getFormatedCurrency() {
        return formatedCurrency;
    }

    public void setFormatedCurrency(String formatedCurrency) {
        this.formatedCurrency = formatedCurrency;
    }
}
