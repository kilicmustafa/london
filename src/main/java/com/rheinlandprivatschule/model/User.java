package com.rheinlandprivatschule.model;

import java.sql.Date;

public class User{

    public static void main(String[] args){
        //User db = new User();
        //countrydb db= new countrydb();
        //Vector a= db.getUserCountryID();
        //System.out.println(a.size());
    }

    public User(int costID,
                String costDesc,
                double actualFee,
                double tranBalance,
                int userID,
                int residenceID,
                int residentID,
                int transPayType,
                int placeID,
                int adminID,
                Date mietStart,
                Date mietEnd,
                String mieterCountStart,
                String mieterCountEnd,
                String userFirstName,
                String userLastName,
                Date userBirthDate,
                int userGender,
                String userBirthPlace,
                String userNationality,
                String userCO,
                String userAddress,
                String userPostCode,
                String userCity,
                String userCountry,
                String userHomePhone,
                String userMobilePhone,
                String userFax,
                String userEmail,
                String userAccountNo,
                String userBLZ,
                String userBankName,
                String userPassport,
                int userType,
                double userStundenLohn,
                double totalPay,
                String userRemarks,
                int userActive,
                String userLoginName,
                String userPassword,
                int userCountryID,
                String userHomeCode,
                String userHomeRegion,
                String userMobileCode,
                String userMobileRegion,
                String userFaxCode,
                String userFaxRegion,
                String userBamfNumber,
                int userBamfChoice,
                int userHours,
                String userLastVisit,
                String userCompany,
                String userBamfNrSchool,
                int userAcademicPoints,
                int userSchoolingYears,
                int userIntTest,
                int userIntTestCheck,
                int userProficency,
                int userSponsorShip,
                int userIdentityID,
                int userCostSharing,
                int userClassification,
                Date userConclusion,
                Date userConcCourse,
                Date userRegDate,
                String userVerifiedNumber,
                Date userGradingDate,
                int userModuleNr,
                String bildName,
                int bildID,
                int freigabeStatus,
                Date freigabeDate)
    {
        this.costID = costID;
        this.costDesc=costDesc;
        this.actualFee=actualFee;
        this.tranBalance=tranBalance;
        this.residenceID = residenceID;
        this.transPayType = transPayType;
        this.placeID = placeID;
        this.adminID = adminID;
        this.mietStart = mietStart;
        this.mietEnd = mietEnd;
        this.mieterCountStart = mieterCountStart;
        this.mieterCountEnd = mieterCountEnd;
        this.userID = userID;
        this.userFirstName = userFirstName;
        this.userLastName = userLastName;
        this.userBirthDate = userBirthDate;
        this.userGender = userGender;
        this.userBirthPlace = userBirthPlace;
        this.userNationality = userNationality;
        this.userCO = userCO;
        this.userAddress = userAddress;
        this.userPostCode = userPostCode;
        this.userCity = userCity;
        this.userCountry = userCountry;
        this.userHomePhone = userHomePhone;
        this.userMobilePhone = userMobilePhone;
        this.userFax = userFax;
        this.userEmail = userEmail;

        this.userAccountNo = userAccountNo;
        this.userBLZ = userBLZ;
        this.userBankName = userBankName;
        this.userPassport = userPassport;

        this.userType = userType;
        this.userStundenLohn=userStundenLohn;
        this.totalPay=totalPay;
        this.userRemarks=userRemarks;
        this.userActive=userActive;

        this.userLoginName = userLoginName;
        this.userPassword = userPassword;
        this.userCountryID = userCountryID;
        this.userHomeCode = userHomeCode;
        this.userHomeRegion = userHomeRegion;
        this.userMobileCode = userMobileCode;
        this.userMobileRegion = userMobileRegion;
        this.userFaxCode = userFaxCode;
        this.userFaxRegion = userFaxRegion;
        this.userBamfNumber = userBamfNumber;
        this.userBamfChoice = userBamfChoice;
        this.userHours = userHours;
        this.userLastVisit = userLastVisit;
        this.userCompany = userCompany;
        this.userBamfNrSchool = userBamfNrSchool;
        this.userAcademicPoints = userAcademicPoints;
        this.userSchoolingYears =userSchoolingYears;
        this.userIntTest = userIntTest;
        this.userIntTestCheck = userIntTestCheck;
        this.userProficency = userProficency;
        this.userSponsorShip = userSponsorShip;
        this.userIdentityID = userIdentityID;
        this.userCostSharing = userCostSharing;
        this.userClassification = userClassification;
        this.userConclusion = userConclusion;
        this.userConcCourse = userConcCourse;
        this.userRegDate = userRegDate;
        this.userVerifiedNumber = userVerifiedNumber;
        this.userGradingDate = userGradingDate;
        this.userModuleNr = userModuleNr;
        this.bildName=bildName;
        this.bildID=bildID;
        this.freigabeStatus=freigabeStatus;
        this.freigabeDate=freigabeDate;

    }

