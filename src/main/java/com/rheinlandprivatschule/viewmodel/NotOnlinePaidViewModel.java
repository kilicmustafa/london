package com.rheinlandprivatschule.viewmodel;

import com.rheinlandprivatschule.model.Student;

public class NotOnlinePaidViewModel {
    private Student student;
    private String formatedBirthDate;
    private String formatedRegDate;

    public NotOnlinePaidViewModel(Student student, String formatedBirthDate, String formatedRegDate) {
        this.student = student;
        this.formatedBirthDate = formatedBirthDate;
        this.formatedRegDate = formatedRegDate;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public String getFormatedBirthDate() {
        return formatedBirthDate;
    }

    public void setFormatedBirthDate(String formatedBirthDate) {
        this.formatedBirthDate = formatedBirthDate;
    }

    public String getFormatedRegDate() {
        return formatedRegDate;
    }

    public void setFormatedRegDate(String formatedRegDate) {
        this.formatedRegDate = formatedRegDate;
    }
}
