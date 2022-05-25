package com.rheinlandprivatschule.service;

import com.rheinlandprivatschule.helper.DBHelper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class AuthService {

    public int userAuth(String username, String password) {
        DBHelper dbHelper = DBHelper.getInstance();

        int retryCount = 10;

        while(dbHelper == null && retryCount > 0) {
            dbHelper = DBHelper.getInstance();
            retryCount--;
        }

        ResultSet resultSet = DBHelper.getInstance().executeQuery("SELECT userID, userLoginName, userPassword FROM rps_systemuser WHERE userLoginName = \"" + username
                + "\" AND userPassword = \"" + password + "\"");
        try {
            if(resultSet.next()) {
                return resultSet.getInt("userID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
}
