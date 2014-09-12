<%-- 
    Document   : wijzigen
    Created on : Sep 7, 2014, 12:22:51 AM
    Author     : ajay
--%>
<%@page import = "database.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Lid lid;
    lid = new Lid("1");
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="main.css" rel="stylesheet" type="text/css" media="screen">
        <title>JSP Page</title>
        
    </head>
    <body>
        <h1>$spelernaam wijzigen</h1>
        <form action = "studentwijzigen.jsp" method="post">
                <input type = "hidden" id = "spelerscode" name = "spelerscode" value="<%= lid.getSpelerscode() %>" /> 
                <fieldset>
                    <legend>Gegegevens van <%= lid.getNaam() %></legend>
                    <label for = "spelersnummer">Spelersnummer</label>
                    <input type = "text" id = "spelersnummer" name = "spelersnummer" value="<%= lid.getSpelersnr() %>" />
                    <label for = "voorletters">Roepnaam</label>
                    <input type = "text" id = "roepnaam" name = "roepnaam" value="<%= lid.getRoepnaam() %>" />
                    <label for = "tussenvoegsels">Tussenvoegsels</label>
                    <input type = "text" id = "tussenvoegsels" name = "tussenvoegsels" value="<%= lid.getTussenvoegsels() %>" />
                    <label for = "achternaam">Achternaam</label>
                    <input type = "text" id = "achternaam" name = "achternaam" value="<%= lid.getAchternaam() %>" />
                    <label for = "achternaam">Adres</label>
                    <input type = "text" id = "adres" name = "adres" value="<%= lid.getAdres() %>" />
                    <label for = "postcode">Postcode</label>
                    <input type = "text" id = "postcode" name = "postcode" value="<%= lid.getPostcode() %>" />
                    <label for = "woonplaats">Woonplaats</label>
                    <input type = "text" id = "woonplaats" name = "woonplaats" value="<%= lid.getWoonplaats() %>" />
                    
                    <label for = "woonplaats">Telefoon</label>
                    <input type = "text" id = "telefoon" name = "telefoon" value="<%= lid.getTelefoon() %>" />
                    
                    <label for = "woonplaats">Geboortedatum</label>
                    <input type = "text" id = "geboortedatum" name = "geboortedatum" value="<%= lid.getGeboortedatum() %>" />
                    
                    <label for = "teamnaam">Teamnaam</label>
                    <input type =  "text" id = "teamnaam" name = "teamnaam" value="teamnaam" />
                    
                    <input type ="submit" value="annuleren"><input type ="submit" value="akkoord" name="update" onclick="return confirm('Weet je het zeker?')" >
            </fieldset>
            
            
            <% 
                if (request.getParameter("update") != null) {
                    out.print("swag");
                } 
            %>
        </form>
    </body>
</html>
