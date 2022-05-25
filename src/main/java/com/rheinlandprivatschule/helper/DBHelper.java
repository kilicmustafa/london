package com.rheinlandprivatschule.helper;


import java.sql.*;

public class DBHelper {

    private static DBHelper dbHelper = null;
    private Connection connection;

    private final String dbName = "rps_db";
    private final String dbUserName = "root";
    private final String dbPassword = "";
    private final String connectionString = "jdbc:mysql://localhost:3306/" + dbName + "?user=" + dbUserName + "&password=" + dbPassword +
            "&useUnicode=true&characterEncoding=UTF-8&autoReconnect=true";

    private DBHelper() {
        try {
            Class.forName("org.gjt.mm.mysql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return;
        }
        try {
            connection = DriverManager.getConnection("jdbc:mysql://85.214.120.230/rps_db_2014_04_29?autoReconnect=true&characterEncoding=UTF-8",
                "megaliu", "Z770?dbb");
//            connection = DriverManager.getConnection("jdbc:mysql://localhost/rps_db?autoReconnect=true&characterEncoding=UTF-8",
//                    "root", "");
            //         connection = DriverManager.getConnection(connectionString);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static DBHelper getInstance() {
        try {
            if (dbHelper == null || dbHelper.connection == null || dbHelper.connection.isClosed()) {
                dbHelper = new DBHelper();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dbHelper;
    }

    public ResultSet executeQuery(String query) {
        getInstance();
        Statement statement;
        ResultSet resultSet;
        try {
            statement = connection.createStatement();
            resultSet = statement.executeQuery(query);
            return resultSet;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public int updateQuery(String query) {
        Statement statement = null;
        int result = -1;
        try {
            statement = connection.createStatement();
            result = statement.executeUpdate(query);
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public int updateQueryGetPrimary(String query) {
        Statement statement = null;
        int result = -1;
        try {
            statement = connection.createStatement();
            result = statement.executeUpdate(query, Statement.RETURN_GENERATED_KEYS);

            ResultSet rs = statement.getGeneratedKeys();
            if (rs.next()){
                result = rs.getInt(1);
            }
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public PreparedStatement getPreparedStatement(String sql) {
        try {
            return connection.prepareStatement(sql);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public PreparedStatement getPreparedStatement(String sql, int request) {
        try {
            return connection.prepareStatement(sql, request);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
