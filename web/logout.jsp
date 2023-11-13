<%-- 
    Document   : logout
    Created on : 4 de nov. de 2023, 17:30:15
    Author     : Anizawa
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.servlet.ServletException"%>

<%
    // Invalidate the session
    HttpSession currentSession = request.getSession(false);
    if (currentSession != null) {
        currentSession.invalidate();
    }

    // Redirect to the login page
    response.sendRedirect("login.jsp");
%>
