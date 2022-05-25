package com.rheinlandprivatschule.viewmodel;

import com.rheinlandprivatschule.model.Student;
import com.rheinlandprivatschule.model.Transaction;

public class ShowTransactionsViewModelXtr  extends ShowTransactionsViewModel {

    private Student sta;

    public ShowTransactionsViewModelXtr(Transaction transaction, String paymentDisplay, String paymentDateDisplay, Student sta) {
        super(transaction, paymentDisplay, paymentDateDisplay);
        this.sta = sta;
    }

    public Student getSta() {
        return sta;
    }

    public void setSta(Student sta) {
        this.sta = sta;
    }
}
