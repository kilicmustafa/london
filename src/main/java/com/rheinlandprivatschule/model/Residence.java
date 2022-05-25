package com.rheinlandprivatschule.model;

import java.sql.Date;

public class Residence {

    public Residence(){
        this.residenceID = 0;
        this.residentID = 0;

        this.residenceAddress = null;
        this.residencePostCode = null;
        this.residenceCity = null;
        this.residenceCountry = null;

        this.residenceSize = null;
        this.residenceDescription = null;
        this.residenceRent = 0;
        this.residenceSideCosts = 0;
        this.residenceMeterNumber = null;

        this.residenceStatus = 0;

        this.residenceOwner = 0;

        this.residenceMark = null;
        this.vermieterWarmMiete = 0;
        this.vermieterKation = 0;
        this.vermieterKationPaidDate = null;
        this.vermieterMietStart = null;
        this.vermieterMietEnd = null;
        this.residenceKation = 0;
        this.residenceID = 0;
        this.rentMonth = 0;
        this.rentYear = 0;
        this.amountPaid = 0;
        this.deleteFunction = 0;
        this.rentDate = null;
        this.paymentModeID = 0;
        this.rentIncomingID = 0;
        this.rentOutgoingID = 0;
        this.rentLoginID = 0;
        this.rentPlaceID = 0;
        this.loginName = null;
        this.placeName = null;
        this.amountBalance = 0;
        this.paymentModeDesc = null;

        this.PaidAmtCurr = 0;
        this.PaidAmtCurr1 = 0;
        this.PaidAmtCurr2 = 0;
        this.PaidAmtCurr3 = 0;
        this.PaidAmtCurr4 = 0;
        this.PaidAmtCurr5 = 0;

        this.userFirstName = null;
        this.userLastName = null;
        this.userAddress = null;
        this.userPostCode = null;
        this.userCity = null;


        this.residenceType = "";

    }

    public int getResidenceID() {
        return residenceID;
    }

    public int getResidentID() {
        return residentID;
    }

    public String getResidenceAddress() {
        return residenceAddress;
    }
    public String getResidencePostCode() {
        return residencePostCode;
    }
    public String getResidenceCity() {
        return residenceCity;
    }

    public String getResidenceCountry() {
        return residenceCountry;
    }

    public String getResidenceSize() {
        return residenceSize;
    }
    public String getResidenceDescription() {
        return residenceDescription;
    }
    public double getResidenceRent() {
        return residenceRent;
    }
    public double getResidenceSideCosts() {
        return residenceSideCosts;
    }

    public String getResidenceMeterNumber() {
        return residenceMeterNumber;
    }

    public int getResidenceStatus() {
        return residenceStatus;
    }

    public int getResidenceOwner() {
        return residenceOwner;
    }

    public String getResidenceMark() {
        return residenceMark;
    }

    public double getVermieterWarmMiete() {
        return vermieterWarmMiete;
    }

    public double getVermieterKation() {
        return vermieterKation;
    }

    public Date getVermieterKationPaidDate() {
        return vermieterKationPaidDate;
    }

    public double getResidenceKation() {
        return residenceKation;
    }

    public Date getVermieterMietEnd() {
        return vermieterMietEnd;
    }

    public Date getVermieterMietStart() {
        return vermieterMietStart;
    }

    public int getRentMonth() {
        return rentMonth;
    }

    public int getRentYear() {
        return rentYear;
    }

    public double getAmountPaid() {
        return amountPaid;
    }

    public int getDeleteFunction() {
        return deleteFunction;
    }

    public Date getRentDate() {
        return rentDate;
    }

    public int getPaymentModeID() {
        return paymentModeID;
    }

    public int getRentIncomingID() {
        return rentIncomingID;
    }

    public int getRentOutgoingID() {
        return rentOutgoingID;
    }

    public int getRentLoginID() {
        return rentLoginID;
    }

    public int getRentPlaceID() {
        return rentPlaceID;
    }

    public String getLoginName() {
        return loginName;
    }

    public String getPlaceName() {
        return placeName;
    }

    public double getAmountBalance() {
        return amountBalance;
    }

    public String getPaymentModeDesc() {
        return paymentModeDesc;
    }

    public double getPaidAmtCurr() {
        return PaidAmtCurr;
    }

    public double getPaidAmtCurr1() {
        return PaidAmtCurr1;
    }

    public double getPaidAmtCurr2() {
        return PaidAmtCurr2;
    }

    public double getPaidAmtCurr3() {
        return PaidAmtCurr3;
    }

    public double getPaidAmtCurr4() {
        return PaidAmtCurr4;
    }

    public double getPaidAmtCurr5() {
        return PaidAmtCurr5;
    }

    public String getUserFirstName() {
        return userFirstName;
    }

