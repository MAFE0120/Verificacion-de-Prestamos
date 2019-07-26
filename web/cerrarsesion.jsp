<%-- 
    Document   : cerrarsesion.jsp
    Created on : 24/07/2019, 07:01:29 PM
    Author     : Desarrolladoras
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String contextPath = request.getContextPath();
    response.setHeader("Cache-Control", "no-store,no-cache, must-revalidate");
    response.addHeader("Cache-Control", "post-check=0, pre-check=0");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
    
    request.getSession().invalidate();
    response.sendRedirect("index.jsp");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
    </body>
</html>
