package com.rheinlandprivatschule.repository;


import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Lecture;
import com.rheinlandprivatschule.model.Sprach;
import com.rheinlandprivatschule.model.Table;
import com.rheinlandprivatschule.model.Vocabul;

import java.sql.*;
import java.util.Vector;

public class VocabulDao {

    public boolean addSprach(String sprachName) {
        boolean result = false;
        Table table= TableManager.getTable(TableManager.RPS_LANGUAGES);
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(1)+")VALUES("
                    + this.replaceNull(sprachName) + ")";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean updateSprach(int sprachID, String sprachName) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_LANGUAGES);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"="
                    + this.replaceNull(sprachName) + " WHERE "+table.getColumn(0)+"='"
                    + sprachID + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean deleteSprach(Sprach sprach) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_LANGUAGES);
        try {
            String q = "DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                    + sprach.getSprachID() + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public Sprach getSprach(int sprachID) {
        Sprach sprach = new Sprach();
        Table table=TableManager.getTable(TableManager.RPS_LANGUAGES);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                    + sprachID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                sprach.setSprachID(rs.getInt(table.getColumn(0)));
                sprach.setSprachName(rs.getString(table.getColumn(1)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return sprach;
    }

    public Vector<Sprach> getAllSprach() {
        Vector<Sprach> sprachList = new Vector<Sprach>();
        Table table=TableManager.getTable(TableManager.RPS_LANGUAGES);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+" FROM "+table.getTableName()+" ORDER BY "+table.getColumn(1);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Sprach sprach = new Sprach();
                sprach.setSprachID(rs.getInt(table.getColumn(0)));
                sprach.setSprachName(rs.getString(table.getColumn(1)));
                sprachList.addElement(sprach);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return sprachList;
    }

    public Vector<Vocabul> getAvailableWordForTan(Vector v, int spr) {
        Vector<Vocabul> vocabulList = new Vector<Vocabul>();
        try {
            for (int i = 0; i < v.size(); i++) {
                Vocabul ts = (Vocabul) v.elementAt(i);
                boolean bt = this.isWordAvailable(ts, spr);
                if (!bt) {
                    vocabulList.addElement(ts);
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return vocabulList;
    }

    public boolean isWordAvailable(Vocabul vocabul, int sprachID) {
        boolean b = false;
        Table table=TableManager.getTable(TableManager.RPS_VOCABAL);
        try {
            String q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(3)+"='"
                    + vocabul.getLectureID() + "' AND "+table.getColumn(2)+"='" + sprachID
                    + "' AND "+table.getColumn(4)+"='" + vocabul.getWordTrack() + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            int temp = 0;
            while (rs.next()) {
                temp = rs.getInt(table.getColumn(0));
            }
            if (temp > 0) {
                b = true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean addVocabal(String word, String desc, int sprachID, int lectureID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_VOCABAL);
        try {
            int wordTrack = this.getWordTrack(lectureID);
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+")VALUES("
                    + this.replaceNull(word)
                    + ",'"
                    + sprachID
                    + "','"
                    + lectureID
                    + "','"
                    + wordTrack
                    + "',"
                    + this.replaceNull(desc) + ")";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean addWordForWord(String word, int sprachID, int lectureID,int wordTrack, String desc) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_VOCABAL);
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+")VALUES("
                    + this.replaceNull(word)
                    + ",'"
                    + sprachID
                    + "','"
                    + lectureID
                    + "','"
                    + wordTrack
                    + "',"
                    + this.replaceNull(desc) + ")";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean updateWordForWord(String word, int sprachID, int lectureID,int wordTrack, String desc) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_VOCABAL);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"=" + this.replaceNull(word)
                    + ", "+table.getColumn(5)+"=" + this.replaceNull(desc) + " WHERE "+table.getColumn(2)+"='"
                    + sprachID + "' AND "+table.getColumn(3)+"='" + lectureID
                    + "' AND "+table.getColumn(4)+"='" + wordTrack + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean updateVocabal(String word, int srNo, String desc) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_VOCABAL);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"=" + this.replaceNull(word)
                    + ", "+table.getColumn(5)+"=" + this.replaceNull(desc) + " WHERE "+table.getColumn(0)+"='"
                    + srNo + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public int getWordTrack(int lectureID) {
        int wordTrack = 0;
        Table table=TableManager.getTable(TableManager.RPS_VOCABAL);
        try {
            String q = "SELECT max("+table.getColumn(4)+") as a FROM "+table.getTableName()+" WHERE "+table.getColumn(3)+"='"
                    + lectureID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                wordTrack = rs.getInt("a");
            }
            wordTrack++;
        } catch (Exception e) {
            setError(e.toString());
        }
        return wordTrack;
    }

    public boolean addLectur(String lectureName) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_LECTURE);
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(1)+")VALUES("
                    + this.replaceNull(lectureName) + ")";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean updateLectur(int lectureID, String lectureName) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_LECTURE);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"="
                    + this.replaceNull(lectureName) + " WHERE "+table.getColumn(0)+"='"
                    + lectureID + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public Lecture getLectur(int lectureID) {
        Lecture lecture = new Lecture();
        Table table=TableManager.getTable(TableManager.RPS_LECTURE);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                    + lectureID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                lecture.setLectureID(rs.getInt(table.getColumn(0)));
                lecture.setLectureName(rs.getString(table.getColumn(1)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return lecture;
    }

    public Vector<Lecture> getAllLectur() {
        Vector<Lecture> lecturesList = new Vector<Lecture>();
        Table table=TableManager.getTable(TableManager.RPS_LECTURE);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+" FROM "+table.getTableName();
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Lecture lecture = new Lecture();
                lecture.setLectureID(rs.getInt(table.getColumn(0)));
                lecture.setLectureName(rs.getString(table.getColumn(1)));
                lecturesList.addElement(lecture);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return lecturesList;
    }

    public Vector<Vocabul> getLectureContents(int lectureID) {
        Vector<Vocabul> v = new Vector<Vocabul>();
        Table table=TableManager.getTable(TableManager.RPS_VOCABAL);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(3)+"='"
                    + lectureID
                    + "' AND "+table.getColumn(2)+"='1' ORDER BY "+table.getColumn(3)+","+table.getColumn(4);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Vocabul vocabul = new Vocabul();
                vocabul.setSerialNo(rs.getInt(table.getColumn(0)));
                vocabul.setWord(rs.getString(table.getColumn(1)));
                vocabul.setSprachID(rs.getInt(table.getColumn(2)));
                vocabul.setLectureID(rs.getInt(table.getColumn(3)));
                vocabul.setWordTrack(rs.getInt(table.getColumn(4)));
                vocabul.setDesc(rs.getString(table.getColumn(5)));
                v.addElement(vocabul);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<Vocabul> getLectureLanWords(int sprachID, int lectureID) {
        Vector<Vocabul> v = new Vector<Vocabul>();
        Table table=TableManager.getTable(TableManager.RPS_VOCABAL);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(3)+"='"
                    + lectureID
                    + "' AND "+table.getColumn(2)+"='"
                    + sprachID
                    + "' ORDER BY "+table.getColumn(3)+","+table.getColumn(4);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Vocabul vocabul = new Vocabul();
                vocabul.setSerialNo(rs.getInt(table.getColumn(0)));
                vocabul.setWord(rs.getString(table.getColumn(1)));
                vocabul.setSprachID(rs.getInt(table.getColumn(2)));
                vocabul.setLectureID(rs.getInt(table.getColumn(3)));
                vocabul.setWordTrack(rs.getInt(table.getColumn(4)));
                vocabul.setDesc(rs.getString(table.getColumn(5)));
                v.addElement(vocabul);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<Vocabul> getRefineLectureWords(int sprachID, int lectureID, int fremdID) {
        Vector<Vocabul> v = new Vector<Vocabul>();
        Table table=TableManager.getTable(TableManager.RPS_VOCABAL);
        try {
            String q = "SELECT a."+table.getColumn(0)+",a."+table.getColumn(1)+",a."+table.getColumn(2)+",a."+table.getColumn(3)+",a."+table.getColumn(4)+",a."+table.getColumn(5)+" FROM "+table.getTableName()+" AS a,"+table.getTableName()+" AS b WHERE a."+table.getColumn(3)+"='"
                    + lectureID
                    + "' AND a."+table.getColumn(2)+"='"
                    + sprachID
                    + "' AND a."+table.getColumn(3)+"=b."+table.getColumn(3)+" AND b."+table.getColumn(2)+"='"
                    + fremdID
                    + "' AND a."+table.getColumn(4)+"=b."+table.getColumn(4)+" ORDER BY "+table.getColumn(3)+","+table.getColumn(4);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Vocabul vocabul = new Vocabul();
                vocabul.setSerialNo(rs.getInt(table.getColumn(0)));
                vocabul.setWord(rs.getString(table.getColumn(1)));
                vocabul.setSprachID(rs.getInt(table.getColumn(2)));
                vocabul.setLectureID(rs.getInt(table.getColumn(3)));
                vocabul.setWordTrack(rs.getInt(table.getColumn(4)));
                vocabul.setDesc(rs.getString(table.getColumn(5)));
                v.addElement(vocabul);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vocabul getDeutschWord(int lectureID, int wordTrack) {
        Vocabul vocabul = new Vocabul();
        Table table=TableManager.getTable(TableManager.RPS_VOCABAL);
        try {
            int track = 1;
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(3)+"='"
                    + lectureID
                    + "' AND "+table.getColumn(2)+"='"
                    + track
                    + "' AND "+table.getColumn(4)+"='" + wordTrack + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                vocabul.setSerialNo(rs.getInt(table.getColumn(0)));
                vocabul.setWord(rs.getString(table.getColumn(1)));
                vocabul.setSprachID(rs.getInt(table.getColumn(2)));
                vocabul.setLectureID(rs.getInt(table.getColumn(3)));
                vocabul.setWordTrack(rs.getInt(table.getColumn(4)));
                vocabul.setDesc(rs.getString(table.getColumn(5)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return vocabul;
    }

    public Vocabul getLectureVocabul(int serialNr) {
        Vocabul vocabul = new Vocabul();
        Table table=TableManager.getTable(TableManager.RPS_VOCABAL);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                    + serialNr + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                vocabul.setSerialNo(rs.getInt(table.getColumn(0)));
                vocabul.setWord(rs.getString(table.getColumn(1)));
                vocabul.setSprachID(rs.getInt(table.getColumn(2)));
                vocabul.setLectureID(rs.getInt(table.getColumn(3)));
                vocabul.setWordTrack(rs.getInt(table.getColumn(4)));
                vocabul.setDesc(rs.getString(table.getColumn(5)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return vocabul;
    }

    public Vector<Sprach> proposeSprach(int lecture, int grupe) {
        Vector<Sprach> v = new Vector<Sprach>();
        Table table=TableManager.getTable(TableManager.RPS_VOCABAL);
        try {
            String q = "SELECT "+table.getColumn(2)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(3)+"='"
                    + lecture + "' AND "+table.getColumn(4)+"='" + grupe + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            Vector<String> temp = new Vector<String>();
            while (rs.next()) {
                temp.addElement("" + rs.getInt(table.getColumn(2)));
            }
            Vector<Sprach> spr = this.getAllSprach();
            for (int i = 0; i < temp.size(); i++) {
                int s = Integer.parseInt((String) temp.elementAt(i));
                int track = -1;
                for (int u = 0; u < spr.size(); u++) {
                    Sprach sp = (Sprach) spr.elementAt(u);
                    if (sp.getSprachID() == s) {
                        track = u;
                    }
                }
                if (track >= 0) {
                    spr.remove(track);
                }
            }
            v = spr;

        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public boolean deleteWord(int lectureID, int wordTrackID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_VOCABAL);
        try {
            String q = "DELETE FROM "+table.getTableName()+" WHERE "+table.getColumn(4)+"='" + wordTrackID
                    + "' AND "+table.getColumn(3)+"='" + lectureID + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean canAddNewLanguage(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"10.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateLanguage(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"10.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeeLectures(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"10.3");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canAddNewLecture(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"10.3.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateLecture(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"10.3.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canWorkWithLecture(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"10.3.3");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public Object replaceNull(Object o) {
        if (o == null) {
            return null;
        } else {
            return "'" + o + "'";
        }
    }

    public void setError(String errorString) {
        error=errorString;
    }

    public String getError() {
        return error;
    }

    //Instance Variables
    private String error;
}
