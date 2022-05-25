package com.rheinlandprivatschule.model;

import java.util.Vector;

public class SystemUser extends User {

    public SystemUser(){
        super();
        this.userPlaces=null;
    }

    public Vector<String> getUserPlaces() {
        return userPlaces;
    }
    public void setUserPlaces(Vector<String> userPlaces) {
        this.userPlaces = userPlaces;
    }

    //Instance Variables
    private Vector<String> userPlaces;
}
