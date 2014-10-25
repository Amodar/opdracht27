<%-- 
    Document   : wijzigen
    Created on : Sep 7, 2014, 12:22:51 AM
    Author     : ajay
--%>
<%@page import="database.Overzicht"%>
<%@page import="database.Lid"%>
<%@page import="database.TeamOverzicht"%>
<%@page import = "database.Team" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Team team;
    TeamOverzicht teamo;
    Lid lid;
    Overzicht ov;
    int fout = 0;
    int aantal;

    lid = new Lid();
    team = new Team();
    teamo = new TeamOverzicht();

    ov = new Overzicht();
    
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
            <h2>Teamspeler Overzicht</h2>
            <hr>
            <div class="row">
                <%                    
                    teamo.getTeamsSorted(1);

                    for (int i = 0; i < teamo.getAantalTeams(); i++) {
                        team = teamo.getTeam(i);
                        ov.getStudentsPerGroup(team.getTeamcode());
                        out.print("<div class=\"col-sm-5 box\">");
                        out.print("<h3>"+ team.getTeamomschrijving() +"</h3>");
                        
                        
                        if(ov.getAantalLeden() == 0) {
                            out.print("<p>geen spelers</p>");
                        }else{
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
                    </tr>
                    <%
                        }
                        }
                    %>
                </table>
            </div>

            <%
                }
            %>
        </div>
    </div>
</body>
</html>