    public User(){
        this.costID = 0;
        this.costDesc =null;
        this.actualFee = 0;
        this.tranBalance=0;
        this.residenceID = 0;
        this.transPayType = 0;
        this.placeID = 0;
        this.adminID = 0;
        this.userID = 0;
        this.mietStart = null;
        this.mietEnd = null;
        this.mieterCountStart = null;
        this.mieterCountEnd = null;
        this.userFirstName = null;
        this.userLastName = null;
        this.userBirthDate = null;
        this.userGender = 0;
        this.userBirthPlace = null;
        this.userNationality = null;
        this.userCO = null;
        this.userAddress = null;
        this.userPostCode = null;
        this.userCity = null;
        this.userCountry = null;
        this.userHomePhone = null;
        this.userMobilePhone = null;
        this.userFax = null;
        this.userEmail = null;

        this.userAccountNo = null;
        this.userBLZ = null;
        this.userBankName = null;
        this.userPassport = null;

        this.userType = 0;
        this.userStundenLohn=0;
        this.totalPay=0;
        this.userRemarks=null;
        this.userActive=1;

        this.userLoginName = null;
        this.userPassword = null;
        this.userCountryID=0;
        this.userHomeCode = null;
        this.userHomeRegion = null;
        this.userMobileCode = null;
        this.userMobileRegion = null;
        this.userFaxCode = null;
        this.userFaxRegion = null;
        this.userBamfNumber = null;
        this.userBamfChoice = 0;
        this.userHours = 0;
        this.userLastVisit = null;
        this.userCompany = null;
        this.userBamfNrSchool = null;
        this.userAcademicPoints = 0;
        this.userSchoolingYears = 0;
        this.userIntTest = 0;
        this.userIntTestCheck = 0;
        this.userProficency = 0;
        this.userSponsorShip = 0;
        this.userIdentityID = 0;
        this.userCostSharing = 0;
        this.userClassification = 0;
        this.userConclusion = null;
        this.userConcCourse = null;
        this.userVerifiedNumber=null;
        this.userGradingDate=null;
        this.userModuleNr=0;
        this.bildName=null;
        this.bildID=0;
        this.freigabeStatus=0;
        this.freigabeDate=null;
    }

    public int getCostID(){
        return this.costID;
    }
    public void setCostID(int costID){
        this.costID = costID;
    }

    public String getCostDesc(){
        return this.costDesc;
    }
    public void setcostDesc(String costDesc){
        this.costDesc = costDesc;
    }

    public double getActualFee() {
        return actualFee;
    }
    public void setActualFee(double actualFee) {
        this.actualFee = actualFee;
    }

    public double getTranBalance() {
        return tranBalance;
    }
    public void setTranBalance(double tranBalance) {
        this.tranBalance= tranBalance;
    }

    public int getResidenceID(){
        return this.residenceID;
    }
    public void setResidenceID(int residenceID){
        this.residenceID = residenceID;
    }

    public int getResidentID(){
        return this.residentID;
    }
    public void setResidentID(int residentID){
        this.residentID = residentID;
    }

    public int getTransPayType(){
        return this.transPayType;
    }
    public void setTransPayType(int transPayType){
        this.transPayType = transPayType;
    }

    public int getPlaceID(){
        return this.placeID;
    }
    public void setPlaceID(int placeID){
        this.placeID = placeID;
    }

    public int getAdminID(){
        return this.adminID;
    }
    public void setAdminID(int adminID){
        this.adminID = adminID;
    }

