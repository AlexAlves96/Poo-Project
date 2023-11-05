<%-- 
    Document   : logout
    Created on : 4 de nov. de 2023, 17:30:15
    Author     : Anizawa
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Remove a variável de sessão para indicar que o usuário não está mais autenticado
    session.removeAttribute("userAuthenticated");
%>

<!DOCTYPE html>
<html>
<head>
    <%@include file="WEB-INF/jspf/html-head-libs.jspf" %>
    <meta charset="UTF-8">
    <title>Logout</title>
</head>
<body>
    <%@include file="WEB-INF/jspf/navbar.jspf" %>
    <h1>Você foi desconectado com sucesso.</h1>
</body>
</html>
