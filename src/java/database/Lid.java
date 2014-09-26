/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import tconnection.TConnection;

/**
 *
 * @author ajay
 */
public class Lid {
    
    TConnection dbc;
    String spelerscode, spelersnr, roepnaam, tussenvoegsels, achternaam;
    String adres, postcode, woonplaats, telefoon;
    Date geboortedatum;
    
    public Lid() {
    }
    
    public Lid(String spelerscode) {
        String selectQuery = "SELECT spelerscode, spelersnr, roepnaam, tussenvoegsels, achternaam, adres, postcode, woonplaats, telefoon, geboortedatum "
                           + "FROM speler "
                           + "WHERE spelerscode = ?";
        
        ResultSet rs;
        
        System.out.print(selectQuery);

        if(connecting() == -1) {
            return;
        }
        
        dbc.makeQuery(selectQuery);
        dbc.insertIntoQuery(1, spelerscode);
        
        if(dbc.sendQuery() == -1) {
            return;
        }
        
        this.spelerscode = spelerscode;
        
        rs = dbc.getResultSet();
        
        try {
            rs.first();
            
            this.spelerscode = rs.getString("spelerscode");
            this.spelersnr = rs.getString("spelersnr");
            this.roepnaam = rs.getString("roepnaam");
            this.tussenvoegsels = rs.getString("tussenvoegsels");
            this.achternaam = rs.getString("achternaam");
            this.adres = rs.getString("adres");
            this.woonplaats = rs.getString("woonplaats");
            this.postcode = rs.getString("postcode");
            this.telefoon = rs.getString("telefoon");
            this.geboortedatum = rs.getDate("geboortedatum");
        } 
        catch(SQLException se) {
        }
        catch(NullPointerException ne) {
        }
        
        dbc.closeDbConnection();
    }
    
    private int connecting() {
        Connection con;
        
        con = new Connection();
        if(con.getConnError() != null) {
            return -1;
        }
        this.dbc = con.getConnection(); 
        return 0;
    }
    
    //-------------------------------------------------------------------------
    //-------------------------------------------------------------------------
    //-------------------------------------------------------------------------
    //-------------------------------------------------------------------------
    public int wijzigen() {
        String updateQuery = "UPDATE speler SET spelersnr = ?, " +
                "roepnaam = ?, tussenvoegsels = ?, achternaam = ?, " +
                "adres = ?, postcode = ?, woonplaats = ?, telefoon = ?, " +
                "geboortedatum = ?, WHERE spelerscode = ?";
        int ret = 0;
        
        if(connecting() == -1) {
           return -1;
        }
        
        dbc.makeQuery(updateQuery);
        dbc.insertIntoQuery(1, this.spelersnr, this.roepnaam, this.tussenvoegsels, 
                this.achternaam, this.adres, this.postcode, this.woonplaats, 
                this.telefoon);
        dbc.insertIntoQuery(9,this.geboortedatum);
        if(dbc.sendQuery() == -1) {
            ret = -1;
        }
        dbc.closeDbConnection();
        return ret;
    }
    
    public int toevoegen() {        
        String insertQuery = "INSERT INTO speler (spelerscode, spelersnr, roepnaam, tussenvoegsels, " +
                "achternaam, adres, postcode, woonplaats, telefoon, geboortedatum) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        int ret = 0;
        
        if(connecting() == -1) {
           return -1;
        }
        dbc.makeQuery(insertQuery);
        dbc.insertIntoQuery(1, this.spelerscode, this.spelersnr, this.roepnaam, this.tussenvoegsels, 
                this.achternaam, this.adres, this.postcode, this.woonplaats, 
                this.telefoon);
        dbc.insertIntoQuery(10,this.geboortedatum);
        
        System.out.print(dbc);
        
        if(dbc.sendQuery() == -1) {
            ret = -1;
        }
        dbc.closeDbConnection();
        return ret;
    }
    //-------------------------------------------------------------------------
    //-------------------------------------------------------------------------
    //-------------------------------------------------------------------------
    //-------------------------------------------------------------------------
    
    public String getSpelerscode() {
        return spelerscode == null? "":spelerscode;
    }
    public String getSpelersnr() {
        return spelersnr == null? "":spelersnr;
    }
    public String getRoepnaam() {
        return roepnaam == null? "":roepnaam;
    }
    public String getTussenvoegsels() {
        return tussenvoegsels == null? "":tussenvoegsels;
    }
    public String getAchternaam() {
        return achternaam == null? "":achternaam;
    }
    public String getAdres() {
        return adres == null? "":adres;
    }
    public String getPostcode() {
        return postcode == null? "":postcode;
    }
    public String getWoonplaats() {
        return woonplaats == null? "":woonplaats;
    }
    public String getTelefoon() {
        return telefoon == null? "":telefoon;
    }
    public String getGeboortedatum() {
        String datum;
        SimpleDateFormat sdf;
        
        if(geboortedatum != null) {
            sdf = new SimpleDateFormat("dd-MM-yyyy");
            datum = sdf.format(geboortedatum);
            return datum;
        }
        else {
            return "";
        }
    }
    
    public String getNaam() 
    {
        if(this.getTussenvoegsels().length() == 0) 
        {
            return this.getRoepnaam() + " " + this.getAchternaam();
        }
        else 
        {
            return this.getRoepnaam() + " "  + this.getTussenvoegsels() + " " +  this.getAchternaam();
        }
    }
    
    

    public void setSpelerscode(String spelerscode) {
        this.spelerscode = spelerscode;
    }

    public void setSpelersnr(String spelersnr) {
        this.spelersnr = spelersnr;
    }

    public void setRoepnaam(String roepnaam) {
        this.roepnaam = roepnaam;
    }

    public void setTussenvoegsels(String tussenvoegsels) {
        this.tussenvoegsels = tussenvoegsels;
    }

    public void setAchternaam(String achternaam) {
        this.achternaam = achternaam;
    }

    public void setAdres(String adres) {
        this.adres = adres;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public void setWoonplaats(String woonplaats) {
        this.woonplaats = woonplaats;
    }

    public void setTelefoon(String telefoon) {
        this.telefoon = telefoon;
    }

    public void setGeboortedatum(Date geboortedatum) {
        this.geboortedatum = geboortedatum;
    }
}
