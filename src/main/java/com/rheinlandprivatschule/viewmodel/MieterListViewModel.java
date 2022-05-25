package com.rheinlandprivatschule.viewmodel;

import com.rheinlandprivatschule.model.Residence;

public class MieterListViewModel {

    public Residence residence;
    public String firstname="";
    public String lastname="";
    public String fnldate ="";
    public String status ="";
    public double rent =0;
    public double rent1 =0;
    public double rent2 =0;
    public double rent3 =0;
    public double rent4 =0;
    public double rent5 =0;

    public Residence getResidence() {
        return residence;
    }

    public void setResidence(Residence residence) {
        this.residence = residence;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getFnldate() {
        return fnldate;
    }

    public void setFnldate(String fnldate) {
        this.fnldate = fnldate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getRent() {
        return rent;
    }

    public void setRent(double rent) {
        this.rent = rent;
    }

    public double getRent1() {
        return rent1;
    }

    public void setRent1(double rent1) {
        this.rent1 = rent1;
    }

    public double getRent2() {
        return rent2;
    }

    public void setRent2(double rent2) {
        this.rent2 = rent2;
    }

    public double getRent3() {
        return rent3;
    }

    public void setRent3(double rent3) {
        this.rent3 = rent3;
    }

    public double getRent4() {
        return rent4;
    }

    public void setRent4(double rent4) {
        this.rent4 = rent4;
    }

    public double getRent5() {
        return rent5;
    }

    public void setRent5(double rent5) {
        this.rent5 = rent5;
    }
}
