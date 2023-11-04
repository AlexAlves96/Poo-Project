<%-- 
    Document   : view-post
    Created on : 24 de out. de 2023, 19:25:56
    Author     : Anizawa
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="minhasClasses.PostDataBean" %>
<%@ page import="minhasClasses.Post" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Visualizar postagem</title>
</head>
<body>
    <h1>Visualizar postagem</h1>

    <%
        int id = Integer.parseInt(request.getParameter("id"));
        PostDataBean dataBean = new PostDataBean();
        Post post = dataBean.getPostById(id);

        if (post != null) {
    %>

    <h2><%= post.getTitle() %></h2>
    <p><%= post.getContent() %></p>

    <%
        } else {
            response.sendError(404, "Postagem não encontrada");
        }
    %>

</body>
</html>
