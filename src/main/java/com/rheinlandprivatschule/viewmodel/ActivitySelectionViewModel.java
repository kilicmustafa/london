package com.rheinlandprivatschule.viewmodel;

import com.rheinlandprivatschule.model.Activity;

public class ActivitySelectionViewModel {
    private Activity activity;
    private boolean allowed;
    private boolean isActivityHasPredecessor;

    public ActivitySelectionViewModel(Activity activity, boolean allowed, boolean isActivityHasPredecessor) {
        this.activity = activity;
        this.allowed = allowed;
        this.isActivityHasPredecessor = isActivityHasPredecessor;
    }

    public Activity getActivity() {
        return activity;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    public boolean isAllowed() {
        return allowed;
    }

    public void setAllowed(boolean allowed) {
        this.allowed = allowed;
    }

    public boolean isActivityHasPredecessor() {
        return isActivityHasPredecessor;
    }

    public void setActivityHasPredecessor(boolean activityHasPredecessor) {
        isActivityHasPredecessor = activityHasPredecessor;
    }
}
