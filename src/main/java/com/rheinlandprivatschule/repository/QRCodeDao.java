package com.rheinlandprivatschule.repository;

import com.rheinlandprivatschule.helper.DBHelper;
import com.rheinlandprivatschule.model.QRCodeInformation;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.ResultSet;
import java.sql.SQLException;

public class QRCodeDao {

    @Autowired
    private final SystemUserDao systemUserDao;

    public QRCodeDao(SystemUserDao systemUserDao) {
        this.systemUserDao = systemUserDao;
    }

    public void insertRecord(String md5, int studentId, int certificateId, int systemUserId) {
        ResultSet resultSet = DBHelper
                .getInstance()
                .executeQuery("SELECT * FROM QRCodeMatch WHERE StudentId='"+studentId+"' AND CertificateId='"+certificateId
                        +"' AND SystemUserId='" + systemUserId + "'");

        try {
            if(resultSet == null || !resultSet.isBeforeFirst()) {
                DBHelper
                        .getInstance()
                        .updateQuery("INSERT INTO QRCodeMatch(md5, StudentId, CertificateId, SystemUserId) VALUES('"
                                + md5 + "', " + studentId + ", " + certificateId + ", " + systemUserId +  ")");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertCourseRegistrationRecord(String md5, int studentId, int courseId, int systemUserId) {
        ResultSet resultSet = DBHelper
                .getInstance()
                .executeQuery("SELECT * FROM QRCodeCourseRegistrationMatch WHERE UserId='"+studentId+"' AND CourseId='"+courseId
                        +"' AND SystemUserId='" + systemUserId + "'");

        try {
            if(resultSet == null || !resultSet.isBeforeFirst()) {
                DBHelper
                        .getInstance()
                        .updateQuery("INSERT INTO QRCodeCourseRegistrationMatch(md5, UserId, CourseId, SystemUserId) VALUES('"
                                + md5 + "', " + studentId + ", " + courseId + ", " + systemUserId +  ")");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public QRCodeInformation getQRCodeInformations(String md5) throws SQLException {
        QRCodeInformation qrCodeInformation = new QRCodeInformation();
        ResultSet resultSet = DBHelper.getInstance().executeQuery("SELECT * FROM QRCodeMatch WHERE md5='"+md5+"'");

        while(resultSet.next()) {
            qrCodeInformation.setMd5(resultSet.getString("md5"));
            qrCodeInformation.setStudentId(resultSet.getInt("StudentId"));
            qrCodeInformation.setCertificateId(resultSet.getInt("CertificateId"));
            qrCodeInformation.setSystemUser(systemUserDao.getSystemUser(resultSet.getInt("SystemUserId")));
        }

        return qrCodeInformation;
    }

    public QRCodeInformation getQRCodeRegistrationInformation(String md5) throws SQLException {
        QRCodeInformation qrCodeInformation = new QRCodeInformation();
        ResultSet resultSet = DBHelper.getInstance().executeQuery("SELECT * FROM QRCodeCourseRegistrationMatch WHERE md5='"+md5+"'");

        while(resultSet.next()) {
            qrCodeInformation.setMd5(resultSet.getString("md5"));
            qrCodeInformation.setStudentId(resultSet.getInt("UserId"));
            qrCodeInformation.setCertificateId(resultSet.getInt("CourseId"));
            qrCodeInformation.setSystemUser(systemUserDao.getSystemUser(resultSet.getInt("SystemUserId")));
        }

        return qrCodeInformation;
    }
}
