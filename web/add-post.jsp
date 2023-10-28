<%@page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.DriverManager, java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Adicionar Postagem</title>
</head>
<body>
    <h1>Adicionar uma nova postagem</h1>
    
    <%
    Connection connection = null;
    PreparedStatement statement = null;
    
    try {
        Class.forName("org.sqlite.JDBC");
        connection = DriverManager.getConnection("jdbc:sqlite:database.db");
        
        // Verifica se a tabela "posts" existe; caso contrário, cria-a
        statement = connection.prepareStatement("CREATE TABLE IF NOT EXISTS posts (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT)");
        statement.executeUpdate();
        
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            
            statement = connection.prepareStatement("INSERT INTO posts (title, content) VALUES (?, ?)");
            statement.setString(1, title);
            statement.setString(2, content);
            statement.executeUpdate();
            response.sendRedirect("/Projeto/index.jsp");
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
    
    <form action="add-post.jsp" method="post">
        <label for="title">Título:</label>
        <input type="text" name="title" id="title" required><br>
        
        <label for "content">Conteúdo:</label>
        <textarea name="content" id="content" rows="4" required></textarea><br>
        
        <input type="submit" value="Adicionar Postagem">
    </form>
</body>
</html>