    public String getUserLastName() {
        return userLastName;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public String getUserPostCode() {
        return userPostCode;
    }

    public String getUserCity() {
        return userCity;
    }


    public void setResidenceID(int residenceID) {
        this.residenceID = residenceID;
    }

    public void setResidentID(int residentID) {
        this.residentID = residentID;
    }

    public void setResidenceAddress(String residenceAddress) {
        this.residenceAddress = residenceAddress;
    }
    public void setResidencePostCode(String residencePostCode) {
        this.residencePostCode = residencePostCode;
    }
    public void setResidenceCity(String residenceCity) {
        this.residenceCity = residenceCity;
    }
    public void setResidenceCountry(String residenceCountry) {
        this.residenceCountry = residenceCountry;
    }

    public void setResidenceSize(String residenceSize) {
        this.residenceSize = residenceSize;
    }
    public void setResidenceDescription(String residenceDescription) {
        this.residenceDescription = residenceDescription;
    }
    public void setResidenceRent(double residenceRent) {
        this.residenceRent = residenceRent;
    }
    public void setResidenceSideCosts(double residenceSideCosts) {
        this.residenceSideCosts = residenceSideCosts;
    }
    public void setResidenceMeterNumber(String residenceMeterNumber) {
        this.residenceMeterNumber = residenceMeterNumber;
    }

    public void setResidenceStatus(int residenceStatus) {
        this.residenceStatus = residenceStatus;
    }

    public void setResidenceOwner(int residenceOwner) {
        this.residenceOwner = residenceOwner;
    }

    public void setResidenceMark(String residenceMark) {
        this.residenceMark = residenceMark;
    }

    public void setVermieterWarmMiete(double vermieterWarmMiete) {
        this.vermieterWarmMiete = vermieterWarmMiete;
    }

    public void setVermieterKation(double vermieterKation) {
        this.vermieterKation = vermieterKation;
    }

    public void setVermieterKationPaidDate(Date vermieterKationPaidDate) {
        this.vermieterKationPaidDate = vermieterKationPaidDate;
    }

    public void setResidenceKation(double residenceKation) {
        this.residenceKation = residenceKation;
    }

    public void setVermieterMietEnd(Date vermieterMietEnd) {
        this.vermieterMietEnd = vermieterMietEnd;
    }

    public void setVermieterMietStart(Date vermieterMietStart) {
        this.vermieterMietStart = vermieterMietStart;
    }
    public void setRentMonth(int rentMonth) {
        this.rentMonth = rentMonth;
    }
    public void setRentYear(int rentYear) {
        this.rentYear = rentYear;
    }

    public void setAmountPaid(double amountPaid) {
        this.amountPaid = amountPaid;
    }

    public void setDeleteFunction(int deleteFunction) {
        this.deleteFunction = deleteFunction;
    }

    public void setRentDate(Date rentDate) {
        this.rentDate = rentDate;
    }

    public void setPaymentModeID(int paymentModeID) {
        this.paymentModeID = paymentModeID;
    }

    public void setRentIncomingID(int rentIncomingID) {
        this.rentIncomingID = rentIncomingID;
    }

    public void setRentLoginID(int rentLoginID) {
        this.rentLoginID = rentLoginID;
    }

    public void setRentPlaceID(int rentPlaceID) {
        this.rentPlaceID = rentPlaceID;
    }

    public void setRentOutgoingID(int rentOutgoingID) {
        this.rentOutgoingID = rentOutgoingID;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public void setPlaceName(String placeName) {
        this.placeName = placeName;
    }

    public void setAmountBalance(double amountBalance) {
        this.amountBalance = amountBalance;
    }

    public void setPaymentModeDesc(String paymentModeDesc) {
        this.paymentModeDesc = paymentModeDesc;
    }

    public void setPaidAmtCurr(double PaidAmtCurr) {
        this.PaidAmtCurr = PaidAmtCurr;
    }

    public void setPaidAmtCurr1(double PaidAmtCurr1) {
        this.PaidAmtCurr1 = PaidAmtCurr1;
    }

    public void setPaidAmtCurr2(double PaidAmtCurr2) {
        this.PaidAmtCurr2 = PaidAmtCurr2;
    }

    public void setPaidAmtCurr3(double PaidAmtCurr3) {
        this.PaidAmtCurr3 = PaidAmtCurr3;
    }

    public void setPaidAmtCurr4(double PaidAmtCurr4) {
        this.PaidAmtCurr4 = PaidAmtCurr4;
    }

    public void setPaidAmtCurr5(double PaidAmtCurr5) {
        this.PaidAmtCurr5 = PaidAmtCurr5;
    }


    public void setUserFirstName(String userFirstName) {
        this.userFirstName = userFirstName;
    }

    public void setUserLastName(String userLastName) {
        this.userLastName = userLastName;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public void setUserPostCode(String userPostCode) {
        this.userPostCode = userPostCode;
    }

    public void setUserCity(String userCity) {
        this.userCity = userCity;
    }


    // Instance Variables
    private int residenceID;
    private int residentID;

    private String residenceAddress;
    private String residencePostCode;
    private String residenceCity;
    private String residenceCountry;

    private String residenceSize;
    private String residenceDescription;
    private double residenceRent;
    private double residenceSideCosts;
    private String residenceMeterNumber;

    private int residenceStatus;

    private int residenceOwner;

    private String residenceMark;
    private double vermieterWarmMiete;
    private double vermieterKation;
    private Date vermieterKationPaidDate;
    private Date vermieterMietStart;
    private Date vermieterMietEnd;
    private double residenceKation;

    private int rentMonth;
    private int rentYear;
    private double amountPaid;
    private int deleteFunction;
    private Date rentDate;
    private int paymentModeID;
    private int rentIncomingID;
    private int rentOutgoingID;
    private int rentLoginID;
    private int rentPlaceID;
    private String loginName;
    private String placeName;
    private double amountBalance;
    private String paymentModeDesc;

    private double PaidAmtCurr;
    private double PaidAmtCurr1;
    private double PaidAmtCurr2;
    private double PaidAmtCurr3;
    private double PaidAmtCurr4;
    private double PaidAmtCurr5;

    private String userFirstName;
    private String userLastName;
    private String userAddress;
    private String userPostCode;
    private String userCity;

    private String residenceType;

    public String getResidenceType() {
        return residenceType;
    }

    public void setResidenceType(String residenceType) {
        this.residenceType = residenceType;
    }
}
