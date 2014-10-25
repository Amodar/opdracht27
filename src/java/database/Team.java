/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package database;

import java.sql.ResultSet;
import java.sql.SQLException;
import tconnection.TConnection;

/**
 *
 * @author ajay
 */
public class Team {
    TConnection dbc;
    String teamcode, teamomschrijving;
    String spelerscode;
    
    public Team() {
    }
    
    public Team(String teamcode) {
        String selectQuery = "SELECT teamcode, teamomschrijving FROM team WHERE teamcode = ?;";
        
        ResultSet rs;
        
        System.out.print(selectQuery);

        if(connecting() == -1) {
            return;
        }
        
        dbc.makeQuery(selectQuery);
        dbc.insertIntoQuery(1, teamcode);
        
        if(dbc.sendQuery() == -1) {
            return;
        }
        
        this.teamcode = teamcode;
        
        rs = dbc.getResultSet();
        
        try {
            rs.first();
            
            this.teamcode = rs.getString("teamcode");
            this.teamomschrijving = rs.getString("teamomschrijving");
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
    
    public int wijzigen() {
        String updateQuery = "UPDATE team SET teamomschrijving = ? WHERE teamcode = ?;";
        int ret = 0;
        
        if(connecting() == -1) {
           return -1;
        }
        
        dbc.makeQuery(updateQuery);
        dbc.insertIntoQuery(1, this.teamomschrijving, this.teamcode);
        
        System.out.print(dbc);
        
        if(dbc.sendQuery() == -1) {
            ret = -1;
        }
        dbc.closeDbConnection();
        return ret;
    }
    public int toevoegen() {        
        String insertQuery = "INSERT INTO team (teamcode, teamomschrijving);" +
                "VALUES (?, ?)";
        int ret = 0;
        
        if(connecting() == -1) {
           return -1;
        }
        dbc.makeQuery(insertQuery);
        dbc.insertIntoQuery(1, this.teamcode, this.teamomschrijving);
        
        if(dbc.sendQuery() == -1) {
            ret = -1;
        }
        dbc.closeDbConnection();
        return ret;
    }
    public int verwijderen() {        
        String deleteQuery = "DELETE FROM team WHERE teamcode = ?;";
        int ret = 0;
        
        if(connecting() == -1) {
           return -1;
        }
        dbc.makeQuery(deleteQuery);
        dbc.insertIntoQuery(1, this.teamcode);
        
        if(dbc.sendQuery() == -1) {
            ret = -1;
        }
        dbc.closeDbConnection();
        return ret;
    }
    public int teamspelerToevoegen() {  
        // insert query teamspeler
        //INSERT INTO teamspeler (teamcode, spelerscode) VALUES (?, ?);
        
        
        //select speler.* from speler, teamspeler 
        //where speler.spelerscode = teamspeler.spelerscode and teamspeler.teamcode = "D1" order by achternaam, tussenvoegsels, roepnaam;
        
        String insertQuery = "INSERT INTO teamspeler (teamcode, spelerscode) VALUES (?, ?)";
        
        int ret = 0;
        
        if(connecting() == -1) {
           return -1;
        }
        dbc.makeQuery(insertQuery);
        dbc.insertIntoQuery(1, this.teamcode, this.spelerscode);
        System.out.print(insertQuery);
        if(dbc.sendQuery() == -1) {
            ret = -1;
        }
        dbc.closeDbConnection();
        return ret;
    }
    
    public String getTeamcode() {
        return teamcode == null? "":teamcode;
    }
    public String getTeamomschrijving() {
        return teamomschrijving == null? "":teamomschrijving;
    }
    
    public void setTeamcode(String teamcode) {
        this.teamcode = teamcode;
    }
    public void setTeamomschrijving(String teamomschrijving) {
        this.teamomschrijving = teamomschrijving;
    }
    //test
    public void setSpelerscode(String spelerscode) {
        this.spelerscode = spelerscode;
    }
    
    
}