    public int getUserID(){
        return this.userID;
    }

    public void setUserID(int userID){
        this.userID = userID;
    }

    public Date getMietStart(){
        return this.mietStart;
    }
    public void setMietStart(Date mietStart){
        this.mietStart = mietStart;
    }

    public Date getMietEnd(){
        return this.mietEnd;
    }
    public void setMietEnd(Date mietEnd){
        this.mietEnd = mietEnd;
    }

    public String getMieterCountStart(){
        return this.mieterCountStart;
    }
    public void setMieterCountStart(String mieterCountStart){
        this.mieterCountStart = mieterCountStart;
    }

    public String getMieterCountEnd(){
        return this.mieterCountEnd;
    }
    public void setMieterCountEnd(String mieterCountEnd){
        this.mieterCountEnd = mieterCountEnd;
    }

    public String getUserFirstName(){
        return this.userFirstName;
    }
    public void setUserFirstName(String userFirstName){
        this.userFirstName = userFirstName;
    }

    public String getUserLastName(){
        return this.userLastName;
    }
    public void setUserLastName(String userLastName){
        this.userLastName = userLastName;
    }

    public Date getUserBirthDate(){
        return this.userBirthDate;
    }
    public void setUserBirthDate(Date userBirthDate){
        this.userBirthDate = userBirthDate;
    }

    public int getUserGender(){
        return this.userGender;
    }
    public void setUserGender(int userGender){
        this.userGender = userGender;
    }

    public String getUserBirthPlace(){
        return this.userBirthPlace;
    }
    public void setUserBirthPlace(String userBirthPlace){
        this.userBirthPlace = userBirthPlace;
    }

    public String getUserNationality(){
        return this.userNationality;
    }
    public void setUserNationality(String userNationality){
        this.userNationality = userNationality;
    }

    public String getUserCO(){
        return this.userCO;
    }
    public void setUserCO(String userCO){
        this.userCO = userCO;
    }

    public String getUserAddress(){
        return this.userAddress;
    }
    public void setUserAddress(String userAddress){
        this.userAddress = userAddress;
    }

    public String getUserPostCode(){
        return this.userPostCode;
    }
    public void setUserPostCode(String userPostCode){
        this.userPostCode = userPostCode;
    }

    public String getUserCity(){
        return this.userCity;
    }
    public void setUserCity(String userCity){
        this.userCity = userCity;
    }

    public String getUserCountry(){
        return this.userCountry;
    }
    public void setUserCountry(String userCountry){
        this.userCountry = userCountry;
    }

    public String getUserHomePhone(){
        return this.userHomePhone;
    }
    public void setUserHomePhone(String userHomePhone){
        this.userHomePhone = userHomePhone;
    }

    public String getUserMobilePhone(){
        return this.userMobilePhone;
    }
    public void setUserMobilePhone(String userMobilePhone){
        this.userMobilePhone =userMobilePhone;
    }

    public String getUserFax(){
        return this.userFax;
    }
    public void setUserFax(String userFax){
        this.userFax = userFax;
    }

    public String getUserEmail(){
        return this.userEmail;
    }
    public void setUserEmail(String userEmail){
        this.userEmail = userEmail;
    }

    public String getUserAccountNo() {
        return userAccountNo;
    }
    public void setUserAccountNo(String userAccountNo) {
        this.userAccountNo = userAccountNo;
    }

    public String getUserBLZ() {
        return userBLZ;
    }
    public void setUserBLZ(String userBLZ) {
        this.userBLZ = userBLZ;
    }

    public String getUserBankName() {
        return userBankName;
    }
    public void setUserBankName(String userBankName) {
        this.userBankName = userBankName;
    }

    public String getUserPassport(){
        return this.userPassport;
    }
    public void setUserPassport(String userPassport){
        this.userPassport = userPassport;
    }

    public int getUserType(){
        return this.userType;
    }
    public void setUserType(int userType){
        this.userType = userType;
    }

    public double getUserStundenLohn() {
        return userStundenLohn;
    }
    public void setUserStundenLohn(double userStundenLohn) {
        this.userStundenLohn = userStundenLohn;
    }

