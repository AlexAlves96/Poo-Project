<%-- 
    Document   : edit-post
    Created on : 24 de out. de 2023, 19:24:48
    Author     : Anizawa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Postagem</title>
</head>
<body>
    <h1>Editar Postagem</h1>

    <%
        // Obtém os parâmetros da postagem a ser editada
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
    %>

    <form action="EditPostServlet" method="post">
        <input type="hidden" name="id" value="<%= id %>">
        Título: <input type="text" name="title" value="<%= title %>"><br>
        Conteúdo: <textarea name="content"><%= content %></textarea><br>
        <input type="submit" value="Salvar Alterações">
    </form>

    <p><a href="view-post.jsp?id=<%= id %>">Cancelar e voltar para a postagem</a></p>
</body>
</html>