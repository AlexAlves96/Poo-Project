<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.SQLException, java.sql.Statement, java.sql.PreparedStatement" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inicialização de Banco de Dados</title>
</head>
<body>
    <%
        try {
            Class.forName("org.sqlite.JDBC");
            Connection connection = DriverManager.getConnection("jdbc:sqlite:login.db");

            // Cria a tabela se ela não existir
            String createTableSQL = "CREATE TABLE IF NOT EXISTS users (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                    "username TEXT NOT NULL," +
                    "password TEXT NOT NULL" +
                    ");";

            Statement createTableStatement = connection.createStatement();
            createTableStatement.execute(createTableSQL);

            // Insere um usuário padrão
            String insertUserSQL = "INSERT INTO users (username, password) VALUES (?, ?)";
            PreparedStatement insertUserStatement = connection.prepareStatement(insertUserSQL);
            insertUserStatement.setString(1, "raziel");
            insertUserStatement.setString(2, "1234");
            insertUserStatement.executeUpdate();

            out.println("Tabela 'users' criada com sucesso e usuário padrão adicionado.");
        } catch (Exception e) {
            out.println("Erro: " + e.getMessage());
        }
    %>
</body>
</html>
