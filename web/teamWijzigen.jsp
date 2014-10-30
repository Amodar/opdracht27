<%-- cleaned and commented
--%>

<%@page import = "database.Team" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
//initialiseren, declareren, toewijzingen
    
    //klassen declareren
    Team team;
    
    //constructors oproepen
    team = new Team();
    
    //variabelen declareren en initialiseren
    int fout = 0;
    String teamcode = request.getParameter("id");
    String wijzigenKnop = request.getParameter("submit");
    String teamOmschrijving = request.getParameter("teamOmschrijving");

//events
    
    //constructors oproepen
    try {
        team = new Team(teamcode);
    } catch (NullPointerException npe) {
        out.print("Something went wrong");
    }
    
    //functie wijzigen
    if (wijzigenKnop != null) {
        team = new Team(teamcode);
        team.setTeamomschrijving(teamOmschrijving);

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
    </head>
    <body>
        <div class="container">
            <div class="col-xs-3">
                <h2>Team wijzigen</h2>
                <%   if (fout == 1) {
                        out.print("<p class = \"error\"> Er is een fout opgetreden bij het toevoegen van gegevens van een lid..!</p>");
                        out.println("       </div>");
                        out.println("   </body>");
                        out.println("</html>");
                        return;
                    }
                %>
                <form action = "teamWijzigen.jsp" method="get">
                    <input type = "hidden" id = "id" name = "id" 
                           value="<%= team.getTeamcode() %>" /> 
                        <label for = "teamcode">Teamcode</label>
                        <input type = "text" id = "teamcode" name = "teamcode" 
                               value = "<%= team.getTeamcode() %>" disabled /><br>

                        <label for = "teamOmschrijving">Team Omschrijving</label>
                        <input type = "text" id = "teamOmschrijving" name = "teamOmschrijving" 
                               value = "<%= team.getTeamomschrijving() %>" autofocus /><br>
                        
                        <a href="teamOverzicht.jsp"><input class="btn btn-danger pull-right" type = "button" name = "terug" value = "Terug" /></a>
                        <input class="btn btn-success pull-right" type = "submit" name = "submit" value="Verzenden" />
                </form>
            </div>
        </div>
    </body>
</html>