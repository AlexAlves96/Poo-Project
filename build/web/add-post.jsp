<%@page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.DriverManager, java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Lógica Java para manipulação do banco de dados aqui
    Connection connection = null;
    PreparedStatement statement = null;

    try {
        Class.forName("org.sqlite.JDBC");
        connection = DriverManager.getConnection("jdbc:sqlite:database.db");

        // Verifica se a tabela "posts" existe; caso contrário, cria-a
        statement = connection.prepareStatement("CREATE TABLE IF NOT EXISTS posts (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, date_published TEXT, author TEXT)");
        statement.executeUpdate();

        if (request.getMethod().equalsIgnoreCase("POST")) {
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String datePublished = request.getParameter("date_published");
            String author = request.getParameter("author");

            statement = connection.prepareStatement("INSERT INTO posts (title, content, date_published, author) VALUES (?, ?, ?, ?)");
            statement.setString(1, title);
            statement.setString(2, content);
            statement.setString(3, datePublished);
            statement.setString(4, author);
            
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

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Adicionar Postagem</title>
        <%@include file="WEB-INF/jspf/html-head-libs.jspf" %>
        <%@include file="WEB-INF/jspf/css.jspf" %>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div class="container">
            <div class="row">
                <div class="col-12 d-flex justify-content-center align-items-center">
                    <div class="caixa">
                        <form class="post-form" action="add-post.jsp" method="POST">
                            <label class="form-label">Titulo:</label>
                             <input class="form-control" type="text" name="title" id="title" required><br>
                            <label class="form-label" for="content">Conteúdo:</label>
                            <textarea class="form-control" name="content" id="content" rows="4" required style="resize: none"></textarea><br>
                            <label class="form-label" for="date_published">Data de Publicação:</label>
                            <input class="form-control" type="text" name="date_published" id="date_published" required><br>
                            <label class="form-label" for="author">Autor:</label>
                            <input class="form-control" type="text" name="author" id="author" required><br>
                            <input class="btn btn-primary" type="submit" value="Adicionar Postagem">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="WEB-INF/jspf/html-body-libs.jspf" %>
    </body>
</html>
