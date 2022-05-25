package com.rheinlandprivatschule.viewmodel;

import com.rheinlandprivatschule.model.AgentStudent;

public class FromAgenturenViewModel {

    private AgentStudent agentStudent;
    private String city;
    private String uni;
    private String wohnung;
    private String arrivalDate;
    private String agentDetail;
    private String registrationDate;

    public AgentStudent getAgentStudent() {
        return agentStudent;
    }

    public void setAgentStudent(AgentStudent agentStudent) {
        this.agentStudent = agentStudent;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getUni() {
        return uni;
    }

    public void setUni(String uni) {
        this.uni = uni;
    }

    public String getWohnung() {
        return wohnung;
    }

    public void setWohnung(String wohnung) {
        this.wohnung = wohnung;
    }

    public String getArrivalDate() {
        return arrivalDate;
    }

    public void setArrivalDate(String arrivalDate) {
        this.arrivalDate = arrivalDate;
    }

    public String getAgentDetail() {
        return agentDetail;
    }

    public void setAgentDetail(String agentDetail) {
        this.agentDetail = agentDetail;
    }

    public String getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(String registrationDate) {
        this.registrationDate = registrationDate;
    }
}
