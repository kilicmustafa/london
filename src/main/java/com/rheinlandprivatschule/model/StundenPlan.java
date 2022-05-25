package com.rheinlandprivatschule.model;

import java.sql.Date;

public class StundenPlan {

    public int getCourseID() {
        return courseID;
    }

    public Date getDate1() {
        return d1;
    }

    public Date getDate2() {
        return d2;
    }

    public Date getDate3() {
        return d3;
    }

    public Date getDate4() {
        return d4;
    }

    public Date getDate5() {
        return d5;
    }

    public Date getDate6() {
        return d6;
    }

    public Date getDate7() {
        return d7;
    }

    public int getStunden1() {
        return std1;
    }

    public int getStunden2() {
        return std2;
    }

    public int getStunden3() {
        return std3;
    }

    public int getStunden4() {
        return std4;
    }

    public int getStunden5() {
        return std5;
    }

    public int getStunden6() {
        return std6;
    }

    public int getStunden7() {
        return std7;
    }

    public int getStundenStatus1() {
        return stdStatus1;
    }

    public int getStundenStatus2() {
        return stdStatus2;
    }

    public int getStundenStatus3() {
        return stdStatus3;
    }

    public int getStundenStatus4() {
        return stdStatus4;
    }

    public int getStundenStatus5() {
        return stdStatus5;
    }

    public int getStundenStatus6() {
        return stdStatus6;
    }

    public int getStundenStatus7() {
        return stdStatus7;
    }

    public int getTeacher1ID() {
        return teacher1ID;
    }

    public String getTeacher1Name() {
        if (teacher1Name == null)
            teacher1Name = "Keine Lehrer/in";
        return teacher1Name;
    }

    public int getTeacher2ID() {
        return teacher2ID;
    }

    public String getTeacher2Name() {
        if (teacher2Name == null)
            teacher2Name = "Kein Lehrer/in";
        return teacher2Name;
    }

    public int getTeacher3ID() {
        return teacher3ID;
    }

    public String getTeacher3Name() {
        if (teacher3Name == null)
            teacher3Name = "Kein Lehrer/in";
        return teacher3Name;
    }

    public int getTeacher4ID() {
        return teacher4ID;
    }

    public String getTeacher4Name() {
        if (teacher4Name == null)
            teacher4Name = "Kein Lehrer/in";
        return teacher4Name;
    }

    public int getTeacher5ID() {
        return teacher5ID;
    }

    public String getTeacher5Name() {
        if (teacher5Name == null)
            teacher5Name = "Kein Lehrer/in";
        return teacher5Name;
    }

    public int getTeacher6ID() {
        return teacher6ID;
    }

    public String getTeacher6Name() {
        if (teacher6Name == null)
            teacher6Name = "Kein Lehrer/in";
        return teacher6Name;
    }

    public int getTeacher7ID() {
        return teacher7ID;
    }

    public String getTeacher7Name() {
        if (teacher7Name == null)
            teacher7Name = "Kein Lehrer/in";
        return teacher7Name;
    }

    //Setters

    public void setCourseID(int code) {
        courseID = code;
    }

    public void setDate1(Date code) {
        d1 = code;
    }

    public void setDate2(Date code) {
        d2 = code;
    }

    public void setDate3(Date code) {
        d3 = code;
    }

    public void setDate4(Date code) {
        d4 = code;
    }

    public void setDate5(Date code) {
        d5 = code;
    }

    public void setDate6(Date code) {
        d6 = code;
    }

    public void setDate7(Date code) {
        d7 = code;
    }

    public void setStunden1(int code) {
        std1 = code;
    }

    public void setStunden2(int code) {
        std2 = code;
    }

    public void setStunden3(int code) {
        std3 = code;
    }

    public void setStunden4(int code) {
        std4 = code;
    }

    public void setStunden5(int code) {
        std5 = code;
    }

    public void setStunden6(int code) {
        std6 = code;
    }

    public void setStunden7(int code) {
        std7 = code;
    }

    public void setStundenStatus1(int code) {
        stdStatus1 = code;
    }

    public void setStundenStatus2(int code) {
        stdStatus2 = code;
    }

    public void setStundenStatus3(int code) {
        stdStatus3 = code;
    }

    public void setStundenStatus4(int code) {
        stdStatus4 = code;
    }

    public void setStundenStatus5(int code) {
        stdStatus5 = code;
    }

    public void setStundenStatus6(int code) {
        stdStatus6 = code;
    }

    public void setStundenStatus7(int code) {
        stdStatus7 = code;
    }