    public double getTotalPay() {
        return totalPay;
    }
    public void setTotalPay(double totalPay) {
        this.totalPay = totalPay;
    }

    public String getUserRemarks() {
        return userRemarks;
    }
    public void setUserRemarks(String userRemarks) {
        this.userRemarks = userRemarks;
    }

    public int getUserActive() {
        return userActive;
    }
    public void setUserActive(int userActive) {
        this.userActive = userActive;
    }

    public String getUserLoginName(){
        return this.userLoginName;
    }
    public void setUserLoginName(String userLoginName){
        this.userLoginName = userLoginName;
    }

    public String getUserPassword(){
        return this.userPassword;
    }
    public void setUserPassword(String userPassword){
        this.userPassword = userPassword;
    }

    public int getUserCountryID(){
        return this.userCountryID;
    }
    public void setUserCountryID(int userCountryID){
        this.userCountryID = userCountryID;
    }

    public String getUserHomeCode(){
        return this.userHomeCode;
    }
    public void setUserHomeCode(String userHomeCode){
        this.userHomeCode = userHomeCode;
    }

    public String getUserHomeRegion(){
        return this.userHomeRegion;
    }
    public void setUserHomeRegion(String userHomeRegion){
        this.userHomeRegion = userHomeRegion;
    }

    public String getUserMobileCode(){
        return this.userMobileCode;
    }
    public void setUserMobileCode(String userMobileCode){
        this.userMobileCode = userMobileCode;
    }

    public String getUserMobileRegion(){
        return this.userMobileRegion;
    }
    public void setUserMobileRegion(String userMobileRegion){
        this.userMobileRegion = userMobileRegion;
    }

    public String getUserFaxCode(){
        return this.userFaxCode;
    }
    public void setUserFaxCode(String userFaxCode){
        this.userFaxCode = userFaxCode;
    }

    public String getUserFaxRegion(){
        return this.userFaxRegion;
    }
    public void setUserFaxRegion(String userFaxRegion){
        this.userFaxRegion = userFaxRegion;
    }

    public String getUserBamfNumber(){
        return this.userBamfNumber;
    }
    public void setUserBamfNumber(String userBamfNumber){
        this.userBamfNumber = userBamfNumber;
    }

    public int getUserBamfChoice(){
        return this.userBamfChoice;
    }
    public void setUserBamfChoice(int userBamfChoice){
        this.userBamfChoice = userBamfChoice;
    }

    public int getUserHours(){
        return this.userHours;
    }
    public void setUserHours(int userHours){
        this.userHours = userHours;
    }

    public String getUserLastVisit(){
        return this.userLastVisit;
    }
    public void setUserLastVisit(String userLastVisit){
        this.userLastVisit = userLastVisit;
    }

    public String getUserCompany(){
        return this.userCompany;
    }
    public void setUserCompany(String userCompany){
        this.userCompany = userCompany;
    }

    public String getUserBamfNrSchool(){
        return this.userBamfNrSchool;
    }
    public void setUserBamfNrSchool(String userBamfNrSchool){
        this.userBamfNrSchool = userBamfNrSchool;
    }

    public int getUserAcademicPoints(){
        return this.userAcademicPoints;
    }
    public void setUserAcademicPoints(int userAcademicPoints){
        this.userAcademicPoints = userAcademicPoints;
    }

    public int getUserSchoolingYears(){
        return this.userSchoolingYears;
    }
    public void setUserSchoolingYears(int userSchoolingYears){
        this.userSchoolingYears = userSchoolingYears;
    }

    public int getUserIntTest(){
        return this.userIntTest;
    }
    public void setUserIntTest(int userIntTest){
        this.userIntTest = userIntTest;
    }

    public int getUserIntTestCheck(){
        return this.userIntTestCheck;
    }
    public void setUserIntTestCheck(int userIntTestCheck){
        this.userIntTestCheck = userIntTestCheck;
    }

    public int getUserProficency(){
        return this.userProficency;
    }
    public void setUserProficency(int userProficency){
        this.userProficency = userProficency;
    }

    public int getUserSponsorShip(){
        return this.userSponsorShip;
    }
    public void setUserSponsorShip(int userSponsorShip){
        this.userSponsorShip = userSponsorShip;
    }

