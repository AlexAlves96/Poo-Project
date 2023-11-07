<%@page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.DriverManager, java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Postagem</title>
</head>
<body>
    <h1>Editar Postagem</h1>
    
    <%
    Connection connection = null;
    PreparedStatement statement = null;
    
    try {
        Class.forName("org.sqlite.JDBC");
        connection = DriverManager.getConnection("jdbc:sqlite:database.db");
        
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String postId = request.getParameter("id");
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            
            statement = connection.prepareStatement("UPDATE posts SET title = ?, content = ? WHERE id = ?");
            statement.setString(1, title);
            statement.setString(2, content);
            statement.setInt(3, Integer.parseInt(postId));
            statement.executeUpdate();
            
            response.sendRedirect("/Projeto/index.jsp"); // Redirecionar para a página principal após a atualização
        } else {
            String postId = request.getParameter("id"); // Assuming you pass the post ID as a parameter
        
            // Recuperando os dados da postagem com o ID fornecido
            if (postId != null) {
                statement = connection.prepareStatement("SELECT * FROM posts WHERE id = ?");
                statement.setInt(1, Integer.parseInt(postId));
                ResultSet resultSet = statement.executeQuery();
                
                if (resultSet.next()) {
                    // Recuperando os valores da postagem para exibição no formulário de edição
                    String title = resultSet.getString("title");
                    String content = resultSet.getString("content");
    %>
                    <form action="edit-post.jsp" method="post">
                        <input type="hidden" name="id" value="<%= postId %>">
                        
                        <label for="title">Título:</label>
                        <input type="text" name="title" id="title" value="<%= title %>" required><br>
            
                        <label for="content">Conteúdo:</label>
                        <textarea name="content" id="content" rows="4" required><%= content %></textarea><br>
            
                        <input type="submit" value="Atualizar Postagem">
                    </form>
    <%
                } else {
                    out.println("Postagem não encontrada");
                }
            } else {
                out.println("ID da postagem não fornecido para edição");
            }
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        response.sendRedirect("/Projeto/errorPage.jsp");
    } finally {
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
    %>
</body>
</html>
