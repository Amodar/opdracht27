<%-- 
    Document   : index
    Created on : Sep 6, 2014, 6:22:14 PM
    Author     : ajay
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "database.*" %>

<%
    Connection con;
    Team team;
    TeamOverzicht teamo;
    
    con = new Connection();
    team = new Team();
    teamo = new TeamOverzicht();
    
    String conmsg;
    int aantal = 0;
    
    if(con.getConnError() == null)
    {
        conmsg = "Connectie successvol";
    }else
    {
        conmsg = "Geen database verbinding";
    }
    
    if(request.getParameter("teamtoevoegen") != null) {
        response.sendRedirect(response.encodeURL("teamToevoegen.jsp"));
        return;
    }
    
    if(request.getParameter("id") != null) {
        team = new Team(request.getParameter("id"));
        team.verwijderen();
    }
    
    if(request.getParameter("submit") != null) {
        if(request.getParameter("input") == "") {
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
        
        <div class="container">
            <h3><i><%= conmsg %></i></h3>

            <form action="index.jsp" method="get">

                <div class="row">
                    <div class="col-xs-3">
                        <div class="input-group">
                            <input type = "text" name = "input" class="form-control">
                            <span class="input-group-btn">
                                <button name = "submit" type="submit" class="btn btn-default" type="button">Zoeken</button>
                            </span>
                        </div>
                    </div>
                </div>

                <%
                if(request.getParameter("input") != null) {
                    teamo.getStudentsSearched(request.getParameter("input"));
                    aantal = teamo.getAantalLeden();

                    out.print("<h2>Resultaat</h2>");

                    if(aantal == 0) {
                        out.print("Geen resultaat");
                    } else {
                %>
                    <table class="table">
                        <tr class="nohover">
                            <th>Teamcode</th>
                            <th>Team Omschrijving</th>
                        </tr>
                        <% 
                        teamo.getStudentsSorted(1);
                        for(int i = 0; i < aantal; i++)
                        {
                            team = teamo.getTeam(i);
                        %>
                            <tr>
                                <td><%= team.getTeamcode() %></td>
                                <td><%= team.getTeamomschrijving() %></td>
                                <!-- button wijzigen -->
                                <th>
                                    <a href="teamWijzigen.jsp?id=<%= team.getTeamcode() %>">
                                        <input type="button" class="btn btn-warning" value="Wijzigen">
                                    </a>
                                </th>
                                <!-- button verwijderen -->               
                                <th>
                                    <a href="index.jsp?id=<%= team.getTeamcode() %>">
                                    <input type="button" class="btn btn-danger" 
                                            onclick="return confirm('Wilt u zeker <%= team.getTeamomschrijving() %> verwijderen?')" 
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
            
        <form action="index.jsp" method="get">
            <div class="container center" style="padding-bottom: 10px;">
                <h2>Overzicht</h2>
                <input class="btn btn-default" type="submit" value="Team toevoegen" name="teamtoevoegen">
            </div>
        
            <div class="container">
                <table class="table">
                        <tr class="nohover">
                            <th>Teamcode</th>
                            <th>Team Omschrijving</th>
                        </tr>
                    <%
                        teamo.getStudentsSorted(1);
                        aantal = teamo.getAantalLeden();

                        for(int i = 0; i < aantal; i++)
                        {
                            team = teamo.getTeam(i);
                    %>
                            <tr>
                                <td><%= team.getTeamcode() %></td>
                                <td><%= team.getTeamomschrijving() %></td>
                                <!-- button wijzigen -->
                                <th>
                                    <a href="teamWijzigen.jsp?id=<%= team.getTeamcode() %>">
                                        <input type="button" class="btn btn-warning" value="Wijzigen">
                                    </a>
                                </th>
                                <!-- button verwijderen -->               
                                <th>
                                    <a href="index.jsp?id=<%= team.getTeamcode() %>">
                                    <input type="button" class="btn btn-danger" 
                                            onclick="return confirm('Wilt u zeker <%= team.getTeamomschrijving() %> verwijderen?')" 
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