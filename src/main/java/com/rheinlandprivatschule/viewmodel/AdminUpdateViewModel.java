package com.rheinlandprivatschule.viewmodel;

public class AdminUpdateViewModel {
    private String birthday;
    private String birthmonth;
    private String birthyear;
    private int userCategoryId;

    public AdminUpdateViewModel() {
    }

    public AdminUpdateViewModel(String birthday, String birthmonth, String birthyear) {
        this.birthday = birthday;
        this.birthmonth = birthmonth;
        this.birthyear = birthyear;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getBirthmonth() {
        return birthmonth;
    }

    public void setBirthmonth(String birthmonth) {
        this.birthmonth = birthmonth;
    }

    public String getBirthyear() {
        return birthyear;
    }

    public void setBirthyear(String birthyear) {
        this.birthyear = birthyear;
    }

    public int getUserCategoryId() {
        return userCategoryId;
    }

    public void setUserCategoryId(int userCategoryId) {
        this.userCategoryId = userCategoryId;
    }
}
