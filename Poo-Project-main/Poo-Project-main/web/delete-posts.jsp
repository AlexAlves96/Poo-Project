<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.DriverManager, java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Excluir Todos os Posts</title>
        <%@include file="WEB-INF/jspf/html-head-libs.jspf" %>
        <%@include file="WEB-INF/jspf/css.jspf" %>
        <%@include file="WEB-INF/jspf/scripts.jspf" %>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <h1>Excluir Todos os Posts</h1>

        <%
            Connection connection = null;
            PreparedStatement statement = null;

            try {
                Class.forName("org.sqlite.JDBC");
                connection = DriverManager.getConnection("jdbc:sqlite:database.db");

                if (request.getMethod().equalsIgnoreCase("POST")) {
                    // Exclua todos os posts da tabela
                    statement = connection.prepareStatement("DELETE FROM posts");
                    statement.executeUpdate();
                    response.sendRedirect("/Projeto/index.jsp"); // Redirecione para a página inicial após a exclusão
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

        <div class="container-del-post">
            <div class="box">
                <form class="del-post" action="delete-posts.jsp" method="post">
                    <p>Tem certeza de que deseja excluir todos os posts? Esta ação não pode ser desfeita.</p>
                    <div class="checkbox-container">
                        <input type="checkbox" id="confirmCheckbox" onclick="toggleButton()">
                        <p>Sim, tenho certeza</p>
                    </div><br>  
                    <input type="submit" class="btn btn-primary" value="Excluir Todos os Posts" disabled="disabled" id="deleteButton">
                </form>
            </div>
        </div>
    </body>
    <%@include file="WEB-INF/jspf/html-body-libs.jspf" %>
</html>
