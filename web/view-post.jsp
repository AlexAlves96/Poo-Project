<%-- 
    Document   : view-post
    Created on : 24 de out. de 2023, 19:25:56
    Author     : Anizawa
--%>

<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <%@include file="WEB-INF/jspf/html-head-libs.jspf" %>
    <%@include file="WEB-INF/jspf/css.jspf" %>
    <style>
        body {
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }

        .post-container {
            width: 100%;
            max-width: 800px; /* Ajuste conforme necessário */
            margin: 20px auto; /* Centraliza o conteúdo */
            padding: 10px;
            box-sizing: border-box;
            text-align: left;
        }

        .post-content {
            text-align: left;
        }
    </style>
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

            // Adiciona a lógica para criar a tabela se ela não existir
            String createTableQuery = "CREATE TABLE IF NOT EXISTS posts (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, date_published TEXT, author TEXT)";
            statement = connection.prepareStatement(createTableQuery);
            statement.execute();

            // Obtém o ID do post da consulta de parâmetros
            int postId = Integer.parseInt(request.getParameter("id"));

            // Consulta para selecionar um post específico pelo ID
            statement = connection.prepareStatement("SELECT * FROM posts WHERE id = ?");
            statement.setInt(1, postId);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String title = resultSet.getString("title");
                String content = resultSet.getString("content");
                String datePublished = resultSet.getString("date_published");
                String author = resultSet.getString("author");
    %>

    <div class="post-container">
        <div class="post-content">
            <div class="info-post">
                <p>Autor: <%= author%></p>
                <p id="date-post"> Publicado em: <%= datePublished%></p>
            </div>
            <h2> <%= title%></h2>
            <p><%= content%></p>
        </div>
    </div>

    <%
        } else {
            // Caso não encontre o post com o ID especificado
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

    <%@include file="WEB-INF/jspf/scripts.jspf" %>
    <%@include file="WEB-INF/jspf/html-body-libs.jspf" %>
</body>
</html>
