<%-- cleaned and commented
--%>

<%@page import = "database.Overzicht"%>
<%@page import = "database.Lid"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
//initialiseren, declareren, toewijzingen
    
    //klassen declareren
    Lid lid;
    Overzicht ov;
    
    //constructors oproepen
    ov = new Overzicht();
    lid = new Lid();

    //variabelen declareren en initialiseren
    int aantal = 0;
    String spelerscode = request.getParameter("id");
    String zoekopdracht = request.getParameter("input");
    String zoekKnop = request.getParameter("submit");
    
//events
    
    //zoekfunctie voor lege string
    if (zoekKnop != null) {
        if (zoekopdracht == "") {
            response.sendRedirect(response.encodeURL("index.jsp"));
        }
    }
    
    //verwijder functie
    if (spelerscode != null) {
        lid = new Lid(spelerscode);
        lid.verwijderen();
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
<!-- zoek interface -->
        <div class="container-fluid padding-top">
            <form action="index.jsp" method="get">
                <div class="row">
                    <div class="col-md-3">
                        <div class="input-group">
                            <input type = "text" name = "input" class="form-control">
                            <span class="input-group-btn">
                                <input type="submit" class="btn btn-default" name = "submit" value="Zoeken">
                            </span>
                        </div>
                    </div>
                </div>
<!-- zoek overzicht -->
                <%
                    /***
                     * checkt als de zoekopdracht(input) parameter aanwezig is in de adresbal of header
                     * Methode getStudentesSearched() wordt geroepen
                     * Arraylist wordt gevuld met gewenste objecten(spelers)
                     * Aantal objecten wordt berekend met methode getAantalLeden() voor de for loop
                     * print overzicht op het scherm
                     */
                    if (zoekopdracht != null) {
                        ov.getStudentsSearched(zoekopdracht);
                        aantal = ov.getAantalLeden();

                        out.print("<h2>Resultaat</h2>");

                        if (aantal == 0) {
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
                    </tr>
                    <%
                        for (int i = 0; i < aantal; i++) {
                            lid = ov.getLid(i);
                    %>
                    <tr>
                        <td><%= lid.getSpelerscode()%></td>
                        <td><%= lid.getSpelersnr()%></td>
                        <td><a href="teamsInSpeler.jsp?spelerscode=<%= lid.getSpelerscode()%>"><%= lid.getRoepnaam()%></a></td>
                        <td><%= lid.getTussenvoegsels()%></td>
                        <td><%= lid.getAchternaam()%></td>
                        <td><%= lid.getAdres()%></td>
                        <td><%= lid.getPostcode()%></td>
                        <td><%= lid.getWoonplaats()%></td>
                        <td><%= lid.getTelefoon()%></td>
                        <td><%= lid.getGeboortedatum()%></td>
                        <td>
                            <a href="wijzigen.jsp?id=<%= lid.getSpelerscode()%>">
                                <input type="button" class="btn btn-warning" value="Wijzigen">
                            </a>
                        </td>
                        <td>
                            <a href="index.jsp?id=<%= lid.getSpelerscode()%>">
                                <input type="button" class="btn btn-danger" onclick="return confirm('Wilt u zeker <%= lid.getNaam()%> verwijderen?')" value="Verwijder">
                            </a>
                        </td>
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

<!-- navigatie -->
        <form action="index.jsp" method="get">
            <div class="container-fluid">
                <h2>Overzicht</h2>
                <a href="toevoegen.jsp">
                    <input class="btn btn-default" type="button" value="Speler toevoegen">
                </a>
                <a href="teamOverzicht.jsp">
                    <input class="btn btn-default pull-right" type="button" value="Naar team overzicht">
                </a>
            </div>
<!-- overzicht -->
            <div class="container-fluid">

                <p>*Klik op een speler's roepnaam om zijn teams te weergeven.</p>
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
                    </tr>
                    <%
                    /**
                     * roept methode geStudentsSorted() aan
                     * Arraylist wordt gevuld met gewenste objecten(spelers)
                     * Aantal objecten wordt berekend met methode getAantalLeden() voor de for loop
                     * print overzicht op het scherm
                     */
                        ov.getStudentsSorted(1);
                        aantal = ov.getAantalLeden();
                        
                        //overzicht functie
                        for (int i = 0; i < aantal; i++) {
                            lid = ov.getLid(i);
                    %>
                    <tr>
                        <td><%= lid.getSpelerscode()%></td>
                        <td><%= lid.getSpelersnr()%></td>
                        <td><a href="teamsInSpeler.jsp?spelerscode=<%= lid.getSpelerscode()%>"><%= lid.getRoepnaam()%></a></td>
                        <td><%= lid.getTussenvoegsels()%></td>
                        <td><%= lid.getAchternaam()%></td>
                        <td><%= lid.getAdres()%></td>
                        <td><%= lid.getPostcode()%></td>
                        <td><%= lid.getWoonplaats()%></td>
                        <td><%= lid.getTelefoon()%></td>
                        <td><%= lid.getGeboortedatum()%></td>
                        
                        <td>
                            <a href="wijzigen.jsp?id=<%= lid.getSpelerscode()%>">
                                <input type="button" class="btn btn-warning" value="Wijzigen">
                            </a>
                        </td>
                        <td>
                            <a href="index.jsp?id=<%= lid.getSpelerscode()%>">
                                <input type="button" class="btn btn-danger" onclick="return confirm('Wilt u zeker <%= lid.getNaam()%> verwijderen?')" value="Verwijder">
                            </a>
                        </td>

                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>
        </form>
    </body>
</html>