<%-- cleaned
--%>
<%@page import = "database.Team"%>
<%@page import = "database.TeamOverzicht"%>
<%@page import = "database.Teamspeler"%>
<%@page import = "database.Lid" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
//initialiseren, declareren, toewijzingen
    //klassen declareren
    Lid lid;
    Team team;
    Teamspeler ts;
    TeamOverzicht teamo;
    
    //constructors oproepen
    lid = new Lid();
    team = new Team();
    ts = new Teamspeler();
    teamo = new TeamOverzicht();
    
    //variabelen declareren en initialiseren
    int fout = 0;
    int aantalTeams = 0;
    String wijzigenKnop = request.getParameter("submit");
    String teamcode = request.getParameter("teamcode");
    String spelerscode = request.getParameter("spelerscode");
    
//events
    
    //constructor oproepen en arraylist team genereren
    try {
        lid = new Lid(spelerscode);
        teamo.getTeamsSorted(1);
        aantalTeams = teamo.getAantalTeams();
    } catch (NullPointerException npe) {
        out.print("Something went wrong");
    }
    
    //functie wijzigen
    if(wijzigenKnop != null) {
        ts = new Teamspeler(spelerscode, teamcode);
        ts.setSpelerscode(spelerscode);
        ts.setTeamcode(teamcode);
        
        if (ts.wijzigen() == 0) {
            response.sendRedirect(response.encodeURL("teamOverzicht.jsp"));
        } else {
            out.print("<p>Er is een fout opgetreden bij het wijzigen.</p>");
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
        <div class="container-fluid">
            <h1>Speler in team toevoegen</h1>
            <hr>
            <form action="#" method="get">
                <fieldset>
                    Voeg
                    <select name="spelerscode">
                        <option value="team" disabled>team</option>
                <%
                        out.print("<option value = \"" + lid.getSpelerscode() + "\" >" 
                                        + lid.getNaam() + "</option>");
                %>
                    </select>
                    toe, aan
                    <select name="teamcode">
                        <option value="team" disabled>team</option>
                        <%
                            for (int i = 0; i < aantalTeams; i++) {
                                team = teamo.getTeam(i);
                                out.print("<option value = \"" + team.getTeamcode() + "\" >" 
                                        + team.getTeamcode() + " | " + team.getTeamomschrijving() 
                                        + "</option>");
                            }
                        %>
                    </select>

                    <input type="submit" class="btn btn-success" name="submit" value="submit">
                    <a href="teamOverzicht.jsp">
                        <input type="button" class="btn btn-danger" value="terug">
                    </a>
                <%
                    if (fout == 1) {
                        out.print("<p>Er is een fout opgetreden!</p>");
                    }
                %>
                </fieldset>
            </form> 
        </div>
    </body>
</html>