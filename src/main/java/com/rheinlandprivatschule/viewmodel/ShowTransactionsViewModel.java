package com.rheinlandprivatschule.viewmodel;

import com.rheinlandprivatschule.model.Transaction;

public class ShowTransactionsViewModel {

    private Transaction transaction;
    private String paymentDisplay;
    private String paymentDateDisplay;

    public ShowTransactionsViewModel(Transaction transaction, String paymentDisplay, String paymentDateDisplay) {
        this.transaction = transaction;
        this.paymentDisplay = paymentDisplay;
        this.paymentDateDisplay = paymentDateDisplay;
    }

    public Transaction getTransaction() {
        return transaction;
    }

    public void setTransaction(Transaction transaction) {
        this.transaction = transaction;
    }

    public String getPaymentDisplay() {
        return paymentDisplay;
    }

    public void setPaymentDisplay(String paymentDisplay) {
        this.paymentDisplay = paymentDisplay;
    }

    public String getPaymentDateDisplay() {
        return paymentDateDisplay;
    }

    public void setPaymentDateDisplay(String paymentDateDisplay) {
        this.paymentDateDisplay = paymentDateDisplay;
    }
}
