
package database;

import tconnection.TConnection;

public class Connection {
    String vendor, host, user, password, database;
    TConnection dbc;
    
    /**
     * Deze constructor geeft de waarde aan de eigenschappen van de klasse
     * en legt vervolgens de verbinding met de database school.
     */
    public Connection() {
        
        this.vendor = "MySQL";
    	this.host = "localhost";
    	this.user = "root";
    	this.password = "";
    	this.database = "sport";
        this.dbc = new TConnection(this.vendor, this.host, this.database, 
                                   this.user, this.password);
    }
    /**
     * Deze methode geeft de verbindingsfout terug. 
     * @return de verbindingsfout
     */
    public String getConnError() {
    	return this.dbc.getConnError();
    }
    
    /**
     * Geeft de verbinding met de database terug
     * @return de verbinding met de database sport.
     */
    public TConnection getConnection() {
        return dbc;
    }
    
    /**
     * Deze methode sluit de verbinding met de database school.
     * @return -1 als de verbinding met de database niet gesloten kan worden,
     * elke andere waarde betekent dat de verbinding gesloten is.
     */
    public int closeConnection() {
        return dbc.closeDbConnection();
    }
}

