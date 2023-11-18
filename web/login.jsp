<%-- 
    Document   : login
    Created on : 28 de out. de 2023, 16:42:01
    Author     : Alex
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

<!DOCTYPE html>
<html>
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
                <form class="row g-3" method="post" action="LoginServlet">
                    <div class="col-12">
                        <label for="inputUsrname" class="form-label">Usuário</label>
                        <input type="text" class="form-control" id="inputUsrname" name="username">
                    </div>
                    <div class="col-12">
                        <label for="inputPassword4" class="form-label">Senha</label>
                        <input type="password" class="form-control" id="inputPassword4" name="password">
                    </div>
                    <div class="col-12">
                        <button type="submit" class="btn btn-primary">Login</button><br>
                        <a href="register.jsp">Não tem uma conta? Registre-se</a>
                    </div>
                </form>
            </div>
        </div>

        <%@include file="WEB-INF/jspf/html-body-libs.jspf" %>
    </body>
</html>