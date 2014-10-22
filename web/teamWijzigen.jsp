<%-- 
    Document   : wijzigen
    Created on : Sep 7, 2014, 12:22:51 AM
    Author     : ajay
--%>
<%@page import = "database.Team" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Team team;
    int fout = 0;

    if (request.getParameter("terug") != null) {
        response.sendRedirect(response.encodeURL("teamOverzicht.jsp"));
        return;
    }
    if (request.getParameter("submit") == null) {
        team = new Team(request.getParameter("id"));
    } else {
        team = new Team(request.getParameter("teamcode"));
        team.setTeamomschrijving(request.getParameter("teamOmschrijving"));

        if (team.wijzigen() == 0) {
            response.sendRedirect(response.encodeURL("teamOverzicht.jsp"));
        } else {
            fout = 1;
        }
    }
%>
<!DOCTYPE html>

<html>
    <head>
        <link rel="stylesheet" href="main.css" type="text/css" media= "screen">
        <script href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" type="text/css">
        <title>Gegevens team wijzigen</title>

        <style>
            label{
                width: 110px;
            }
        </style>

    </head>
    <body>
        <div class="container">
            <div class="col-xs-3">
                <h2>Gegevens team wijzigen</h2>
                <%   if (fout == 1) {
                        out.print("<p class = \"error\"> Er is een fout opgetreden bij het toevoegen van gegevens van een lid..!</p>");
                        out.println("       </div>");
                        out.println("   </body>");
                        out.println("</html>");
                        return;
                    }
                %>
                <form action = "teamWijzigen.jsp" method="post">
                    <input type = "hidden" id = "spelerscode" name = "teamcode" 
                           value="<%= team.getTeamcode() %>" /> 

                    <fieldset>
                        <legend>Gegevens team</legend>
                        <label for = "teamcode">Teamcode</label>
                        <input type = "text" id = "teamcode" name = "teamcode" 
                               value = "<%= team.getTeamcode() %>" autofocus /><br>

                        <label for = "teamOmschrijving">Team Omschrijving</label>
                        <input type = "text" id = "teamOmschrijving" name = "teamOmschrijving" 
                               value = "<%= team.getTeamomschrijving() %>" /><br>
                        
                        <input class="btn btn-success pull-right" type = "submit" name = "submit" value="Verzenden" />
                        <input class="btn btn-danger pull-right" type = "submit" name = "terug" value = "Terug" />
                    </fieldset>
                </form>
            </div>
        </div>
    </body>
</html>