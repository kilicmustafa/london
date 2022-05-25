package com.rheinlandprivatschule.model;

import java.sql.Date;

public class Group {

    public Group(
            int groupID,
            String groupName,
            String groupDetail,
            int groupParent,
            int status,
            int groupActive,
            String messePlace,
            String messeCountry,
            String messeOrg,
            Date messeDate,
            String messeUser,
            int messeID,
            String firstName,
            String lastName,
            String email,
            String studyReason,
            Date beginDate,
            String intendedLanguage,
            String remarks,
            int studentID,
            String telephoneNumber,
            String fax,
            String mobile,
            String web,
            int textID,
            String textDesc,
            int studentActive,
            String consultantPlace,
            String consultantCountry,
            String consultantOrg,
            Date consultantDate,
            String consultantUser,
            int consultantID,
            String consultantAddress
    )
    {
        this.groupID =groupID;
        this.groupName =groupName;
        this.groupDetail =groupDetail;
        this.groupParent =groupParent;
        this.status=status;
        this.groupActive=groupActive;
        this.messePlace=messePlace;
        this.messeCountry=messeCountry;
        this.messeOrg=messeOrg;
        this.messeDate=messeDate;
        this.messeUser=messeUser;
        this.messeID=messeID;
        this.firstName=firstName;
        this.lastName=lastName;
        this.email=email;
        this.studyReason=studyReason;
        this.beginDate=beginDate;
        this.intendedLanguage=intendedLanguage;
        this.remarks=remarks;
        this.studentID=studentID;
        this.telephoneNumber=telephoneNumber;
        this.fax=fax;
        this.mobile=mobile;
        this.web=web;
        this.textID=textID;
        this.textDesc=textDesc;
        this.studentActive=studentActive;
        this.consultantPlace=consultantPlace;
        this.consultantCountry=consultantCountry;
        this.consultantOrg=consultantOrg;
        this.consultantDate=consultantDate;
        this.consultantUser=consultantUser;
        this.consultantID=consultantID;
        this.consultantAddress=consultantAddress;

    }

    public Group(){
        this.groupID = 0;
        this.groupName = null;
        this.groupDetail = null;
        this.groupParent =0;
        this.status = 0;
        this.groupActive =0;
        this.messePlace = null;
        this.messeCountry = null;
        this.messeOrg = null;
        this.messeDate = null;
        this.messeUser = null;
        this.messeID = 0;
        this.firstName = null;
        this.lastName = null;
        this.email =  null;
        this.studyReason = null;
        this.beginDate = null;
        this.intendedLanguage = null;
        this.remarks = null;
        this.studentID = 0;
        this.telephoneNumber = null;
        this.fax = null;
        this.mobile = null;
        this.web = null;
        this.textID = 0;
        this.textDesc = null;
        this.studentActive = 0;
        this.consultantPlace = null;
        this.consultantCountry = null;
        this.consultantOrg = null;
        this.consultantDate = null;
        this.consultantUser = null;
        this.consultantID =0;
        this.consultantAddress=null;
    }

    public void setGroupID(int groupID) {
        this.groupID = groupID;
    }
    public int getGroupID() {
        return groupID;
    }

    public void setGroupActive(int groupActive) {
        this.groupActive = groupActive;
    }
    public int getGroupActive() {
        return groupActive;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }
    public String getGroupName() {
        return this.groupName;
    }

    public void setGroupDetail(String groupDetail) {
        this.groupDetail = groupDetail;
    }
    public String getGroupDetail() {
        return this.groupDetail;
    }

