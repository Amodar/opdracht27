<%-- 
    Document   : wijzigen
    Created on : Sep 7, 2014, 12:22:51 AM
    Author     : ajay
--%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import = "database.Lid" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Lid lid;
    Date date;
    int fout = 0;
    
    if(request.getParameter("terug") != null) {
         response.sendRedirect(response.encodeURL("index.jsp"));
         return;
    }
    if(request.getParameter("submit") == null) {
        lid = new Lid(request.getParameter("id"));
    }
    else {
        SimpleDateFormat sdf;
        sdf = new SimpleDateFormat("dd-MM-yyyy");
        date = sdf.parse(request.getParameter("geboortedatum"));
        
        lid = new Lid(request.getParameter("spelerscode"));
        lid.setSpelersnr(request.getParameter("spelersnr"));
        lid.setRoepnaam(request.getParameter("roepnaam"));
        lid.setTussenvoegsels(request.getParameter("tussenvoegsels"));
        lid.setAchternaam(request.getParameter("achternaam"));
        lid.setAdres(request.getParameter("adres"));
        lid.setPostcode(request.getParameter("postcode"));
        lid.setWoonplaats(request.getParameter("woonplaats"));
        lid.setTelefoon(request.getParameter("telefoon"));
        lid.setGeboortedatum(date);

        if(lid.wijzigen() == 0) {
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
        <link rel = "shortcut icon" href = "images/kitten1.ico">
        <link rel="stylesheet" href="pagina.css" type="text/css" media= "screen">
        <title>Gegevens lid toevoegen</title>
    </head>
    <body>
      <div id = "wrapper">
        <h2>Gegevens lid toevoegen</h2>
       <%   if(fout == 1) {
                out.print("<p class = \"error\"> Er is een fout opgetreden bij het toevoegen van gegevens van een lid..!</p>");
                out.println("       </div>");
                out.println("   </body>");
                out.println("</html>");
                return;
            }
        %>
        <form action = "wijzigen.jsp" method="post">
            <input type = "hidden" id = "spelerscode" name = "spelerscode" 
                   value="<%= lid.getSpelerscode() %>" /> 
            
            <fieldset>
                <legend>Gegevens lid</legend>
                <label for = "spelerscode">Spelerscode: <%= lid.getSpelerscode() %></label><br>
                
                <label for = "spelersnr">Spelersnr</label>
                <input type = "text" id = "spelersnr" name = "spelersnr" 
                       value = "<%= lid.getSpelersnr() %>" /><br>
                
                <label for = "roepnaam">Roepnaam</label>
                <input type = "text" id = "roepnaam" name = "roepnaam" 
                       value = "<%= lid.getRoepnaam() %>" /><br>
                
                <label for = "tussenvoegsels">Tussenvoegsels</label>
                <input type = "text" id = "tussenvoegsels" name = "tussenvoegsels" 
                       value = "<%= lid.getTussenvoegsels() %>" /><br>
                
                <label for = "achternaam">Achternaam</label>
                <input type = "text" id = "achternaam" name = "achternaam" 
                       value = "<%= lid.getAchternaam() %>" /><br>
                
                <label for = "adres">Adres</label>
                <input type = "text" id = "adres" name = "adres" 
                       value = "<%= lid.getAdres() %>" /><br>
                
                <label for = "postcode">Postcode</label>
                <input type = "text" id = "postcode" name = "postcode" 
                       value = "<%= lid.getPostcode() %>" /><br>
                
                <label for = "woonplaats">Woonplaats</label>
                <input type = "text" id = "woonplaats" name = "woonplaats" 
                       value = "<%= lid.getWoonplaats() %>" /><br>
                
                <label for = "telefoon">Telefoon</label>
                <input type = "text" id = "telefoon" name = "telefoon" 
                       value = "<%= lid.getTelefoon() %>" /><br>
                
                <label for = "geboortedatum">Geboortedatum</label>
                <input type = "text" id = "geboortedatum" name = "geboortedatum" 
                       value = "<%= lid.getGeboortedatum() %>" /><br>
                
                <input type = "submit" name = "submit" value="Verzenden" />
                <input type = "submit" name = "terug" value = "Terug" />
            </fieldset>
        </form>
      </div>
    </body>
</html>