<%-- 
    Document   : teamToevoegen
    Created on : Sep 28, 2014, 12:00:33 PM
    Author     : ajay
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="database.Team;"%>

<%
    Team team;
    
    int fout = 0;
    
    if(request.getParameter("terug") != null) {
        response.sendRedirect(response.encodeURL("index.jsp"));
        return;
    }
    if(request.getParameter("submit") != null) {
        team = new Team();
        team.setTeamcode(request.getParameter("teamcode"));
        team.setTeamomschrijving(request.getParameter("teamomschrijving"));

        if(team.toevoegen() == 0) {
            response.sendRedirect(response.encodeURL("index.jsp"));
        }
        else {
            fout = 1;
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="main.css" type="text/css" media= "screen">
        <title>JSP Page</title>
    </head>
    <body>
        <%   
            if(fout == 1) {
                out.print("<p class = \"error\"> Er is een fout opgetreden bij het toevoegen van gegevens van een team..!</p>");
                out.println("       </div>");
                out.println("   </body>");
                out.println("</html>");
                return;
            }
        %>
        <h1>Team toevoegen</h1>
        <form action="teamToevoegen.jsp" method="get">
            <label for="teamcode">teamcode</label>
            <input type="text" name="teamcode" id="teamcode">
            <label for="teamomschrijving">team omschrijving</label>
            <input type="text" name="teamomschrijving" id="teamomschrijving">
            
            <input type = "submit" name = "terug" value = "Terug" />
            <input type = "submit" name = "submit" value="Verzenden" />
        </form>
    </body>
</html>