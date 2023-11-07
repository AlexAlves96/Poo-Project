package meusServlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeletePostServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtém o id da postagem a ser excluída
        int id = Integer.parseInt(request.getParameter("id"));

        Connection connection = null;
        PreparedStatement statement = null;

        try {
            // Conecta-se ao banco de dados
            connection = DriverManager.getConnection("jdbc:sqlite:database.db");

            // Cria uma consulta para excluir a postagem
            statement = connection.prepareStatement(
                    "DELETE FROM posts WHERE id = ?");
            statement.setInt(1, id);

            // Executa a consulta
            statement.executeUpdate();

            // Redireciona o usuário para a página de listagem de postagens
            response.sendRedirect("/posts");
        } catch (SQLException e) {
            e.printStackTrace();
            // Lide com exceções adequadamente, por exemplo, redirecionando para uma página de erro
            response.sendRedirect("/errorPage");
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
