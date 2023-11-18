/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package web;

import java.sql.*;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.sqlite.SQLiteConfig;

/**
 *
 * @author user
 */
public class DatabaseListener implements ServletContextListener {

    public static final String CLASS_NAME = "org.sqlite.JDBC";
    public static final String URL = "jdbc:sqlite:login.db";
    public static Exception exception = null;

    public static Connection getConnection() throws Exception {
        Class.forName(CLASS_NAME);
        Connection connection = null;
        SQLiteConfig config = new SQLiteConfig();
        config.enforceForeignKeys(true);
        connection = DriverManager.getConnection(URL, config.toProperties());
        return connection;

    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            Class.forName(CLASS_NAME);
            Connection con = getConnection();
            Statement stmt = con.createStatement();

            // USUÁRIOS
           stmt.execute("CREATE TABLE IF NOT EXISTS users("
                    + "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                    + "nome TEXT NOT NULL,"
                    + "sobrenome TEXT NOT NULL,"
                    + "username TEXT NOT NULL UNIQUE,"
                    + "password TEXT NOT NULL)");
            stmt.execute("INSERT OR IGNORE INTO users VALUES(1,'Fulano', 'do Silvo', 'FS', '123')");          
        } catch (Exception ex) {
            exception = ex;
        }
    }
}
