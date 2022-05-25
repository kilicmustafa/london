package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Buch;
import com.rheinlandprivatschule.model.Student;
import com.rheinlandprivatschule.model.SystemUser;
import com.rheinlandprivatschule.model.Table;

import java.sql.*;
import java.util.Vector;

public class BuchDao {

    public boolean addBook(Buch buch) {
        boolean result = false;
        Table table= TableManager.getTable(TableManager.RPS_BOOKS);
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+") VALUES("
                    + this.replaceNull(buch.getBookName())
                    + ","
                    + this.replaceNull(buch.getISBN())
                    + ",'"
                    + buch.getPrice()
                    + "','" + buch.getStufe() + "')";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean updateBook(Buch buch) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_BOOKS);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(1)+"="
                    + this.replaceNull(buch.getBookName()) + ", "+table.getColumn(2)+"="
                    + this.replaceNull(buch.getISBN()) + ", "+table.getColumn(3)+"='"
                    + buch.getPrice() + "', "+table.getColumn(4)+"='" + buch.getStufe()
                    + "' WHERE "+table.getColumn(0)+"='" + buch.getBookID() + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;

    }

    public Buch getBuch(int buchID) {
        Buch b = new Buch();
        Table table=TableManager.getTable(TableManager.RPS_BOOKS);
        try {
            String q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(0)+"='"
                    + buchID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                b.setBookID(rs.getInt(table.getColumn(0)));
                b.setBookName(rs.getString(table.getColumn(1)));
                b.setISBN(rs.getString(table.getColumn(2)));
                b.setPrice(rs.getDouble(table.getColumn(3)));
                b.setStufe(rs.getInt(table.getColumn(4)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public Vector<Buch> getAllBuch(int stufeID) {
        Vector<Buch> v = new Vector<Buch>();
        Table table=TableManager.getTable(TableManager.RPS_BOOKS);
        try {
            String q = "";
            if (stufeID == 0) {
                q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+" FROM "+table.getTableName();
            } else {
                q = "SELECT "+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(4)+"='"
                        + stufeID + "'";
            }

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Buch b = new Buch();
                b.setBookID(rs.getInt(table.getColumn(0)));
                b.setBookName(rs.getString(table.getColumn(1)));
                b.setISBN(rs.getString(table.getColumn(2)));
                b.setPrice(rs.getDouble(table.getColumn(3)));
                b.setStufe(rs.getInt(table.getColumn(4)));
                v.addElement(b);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public boolean booksEntry(int buchID, int startID, int endID, String rechnungID, int ausgabeID) {
        boolean result = false;
        Table booklimit_table=TableManager.getTable(TableManager.RPS_BOOKLIMIT);
        Table bookstock_table=TableManager.getTable(TableManager.RPS_BOOKSTOCK);
        try {
            String q = "";
            q = "INSERT INTO "+booklimit_table.getTableName()+"("+booklimit_table.getColumn(1)+","+booklimit_table.getColumn(2)+","+booklimit_table.getColumn(3)+","+booklimit_table.getColumn(4)+")VALUES('"
                    + startID + "','" + endID + "','" + rechnungID + "','" + ausgabeID + "')";
            DBHelper.getInstance().updateQuery(q);
            int temp = 0;
            for (int i = startID; i <= endID; i++) {
                q = "INSERT INTO "+bookstock_table.getTableName()+"("+bookstock_table.getColumn(0)+","+bookstock_table.getColumn(1)+","+bookstock_table.getColumn(2)+","+bookstock_table.getColumn(3)+")VALUES('"
                        + i
                        + "','"
                        + buchID
                        + "','"
                        + temp
                        + "','"
                        + temp
                        + "')";
                DBHelper.getInstance().updateQuery(q);
            }
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean shiftToSchule(int startID, int endID, int schuleID) {
        boolean result = false;
        Table bookstock_table=TableManager.getTable(TableManager.RPS_BOOKSTOCK);
        try {
            String q = "";
            for (int i = startID; i <= endID; i++) {
                q = "UPDATE "+bookstock_table.getTableName()+" SET "+bookstock_table.getColumn(2)+"='" + schuleID
                        + "' WHERE "+bookstock_table.getColumn(0)+"='" + i + "'";
                DBHelper.getInstance().updateQuery(q);
            }
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public Vector<Buch> getAvailableBooks(int schuleID, int stufeID) {
        Vector<Buch> v = new Vector<Buch>();
        Table books_table=TableManager.getTable(TableManager.RPS_BOOKS);
        Table bookstock_table=TableManager.getTable(TableManager.RPS_BOOKSTOCK);
        try {
            int avail = 0;
            String q = "";
            if (stufeID == 0) {
                q = "SELECT a."+books_table.getColumn(0)+",a."+books_table.getColumn(1)+",a."+books_table.getColumn(2)+",a."+books_table.getColumn(3)+",a."+books_table.getColumn(4)+",b."+bookstock_table.getColumn(0)+",b."+bookstock_table.getColumn(2)+",b."+bookstock_table.getColumn(3)+" FROM "+books_table.getTableName()+" AS a,"+bookstock_table.getTableName()+" AS b WHERE a."+books_table.getColumn(0)+"=b."+bookstock_table.getColumn(1)+" AND b."+bookstock_table.getColumn(2)+"='"
                        + schuleID + "' AND b."+bookstock_table.getColumn(3)+"='" + avail + "'";
            } else {
                q = "SELECT a."+books_table.getColumn(0)+",a."+books_table.getColumn(1)+",a."+books_table.getColumn(2)+",a."+books_table.getColumn(3)+",a."+books_table.getColumn(4)+",b."+bookstock_table.getColumn(0)+",b."+bookstock_table.getColumn(2)+",b."+bookstock_table.getColumn(3)+" FROM "+books_table.getTableName()+" AS a,"+bookstock_table.getTableName()+" AS b WHERE a."+books_table.getColumn(0)+"=b."+bookstock_table.getColumn(1)+" AND b."+bookstock_table.getColumn(2)+"='"
                        + schuleID
                        + "' AND b."+bookstock_table.getColumn(3)+"='"
                        + avail
                        + "' AND a."+books_table.getColumn(4)+"='"
                        + stufeID + "'";
            }
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Buch b = new Buch();
                b.setBookID(rs.getInt(books_table.getColumn(0)));
                b.setBookName(rs.getString(books_table.getColumn(1)));
                b.setISBN(rs.getString(books_table.getColumn(2)));
                b.setPrice(rs.getDouble(books_table.getColumn(3)));
                b.setStufe(rs.getInt(books_table.getColumn(4)));
                b.setBookTrack(rs.getInt(bookstock_table.getColumn(0)));
                b.setSchule(rs.getInt(bookstock_table.getColumn(2)));
                b.setStatus(rs.getInt(bookstock_table.getColumn(3)));
                v.addElement(b);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Buch getBookForSale(int buchTrackID) {
        Buch b = new Buch();
        Table books_table=TableManager.getTable(TableManager.RPS_BOOKS);
        Table bookstock_table=TableManager.getTable(TableManager.RPS_BOOKSTOCK);
        try {
            String q = "";
            q = "SELECT a."+books_table.getColumn(0)+",a."
                    +books_table.getColumn(1)+",a."
                    +books_table.getColumn(2)+",a."
                    +books_table.getColumn(3)+",a."
                    +books_table.getColumn(4)+",b."
                    +bookstock_table.getColumn(0)+",b."
                    +bookstock_table.getColumn(2)+",b."
                    +bookstock_table.getColumn(3)+" FROM "
                    +books_table.getTableName()+" AS a,"
                    +bookstock_table.getTableName()+" AS b WHERE a."
                    +books_table.getColumn(0)+"=b."+bookstock_table.getColumn(1)+" and b."
                    +bookstock_table.getColumn(0)+"='"
                    + buchTrackID + "'";

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                b.setBookID(rs.getInt(books_table.getColumn(0)));
                b.setBookName(rs.getString(books_table.getColumn(1)));
                b.setISBN(rs.getString(books_table.getColumn(2)));
                b.setPrice(rs.getDouble(books_table.getColumn(3)));
                b.setStufe(rs.getInt(books_table.getColumn(4)));
                b.setBookTrack(rs.getInt(bookstock_table.getColumn(0)));
                b.setSchule(rs.getInt(bookstock_table.getColumn(2)));
                b.setStatus(rs.getInt(bookstock_table.getColumn(3)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public Buch getBookBuyer(int buchTrackID) {
        Buch b = new Buch();
        Table bookrec_table=TableManager.getTable(TableManager.RPS_BOOKRECHNUNG);
        Table booksold_table=TableManager.getTable(TableManager.RPS_BOOKSOLD);
        try {
            String q = "";
            q = "SELECT d."+bookrec_table.getColumn(2)+" FROM "
                    +booksold_table.getTableName()+" AS c,"
                    +bookrec_table.getTableName()+" AS d WHERE c."
                    +booksold_table.getColumn(1)+"=d."+bookrec_table.getColumn(0)+" and c."
                    +booksold_table.getColumn(0)+"='"+ buchTrackID + "'";

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                b.setStudentName(rs.getString(bookrec_table.getColumn(2)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public int saleBooks(Vector books, Student s, int systemUserID, int placeID) {
        int rechnungID = 0;
        Table booksold_table=TableManager.getTable(TableManager.RPS_BOOKSOLD);
        Table bookstock_table=TableManager.getTable(TableManager.RPS_BOOKSTOCK);
        try {
            int sta = 1;
            int buyerType = 0;
            String q = "";
            double pay = 0;
            for (int ii = 0; ii < books.size(); ii++) {
                Buch tempBuch = (Buch) books.elementAt(ii);
                pay = pay + tempBuch.getPrice();
            }
            int rechid = addRechnung(s.getUserID(), s.getUserFirstName()+ "-" + s.getUserLastName(), systemUserID, pay, buyerType, placeID);
            for (int iii = 0; iii < books.size(); iii++) {
                Buch tempBuch = (Buch) books.elementAt(iii);
                q = "INSERT INTO "+booksold_table.getTableName()+"("+booksold_table.getColumn(0)+","+booksold_table.getColumn(1)+")VALUES('"
                        + tempBuch.getBookTrack() + "','" + rechid + "')";
                DBHelper.getInstance().updateQuery(q);
            }
            for (int i = 0; i < books.size(); i++) {
                Buch tempBuch = (Buch) books.elementAt(i);
                q = "UPDATE "+bookstock_table.getTableName()+" SET "+bookstock_table.getColumn(3)+"='" + sta
                        + "' WHERE "+bookstock_table.getColumn(0)+"='" + tempBuch.getBookTrack() + "'";
                DBHelper.getInstance().updateQuery(q);
            }
            rechnungID = rechid;
        } catch (Exception e) {
            setError(e.toString());
        }
        return rechnungID;
    }

    public int saleBooksUser(Vector books, SystemUser s, int systemUserID, int placeID) {
        int rechnungID = 0;
        Table booksold_table=TableManager.getTable(TableManager.RPS_BOOKSOLD);
        Table bookstock_table=TableManager.getTable(TableManager.RPS_BOOKSTOCK);
        try {
            int sta = 1;
            int buyerType = 1;
            String q = "";
            double pay = 0;
            for (int ii = 0; ii < books.size(); ii++) {
                Buch tempBuch = (Buch) books.elementAt(ii);
                pay = pay + tempBuch.getPrice();
            }
            int rechid = addRechnung(s.getUserID(), s.getUserFirstName()+ "-" + s.getUserLastName(), systemUserID, pay, buyerType, placeID);
            for (int iii = 0; iii < books.size(); iii++) {
                Buch tempBuch = (Buch) books.elementAt(iii);
                q = "INSERT INTO "+booksold_table.getTableName()+"("+booksold_table.getColumn(0)+","+booksold_table.getColumn(1)+")VALUES('"
                        + tempBuch.getBookTrack() + "','" + rechid + "')";
                DBHelper.getInstance().updateQuery(q);
            }
            for (int i = 0; i < books.size(); i++) {
                Buch tempBuch = (Buch) books.elementAt(i);
                q = "UPDATE "+bookstock_table.getTableName()+" SET "+bookstock_table.getColumn(3)+"='" + sta
                        + "' WHERE "+bookstock_table.getColumn(0)+"='" + tempBuch.getBookTrack() + "'";
                DBHelper.getInstance().updateQuery(q);
            }
            rechnungID = rechid;
        } catch (Exception e) {
            setError(e.toString());
        }
        return rechnungID;
    }

    public int addRechnung(int studentID, String studentName, int adminId, double paidAmount, int buyerType, int place) {
        int rechnungID = 0;
        Table table=TableManager.getTable(TableManager.RPS_BOOKRECHNUNG);
        try {
            String q = "INSERT INTO "+table.getTableName()+"("
                    +table.getColumn(1)+","
                    +table.getColumn(2)+","
                    +table.getColumn(3)+","
                    +table.getColumn(4)+","
                    +table.getColumn(5)+","
                    +table.getColumn(7)+","
                    +table.getColumn(6)+")VALUES('"
                    + studentID	+ "',"
                    + this.replaceNull(studentName)	+ ",'"
                    + adminId + "','"
                    + paidAmount + "','"
                    + buyerType + "','"
                    + place + "', curdate())";

            DBHelper.getInstance().updateQuery(q);
            q = "SELECT LAST_INSERT_ID() AS id";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                rechnungID = rs.getInt("id");
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return rechnungID;
    }

    public boolean isBookForSale(int buchTrackID, int schuleID) {
        boolean result = false;
        Table bookstock_table=TableManager.getTable(TableManager.RPS_BOOKSTOCK);
        try {
            String q = "";
            q = "SELECT "+bookstock_table.getColumn(0)+","+bookstock_table.getColumn(2)+","+bookstock_table.getColumn(3)+" FROM "+bookstock_table.getTableName()+" WHERE "+bookstock_table.getColumn(0)+"='"
                    + buchTrackID + "'";

            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            int bt = 0;
            int sh = 0;
            int st = 0;
            while (rs.next()) {
                bt = rs.getInt(bookstock_table.getColumn(0));
                sh = rs.getInt(bookstock_table.getColumn(2));
                st = rs.getInt(bookstock_table.getColumn(3));
            }
            if (bt > 0 && st == 0 && sh == schuleID) {
                result = true;
            } else {
                result = false;
                if (bt == 0) {
                    setError("Buch Nummer ist falsch.");
                }
                if (st == 1) {
                    setError("Buch hat schon verkauft");
                }
                if (sh != schuleID) {
                    setError("Buch ist nicht in die Schule gekommen.");
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean isIDFree(int startID, int endID) {
        boolean b = true;
        Table table=TableManager.getTable(TableManager.RPS_BOOKLIMIT);
        try {
            String q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"<='"
                    + startID + "' AND "+table.getColumn(2)+">='" + startID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            int temp = 0;
            while (rs.next()) {
                temp = rs.getInt(table.getColumn(0));
            }
            if (temp > 0) {
                b = false;
            }
            if (startID > endID) {
                b = false;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean isIDExist(int firstTrackID, int secondTrackID) {
        boolean b = false;
        Table table=TableManager.getTable(TableManager.RPS_BOOKLIMIT);
        try {
            String q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"<='" + firstTrackID
                    + "' AND "+table.getColumn(2)+">='" + firstTrackID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            int temp = 0;
            while (rs.next()) {
                temp = rs.getInt(table.getColumn(0));
            }
            if (temp > 0) {
                b = true;
            } else {
                b = false;
            }
            q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"<='" + secondTrackID
                    + "' AND "+table.getColumn(2)+">='" + secondTrackID + "'";
            ResultSet rs1 = DBHelper.getInstance().executeQuery(q);
            temp = 0;
            while (rs1.next()) {
                temp = rs1.getInt(table.getColumn(0));
            }
            if (temp > 0) {
                b = true;
            } else {
                b = false;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public int getLastTrackID() {
        int b = 0;
        Table table=TableManager.getTable(TableManager.RPS_BOOKLIMIT);
        try {
            String q = "SELECT max("+table.getColumn(2)+") AS a FROM "+table.getTableName();
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            int temp = 0;
            while (rs.next()) {
                temp = rs.getInt("a");
            }
            b = temp + 1;
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public Vector<Buch> getBooksSaledToStudent(int studentID, int buyerType) {
        Vector<Buch> v = new Vector<Buch>();
        Table rechnung_table=TableManager.getTable(TableManager.RPS_BOOKRECHNUNG);
        Table booksold_table=TableManager.getTable(TableManager.RPS_BOOKSOLD);
        try {
            String q = "";
            q = "SELECT "+rechnung_table.getColumn(0)+" FROM "
                    +rechnung_table.getTableName()+" WHERE "
                    +rechnung_table.getColumn(1)+"='" + studentID + "' AND "
                    +rechnung_table.getColumn(5)+"='"+ buyerType + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            Vector<String> tempR = new Vector<String>();
            while (rs.next()) {
                tempR.addElement("" + rs.getInt("rechID"));
            }
            for (int i = 0; i < tempR.size(); i++) {
                Vector<String> tempB = new Vector<String>();
                int tempRechnungID = Integer.parseInt((String) tempR.elementAt(i));
                q = "SELECT "+booksold_table.getColumn(0)+" FROM "
                        +booksold_table.getTableName()+" WHERE "
                        +booksold_table.getColumn(1)+"='"
                        + tempRechnungID + "'";
                ResultSet rs1 = DBHelper.getInstance().executeQuery(q);
                while (rs1.next()) {
                    tempB.addElement("" + rs1.getInt("bookTrack"));
                }
                for (int ii = 0; ii < tempB.size(); ii++) {
                    int temp1 = Integer.parseInt((String) tempB.elementAt(ii));
                    Buch tb = getBookForSale(temp1);
                    tb.setBookRechnungID(tempRechnungID);
                    v.addElement(tb);
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<Buch> getBooksSoldRecord(int rechID, int buyerType) {
        Vector<Buch> v = new Vector<Buch>();
        Table rechnung_table=TableManager.getTable(TableManager.RPS_BOOKRECHNUNG);
        Table booksold_table=TableManager.getTable(TableManager.RPS_BOOKSOLD);
        try {
            String q = "";
            q = "SELECT "+rechnung_table.getColumn(0)+" FROM "
                    +rechnung_table.getTableName()+" WHERE "
                    +rechnung_table.getColumn(0)+"='" + rechID + "' AND "
                    +rechnung_table.getColumn(5)+"='"+ buyerType + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            Vector<String> tempR = new Vector<String>();
            while (rs.next()) {
                tempR.addElement("" + rs.getInt("rechID"));
            }
            for (int i = 0; i < tempR.size(); i++) {
                Vector<String> tempB = new Vector<String>();
                int tempRechnungID = Integer.parseInt((String) tempR.elementAt(i));
                q = "SELECT "+booksold_table.getColumn(0)+" FROM "
                        +booksold_table.getTableName()+" WHERE "
                        +booksold_table.getColumn(1)+"='"
                        + tempRechnungID + "'";
                ResultSet rs1 = DBHelper.getInstance().executeQuery(q);
                while (rs1.next()) {
                    tempB.addElement("" + rs1.getInt("bookTrack"));
                }
                for (int ii = 0; ii < tempB.size(); ii++) {
                    int temp1 = Integer.parseInt((String) tempB.elementAt(ii));
                    Buch tb = getBookForSale(temp1);
                    tb.setBookRechnungID(tempRechnungID);
                    v.addElement(tb);
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Buch getBooksSold(int studentID, int buyerType) {
        Buch v = new Buch();
        Table rechnung_table=TableManager.getTable(TableManager.RPS_BOOKRECHNUNG);
        Table booksold_table=TableManager.getTable(TableManager.RPS_BOOKSOLD);
        try {
            String q = "";
            q = "SELECT "+rechnung_table.getColumn(0)+" FROM "
                    +rechnung_table.getTableName()+" WHERE "
                    +rechnung_table.getColumn(1)+"='" + studentID + "' AND "
                    +rechnung_table.getColumn(5)+"='"+ buyerType + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            Vector<String> tempR = new Vector<String>();
            while (rs.next()) {
                tempR.addElement("" + rs.getInt("rechID"));
            }
            for (int i = 0; i < tempR.size(); i++) {
                Vector<String> tempB = new Vector<String>();
                int tempRechnungID = Integer.parseInt((String) tempR.elementAt(i));
                q = "SELECT "+booksold_table.getColumn(0)+" FROM "
                        +booksold_table.getTableName()+" WHERE "
                        +booksold_table.getColumn(1)+"='"
                        + tempRechnungID + "'";
                ResultSet rs1 = DBHelper.getInstance().executeQuery(q);
                while (rs1.next()) {
                    tempB.addElement("" + rs1.getInt("bookTrack"));
                }
                for (int ii = 0; ii < tempB.size(); ii++) {
                    int temp1 = Integer.parseInt((String) tempB.elementAt(ii));
                    Buch tb = getBookForSale(temp1);
                    tb.setBookRechnungID(tempRechnungID);
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Buch getBookRech(int rechID, int buyerType) {
        Buch v = new Buch();
        Table rechnung_table=TableManager.getTable(TableManager.RPS_BOOKRECHNUNG);
        Table booksold_table=TableManager.getTable(TableManager.RPS_BOOKSOLD);
        try {
            String q = "";
            q = "SELECT "+rechnung_table.getColumn(0)+" FROM "
                    +rechnung_table.getTableName()+" WHERE "
                    +rechnung_table.getColumn(0)+"='" + rechID + "' AND "
                    +rechnung_table.getColumn(5)+"='"+ buyerType + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            Vector<String> tempR = new Vector<String>();
            while (rs.next()) {
                tempR.addElement("" + rs.getInt("rechID"));
            }
            for (int i = 0; i < tempR.size(); i++) {
                Vector<String> tempB = new Vector<String>();
                int tempRechnungID = Integer.parseInt((String) tempR.elementAt(i));
                q = "SELECT "+booksold_table.getColumn(0)+" FROM "
                        +booksold_table.getTableName()+" WHERE "
                        +booksold_table.getColumn(1)+"='"
                        + tempRechnungID + "'";
                ResultSet rs1 = DBHelper.getInstance().executeQuery(q);
                while (rs1.next()) {
                    tempB.addElement("" + rs1.getInt("bookTrack"));
                }
                for (int ii = 0; ii < tempB.size(); ii++) {
                    int temp1 = Integer.parseInt((String) tempB.elementAt(ii));
                    Buch tb = getBookForSale(temp1);
                    tb.setBookRechnungID(tempRechnungID);
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public int countBooks(int bookID, int schuleID) {
        int b = 0;
        Table bookstock_table=TableManager.getTable(TableManager.RPS_BOOKSTOCK);
        try {
            String q = "SELECT count("+bookstock_table.getColumn(0)+") AS a FROM "+bookstock_table.getTableName()+" WHERE "+bookstock_table.getColumn(1)+"='"
                    + bookID
                    + "' AND "+bookstock_table.getColumn(2)+"='"
                    + schuleID
                    + "' AND "+bookstock_table.getColumn(3)+"='"
                    + b
                    + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                b = rs.getInt("a");
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public int whereIsBook(int bookID) {
        int b = 0;
        Table bookstock_table=TableManager.getTable(TableManager.RPS_BOOKSTOCK);
        try {
            String q = "SELECT "+bookstock_table.getColumn(2)+" FROM "+bookstock_table.getTableName()+" WHERE "+bookstock_table.getColumn(0)+"='"
                    + bookID+ "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                b = rs.getInt(bookstock_table.getColumn(2));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean deleteBookRecord(int bookID) {
        boolean result = false;
        Table bookstock_table=TableManager.getTable(TableManager.RPS_BOOKSTOCK);
        try {
            String q = "DELETE FROM "+bookstock_table.getTableName()+" WHERE "+bookstock_table.getColumn(0)+"='"
                    + bookID+ "'";
            DBHelper.getInstance().updateQuery(q);
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean canAddNewBook(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"9.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canUpdateBook(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"9.1.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canBooksEingang(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"9.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canBooksFreigabe(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"9.3");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSearchBook(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"9.4");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeeBookinCity(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"9.4.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canSeeBookinStock(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"9.4.2");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canBookSale(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"9.5");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public boolean canDeleteBook(int loginUser){
        boolean flag=PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"9.4.3");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    public static void main(String args[]){

    }

    public String getError(){
        return error;
    }

    public void setError(String errorMessage){
        error=errorMessage;
    }

    public Object replaceNull(Object o){
        if(o == null){
            return null;
        }else{
            return "'" + o + "'";
        }
    }

    //Instance Variables
    private String error;
}
