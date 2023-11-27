<%@page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.DriverManager, java.sql.SQLException, java.text.SimpleDateFormat, java.util.Date"%>
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
            
            // Obtem a data atual do sistema
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String datePublished = sdf.format(new Date());

            // Recupera o autor da sessão
            String author = (String) session.getAttribute("username");

            statement = connection.prepareStatement("INSERT INTO posts (title, content, date_published, author) VALUES (?, ?, ?, ?)");
            statement.setString(1, title);
            statement.setString(2, content);
            statement.setString(3, datePublished);
            statement.setString(4, author);

            statement.executeUpdate();

            // Redireciona para index.jsp com o novo post
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
        <%@include file="WEB-INF/jspf/navbar.jspf" %>
        <div class="container">
            <div class="row">
                <div class="col-12 d-flex justify-content-center align-items-center">
                    <div class="caixa">
                        <form class="post-form" action="add-post.jsp" method="POST">
                            <label class="form-label">Titulo:</label>
                            <input class="form-control" type="text" name="title" id="title" required><br>
                            <label class="form-label" for="content">Conteúdo:</label>
                            <textarea class="form-control" name="content" id="content" rows="4" required style="resize: none"></textarea><br>                        
                            <input class="btn btn-primary" id="btn-add-post" type="submit" value="Adicionar Postagem">
                        </form>
                        <p id="date-post"></p>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="WEB-INF/jspf/footer.jspf" %>
        <%@include file="WEB-INF/jspf/scripts.jspf" %>
        <%@include file="WEB-INF/jspf/html-body-libs.jspf" %>
    </body>
</html>
