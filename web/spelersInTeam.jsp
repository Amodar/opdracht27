<%-- 
    Document   : wijzigen
    Created on : Sep 7, 2014, 12:22:51 AM
    Author     : ajay
--%>
<%@page import="database.Teamspeler"%>
<%@page import="database.Lid"%>
<%@page import="database.Overzicht"%>
<%@page import="database.TeamOverzicht"%>
<%@page import="database.Team" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Team team;
    TeamOverzicht teamo;
    Lid lid;
    Overzicht ov;
    Teamspeler ts;
    
    lid = new Lid(); 
    ov = new Overzicht();
    team = new Team();
    teamo = new TeamOverzicht();
    ts = new Teamspeler();
    
    int aantal;
    String deleteURL = "";
    String wijzigURL = "";
    String teamcode = request.getParameter("teamcode");
    String spelerscode = request.getParameter("spelerscode");
    
    if(teamcode != null) {
        team = new Team(teamcode);
        ov.getStudentsPerGroup(teamcode);
    }
    
    if(spelerscode != null) {
        ts = new Teamspeler(spelerscode, teamcode);
        
        ts.getSpelerscode();
        ts.getTeamcode();
        
        if (ts.verwijderen() == 0) {
            response.sendRedirect(response.encodeURL("spelersInTeam.jsp?teamcode=" + team.getTeamcode()));
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
        <title>Gegevens team wijzigen</title>

    </head>
    <body>
        <div class="container-fluid">
                <h2>Team Overzicht</h2>
                <a href="spelerInTeamToevoegen.jsp">
                    <input class="btn btn-default" type="button" value="Speler Toevoegen">
                </a>
                <a href="teamOverzicht.jsp">
                    <input class="btn btn-default pull-right " type="button" value="Team Overzicht">
                </a>
                <div class="row">
                    <div class="col-md-10">
                        <h3><%= team.getTeamcode() %> | <%= team.getTeamomschrijving() %></h3>
                        <%
                            if(ov.getAantalLeden() == 0) {
                                out.print("<p>Er zijn geen spelers in: " + team.getTeamomschrijving() + "</p>");
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
                            for(aantal = 0; aantal < ov.getAantalLeden(); aantal++) {
                                
                                lid = ov.getLid(aantal);
                                
                                deleteURL = "spelersInTeam.jsp?teamcode=" + team.getTeamcode() 
                                        + "&spelerscode=" + lid.getSpelerscode();
                                wijzigURL = "teamspelerWijzigen.jsp?teamcode=" + team.getTeamcode() 
                                        + "&spelerscode=" + lid.getSpelerscode();
                            %>
                            <tr>
                                <td>
                                    <%= lid.getSpelerscode() %>
                                </td>
                                <td>
                                    <%= lid.getSpelersnr() %>
                                </td>
                                <td>
                                    <%= lid.getNaam() %>
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