<%-- cleaned
--%>
<%@page import="database.Teamspeler"%>
<%@page import= "database.Overzicht"%>
<%@page import= "database.Lid"%>
<%@page import= "database.TeamOverzicht"%>
<%@page import = "database.Team" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Lid lid;
    Overzicht ov;
    Team team;
    TeamOverzicht teamo;
    Teamspeler ts;
    
    lid = new Lid();
    ov = new Overzicht();
    team = new Team();
    teamo = new TeamOverzicht();
    
    int aantal;
    String deleteURL = "";
    String wijzigURL = "";
    String teamcode = request.getParameter("teamcode");
    String spelerscode = request.getParameter("spelerscode");
    
    if(spelerscode != null) {
        ts = new Teamspeler(spelerscode, teamcode);
        
        ts.getSpelerscode();
        ts.getTeamcode();
        
        if (ts.verwijderen() == 0) {
            response.sendRedirect(response.encodeURL("spelersInTeamOverzicht.jsp?teamcode=" + team.getTeamcode()));
        } else {
            out.print("<p>Er is een fout opgetreden bij het verwijderen.</p>");
        }
    }
%>
<!DOCTYPE html>

<html>
    <head>
        <link rel="stylesheet" href="main.css" type="text/css" media= "screen">
        <script href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" type="text/css">
        <title>Team overzicht</title>
    </head>
    
    <body>
        <div class="container">
            <h2>Teamspeler Overzicht</h2>
            <div class="container">
            <a href="teamToevoegen.jsp">
                <input class="btn btn-default"type="button"  value="Team toevoegen">
            </a>
            <a href="spelerInTeamToevoegen.jsp">
                <input class="btn btn-default"type="button"  value="Speler wijzigen">
            </a>
            <a href="teamOverzicht.jsp">
                <input class="btn btn-default pull-right" type="button" value="Team Overzicht">
            </a>
            </div>
            <div class="row">
                <%  
                    teamo.getTeamsSorted(1);

                    for (int i = 0; i < teamo.getAantalTeams(); i++) {
                        team = teamo.getTeam(i);
                        ov.getStudentsPerGroup(team.getTeamcode());
                        out.print("<div class=\"col-lg-12\">");
                        out.print("<div class=\"box\">");
                 
                        
                        if(request.getParameter("toevoegen") != null) {
                            out.print("test");
                        }
                        
                        out.print("<a href=\"teamWijzigen.jsp?id=" + team.getTeamcode() +"\">");
                        out.print("<input class=\"btn btn-default padding\" type=\"button\" value=\"Team wijzigen\">");
                        out.print("</a>");
                        
                        out.print("<h3>" + team.getTeamomschrijving() + "</h3>");

                        if (ov.getAantalLeden() == 0) {
                            out.print("<p>geen spelers</p>");
                        } else {
                %>
                        <table class="table">
                            <tr class="nohover">
                                <th>
                                    Spelerscode
                                </th>
                                <th>
                                    Spelersnummer
                                </th>
                                <th>
                                    Naam
                                </th>
                            </tr>
                    <%
                        for (aantal = 0; aantal < ov.getAantalLeden(); aantal++) {
                                
                            lid = ov.getLid(aantal);

                            deleteURL = "spelersInTeamOverzicht.jsp?teamcode=" + team.getTeamcode() 
                                    + "&spelerscode=" + lid.getSpelerscode();
                            wijzigURL = "teamspelerWijzigen.jsp?teamcode=" + team.getTeamcode() 
                                    + "&spelerscode=" + lid.getSpelerscode();
                    %>
                            <tr>
                                <td>
                                    <%= lid.getSpelerscode()%>
                                </td>
                                <td>
                                    <%= lid.getSpelersnr()%>
                                </td>
                                <td>
                                    <%= lid.getNaam()%>
                                </td>
                                <td>
                                    <a href=<%= wijzigURL %>>
                                        <input type="button" class="btn btn-warning" value="Wijzigen">
                                    </a>
                                </td>
                                <td>
                                    <a href=<%= deleteURL %>>
                                    <input type="button" class="btn btn-danger" name="verwijder"
                                           onclick="return confirm('Wilt u zeker <%= lid.getNaam() %> van <%= team.getTeamomschrijving() %> verwijderen?')" 
                                           value="Verwijder">
                                    </a>
                                </td>
                            </tr>
                <%
                            }
                        }
                        out.print("</table>");
                        out.print("</div>");
                        out.print("</div>");
                    }
                %>
            </div>
        </div>
    </body>
</html>