    public void setGroupParent(int groupParent) {
        this.groupParent = groupParent;
    }
    public int getGroupParent() {
        return this.groupParent;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    public int getStatus() {
        return status;
    }

    public void setMessePlace(String messePlace) {
        this.messePlace = messePlace;
    }
    public String getMessePlace() {
        return this.messePlace;
    }

    public void setMesseCountry(String messeCountry) {
        this.messeCountry = messeCountry;
    }
    public String getMesseCountry() {
        return this.messeCountry;
    }

    public void setMesseOrg(String messeOrg) {
        this.messeOrg = messeOrg;
    }
    public String getMesseOrg() {
        return this.messeOrg;
    }

    public void setMesseDate(Date messeDate) {
        this.messeDate = messeDate;
    }
    public Date getMesseDate() {
        return this.messeDate;
    }

    public void setMesseUser(String messeUser) {
        this.messeUser = messeUser;
    }
    public String getMesseUser() {
        return this.messeUser;
    }

    public void setMesseID(int messeID) {
        this.messeID = messeID;
    }
    public int getMesseID() {
        return messeID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }
    public int getStudentID() {
        return studentID;
    }

    public String getFirstName(){
        return this.firstName;
    }
    public void setFirstName(String firstName){
        this.firstName = firstName;
    }

    public String getLastName(){
        return this.lastName;
    }
    public void setLastName(String lastName){
        this.lastName = lastName;
    }

    public String getEmail(){
        return this.email;
    }
    public void setEmail(String email){
        this.email = email;
    }

    public String getStudyReason(){
        return this.studyReason;
    }
    public void setStudyReason(String studyReason){
        this.studyReason = studyReason;
    }

    public Date getBeginDate(){
        return this.beginDate;
    }
    public void setBeginDate(Date beginDate){
        this.beginDate = beginDate;
    }

    public String getIntendedLanguage(){
        return this.intendedLanguage;
    }
    public void setIntendedLanguage(String intendedLanguage){
        this.intendedLanguage = intendedLanguage;
    }

    public String getRemarks(){
        return this.remarks;
    }
    public void setRemarks(String remarks){
        this.remarks = remarks;
    }

    public String getTelephoneNumber(){
        return this.telephoneNumber;
    }
    public void setTelephoneNumber(String telephoneNumber){
        this.telephoneNumber = telephoneNumber;
    }

    public String getFax(){
        return this.fax;
    }
    public void setFax(String fax){
        this.fax = fax;
    }

    public String getMobile(){
        return this.mobile;
    }
    public void setMobile(String mobile){
        this.mobile = mobile;
    }

    public String getWeb(){
        return this.web;
    }
    public void setWeb(String web){
        this.web = web;
    }

    public void setTextID(int textID) {
        this.textID = textID;
    }
    public int getTextID() {
        return textID;
    }

    public String getTextDesc(){
        return this.textDesc;
    }
    public void setTextDesc(String textDesc){
        this.textDesc = textDesc;
    }

    public void setStudentActive(int studentActive) {
        this.studentActive = studentActive;
    }
    public int getStudentActive() {
        return studentActive;
    }

    public void setConsultantPlace(String consultantPlace) {
        this.consultantPlace = consultantPlace;
    }
    public String getConsultantPlace() {
        return this.consultantPlace;
    }

    public void setConsultantCountry(String consultantCountry) {
        this.consultantCountry = consultantCountry;
    }
    public String getConsultantCountry() {
        return this.consultantCountry;
    }

    public void setConsultantOrg(String consultantOrg) {
        this.consultantOrg = consultantOrg;
    }
    public String getConsultantOrg() {
        return this.consultantOrg;
    }

    public void setConsultantDate(Date consultantDate) {
        this.consultantDate = consultantDate;
    }
    public Date getConsultantDate() {
        return this.consultantDate;
    }

    public void setConsultantUser(String consultantUser) {
        this.consultantUser = consultantUser;
    }
    public String getConsultantUser() {
        return this.consultantUser;
    }

    public void setConsultantID(int consultantID) {
        this.consultantID = consultantID;
    }
    public int getConsultantID() {
        return consultantID;
    }

    public void setConsultantAddress(String consultantAddress) {
        this.consultantAddress = consultantAddress;
    }
    public String getConsultantAddress() {
        return this.consultantAddress;
    }

    //Instance Variables
    private int groupID;
    private String groupName;
    private String groupDetail;
    private int groupParent;
    private int status;
    private int groupActive;
    private String messePlace;
    private String messeCountry;
    private String messeOrg;
    private Date messeDate;
    private String messeUser;
    private int messeID;
    private String firstName;
    private String lastName;
    private String email;
    private String studyReason;
    private Date beginDate;
    private String intendedLanguage;
    private String remarks;
    private int studentID;
    private String telephoneNumber;
    private String fax;
    private String mobile;
    private String web;
    private int textID;
    private String textDesc;
    private int studentActive;
    private String consultantPlace;
    private String consultantCountry;
    private String consultantOrg;
    private Date consultantDate;
    private String consultantUser;
    private int consultantID;
    private String consultantAddress;


}
