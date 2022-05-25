package com.rheinlandprivatschule.viewmodel;

import com.rheinlandprivatschule.model.Expenditure;

public class AusgabeListViewModel {
    private Expenditure expenditure;
    private String formatedDate;
    private String neStr;

    public AusgabeListViewModel(Expenditure expenditure, String formatedDate, String ne) {
        this.expenditure = expenditure;
        this.formatedDate = formatedDate;
        this.neStr = ne;
    }

    public Expenditure getExpenditure() {
        return expenditure;
    }

    public void setExpenditure(Expenditure expenditure) {
        this.expenditure = expenditure;
    }

    public String getFormatedDate() {
        return formatedDate;
    }

    public void setFormatedDate(String formatedDate) {
        this.formatedDate = formatedDate;
    }

    public String getNeStr() {
        return neStr;
    }

    public void setNeStr(String neStr) {
        this.neStr = neStr;
    }
}
