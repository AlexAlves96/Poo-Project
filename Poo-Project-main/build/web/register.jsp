<%-- 
    Document   : register
    Created on : 28 de out. de 2023, 16:43:00
    Author     : Alex
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <div tabindex="-1">
            <form class=" register row g-3" >
                <div class="col-md-6">
                    <label for="inputName4" class="form-label">Nome:</label>
                    <input type="text" class="form-control" id="inputName4">
                </div>
                <div class="col-md-6">
                    <label for="inputLastname4" class="form-label">Sobreome:</label>
                    <input type="text" class="form-control" id="inputLastname4">
                </div>
                <div class="col-12">
                    <label for="inputUsrname" class="form-label">Usuário:</label>
                    <input type="text" class="form-control" id="inputUsrname">
                </div>
                <div class="col-12">
                    <label for="inputPassword4" class="form-label">Senha:</label>
                    <input type="password" class="form-control" id="inputPassword4">
                </div>
                <div class="col-12">
                    <label for="inputConfirmPassword4" class="form-label">Confirmar Senha: </label>
                    <input type="password" class="form-control" id="inputConfirmPassword4">
                </div>   

                <div class="col-12">
                    <button type="submit" class="btn btn-primary">Registrar-se</button><br>
                    <a><a href="login.jsp">Já possui uma conta? Entre aqui</a>
                </div>
            </form>
        </div>
        <%@include file="WEB-INF/jspf/html-body-libs.jspf" %>
    </body>
</html>
