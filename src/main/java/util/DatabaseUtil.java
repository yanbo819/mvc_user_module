package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseUtil {
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mvc_user_module_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    
    static {
        try {
        
            Class.forName(DB_DRIVER);
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError("Failed to load JDBC driver: " + DB_DRIVER);
        }
    }

    public static Connection getConnection() throws SQLException {
      
        Properties connectionProps = new Properties();
        connectionProps.put("user", DB_USER);
        connectionProps.put("password", DB_PASSWORD);
        
        
        connectionProps.put("useSSL", "false");
        connectionProps.put("serverTimezone", "UTC");
        connectionProps.put("useUnicode", "true");
        connectionProps.put("characterEncoding", "UTF-8");
        connectionProps.put("autoReconnect", "true");
        
        return DriverManager.getConnection(DB_URL, connectionProps);
    }
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
               
                System.err.println("Failed to close database connection: " + e.getMessage());
            }
        }
    }
}