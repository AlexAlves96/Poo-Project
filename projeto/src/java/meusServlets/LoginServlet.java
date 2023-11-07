/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package meusServlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null && password != null) {
            try {
                Class.forName("org.sqlite.JDBC");
                Connection connection = DriverManager.getConnection("jdbc:sqlite:login.db");

                String query = "SELECT * FROM users WHERE username = ? AND password = ?";
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, username);
                statement.setString(2, password);

                ResultSet result = statement.executeQuery();

                if (result.next()) {
                    // Redirecionar para a página "index.jsp" após um login bem-sucedido
                    response.sendRedirect("index.jsp");
                } else {
                    // Caso contrário, redirecionar de volta para a página de login com uma mensagem de erro
                    response.sendRedirect("login.jsp?error=1");
                }

                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
                // Trate o erro apropriadamente
            }
        }
    }
}