    public int getUserIdentityID(){
        return this.userIdentityID;
    }
    public void setUserIdentityID(int userIdentityID){
        this.userIdentityID = userIdentityID;
    }

    public int getUserCostSharing(){
        return this.userCostSharing;
    }
    public void setUserCostSharing(int userCostSharing){
        this.userCostSharing = userCostSharing;
    }

    public int getUserClassification(){
        return this.userClassification;
    }
    public void setUserClassification(int userClassification){
        this.userClassification = userClassification;
    }

    public Date getUserConclusion(){
        return this.userConclusion;
    }
    public void setUserConclusion(Date userConclusion){
        this.userConclusion = userConclusion;
    }

    public Date getUserConcCourse(){
        return this.userConcCourse;
    }
    public void setUserConcCourse(Date userConcCourse){
        this.userConcCourse = userConcCourse;
    }

    public Date getUserRegDate(){
        return this.userRegDate;
    }
    public void setUserRegDate(Date userRegDate){
        this.userRegDate = userRegDate;
    }
    public String getUserVerifiedNumber(){
        return this.userVerifiedNumber;
    }
    public void setUserVerifiedNumber(String userVerifiedNumber){
        this.userVerifiedNumber = userVerifiedNumber;
    }

    public Date getUserGradingDate(){
        return this.userGradingDate;
    }
    public void setUserGradingDate(Date userGradingDate){
        this.userGradingDate = userGradingDate;
    }

    public int getUserModuleNr(){
        return this.userModuleNr;
    }
    public void setUserModuleNr(int userModuleNr){
        this.userModuleNr = userModuleNr;
    }

    public String getBildName(){
        return this.bildName;
    }
    public void setBildName(String bildName){
        this.bildName = bildName;
    }

    public int getBildID(){
        return this.bildID;
    }
    public void setBildID(int bildID){
        this.bildID = bildID;
    }


    public int getFreigabeStatus()
    {
        return this.freigabeStatus;
    }

    public Date getFreigabeDate()
    {
        return this.freigabeDate;
    }

    public void setFreigabeStatus(int code)
    {
        this.freigabeStatus = code;
    }

    public void setFreigabeDate(Date code)
    {
        this.freigabeDate = code;
    }

    //Instance Variables
    private int costID;
    private String costDesc;
    private double actualFee;
    private double tranBalance;
    private int residenceID;
    private int residentID;
    private int transPayType;
    private int placeID;
    private int adminID;
    private int userID;
    private Date mietStart;
    private Date mietEnd;
    private String mieterCountStart;
    private String mieterCountEnd;
    private String userFirstName;
    private String userLastName;
    private Date userBirthDate;
    private int userGender;
    private String userBirthPlace;
    private String userNationality;
    private String userCO;
    private String userAddress;
    private String userPostCode;
    private String userCity;
    private String userCountry;
    private String userHomePhone;
    private String userMobilePhone;
    private String userFax;
    private String userEmail;

    private String userAccountNo;
    private String userBLZ;
    private String userBankName;
    private String userPassport;

    private int userType;
    private double userStundenLohn;
    private double totalPay;
    private String userRemarks;
    private int userActive;

    private String userLoginName;
    private String userPassword;
    private int userCountryID;
    private String userHomeCode;
    private String userHomeRegion;
    private String userMobileCode;
    private String userMobileRegion;
    private String userFaxCode;
    private String userFaxRegion;
    private String userBamfNumber;
    private int userBamfChoice;
    private int userHours;
    private String userLastVisit;
    private String userCompany;
    private String userBamfNrSchool;
    private int userAcademicPoints;
    private int userSchoolingYears;
    private int userIntTest;
    private int userIntTestCheck;
    private int userProficency;
    private int userSponsorShip;
    private int userIdentityID;
    private int userCostSharing;
    private int userClassification;
    private Date userConclusion;
    private Date userConcCourse;
    private Date userRegDate;
    private String userVerifiedNumber;
    private Date userGradingDate;
    private int userModuleNr;
    private String bildName;
    private int bildID;
    private int freigabeStatus;
    private Date freigabeDate;


    //Class Variables
    public static final int MALE=1;
    public static final int FEMALE=0;
}
