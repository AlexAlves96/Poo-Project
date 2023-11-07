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

public class ViewPostServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtém o id da postagem a ser visualizada
        int id = Integer.parseInt(request.getParameter("id"));

        Connection connection = null;
        PreparedStatement statement = null;

        try {
            // Conecta-se ao banco de dados
            connection = DriverManager.getConnection("jdbc:sqlite:database.db");

            // Cria uma consulta para selecionar a postagem
            statement = connection.prepareStatement(
                    "SELECT * FROM posts WHERE id = ?");
            statement.setInt(1, id);

            // Executa a consulta
            ResultSet resultSet = statement.executeQuery();

            // Verifica se a postagem existe
            if (!resultSet.next()) {
                response.sendError(404, "Postagem não encontrada");
                return;
            }

            // Obtém os dados da postagem
            String title = resultSet.getString("title");
            String content = resultSet.getString("content");

            // Exibe os dados da postagem na página da web
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Visualizar postagem</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>" + title + "</h1>");
            out.println("<p>" + content + "</p>");
            out.println("</body>");
            out.println("</html>");
        } catch (SQLException e) {
            e.printStackTrace();
            // Lide com exceções adequadamente, por exemplo, redirecionando para uma página de erro
            response.sendError(500, "Erro ao processar a solicitação");
        } finally {
            // Fecha a conexão com o banco de dados e os recursos
            try {
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
