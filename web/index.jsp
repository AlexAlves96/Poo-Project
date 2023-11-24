<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
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
                statement = connection.prepareStatement("SELECT * FROM posts ORDER BY date_published DESC");
                resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    int postId = resultSet.getInt("id");
                    String title = resultSet.getString("title");
                    String content = resultSet.getString("content");
                    String datePublished = resultSet.getString("date_published");
                    String author = resultSet.getString("author");
                    
                    // Obtém o nome do usuário da sessão
                    String sessionUsername = (String) session.getAttribute("username");
        %>

        <div class="index-container">
            <div class="index-content">
                <div class="post-title">
                    <div class="info-post">
                        <p>Autor: <%= author%></p>  
                        <p id="date-post"> Publicado em: <%= datePublished%></p>
                    </div>
                    <h2> <%= title%></h2>
                </div>
                <div class="post-content">
                    <p><%= content%></p> 
                </div>
                <% if (content != null) {%>
                    <a href="view-post.jsp?id=<%= postId%>">Ver Post Completo</a><br>
                    
                    <%-- Verifica se o autor é "raziel" ou se o usuário da sessão é "raziel" antes de mostrar o link "Editar Post" --%>
                    <% if ("raziel".equals(sessionUsername)) { %>
                        <a href="edit-post.jsp?id=<%= postId%>">Editar Post</a>
                    <% } %>
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
        <%@include file="WEB-INF/jspf/scripts.jspf" %>
        <%@include file="WEB-INF/jspf/html-body-libs.jspf" %>
    </body>
</html>
