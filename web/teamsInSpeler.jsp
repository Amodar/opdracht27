<%-- cleaned and commented
--%>
<%@page import = "database.Teamspeler"%>
<%@page import = "database.Lid"%>
<%@page import = "database.TeamOverzicht"%>
<%@page import = "database.Team" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
//initialiseren, declareren, toewijzingen
    
    //klassen declareren
    Team team;
    TeamOverzicht teamo;
    Lid lid;
    
    //constructors oproepen
    lid = new Lid();
    team = new Team();
    teamo = new TeamOverzicht();
    
    //variabelen declareren en initialiseren
    int aantal;
    String spelerscode = request.getParameter("spelerscode");
    
//events
    
    //constructors lid oproepen
    try {
        teamo.getTeamsFromSpeler(spelerscode);
        lid = new Lid(spelerscode);
    } catch(NullPointerException npe) {
        out.print("Geen speler geselecteerd");
    }
%>
<!DOCTYPE html>

<html>
    <head>
        <link rel="stylesheet" href="main.css" type="text/css" media= "screen">
        <script href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" type="text/css">
        <title>Teams in Speler</title>
    </head>
    <body>
        <div class="container-fluid">
<!-- overzicht interface -->
            <h2>Teams in speler</h2>
            <a href="index.jsp">
                <input class="btn btn-default pull-right" type="button" value="Speler overzicht">
            </a>
            <a href="teamOverzicht.jsp">
                <input class="btn btn-default pull-right margin-right" type="button" value="Team overzicht">
            </a>
            <div class="row">
                <div class="col-md-10">
<!-- overzicht -->
                    <h3><%= lid.getSpelerscode() %> | <%= lid.getNaam() %></h3>
                <%
                    if(teamo.getAantalTeams() == 0) {
                        out.print("<p>deze speler bevat geen teams</p>");
                    } else {
                %>
                    <table class="table">
                        <tr class="nohover">
                            <th>
                                Teamcode
                            </th>
                            <th>
                                Team Omschrijving
                            </th>
                        </tr>
                    <%
                        for(aantal = 0; aantal < teamo.getAantalTeams(); aantal++) {
                            team = teamo.getTeam(aantal);
                    %>
                        <tr>
                            <td>
                                <%= team.getTeamcode() %>
                            </td>
                            <td>
                                <%= team.getTeamomschrijving() %>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                    </table>
                <%
                    }
                %>
                </div>
            </div>
        </div>
    </body>
</html>