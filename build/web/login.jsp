<%-- 
    Document   : login
    Created on : 28 de out. de 2023, 16:42:01
    Author     : Alex
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="db.User" %>
<%@ page import="java.io.IOException" %>
<!DOCTYPE html>
<html>
    
<%
    if (request.getParameter("login") != null) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            if (User.authenticateUser(username, password)) {
                // Usuário autenticado com sucesso
                // Redirecionamento para página de sucesso ou ação desejada
                response.sendRedirect("add-post.jsp");
            } else {
                // Usuário não autenticado, tratamento de erro ou redirecionamento para página de erro
                <script> 
            }
        } catch (Exception ex) {
            ex.printStackTrace(); // Trate o erro de forma adequada para a sua aplicação
        }
    }
%>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="WEB-INF/jspf/html-head-libs.jspf" %>
        <%@include file="WEB-INF/jspf/css.jspf" %>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div class="form-container">
            <div class="form-box">
                <form class="row g-3" method="post">
                    <div class="col-12">
                        <label for="inputUsrname" class="form-label">Usuário</label>
                        <input type="text" class="form-control" id="inputUsrname" name="username">
                    </div>
                    <div class="col-12">
                        <label for="inputPassword4" class="form-label">Senha</label>
                        <input type="password" class="form-control" id="inputPassword4" name="password">
                    </div>
                    <div class="col-12">
                        <input type="submit" class="btn btn-primary" name="login" value="login"><br>
                        <a href="register.jsp">Não tem uma conta? Registre-se</a>
                    </div>
                </form>
            </div>
        </div>
        
        <%@include file="WEB-INF/jspf/scripts.jspf" %>
        <%@include file="WEB-INF/jspf/html-body-libs.jspf" %>
    </body>
</html>
