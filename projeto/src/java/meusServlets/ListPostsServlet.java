package meusServlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListPostsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // Conecta-se ao banco de dados
            connection = DriverManager.getConnection("jdbc:sqlite:database.db");

            // Cria uma consulta para selecionar todas as postagens
            statement = connection.prepareStatement("SELECT * FROM posts");

            // Executa a consulta
            resultSet = statement.executeQuery();

            // Configura a resposta
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Lista de postagens</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<table>");
            out.println("<tr>");
            out.println("<th>Título</th>");
            out.println("<th>Conteúdo</th>");
            out.println("</tr>");
            while (resultSet.next()) {
                out.println("<tr>");
                out.println("<td>" + resultSet.getString("title") + "</td>");
                out.println("<td>" + resultSet.getString("content") + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
            out.println("</body>");
            out.println("</html>");
        } catch (SQLException e) {
            e.printStackTrace();
            // Lide com exceções adequadamente
        } finally {
            // Fecha a conexão com o banco de dados e os recursos
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
