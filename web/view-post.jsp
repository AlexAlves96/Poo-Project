<%-- 
    Document   : view-post
    Created on : 24 de out. de 2023, 19:25:56
    Author     : Anizawa
--%>

<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <%@include file="WEB-INF/jspf/html-head-libs.jspf" %>
    <%@include file="WEB-INF/jspf/css.jspf" %>
</head>
<body>
    <%@include file="WEB-INF/jspf/navbar.jspf" %>
    <% 
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("org.sqlite.JDBC");
            connection = DriverManager.getConnection("jdbc:sqlite:database.db");

            String createTableQuery = "CREATE TABLE IF NOT EXISTS posts (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, date_published TEXT, author TEXT)";
            statement = connection.prepareStatement(createTableQuery);
            statement.execute();

            int postId = Integer.parseInt(request.getParameter("id"));

            statement = connection.prepareStatement("SELECT * FROM posts WHERE id = ?");
            statement.setInt(1, postId);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String title = resultSet.getString("title");
                String content = resultSet.getString("content");
                String datePublished = resultSet.getString("date_published");
                String author = resultSet.getString("author");
    %>

    <div class="view-post-container">
        <div class="post-content">
            <div class="info-post">
                <p class="view-post">Autor: <%= author%></p>
                <p class="view-post" id="date-post"> Publicado em: <%= datePublished%></p>
            </div>
            <div class="view-post-tittle">
               <h2 class="view-post"> <%= title%></h2> 
            </div>       
            <hr>
            <p class="view-post"><%= content%></p>
        </div>
    </div>

        
    

    <% 
        } else {
            out.println("Post não encontrado.");
        }
    } catch (SQLException | ClassNotFoundException | NumberFormatException e) {
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
    
    <%@include file="WEB-INF/jspf/footer.jspf" %>
    <%@include file="WEB-INF/jspf/scripts.jspf" %>
    <%@include file="WEB-INF/jspf/html-body-libs.jspf" %>
</body>
</html>
