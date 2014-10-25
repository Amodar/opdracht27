<%-- 
    Document   : wijzigen
    Created on : Sep 7, 2014, 12:22:51 AM
    Author     : ajay
--%>
<%@page import="database.Lid"%>
<%@page import="database.Overzicht"%>
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
    ov = new Overzicht();
    team = new Team();
    teamo = new TeamOverzicht();
    
    if(request.getParameter("teamcode") != null) {
        team = new Team(request.getParameter("teamcode"));
        ov.getStudentsPerGroup(request.getParameter("teamcode"));
    } else {
        response.sendRedirect("teamOverzicht.jsp");
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
                <h2>Team Overzicht</h2>
                <hr>
                <div class="row">
                    <div class="col-md-10 box">
                        <h3><%= team.getTeamcode() %> | <%= team.getTeamomschrijving() %></h3>
                        <hr>
                        <%
                            if(ov.getAantalLeden() == 0) {
                                out.print("<p>Er zijn geen spelers in: " + team.getTeamomschrijving() + "</p>");
                            }else {
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