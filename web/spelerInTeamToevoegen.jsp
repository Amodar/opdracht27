<%-- cleaned and commented
--%>

<%@page import = "database.TeamOverzicht"%>
<%@page import = "database.Team"%>
<%@page import = "database.Overzicht"%>
<%@page import = "database.Lid"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
//initialiseren, declareren, toewijzingen
    
    //klassen declareren
    Lid lid;
    Overzicht ov;
    Team team;
    TeamOverzicht teamo;

    //constructors oproepen
    ov = new Overzicht();
    lid = new Lid();
    team = new Team();
    teamo = new TeamOverzicht();

    //variabelen declareren en initialiseren
    int fout = 0;
    int aantalLeden = 0;
    int aantalTeams = 0;
    String toevoegenKnop = request.getParameter("submit");
    String spelerscode = request.getParameter("speler");
    String teamcode = request.getParameter("team");

//events
    
    //toevoegen functie
    if (toevoegenKnop != null) {
        team.setSpelerscode(spelerscode);
        team.setTeamcode(teamcode);

        if (team.teamspelerToevoegen() == 0) {
            response.sendRedirect(response.encodeURL("teamOverzicht.jsp"));
        } else {
            fout = 1;
        }
    }
    
    /**
     * roep methodes aan
     * Arraylisten worden gevuld met gewenste objecten(spelers, teams)
     * Catch als er geen objecten zijn
     */
    try {
        ov.getStudentsSorted(1);
        teamo.getTeamsSorted(1);
        aantalLeden = ov.getAantalLeden();
        aantalTeams = teamo.getAantalTeams();
    } catch (NullPointerException npe) {
        out.print("error in het ophalen van spelers/teams");
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
                    <p>Voeg
                        <select name="speler">
                            <option value="speler" disabled>speler</option>
                            <%
                                //selectbox is gevuld met alle leden
                                for (int i = 0; i < aantalLeden; i++) {
                                    lid = ov.getLid(i);
                                    out.print("<option value = \"" + lid.getSpelerscode() + "\">"
                                                + lid.getSpelerscode() + " | " + lid.getNaam()
                                            + "</option>");
                                }
                            %>
                        </select>
                        toe, aan
                        <select name="team">
                            <option value="team" disabled>team</option>
                            <%
                                //selectbox is gevuld met alle teams
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
                        <%  //insertquery error
                            if (fout == 1) {
                                out.print("<p>Er is een fout opgetreden bij het toevoegen!</p>");
                            }
                        %>
                    </p>
                </fieldset>
            </form> 
        </div>
    </body>
</html>