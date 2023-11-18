<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <%@include file="WEB-INF/jspf/html-head-libs.jspf" %>
        <%@include file="WEB-INF/jspf/css.jspf" %>
    </head>
    <body> 
        <jsp:include page="header.jsp" />

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
                    int postId = resultSet.getInt("id");
                    String title = resultSet.getString("title");
                    String content = resultSet.getString("content");
                    String datePublished = resultSet.getString("date_published");
                    String author = resultSet.getString("author");
        %>

        <div class="index-container">
            <div class="index-content">
                <div class="post-title">
                  <h2><%= title %></h2>
                </div>
                <p>Autor: <%= author %></p>
                <p>Data de Publicação: <%= datePublished %></p>
                <p><%= content %></p>
                
                <% if (content != null) { %>
                    <a href="edit-post.jsp?id=<%= postId %>">Editar Post</a>
                <% } %>
                <hr>
            </div>
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

        <%@include file="WEB-INF/jspf/html-body-libs.jspf" %>
    </body>
</html>