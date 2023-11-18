<%-- 
    Document   : register
    Created on : 28 de out. de 2023, 16:43:00
    Author     : Alex
--%>
<%@page import="db.User"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    String execao = "";

    try {
        if (request.getParameter("register") != null) {
            String nome = request.getParameter("inputName");
            String sobrenome = request.getParameter("inputLastname");
            String apelido = request.getParameter("inputUsername");
            String senha = request.getParameter("inputPassword");

            User.addUser(nome, sobrenome, apelido, senha);
        }
    } catch (Exception ex) {
        execao = ex.getMessage();
    }

%>

<html>
    <head>
        <title>JSP Page</title>
        <%@include file="WEB-INF/jspf/html-head-libs.jspf" %>
        <%@include file="WEB-INF/jspf/css.jspf" %>
    </head>
    <body>
        <jsp:include page="header.jsp" /> 
        <div tabindex="-1">
            <h1> <% out.print(execao);%></h1>
            <form class=" register row g-3" method="post">
                <div class="col-md-6">
                    <label for="inputName4" class="form-label"> Nome:</label>
                    <input type="text" class="form-control" id="inputName" name="inputName" required>
                </div>
                <div class="col-md-6">
                    <label for="inputLastname4" class="form-label">Sobreome:</label>
                    <input type="text" class="form-control" id="inputLastname" name="inputLastname"required>
                </div>
                <div class="col-12">
                    <label for="inputUsrname" class="form-label">Usuário:</label>
                    <input type="text" class="form-control" id="inputUsername" name="inputUsername" required>
                </div>
                <div class="col-12">
                    <label for="inputPassword4" class="form-label">Senha:</label>
                    <input type="password" class="form-control" id="inputPassword" name="inputPassword" required>
                </div>
                <div class="col-12">
                    <label for="inputConfirmPassword4" class="form-label">Confirmar Senha: </label>
                    <input type="password" class="form-control" id="inputConfirmPassword" name="inputConfirmPassword" required>
                </div>   

                <div class="col-12">
                    <input type="submit" class="btn btn-primary" name="register" value="Registrar-se">
                    <a><a href="login.jsp">Já possui uma conta? Entre aqui</a>
                </div>
            </form>
        </div>
        <%@include file="WEB-INF/jspf/scripts.jspf" %>
        <%@include file="WEB-INF/jspf/html-body-libs.jspf" %>
    </body>
</html>
