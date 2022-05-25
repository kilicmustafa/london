package com.rheinlandprivatschule.viewmodel;

import com.rheinlandprivatschule.helper.contentmanager.Module;

public class ModuleSelectionViewModel {
    private Module module;
    private boolean allowed;
    private boolean isModuleHasPredecessor;

    public ModuleSelectionViewModel(Module module, boolean allowed, boolean isModuleHasPredecessor) {
        this.module = module;
        this.allowed = allowed;
        this.isModuleHasPredecessor = isModuleHasPredecessor;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public boolean isAllowed() {
        return allowed;
    }

    public void setAllowed(boolean allowed) {
        this.allowed = allowed;
    }

    public boolean isModuleHasPredecessor() {
        return isModuleHasPredecessor;
    }

    public void setModuleHasPredecessor(boolean moduleHasPredecessor) {
        isModuleHasPredecessor = moduleHasPredecessor;
    }
}
