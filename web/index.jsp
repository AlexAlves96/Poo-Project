<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Visualizar Postagens</title>
</head>
<body>
    <jsp:include page="WEB-INF/jspf/header.jspf" />
    <h1>Postagens</h1>
    
    <%
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    
    try {
        Class.forName("org.sqlite.JDBC");
        connection = DriverManager.getConnection("jdbc:sqlite:database.db");
        
        // Consulta para selecionar todos os posts
        statement = connection.prepareStatement("SELECT * FROM posts");
        resultSet = statement.executeQuery();
        
        while (resultSet.next()) {
            String title = resultSet.getString("title");
            String content = resultSet.getString("content");
    %>
            <div>
                <h2><%= title %></h2>
                <p><%= content %></p>
                <%
                if (content != null) {
                %>
                <a href="edit-post.jsp">Editar Post</a>
                <%
                }
                %>
                <hr></hr>
            </div>
    <%
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        response.sendRedirect("/Projeto/errorPage.jsp");
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
    %>
</body>
</html>
