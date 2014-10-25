<%-- 
    Document   : lidInTeamToevoegen
    Created on : Oct 21, 2014, 7:34:00 PM
    Author     : ajay
--%>

<%@page import="database.TeamOverzicht"%>
<%@page import="database.Team"%>
<%@page import="database.Connection"%>
<%@page import="database.Overzicht"%>
<%@page import="database.Lid"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Connection con;
    Lid lid;
    Overzicht ov;

    Team team;
    TeamOverzicht teamo;
    int fout = 0;

    con = new Connection();
    ov = new Overzicht();
    lid = new Lid();
    team = new Team();
    teamo = new TeamOverzicht();

    if (request.getParameter("submit") != null) {
        team.setSpelerscode(request.getParameter("speler"));
        team.setTeamcode(request.getParameter("team"));

        if (team.teamspelerToevoegen() == 0) {
            response.sendRedirect(response.encodeURL("teamOverzicht.jsp"));
        } else {
            fout = 1;
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
        <form action="#" method="get">
            <div style="padding-top: 10px;">
                <fieldset style="background-color: lightgray; border: 10px; padding: 20px;">
                    <p class="text-center">Voeg
                        <select name="speler">
                            <option value="speler" disabled>speler</option>
                            <%
                                ov.getStudentsSorted(1);

                                int aantalLeden = ov.getAantalLeden();
                                for (int i = 0; i < aantalLeden; i++) {
                                    lid = ov.getLid(i);
                                    out.print("<option value = \"" + lid.getSpelerscode() + "\">" + lid.getSpelerscode() + " | " + lid.getNaam() + "</option>");
                                }
                            %>
                        </select>
                        toe, aan
                        <select name="team">
                            <option value="team" disabled>team</option>
                            <%
                                teamo.getTeamsSorted(1);

                                int aantalTeams = teamo.getAantalTeams();
                                for (int i = 0; i < aantalTeams; i++) {
                                    team = teamo.getTeam(i);
                                    out.print("<option value = \"" + team.getTeamcode() + "\" >" + team.getTeamcode() + " | " + team.getTeamomschrijving() + "</option>");
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
                    </p>
                </fieldset>
            </div>
        </form>
    </body>
</html>