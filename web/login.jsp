<%-- 
    Document   : login
    Created on : 28 de out. de 2023, 16:42:01
    Author     : Alex
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="WEB-INF/jspf/html-head-libs.jspf" %>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/navbar.jspf" %>
     <div >
             <form class="row g-3" >
  <div class="col-12">
    <label for="inputUsrname" class="form-label">Usuário</label>
    <input type="text" class="form-control" id="inputUsrname">
  </div>
     <div class="col-12">
    <label for="inputPassword4" class="form-label">Senha</label>
    <input type="password" class="form-control" id="inputPassword4">
  </div>
 
  <div class="col-12">
    <button type="submit" class="btn btn-primary">Login</button>
  </div>
</form>
        </div>
     
        <%@include file="WEB-INF/jspf/html-body-libs.jspf" %>
    </body>
</html>