    public void setTeacher1ID(int code) {
        teacher1ID = code;
    }

    public void setTeacher1Name(String code) {
        teacher1Name = code;
    }

    public void setTeacher2ID(int code) {
        teacher2ID = code;
    }

    public void setTeacher2Name(String code) {
        teacher2Name = code;
    }

    public void setTeacher3ID(int code) {
        teacher3ID = code;
    }

    public void setTeacher3Name(String code) {
        teacher3Name = code;
    }

    public void setTeacher4ID(int code) {
        teacher4ID = code;
    }

    public void setTeacher4Name(String code) {
        teacher4Name = code;
    }

    public void setTeacher5ID(int code) {
        teacher5ID = code;
    }

    public void setTeacher5Name(String code) {
        teacher5Name = code;
    }

    public void setTeacher6ID(int code) {
        teacher6ID = code;
    }

    public void setTeacher6Name(String code) {
        teacher6Name = code;
    }

    public void setTeacher7ID(int code) {
        teacher7ID = code;
    }

    public void setTeacher7Name(String code) {
        teacher7Name = code;
    }

    public int getTeacherStunden1() {
        return teacherStunden1;
    }

    public void setTeacherStunden1(int teacherStunden1) {
        this.teacherStunden1 = teacherStunden1;
    }

    public int getTeacherStunden2() {
        return teacherStunden2;
    }

    public void setTeacherStunden2(int teacherStunden2) {
        this.teacherStunden2 = teacherStunden2;
    }

    public int getTeacherStunden3() {
        return teacherStunden3;
    }

    public void setTeacherStunden3(int teacherStunden3) {
        this.teacherStunden3 = teacherStunden3;
    }

    public int getTeacherStunden4() {
        return teacherStunden4;
    }

    public void setTeacherStunden4(int teacherStunden4) {
        this.teacherStunden4 = teacherStunden4;
    }

    public int getTeacherStunden5() {
        return teacherStunden5;
    }

    public void setTeacherStunden5(int teacherStunden5) {
        this.teacherStunden5 = teacherStunden5;
    }

    public int getTeacherStunden6() {
        return teacherStunden6;
    }

    public void setTeacherStunden6(int teacherStunden6) {
        this.teacherStunden6 = teacherStunden6;
    }

    public int getTeacherStunden7() {
        return teacherStunden7;
    }

    public void setTeacherStunden7(int teacherStunden7) {
        this.teacherStunden7 = teacherStunden7;
    }

    public String getDescription1() {
        return description1;
    }

    public void setDescription1(String description1) {
        this.description1 = description1;
    }

    public String getDescription2() {
        return description2;
    }

    public void setDescription2(String description2) {
        this.description2 = description2;
    }

    public String getDescription3() {
        return description3;
    }

    public void setDescription3(String description3) {
        this.description3 = description3;
    }

    public String getDescription4() {
        return description4;
    }

    public void setDescription4(String description4) {
        this.description4 = description4;
    }

    public String getDescription5() {
        return description5;
    }

    public void setDescription5(String description5) {
        this.description5 = description5;
    }

    public String getDescription6() {
        return description6;
    }

    public void setDescription6(String description6) {
        this.description6 = description6;
    }

    public String getDescription7() {
        return description7;
    }

    public void setDescription7(String description7) {
        this.description7 = description7;
    }


    private int courseID;

    private Date d1;
    private Date d2;
    private Date d3;
    private Date d4;
    private Date d5;
    private Date d6;
    private Date d7;

    private int std1;
    private int std2;
    private int std3;
    private int std4;
    private int std5;
    private int std6;
    private int std7;

    private int stdStatus1;
    private int stdStatus2;
    private int stdStatus3;
    private int stdStatus4;
    private int stdStatus5;
    private int stdStatus6;
    private int stdStatus7;

    private int teacher1ID;
    private String teacher1Name;

    private int teacher2ID;
    private String teacher2Name;

    private int teacher3ID;
    private String teacher3Name;

    private int teacher4ID;
    private String teacher4Name;

    private int teacher5ID;
    private String teacher5Name;

    private int teacher6ID;
    private String teacher6Name;

    private int teacher7ID;
    private String teacher7Name;

    private int teacherStunden1;
    private int teacherStunden2;
    private int teacherStunden3;
    private int teacherStunden4;
    private int teacherStunden5;
    private int teacherStunden6;
    private int teacherStunden7;

    private String description1;
    private String description2;
    private String description3;
    private String description4;
    private String description5;
    private String description6;
    private String description7;
}
