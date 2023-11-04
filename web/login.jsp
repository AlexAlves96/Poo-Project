<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Página de Login</title>
    <%@include file="WEB-INF/jspf/html-head-libs.jspf" %>
</head>
<body>
    <%@include file="WEB-INF/jspf/navbar.jspf" %>
    <div class="container">
        <h2>Faça o Login</h2>
        <form method="post">
            <div class="mb-3">
                <label for="inputUsrname" class="form-label">Usuário</label>
                <input type="text" class="form-control" id="inputUsrname" name="username">
            </div>
            <div class="mb-3">
                <label for="inputPassword" class="form-label">Senha</label>
                <input type="password" class="form-control" id="inputPassword" name="password">
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
        </form>

        <% 
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (username != null && password != null) {
                try {
                    Class.forName("org.sqlite.JDBC");
                    Connection connection = DriverManager.getConnection("jdbc:sqlite:login.db");

                    String query = "SELECT * FROM users WHERE username = ? AND password = ?";
                    PreparedStatement statement = connection.prepareStatement(query);
                    statement.setString(1, username);
                    statement.setString(2, password);

                    ResultSet result = statement.executeQuery();

                    if (result.next()) {
                        out.println("Login bem-sucedido!");
                    } else {
                        out.println("Falha no login. Credenciais inválidas.");
                    }

                    connection.close();
                } catch (Exception e) {
                    out.println("Erro: " + e.getMessage());
                }
            }
        %>
    </div>
</body>
</html>
