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
    lid = new Lid("");
    
    String conmsg;
    int aantal = 0;
    
    if(con.getConnError() == null)
    {
        conmsg = "Connectie successvol";
    }else
    {
        conmsg = "Geen database verbinding";
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="main.css" type="text/css" media= "screen">
        <title>JSP Page</title>
    </head>
    <body>
        <h3><i><%= conmsg %></i></h3>
        
        <form action="index.jsp" method="get">
            Zoeken: <input type = "text" name = "input"><input name = "submit" type="submit">

            <%
            if(request.getParameter("input") != null)
            {
                ov.getStudentsSearched(request.getParameter("input"));
                aantal = ov.getAantalLeden();
                
                out.print("<h2>Resultaat</h2>");
                
                if(aantal == 0)
                {
                    out.print("Geen resultaat");
                }
                else
                {
            %>
            <table border="1">
                <tr>
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
                    <th>Wijzig</th>
                    <th>Verwijder</th>
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
    
        <form action="index.jsp" method="get">
            <h2>Overzicht</h2>
            <table border="1">
                <tr>
                    <th><b>Spelerscode</b></th>
                    <th><b>Spelersnummer</b></th>
                    <th><b>Roepnaam</b></th>
                    <th><b>Tussenvoegsels</b></th>
                    <th><b>Achternaam</b></th>
                    <th><b>Adres</b></th>
                    <th><b>Postcode</b></th>
                    <th><b>Woonplaats</b></th>
                    <th><b>Telefoon</b></th>
                    <th><b>Geboortedatum</b></th>
                    <th><b>Team<b></th>
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
                        <th>Wijzig</th>
                        <th>Verwijder</th>
                    </tr>
                <%
                    }
                %>
            </table>
        </form>
    </body>
</html>
