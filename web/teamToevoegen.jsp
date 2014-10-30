<%-- cleaned
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "database.Team;"%>

<%
    Team team;
    
    int fout = 0;
    String toevoegenKnop = request.getParameter("submit");
    String teamcode = request.getParameter("teamcode");
    String teamOmschrijving = request.getParameter("teamomschrijving");
    
    if(toevoegenKnop != null) {
        team = new Team();
        team.setTeamcode(teamcode);
        team.setTeamomschrijving(teamOmschrijving);

        if(team.toevoegen() == 0) {
            response.sendRedirect(response.encodeURL("teamOverzicht.jsp"));
        }
        else {
            fout = 1;
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "shortcut icon" href = "images/kitten1.ico">
        <script href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="main.css" type="text/css" media= "screen">
        <title>Gegevens team toevoegen</title>
    </head>
    <body>
        <div class="container">
        <%   
            if(fout == 1) {
                out.print("<p class = \"error\"> Er is een fout opgetreden bij het toevoegen van gegevens van een team..!</p>");
                out.println("       </div>");
                out.println("   </body>");
                out.println("</html>");
                return;
            }
        %>
        <h1>Team toevoegen</h1>
        
        <form action="teamToevoegen.jsp" method="get">
            <label for="teamcode">teamcode</label>
            <input type="text" name="teamcode" id="teamcode">
            <label for="teamomschrijving">team omschrijving</label>
            <input type="text" name="teamomschrijving" id="teamomschrijving">
            <br />
            <a href="teamOverzicht.jsp"><input class="btn btn-danger" type = "button" name = "terug" value = "Terug" /></a>
            <input class="btn btn-success" type = "submit" name = "submit" value="Verzenden" />
        </form>
        </div>
    </body>
</html>