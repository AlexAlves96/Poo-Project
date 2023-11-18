package meusServlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EditPostServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtém o id da postagem a ser editada
        int id = Integer.parseInt(request.getParameter("id"));

        // Obtém os dados do usuário
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        Connection connection = null;
        PreparedStatement statement = null;

        try {
            // Conecta-se ao banco de dados
            connection = DriverManager.getConnection("jdbc:sqlite:database.db");

            // Cria uma consulta para selecionar a postagem a ser editada
            statement = connection.prepareStatement(
                    "SELECT * FROM posts WHERE id = ?");
            statement.setInt(1, id);

            // Executa a consulta
            ResultSet resultSet = statement.executeQuery();

            // Verifica se a postagem existe
            if (!resultSet.next()) {
                response.sendRedirect("/posts");
                return;
            }

            // Atualiza os dados da postagem
            statement = connection.prepareStatement(
                    "UPDATE posts SET title = ?, content = ? WHERE id = ?");
            statement.setString(1, title);
            statement.setString(2, content);
            statement.setInt(3, id);

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
