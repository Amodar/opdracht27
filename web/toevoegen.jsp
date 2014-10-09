
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "database.Lid"%>
<%
Lid lid;

int fout = 0;
Date date;


if(request.getParameter("terug") != null) {
     response.sendRedirect(response.encodeURL("index.jsp"));
     return;
}
if(request.getParameter("submit") != null) {
    SimpleDateFormat sdf;
    sdf = new SimpleDateFormat("dd-MM-yyyy");
    date = sdf.parse(request.getParameter("geboortedatum"));
    
    lid = new Lid();
    lid.setSpelerscode(request.getParameter("spelerscode"));
    lid.setSpelersnr(request.getParameter("spelersnr"));
    lid.setRoepnaam(request.getParameter("roepnaam"));
    lid.setAchternaam(request.getParameter("achternaam"));
    lid.setTussenvoegsels(request.getParameter("tussenvoegsels"));
    lid.setAdres(request.getParameter("adres"));
    lid.setPostcode(request.getParameter("postcode"));
    lid.setWoonplaats(request.getParameter("woonplaats"));
    lid.setTelefoon(request.getParameter("telefoon"));
    lid.setGeboortedatum(date);
    
    if(lid.toevoegen() == 0) {
        response.sendRedirect(response.encodeURL("index.jsp"));
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
        <link rel="stylesheet" href="pagina.css" type="text/css" media= "screen">
        <title>Gegevens lid toevoegen</title>
    </head>
    <body>
        <h2>Gegevens lid toevoegen</h2>
       <%   if(fout == 1) {
                out.print("<p class = \"error\"> Er is een fout opgetreden bij het toevoegen van gegevens van een lid..!</p>");
                out.println("       </div>");
                out.println("   </body>");
                out.println("</html>");
                return;
            }
        %>
        <form action = "toevoegen.jsp" method="post">
            <fieldset>
                <legend>Gegevens lid</legend>
                <label for = "spelerscode">Spelerscode</label>
                <input type = "text" id = "spelerscode" name = "spelerscode"  /><br>
                <label for = "spelersnr">Spelersnr</label>
                <input type = "text" id = "spelersnr" name = "spelersnr"  /><br>
                <label for = "roepnaam">Roepnaam</label>
                <input type = "text" id = "roepnaam" name = "roepnaam" /><br>
                <label for = "achternaam">Achternaam</label>
                <input type = "text" id = "achternaam" name = "achternaam" /><br>
                <label for = "tussenvoegsels">Tussenvoegsels</label>
                <input type = "text" id = "tussenvoegsels" name = "tussenvoegsels" /><br>
                <label for = "adres">Adres</label>
                <input type = "text" id = "adres" name = "adres" /><br>
                <label for = "postcode">Postcode</label>
                <input type = "text" id = "postcode" name = "postcode" /><br>
                <label for = "woonplaats">Woonplaats</label>
                <input type = "text" id = "woonplaats" name = "woonplaats" /><br>
                <label for = "telefoon">Telefoon</label>
                <input type = "text" id = "telefoon" name = "telefoon" /><br>
                <label for = "geboortedatum">Geboortedatum</label>
                <input type = "date" id = "geboortedatum" name = "geboortedatum" /><br>
                
                <input type = "submit" name = "submit" value="Verzenden" />
                <input type = "submit" name = "terug" value = "Terug" />
            </fieldset>
        </form>
    </body>
</html>