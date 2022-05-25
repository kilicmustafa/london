package com.rheinlandprivatschule.viewmodel;

import com.rheinlandprivatschule.model.Student;

public class NotRegisterViewModel {
    private Student student;
    private String regDate;

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public String getRegDate() {
        return regDate;
    }

    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }
}
