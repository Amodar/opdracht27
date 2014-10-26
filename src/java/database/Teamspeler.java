/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import tconnection.TConnection;

/**
 *
 * @author ajay
 * testing
 * */
public class Teamspeler{
    TConnection dbc;
    String spelerscode, teamcode;

    public Teamspeler() {
        
    }
    
    public Teamspeler(String spelerscode, String teamcode) {
        this.spelerscode = spelerscode;
        this.teamcode = teamcode;
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
    
    public int verwijderen() {
        String deleteQuery = "DELETE FROM teamspeler WHERE spelerscode = ? AND teamcode = ?;";
        int ret = 0;
        
        if(connecting() == -1) {
           return -1;
        }
        
        dbc.makeQuery(deleteQuery);
        dbc.insertIntoQuery(1, this.spelerscode, this.teamcode);
        
        if(dbc.sendQuery() == -1) {
            ret = -1;
        }
        dbc.closeDbConnection();
        return ret;
    }
    public int wijzigen() {
        String updateQuery = "UPDATE teamspeler SET teamcode = ? WHERE spelerscode = ?;";
        int ret = 0;
        
        if(connecting() == -1) {
           return -1;
        }
        
        dbc.makeQuery(updateQuery);
        dbc.insertIntoQuery(1, this.teamcode, this.spelerscode);
        
        if(dbc.sendQuery() == -1) {
            ret = -1;
        }
        
        dbc.closeDbConnection();
        return ret;
    }
    public int toevoegen() {
        String insertQuery = "INSERT INTO teamspeler(spelerscode, teamcode) VALUES (?, ?);";
        int ret = 0;
        
        if(connecting() == -1) {
           return -1;
        }
        
        dbc.makeQuery(insertQuery);
        dbc.insertIntoQuery(1, this.spelerscode, this.teamcode);
        
        
        if(dbc.sendQuery() == -1) {
            ret = -1;
        }
        dbc.closeDbConnection();
        return ret;
    }
    
    public String getSpelerscode() {
        return spelerscode;
    }

    public void setSpelerscode(String spelerscode) {
        this.spelerscode = spelerscode;
    }

    public String getTeamcode() {
        return teamcode;
    }

    public void setTeamcode(String teamcode) {
        this.teamcode = teamcode;
    }
    
}