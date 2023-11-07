package minhasClasses;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PostDataBean {
    public List<Post> getAllPosts() {
        List<Post> posts = new ArrayList<>();

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DriverManager.getConnection("jdbc:sqlite:database.db");
            statement = connection.prepareStatement("SELECT * FROM posts");
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Post post = new Post();
                post.setId(resultSet.getInt("id"));
                post.setTitle(resultSet.getString("title"));
                post.setContent(resultSet.getString("content"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Lide com exceções adequadamente, por exemplo, registre o erro ou lance uma exceção personalizada
        } finally {
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

        return posts;
    }
}
