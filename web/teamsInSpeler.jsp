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
    
    lid = new Lid(); 
    ov = new Overzicht();
    team = new Team();
    teamo = new TeamOverzicht();
    
    int aantal;
    String deleteURL = "";
    String wijzigURL = "";
    
    String spelerscode = request.getParameter("spelerscode");
    
    try {
        teamo.getTeamsFromSpeler(spelerscode);
        lid = new Lid(spelerscode);
    }catch(NullPointerException npe) {
        out.print("Geen speler geselecteerd");
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
                <h2>Teams in speler</h2>
                <a href="index.jsp">
                    <input class="btn btn-default pull-right" type="button" value="Speler overzicht">
                </a>
                <a href="teamOverzicht.jsp">
                    <input class="btn btn-default pull-right margin-right" type="button" value="Team overzicht">
                </a>
                <div class="row">
                    <div class="col-md-10">
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
                                    Team omschrijving
                                </th>
                            </tr>
                            
                            
                            <%
                            for(aantal = 0; aantal < teamo.getAantalTeams(); aantal++) {
                                
                                team = teamo.getTeam(aantal);
                                
                                deleteURL = "spelersInTeam.jsp?teamcode=" + team.getTeamcode() 
                                        + "&spelerscode=" + lid.getSpelerscode();
                                wijzigURL = "teamspelerWijzigen.jsp?teamcode=" + team.getTeamcode() 
                                        + "&spelerscode=" + lid.getSpelerscode();
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