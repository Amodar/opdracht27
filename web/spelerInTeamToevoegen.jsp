<%-- 
    Document   : lidInTeamToevoegen
    Created on : Oct 21, 2014, 7:34:00 PM
    Author     : ajay
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
        <div style="padding-top: 10px;">
            <fieldset style="background-color: lightgray; border: 10px;">
                <p class="text-center">Voeg
                    <select>
                        <option value="speler" disabled>speler</option>
                        <option>speler</option>
                        <option>speler</option>
                        <option>speler</option>
                    </select>
                    toe, aan
                    <select>
                        <option value="choose" disabled>team</option>
                    </select>
                    <input type="submit" class="btn btn-success" value="bevestig">
                    <a href="teamOverzicht.jsp"><input type="button" class="btn btn-danger" value="terug"></a>
                </p>
            </fieldset>
        </div>
    </body>
</html>