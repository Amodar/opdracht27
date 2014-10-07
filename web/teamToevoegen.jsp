<%-- 
    Document   : teamToevoegen
    Created on : Sep 28, 2014, 12:00:33 PM
    Author     : ajay
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="database.*;"%>

<%
    Lid lid;
    Overzicht ov;
    
    lid = new Lid();
    ov = new Overzicht();
    
    
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form action="teamToevoegen.jsp" method="get">
            <legend>Toevoegen</legend>
            <label for="teamcode">teamcode</label>
            <input type="text" name="teamcode" id="teamcode">
            <label for="teamomschrijving">team omschrijving</label>
            <input type="text" name="teamomschrijving" id="teamomschrijving">
            
            <input type="submit" value="Toevoegen">
        </form>
    </body>
</html>