package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.helper.TableManager;
import com.rheinlandprivatschule.model.Certificate;
import com.rheinlandprivatschule.model.Course;
import com.rheinlandprivatschule.model.Table;

import java.sql.*;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Vector;


public class CertificateDao {

    public CertificateDao() {
        this.error = null;
    }

    public int addCertificate(int studentID, int courseID,double listenPercentage,double writingPercentage,double readPercentage,double contentPercentage,double oralPercentage,double stunden, double totalPercentage, Date dateIssue,int adminID) {
        int newCertificateID = 0;
        Table table= TableManager.getTable(TableManager.RPS_CERTIFICATE);
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+","+table.getColumn(7)+","+table.getColumn(8)+","+table.getColumn(9)+","+table.getColumn(10)+","+table.getColumn(11)+") VALUES ('"
                    + studentID + "','" + courseID + "','"+listenPercentage+"','"+writingPercentage+"','"+readPercentage+"','"+contentPercentage+"','"+oralPercentage+"','" + stunden + "','" + totalPercentage + "',"
                    + replaceNull(dateIssue) + ",'" + adminID + "')";
            DBHelper.getInstance().updateQuery(q);
            q = "select LAST_INSERT_ID() as id";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            int chk = 0;
            while (rs.next()) {
                chk = rs.getInt("id");
            }
            if (chk > 0) {
                addMultiRecord(studentID, courseID, chk);
            }
            newCertificateID = chk;
        } catch (Exception e) {
            setError(e.toString());
        }
        return newCertificateID;
    }

    public void addOnlineCertificateRecord(int certificateId) {
        DBHelper.getInstance().updateQuery("INSERT INTO OnlineCertificate(CertificateId) VALUES('" + certificateId + "')");
        System.out.println(certificateId + " certificate added to OnlineCertificate");
    }

    public boolean addMultiRecord(int studentID, int courseID, int certificateID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_MULCERTIFICATE);
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+")VALUES('" + certificateID
                    + "','" + studentID + "','" + courseID + "')";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public Vector<Certificate> getAllCertificate(int studentID, int courseID) {
        Vector<Certificate> v = new Vector<Certificate>();
        Table t_cer=TableManager.getTable(TableManager.RPS_CERTIFICATE);
        Table t_mulcer=TableManager.getTable(TableManager.RPS_MULCERTIFICATE);
        try {
            String q = "SELECT a."+t_cer.getColumn(0)+",a."+t_cer.getColumn(1)+",a."+t_cer.getColumn(2)+",a."+t_cer.getColumn(3)+",a."+t_cer.getColumn(4)+",a."+t_cer.getColumn(5)+",a."+t_cer.getColumn(6)+",a."+t_cer.getColumn(7)+",a."+t_cer.getColumn(8)+",a."+t_cer.getColumn(9)+",a."+t_cer.getColumn(10)+",a."+t_cer.getColumn(11)+" FROM "+t_cer.getTableName()+" a LEFT JOIN OnlineCertificate ON a.cerID = OnlineCertificate.CertificateId,"+t_mulcer.getTableName()+" b WHERE OnlineCertificate.CertificateId IS NULL AND b."+t_mulcer.getColumn(1)+"='"
                    + studentID + "' AND b."+t_mulcer.getColumn(2)+"='" + courseID + "' AND b."+t_mulcer.getColumn(0)+"=a."+t_cer.getColumn(0);
            System.out.println(q);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Certificate c = new Certificate();
                c.setCertificateID(rs.getInt(t_cer.getColumn(0)));
                c.setStudentID(rs.getInt(t_cer.getColumn(1)));
                c.setCourseID(rs.getInt(t_cer.getColumn(2)));
                c.setListenPercentage(rs.getDouble(t_cer.getColumn(3)));
                c.setWrittingPercentage(rs.getDouble(t_cer.getColumn(4)));
                c.setReadPercentage(rs.getDouble(t_cer.getColumn(5)));
                c.setContentPercentage(rs.getDouble(t_cer.getColumn(6)));
                c.setOralPercentage(rs.getDouble(t_cer.getColumn(7)));
                c.setStunden(rs.getDouble(t_cer.getColumn(8)));
                c.setTotalPercentage(rs.getDouble(t_cer.getColumn(9)));
                c.setIssueDate(rs.getDate(t_cer.getColumn(10)));
                c.setAdminID(rs.getInt(t_cer.getColumn(11)));
                v.addElement(c);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Vector<Certificate> getAllOnlineCertificate(int studentID, int courseID) {
        Vector<Certificate> v = new Vector<Certificate>();
        Table t_cer=TableManager.getTable(TableManager.RPS_CERTIFICATE);
        Table t_mulcer=TableManager.getTable(TableManager.RPS_MULCERTIFICATE);
        try {
            String q = "SELECT a."+t_cer.getColumn(0)+",a."+t_cer.getColumn(1)+",a."+t_cer.getColumn(2)+",a."+t_cer.getColumn(3)+",a."+t_cer.getColumn(4)+",a."+t_cer.getColumn(5)+",a."+t_cer.getColumn(6)+",a."+t_cer.getColumn(7)+",a."+t_cer.getColumn(8)+",a."+t_cer.getColumn(9)+",a."+t_cer.getColumn(10)+",a."+t_cer.getColumn(11)+" FROM "+t_cer.getTableName()+" a INNER JOIN OnlineCertificate ON a.cerID = OnlineCertificate.CertificateId,"+t_mulcer.getTableName()+" b WHERE b."+t_mulcer.getColumn(1)+"='"
                    + studentID + "' AND b."+t_mulcer.getColumn(2)+"='" + courseID + "' AND b."+t_mulcer.getColumn(0)+"=a."+t_cer.getColumn(0);
            System.out.println(q);
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Certificate c = new Certificate();
                c.setCertificateID(rs.getInt(t_cer.getColumn(0)));
                c.setStudentID(rs.getInt(t_cer.getColumn(1)));
                c.setCourseID(rs.getInt(t_cer.getColumn(2)));
                c.setListenPercentage(rs.getDouble(t_cer.getColumn(3)));
                c.setWrittingPercentage(rs.getDouble(t_cer.getColumn(4)));
                c.setReadPercentage(rs.getDouble(t_cer.getColumn(5)));
                c.setContentPercentage(rs.getDouble(t_cer.getColumn(6)));
                c.setOralPercentage(rs.getDouble(t_cer.getColumn(7)));
                c.setStunden(rs.getDouble(t_cer.getColumn(8)));
                c.setTotalPercentage(rs.getDouble(t_cer.getColumn(9)));
                c.setIssueDate(rs.getDate(t_cer.getColumn(10)));
                c.setAdminID(rs.getInt(t_cer.getColumn(11)));
                v.addElement(c);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Certificate getCertificate(int certificateID) {
        Certificate c = new Certificate();
        Table t_cer=TableManager.getTable(TableManager.RPS_CERTIFICATE);
        try {
            String q = "SELECT "+t_cer.getColumn(0)+","+t_cer.getColumn(1)+","+t_cer.getColumn(2)+","+t_cer.getColumn(3)+","+t_cer.getColumn(4)+","+t_cer.getColumn(5)+","+t_cer.getColumn(6)+","+t_cer.getColumn(7)+","+t_cer.getColumn(8)+","+t_cer.getColumn(9)+","+t_cer.getColumn(10)+","+t_cer.getColumn(11)+" FROM "+t_cer.getTableName()+" WHERE "+t_cer.getColumn(0)+"='"
                    + certificateID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                c.setCertificateID(rs.getInt(t_cer.getColumn(0)));
                c.setStudentID(rs.getInt(t_cer.getColumn(1)));
                c.setCourseID(rs.getInt(t_cer.getColumn(2)));
                c.setListenPercentage(rs.getDouble(t_cer.getColumn(3)));
                c.setWrittingPercentage(rs.getDouble(t_cer.getColumn(4)));
                c.setReadPercentage(rs.getDouble(t_cer.getColumn(5)));
                c.setContentPercentage(rs.getDouble(t_cer.getColumn(6)));
                c.setOralPercentage(rs.getDouble(t_cer.getColumn(7)));
                c.setStunden(rs.getDouble(t_cer.getColumn(8)));
                c.setTotalPercentage(rs.getDouble(t_cer.getColumn(9)));
                c.setIssueDate(rs.getDate(t_cer.getColumn(10)));
                c.setAdminID(rs.getInt(t_cer.getColumn(11)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return c;
    }

    public int getCourseStunden(String courseTiming) {
        int courseHours = 0;
        try {
            String temp = courseTiming;
            if (temp.equalsIgnoreCase("8:30-12:00")) {
                courseHours = 4;
            } else if (temp.equalsIgnoreCase("12:00-18:00")) {
                courseHours = 6;
            } else if (temp.equalsIgnoreCase("18:00-21:00")) {
                courseHours = 3;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return courseHours;
    }

    public boolean updateCertificate(Certificate c) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_CERTIFICATE);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(3)+"='" + c.getListenPercentage() + "', "+table.getColumn(4)+"='"
                    + c.getWrittingPercentage() + "', "+table.getColumn(5)+"='"
                    + c.getReadPercentage() + "', "+table.getColumn(6)+"='"
                    + c.getContentPercentage() + "', "+table.getColumn(7)+"='"
                    + c.getOralPercentage() + "', "+table.getColumn(8)+"='"
                    + c.getStunden() + "', "+table.getColumn(9)+"='"
                    + c.getTotalPercentage() + "', "+table.getColumn(10)+"="
                    + replaceNull(c.getIssueDate())+ ", "+table.getColumn(11)+"='"
                    + c.getAdminID() + "' WHERE "+table.getColumn(0)+"='" + c.getCertificateID()
                    + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean isCertificateAvailable(int certificateID) {
        boolean b = false;
        try {
            CourseDao cdb = new CourseDao();
            Course c = cdb.getCourse(certificateID);
            Calendar gc = new GregorianCalendar();
            gc.setTime(c.getCourseEndDate());
            gc.add(Calendar.DATE, -25);
            Date tempDate = new Date(gc.getTime().getTime());
            boolean b1 = MyDate.getCurrentSQLDate().after(c.getCourseEndDate());
            boolean b2 = MyDate.getCurrentSQLDate().after(tempDate)
                    && MyDate.getCurrentSQLDate().before(c.getCourseEndDate());
            if (b1 || b2) {
                b = true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean isCertificateExist(int studentID, int courseID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_CERTIFICATE);
        try {
            String q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"
                    + studentID + "' AND "+table.getColumn(2)+"='" + courseID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                int tempCertificateID = rs.getInt(table.getColumn(0));
                if (tempCertificateID > 0) {
                    result = true;
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public int addCertificateNP(int studentID, int courseID,double listenPercentage,double writingPercentage,double readPercentage,double contentPercentage,double oralPercentage,double stunden, double totalPercentage, Date dateIssue,int adminID) {
        int newCertificateID = 0;
        Table table=TableManager.getTable(TableManager.RPS_CERTIFICATENP);
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(1)+","+table.getColumn(2)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+","+table.getColumn(6)+","+table.getColumn(7)+","+table.getColumn(8)+","+table.getColumn(9)+","+table.getColumn(10)+","+table.getColumn(11)+") VALUES ('"
                    + studentID + "','" + courseID + "','"+listenPercentage+"','"+writingPercentage+"','"+readPercentage+"','"+contentPercentage+"','"+oralPercentage+"','" + stunden + "','" + totalPercentage + "',"
                    + replaceNull(dateIssue) + ",'" + adminID + "')";
            DBHelper.getInstance().updateQuery(q);
            q = "select LAST_INSERT_ID() as id";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            int chk = 0;
            while (rs.next()) {
                chk = rs.getInt("id");
            }
            if (chk > 0) {
                addMultiRecordNP(studentID, courseID, chk);
            }
            newCertificateID = chk;
        } catch (Exception e) {
            setError(e.toString());
        }
        return newCertificateID;
    }

    public boolean addMultiRecordNP(int studentID, int courseID, int certificateID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_MULCERTIFICATENP);
        try {
            String q = "INSERT INTO "+table.getTableName()+"("+table.getColumn(0)+","+table.getColumn(1)+","+table.getColumn(2)+")VALUES('" + certificateID
                    + "','" + studentID + "','" + courseID + "')";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public Vector<Certificate> getAllCertificateNP(int studentID, int courseID) {
        Vector<Certificate> v = new Vector<Certificate>();
        Table t_cer=TableManager.getTable(TableManager.RPS_CERTIFICATENP);
        Table t_mulcer=TableManager.getTable(TableManager.RPS_MULCERTIFICATENP);
        try {
            String q = "SELECT a."+t_cer.getColumn(0)+",a."+t_cer.getColumn(1)+",a."+t_cer.getColumn(2)+",a."+t_cer.getColumn(3)+",a."+t_cer.getColumn(4)+",a."+t_cer.getColumn(5)+",a."+t_cer.getColumn(6)+",a."+t_cer.getColumn(7)+",a."+t_cer.getColumn(8)+",a."+t_cer.getColumn(9)+",a."+t_cer.getColumn(10)+",a."+t_cer.getColumn(11)+" FROM "+t_cer.getTableName()+" a,"+t_mulcer.getTableName()+" b WHERE b."+t_mulcer.getColumn(1)+"='"
                    + studentID + "' AND b."+t_mulcer.getColumn(2)+"='" + courseID + "' AND b."+t_mulcer.getColumn(0)+"=a."+t_cer.getColumn(0)+"";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                Certificate c = new Certificate();
                c.setCertificateID(rs.getInt(t_cer.getColumn(0)));
                c.setStudentID(rs.getInt(t_cer.getColumn(1)));
                c.setCourseID(rs.getInt(t_cer.getColumn(2)));
                c.setListenPercentage(rs.getDouble(t_cer.getColumn(3)));
                c.setWrittingPercentage(rs.getDouble(t_cer.getColumn(4)));
                c.setReadPercentage(rs.getDouble(t_cer.getColumn(5)));
                c.setContentPercentage(rs.getDouble(t_cer.getColumn(6)));
                c.setOralPercentage(rs.getDouble(t_cer.getColumn(7)));
                c.setStunden(rs.getDouble(t_cer.getColumn(8)));
                c.setTotalPercentage(rs.getDouble(t_cer.getColumn(9)));
                c.setIssueDate(rs.getDate(t_cer.getColumn(10)));
                c.setAdminID(rs.getInt(t_cer.getColumn(11)));
                v.addElement(c);
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return v;
    }

    public Certificate getCertificateNP(int certificateID) {
        Certificate c = new Certificate();
        Table t_cer=TableManager.getTable(TableManager.RPS_CERTIFICATENP);
        try {
            String q = "SELECT "+t_cer.getColumn(0)+","+t_cer.getColumn(1)+","+t_cer.getColumn(2)+","+t_cer.getColumn(3)+","+t_cer.getColumn(4)+","+t_cer.getColumn(5)+","+t_cer.getColumn(6)+","+t_cer.getColumn(7)+","+t_cer.getColumn(8)+","+t_cer.getColumn(9)+","+t_cer.getColumn(10)+","+t_cer.getColumn(11)+" FROM "+t_cer.getTableName()+" WHERE "+t_cer.getColumn(0)+"='"
                    + certificateID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                c.setCertificateID(rs.getInt(t_cer.getColumn(0)));
                c.setStudentID(rs.getInt(t_cer.getColumn(1)));
                c.setCourseID(rs.getInt(t_cer.getColumn(2)));
                c.setListenPercentage(rs.getDouble(t_cer.getColumn(3)));
                c.setWrittingPercentage(rs.getDouble(t_cer.getColumn(4)));
                c.setReadPercentage(rs.getDouble(t_cer.getColumn(5)));
                c.setContentPercentage(rs.getDouble(t_cer.getColumn(6)));
                c.setOralPercentage(rs.getDouble(t_cer.getColumn(7)));
                c.setStunden(rs.getDouble(t_cer.getColumn(8)));
                c.setTotalPercentage(rs.getDouble(t_cer.getColumn(9)));
                c.setIssueDate(rs.getDate(t_cer.getColumn(10)));
                c.setAdminID(rs.getInt(t_cer.getColumn(11)));
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return c;
    }

    public boolean updateCertificateNP(Certificate c) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_CERTIFICATENP);
        try {
            String q = "UPDATE "+table.getTableName()+" SET "+table.getColumn(3)+"='" + c.getListenPercentage() + "', "+table.getColumn(4)+"='"
                    + c.getWrittingPercentage() + "', "+table.getColumn(5)+"='"
                    + c.getReadPercentage() + "', "+table.getColumn(6)+"='"
                    + c.getContentPercentage() + "', "+table.getColumn(7)+"='"
                    + c.getOralPercentage() + "', "+table.getColumn(8)+"='"
                    + c.getStunden() + "', "+table.getColumn(9)+"='"
                    + c.getTotalPercentage() + "', "+table.getColumn(10)+"="
                    + replaceNull(c.getIssueDate())+ ", "+table.getColumn(11)+"='"
                    + c.getAdminID() + "' WHERE "+table.getColumn(0)+"='" + c.getCertificateID()
                    + "'";
            DBHelper.getInstance().updateQuery(q);
            result = true;
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }

    public boolean isCertificateExistNP(int studentID, int courseID) {
        boolean result = false;
        Table table=TableManager.getTable(TableManager.RPS_CERTIFICATENP);
        try {
            String q = "SELECT "+table.getColumn(0)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"
                    + studentID + "' AND "+table.getColumn(2)+"='" + courseID + "'";
            ResultSet rs = DBHelper.getInstance().executeQuery(q);
            while (rs.next()) {
                int tempCertificateID = rs.getInt(table.getColumn(0));
                if (tempCertificateID > 0) {
                    result = true;
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return result;
    }


    public String getRemarks(double percentage) {
        if (percentage >= 90) {
            return "sehr gut";
        }else if (percentage >= 80) {
            return "gut";
        } else if (percentage >= 70) {
            return "befriedigend";
        } else if (percentage >= 60) {
            return "ausreichend";
        }else if(percentage == 0){
            return "nicht geprüft";
        }else{
            return "nicht bestanden";
        }
    }

	/*@SuppressWarnings("unused")
	public void getStundenForStudent(int courseID, int studentID) {
		Table table=TableManager.getTable(TableManager.RPS_ANWESEN);
		try {
			int hours;
			CourseDB cdb = new CourseDB();
			Course c = cdb.getCourse(courseID);
			hours = getCourseStunden(c.getCourseTiming());
			Vector<String> pv = new Vector<String>();
			double sv = 0.0;
			String q = "SELECT "+table.getColumn(0)+","+table.getColumn(3)+","+table.getColumn(4)+","+table.getColumn(5)+" FROM "+table.getTableName()+" WHERE "+table.getColumn(1)+"='"
					+ courseID
					+ "' AND "+table.getColumn(2)+"='"
					+ studentID
					+ "' AND "+table.getColumn(0)+" BETWEEN "
					+ replaceNull(c.getCourseStartDate())
					+ " AND "
					+ replaceNull(c.getCourseEndDate())
					+ "AND "+table.getColumn(3)+"!='12' ORDER BY "+table.getColumn(0);
			ResultSet rs = DBHelper.getInstance().executeQuery(q);
			while (rs.next()) {

				Date tempdate = rs.getDate(table.getColumn(0));
				int temptype = rs.getInt(table.getColumn(3));
				double tempper = rs.getDouble(table.getColumn(4));
				double tempstun = rs.getDouble(table.getColumn(5));
				if (tempper > 0.0D) {
					pv.addElement("" + tempper);
				}

				if (temptype != 0) {
					if (temptype == 1) {
						sv += hours;
					} else if (temptype == 2) {
						sv += tempstun;
					} else if (temptype == 3) {
						sv += tempstun;
					}
				}
			}

			double temppercen = 0.0D;
			for (int i = 0; i < pv.size(); i++) {
				temppercen += Double.parseDouble((String) pv.elementAt(i));
			}

			totalPercentage = temppercen / (double) pv.size();
			stunden = sv;
			totalStunden = Double.parseDouble(c.getCourseTotalHours());
		} catch (Exception e) {
			setError(e.toString());
		}
	}

	public void makeCertificate(int courseID, int studentID) {
		totalPercentage = 0;
		stunden = 0;
		totalStunden = 0;
		getStundenForStudent(courseID, studentID);
	}*/

	/*public double getEndPercentage() {
		return totalPercentage;
	}

	public double getPresentStunden() {
		return stunden;
	}

	public double getTotalStunden() {
		return totalStunden;
	}*/

    /* Methods Related To Every Method */
    private void setError(String errorPara) {
        this.error=errorPara;
    }

    public String getError() {
        return error;
    }

    public Object replaceNull(Object o) {
        if (o == null) {
            return null;
        } else {
            return "'" + o + "'";
        }
    }

    //Instance Variables
    private String error;
}
