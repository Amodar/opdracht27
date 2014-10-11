<%-- 
    Document   : index
    Created on : Sep 6, 2014, 6:22:14 PM
    Author     : ajay
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "database.*" %>

<%
    Connection con;
    Lid lid;
    Overzicht ov;
    
    con = new Connection();
    ov = new Overzicht();
    lid = new Lid();
    
    String conmsg;
    int aantal = 0;
    
    if(con.getConnError() == null)
    {
        conmsg = "Connectie successvol";
    }else
    {
        conmsg = "Geen database verbinding";
    }
    
    if(request.getParameter("toevoegen") != null) {
        response.sendRedirect(response.encodeURL("toevoegen.jsp"));
        return;
    }
    if(request.getParameter("teamtoevoegen") != null) {
        response.sendRedirect(response.encodeURL("teamToevoegen.jsp"));
        return;
    }
    if(request.getParameter("teamoverzicht") != null) {
        response.sendRedirect(response.encodeURL("teamOverzicht.jsp"));
        return;
    }
    if(request.getParameter("id") != null) {
        lid = new Lid(request.getParameter("id"));
        lid.verwijderen();
    }
    
    if(request.getParameter("submit") != null) {
        if(request.getParameter("input") == "") {
            response.sendRedirect(response.encodeURL("index.jsp"));
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
                    ov.getStudentsSearched(request.getParameter("input"));
                    aantal = ov.getAantalLeden();

                    out.print("<h2>Resultaat</h2>");

                    if(aantal == 0) {
                        out.print("Geen resultaat");
                    } else {
                %>
                    <table class="table">
                        <tr class="nohover">
                            <th>Spelerscode</th>
                            <th>Spelersnummer</th>
                            <th>Roepnaam</th>
                            <th>Tussenvoegsels</th>
                            <th>Achternaam</th>
                            <th>Adres</th>
                            <th>Postcode</th>
                            <th>Woonplaats</th>
                            <th>Telefoon</th>
                            <th>Geboortedatum</th>
                            <th>Team</th>
                        </tr>
                        <% 
                        for(int i = 0; i < aantal; i++)
                        {
                            lid = ov.getLid(i);
                        %>
                        <tr>
                            <td><%= lid.getSpelerscode() %></td>
                            <td><%= lid.getSpelersnr() %></td>
                            <td><%= lid.getRoepnaam() %></td>
                            <td><%= lid.getTussenvoegsels() %></td>
                            <td><%= lid.getAchternaam() %></td>
                            <td><%= lid.getAdres() %></td>
                            <td><%= lid.getPostcode() %></td>
                            <td><%= lid.getWoonplaats() %></td>
                            <td><%= lid.getTelefoon() %></td>
                            <td><%= lid.getGeboortedatum() %></td>
                            <td>teamnaam</td>
                            <th>
                                <a href="wijzigen.jsp?id=<%= lid.getSpelerscode() %>">
                                    <input type="button" class="btn btn-warning" value="Wijzigen">
                                </a>
                            </th>
                            <th>
                                <a href="index.jsp?id=<%= lid.getSpelerscode() %>">
                                    <input type="button" class="btn btn-danger" onclick="return confirm('Wilt u zeker <%= lid.getNaam() %> verwijderen?')" value="Verwijder">
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
                    <input class="btn btn-default" type="submit" value="Speler toevoegen" name="toevoegen">
                    <input class="btn btn-default" type="submit" value="Team toevoegen" name="teamtoevoegen">
                    <input class="btn btn-default pull-right" type="submit" value="Naar team overzicht" name="teamoverzicht">
            </div>
        
            <div class="container">
                <table class="table">
                    <tr class="nohover">
                        <th>Spelerscode</th>
                        <th>Spelersnummer</th>
                        <th>Roepnaam</th>
                        <th>Tussenvoegsels</th>
                        <th>Achternaam</th>
                        <th>Adres</th>
                        <th>Postcode</th>
                        <th>Woonplaats</th>
                        <th>Telefoon</th>
                        <th>Geboortedatum</th>
                        <th>Team</th>
                    </tr>
                    <%
                        ov.getStudentsSorted(1);
                        aantal = ov.getAantalLeden();

                        for(int i = 0; i < aantal; i++)
                        {
                            lid = ov.getLid(i);
                    %>
                            <tr>
                                <td><%= lid.getSpelerscode() %></td>
                                <td><%= lid.getSpelersnr() %></td>
                                <td><%= lid.getRoepnaam() %></td>
                                <td><%= lid.getTussenvoegsels() %></td>
                                <td><%= lid.getAchternaam() %></td>
                                <td><%= lid.getAdres() %></td>
                                <td><%= lid.getPostcode() %></td>
                                <td><%= lid.getWoonplaats() %></td>
                                <td><%= lid.getTelefoon() %></td>
                                <td><%= lid.getGeboortedatum() %></td>
                                <td>teamnaam</td>
                                <th>
                                    <a href="wijzigen.jsp?id=<%= lid.getSpelerscode() %>">
                                        <input type="button" class="btn btn-warning" value="Wijzigen">
                                    </a>
                                </th>
                                <th>
                                    <a href="index.jsp?id=<%= lid.getSpelerscode() %>">
                                        <input type="button" class="btn btn-danger" onclick="return confirm('Wilt u zeker <%= lid.getNaam() %> verwijderen?')" value="Verwijder">
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