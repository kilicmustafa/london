package com.rheinlandprivatschule.viewmodel;

import com.rheinlandprivatschule.model.Buch;
import com.rheinlandprivatschule.model.SystemUser;
import com.rheinlandprivatschule.model.UserCategory;
import com.rheinlandprivatschule.model.UserType;

import java.util.List;

public class AdminRemarkViewModel {

    private SystemUser systemUser;
    private String userGender;
    private String userType;
    private String userCategoryName;
    private List<Buch> bucher;

    public AdminRemarkViewModel(SystemUser systemUser) {
        this.systemUser = systemUser;
        if(systemUser.getUserGender()==0) {
            userGender ="M&auml;nnlich";
        } else {
            userGender ="Weiblich";
        }
    }

    public String getUserGender() {
        return userGender;
    }

    public void setUserGender(String userGender) {
        this.userGender = userGender;
    }

    public SystemUser getSystemUser() {
        return systemUser;
    }

    public void setSystemUser(SystemUser systemUser) {
        this.systemUser = systemUser;
    }

    public String getUserType() {
        return userType;
    }

    private void setUserType(String userType) {
        this.userType = userType;
    }

    public void setUserType(List<UserType> userTypes) {
        for(UserType userType : userTypes) {
            if(!userType.getUserTypeName().equalsIgnoreCase("Sch�ler") && userType.getUserTypeID() == systemUser.getUserType()) {
                setUserType(userType.getUserTypeName());
            }
        }
    }

    public String getUserCategoryName() {
        return userCategoryName;
    }

    private void setUserCategoryName(String userCategoryName) {
        this.userCategoryName = userCategoryName;
    }

    public void setUserCategoryName(List<UserCategory> categories, int userCategoryId) {
        for(UserCategory userCategory : categories) {
            if(userCategoryId == userCategory.getUserCategoryID()) {
                userCategoryName = userCategory.getUserCategoryName();
            }
        }
    }

    public List<Buch> getBucher() {
        return bucher;
    }

    public void setBucher(List<Buch> bucher) {
        this.bucher = bucher;
    }
}
