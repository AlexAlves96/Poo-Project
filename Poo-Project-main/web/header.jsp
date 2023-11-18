<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Add your CSS links or styles here -->
    <title>TecBlog</title>
</head>
<body>

<%
    // Check if the user is logged in
    String username = (String) session.getAttribute("username");
    boolean isLoggedIn = (username != null && !username.isEmpty());
%>

<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp"> TecBlog </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 <% if (isLoggedIn) { %> ml-auto <% } %>">
                <li class="nav-item">
                    <% if (isLoggedIn) { %>
                        <a class="nav-link" href="logout.jsp">Logout</a>
                    <% } else { %>
                        <a class="nav-link" href="login.jsp">Login</a>
                    <% } %>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="register.jsp">Registro</a>
                </li>
                <% if (isLoggedIn) { %>
                    <li class="nav-item">
                        <a class="nav-link" href="add-post.jsp">Adicionar Posts</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="delete-posts.jsp">Remover todos os posts</a>
                    </li>
                <% } %>
            </ul>
        </div>
        <hr>
    </div>
</nav>

<!-- Add your JSP content here -->

</body>
</html>
