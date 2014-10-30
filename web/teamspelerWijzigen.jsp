<%-- cleaned
--%>
<%@page import = "database.Team"%>
<%@page import = "database.TeamOverzicht"%>
<%@page import = "database.Teamspeler"%>
<%@page import = "database.Lid" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Lid lid;
    Team team;
    Teamspeler ts;
    TeamOverzicht teamo;
    
    lid = new Lid();
    team = new Team();
    ts = new Teamspeler();
    teamo = new TeamOverzicht();
    
    int fout = 0;
    String wijzigenKnop = request.getParameter("submit");
    String teamcode = request.getParameter("teamcode");
    String spelerscode = request.getParameter("spelerscode");
    
    try {
        lid = new Lid(spelerscode);
    } catch (NullPointerException npe) {
        out.print("Something went wrong");
    }
    
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
                            teamo.getTeamsSorted(1);

                            int aantalTeams = teamo.getAantalTeams();
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