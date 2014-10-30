<%-- cleaned and commented
--%>

<%@page import = "database.TeamOverzicht"%>
<%@page import = "database.Team"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
//initialiseren, declareren, toewijzingen
    
    //klassen declareren
    Team team;
    TeamOverzicht teamo;

    //constructors oproepen
    team = new Team();
    teamo = new TeamOverzicht();
    
    //variabelen declareren en initialiseren
    int aantal = 0;
    String teamcode = request.getParameter("id");
    String zoekOpdracht = request.getParameter("input");
    String zoekKnop = request.getParameter("submit");

//events
    
    //remove team
    if (teamcode != null) {
        team = new Team(teamcode);
        team.verwijderen();
    }
    //reset search when input has empty string
    if (zoekKnop != null) {
        if (zoekOpdracht == "") {
            response.sendRedirect(response.encodeURL("teamOverzicht.jsp"));
        }
    }

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="main.css" type="text/css">
        <script href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" type="text/css">
        <title>JSP Page</title>
    </head>
    <body>
<!-- zoek interface -->
        <div class="container-fluid">
            <form action="teamOverzicht.jsp" method="get">

                <div class="row padding-top">
                    <div class="col-xs-3">
                        <div class="input-group">
                            <input type = "text" name = "input" class="form-control">
                            <span class="input-group-btn">
                                <button name = "submit" type="submit" class="btn btn-default" type="button">Zoeken</button>
                            </span>
                        </div>
                    </div>
                </div>
<!-- zoek functie -->
            <% 
                if (zoekKnop != null) {
                    teamo.getTeamsSearched(zoekOpdracht);
                    aantal = teamo.getAantalTeams();

                    out.print("<h2>Resultaat</h2>");

                if (aantal == 0) {
                    out.print("Geen resultaat");
                } else {
            %>
                <table class="table">
                    <tr class="nohover">
                        <th>Teamcode</th>
                        <th>Team Omschrijving</th>
                    </tr>
                    <%
                        for (int i = 0; i < aantal; i++) {
                            team = teamo.getTeam(i);
                    %>
                    <tr>
                        <td><a href="spelersInTeam.jsp?teamcode=<%= team.getTeamcode()%>">
                                <%= team.getTeamcode()%>
                            </a>
                        </td>

                        <td>
                            <a href="spelersInTeam.jsp?teamcode=<%= team.getTeamcode()%>">
                                <%= team.getTeamomschrijving()%>
                            </a>
                        </td>
                        <!-- button wijzigen -->
                        <th>
                            <a href="teamWijzigen.jsp?id=<%= team.getTeamcode()%>">
                                <input type="button" class="btn btn-warning" value="Wijzigen">
                            </a>
                        </th>
                        <!-- button verwijderen -->               
                        <th>
                            <a href="teamOverzicht.jsp?id=<%= team.getTeamcode()%>">
                                <input type="button" class="btn btn-danger" 
                                       onclick="return confirm('Wilt u zeker <%= team.getTeamomschrijving()%> verwijderen?')" 
                                       value="Verwijder">
                            </a>
                        </th>
                    </tr>
                    <%
                        }
                    %>
                </table>
                <%
                        }
                    }
                %>
            </form>
        </div>
<!-- overzicht interface -->
        <form action="teamOverzicht.jsp" method="get">
            <div class="container-fluid center" style="padding-bottom: 10px;">
                <h2>Overzicht</h2>
                <a href="teamToevoegen.jsp">
                    <input class="btn btn-default" type="button" value="Team toevoegen">
                </a>
                <a href="spelerInTeamToevoegen.jsp">
                    <input class="btn btn-default" type="button" value="Speler in team toevoegen">
                </a>

                <a href="index.jsp">
                    <input class="btn btn-default pull-right" type="button" value="Speler overzicht">
                </a>
                <a href="spelersInTeamOverzicht.jsp">
                    <input class="btn btn-default pull-right margin-right" type="button" value="Spelers in Team Overzicht">
                </a>
            </div>
<!-- overzicht -->
            <div class="container-fluid">
                <table class="table">
                    <tr class="nohover">
                        <th>Teamcode</th>
                        <th>Team Omschrijving</th>
                    </tr>
                    <%
                        teamo.getTeamsSorted(1);
                        aantal = teamo.getAantalTeams();

                        for (int i = 0; i < aantal; i++) {
                            team = teamo.getTeam(i);
                    %>
                    <tr>
                        <td><a href="spelersInTeam.jsp?teamcode=<%= team.getTeamcode()%>">
                                <%= team.getTeamcode()%>
                            </a>
                        </td>

                        <td>
                            <a href="spelersInTeam.jsp?teamcode=<%= team.getTeamcode()%>">
                                <%= team.getTeamomschrijving()%>
                            </a>
                        </td>

                        <!-- button wijzigen -->
                        <th>
                            <a href="teamWijzigen.jsp?id=<%= team.getTeamcode()%>">
                                <input type="button" class="btn btn-warning" value="Wijzigen">
                            </a>
                        </th>
                        <!-- button verwijderen -->               
                        <th>
                            <a href="teamOverzicht.jsp?id=<%= team.getTeamcode()%>">
                                <input type="button" class="btn btn-danger" 
                                       onclick="return confirm('Wilt u zeker <%= team.getTeamomschrijving()%> verwijderen?')" 
                                       value="Verwijder">
                            </a>
                        </th>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>
        </form>
    </body>
</html>