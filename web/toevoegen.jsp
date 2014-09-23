
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
    lid = new Lid("");
    lid.setSpelerscode(request.getParameter("spelerscode"));
    lid.setSpelersnr(request.getParameter("spelersnr"));
    lid.setRoepnaam(request.getParameter("roepnaam"));
    lid.setTussenvoegsels(request.getParameter("tussenvoegsels"));
    lid.setAchternaam(request.getParameter("achternaam"));
    lid.setAdres(request.getParameter("adres"));
    lid.setPostcode(request.getParameter("postcode"));
    lid.setWoonplaats(request.getParameter("woonplaats"));
    lid.setTelefoon(request.getParameter("telefoon"));    
    lid.setGeboortedatum(request.getParameter(datum));
    
    if(lid.toevoegen() == 0) {
        response.sendRedirect(response.encodeURL("index.jsp"));
    }
    else {
        fout = 1;
    }
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/transitional.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "shortcut icon" href = "images/kitten1.ico">
        <link rel="stylesheet" href="pagina.css" type="text/css" media= "screen">
        <title>Gegevens lid toevoegen</title>
    </head>
    <body>
      <div id = "wrapper">
        <h2>Gegevens lid toevoegen</h2>
       <% if(fout == 1) {
                out.print("<p class = \"error\"> Er is een fout opgetreden bij het toevoegen van gegevens van een lid..!</p>");
                out.println("       </div>");
                out.println("   </body>");
                out.println("</html>");
                return;
               }
            %>
        <form action = "lidtoevoegen.jsp" method="post">
            <fieldset>
                <legend>Gegevens lid</legend>
                <label for = "spelerscode">Spelerscode</label>
                <input type = "text" id = "spelerscode" name = "spelerscode"  />
                <label for = "spelersnr">Spelersnr</label>
                <input type = "text" id = "spelersnr" name = "spelersnr"  />
                <label for = "roepnaam">Roepnaam</label>
                <input type = "text" id = "roepnaam" name = "roepnaam" />
                <label for = "achternaam">Achternaam</label>
                <input type = "text" id = "achternaam" name = "achternaam" />
                <label for = "adres">Adres</label>
                <input type = "text" id = "adres" name = "adres" />
                <label for = "postcode">Postcode</label>
                <input type = "text" id = "postcode" name = "postcode" />
                <label for = "woonplaats">Woonplaats</label>
                <input type = "text" id = "woonplaats" name = "woonplaats" />
                <label for = "telefoon">Telefoon</label>
                <input type = "text" id = "telefoon" name = "telefoon" />
                <label for = "geboortedatum">Geboortedatum</label>
                <input type = "text" id = "geboortedatum" name = "geboortedatum" />
                <%
                    if(request.getParameter("geboortedatum") != null) {
                        try{
                        SimpleDateFormat sdf;
                        sdf = new SimpleDateFormat("dd-MM-yyyy");
                        date = sdf.format(request.getParameter("geboortedatum"));
                        }
                        catch{
                            
                        }
                    }
                %>
                <div id = "knoppenbalk">
                    <input type = "submit" class = "knop" name = "submit" value="Verzenden" />
                    <input type = "submit" class = "knop" name = "terug" value = "Terug" />
                </div>
            </fieldset>
        </form>
      </div>
    </body>
</html>