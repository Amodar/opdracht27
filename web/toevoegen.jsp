<%-- cleaned --%>
<%@page import = "java.util.Date"%>
<%@page import = "java.text.SimpleDateFormat"%>
<%@page import = "database.Lid"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Lid lid;

    int fout = 0;
    Date date;
    
    String spelerscode = request.getParameter("spelerscode");
    String spelersnr = request.getParameter("spelersnr");
    String roepnaam = request.getParameter("roepnaam");
    String achternaam = request.getParameter("achternaam");
    String tussenvoegsels = request.getParameter("tussenvoegsels");
    String adres = request.getParameter("adres");
    String postcode = request.getParameter("postcode");
    String woonplaats = request.getParameter("woonplaats");
    String telefoon = request.getParameter("telefoon");
    String geboortedatum = request.getParameter("geboortedatum");

    if (request.getParameter("submit") != null) {
        SimpleDateFormat sdf;
        sdf = new SimpleDateFormat("dd-MM-yyyy");
        date = sdf.parse(geboortedatum);

        lid = new Lid();
        lid.setSpelerscode(spelerscode);
        lid.setSpelersnr(spelersnr);
        lid.setRoepnaam(roepnaam);
        lid.setAchternaam(achternaam);
        lid.setTussenvoegsels(tussenvoegsels);
        lid.setAdres(adres);
        lid.setPostcode(postcode);
        lid.setWoonplaats(woonplaats);
        lid.setTelefoon(telefoon);
        lid.setGeboortedatum(date);

        if (lid.toevoegen() == 0) {
            response.sendRedirect(response.encodeURL("index.jsp"));
        } else {
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
        <title>Lid toevoegen</title>
    </head>
    <body>
        <div class="container">
            <h2>Lid toevoegen</h2>
            <%
                if (fout == 1) {
                    out.print("<p class = \"error\"> Er is een fout opgetreden bij het toevoegen van gegevens van een lid..!</p>");
                    out.println("       </div>");
                    out.println("   </body>");
                    out.println("</html>");
                    return;
                }
            %>
            <form action = "toevoegen.jsp" method="post">
                <label for = "spelerscode">Spelerscode</label>
                <input type = "text" id = "spelerscode" name = "spelerscode"  />
                <label for = "spelersnr">Spelersnr</label>
                <input type = "text" id = "spelersnr" name = "spelersnr"  />
                <label for = "roepnaam">Roepnaam</label>
                <input type = "text" id = "roepnaam" name = "roepnaam" />
                <label for = "tussenvoegsels">Tussenvoegsels</label>
                <input type = "text" id = "tussenvoegsels" name = "tussenvoegsels" />
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
                <input type = "date" id = "geboortedatum" name = "geboortedatum" />
                <br />
                <a href="index.jsp"><input class="btn btn-danger" type = "button" name = "terug" value = "Terug" /></a>
                <input type = "submit" class="btn btn-success" name = "submit" value="Verzenden" />
            </form>
        </div>
    </body>
</html>