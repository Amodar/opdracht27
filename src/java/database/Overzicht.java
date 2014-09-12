
package database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import tconnection.TConnection;
/**
 * De klasse <strong>OverzichtStudenten</strong> haalt de gegevens 
 * van de studenten op uit de database en gebruikt de klasse 
 * <strong>Student</strong> om daarin de gegevens per student
 * op te slaan. De klassen <strong>Student</strong> worden in 
 * een <strong>ArrayList</strong> opgeslagen.
 * @author Ton van Beuningen
 * @version 24-09-2008
 */
public class Overzicht {
    private ArrayList lijst;
    private String sortMethode;
    
    /**
     * Deze constructor maakt een lege lijst aan waarin
     * de klassen <strong>Student</strong> kunnen worden
     * opgeslagen.
     */
    public Overzicht() {
        lijst = new ArrayList<Lid>();
        sortMethode = "asc";
    }
    
    /**
     * Deze methode haalt alle studenten op uit 
     * de database School. Hij maakt daarbij gebruik
     * van de methode <strong>getData(String selectQuery)
     * </strong>.
     * @param sort 0 = niet gesorteerd 1 = gesorteerd op
     * achternaam, tussenvoegsels en roepnaam
     * @return 0 als alles goed is gegaan, -1 als
     * er een exceptie is opgetreden
     */
    public int getStudentsSorted(int sort) {
        Connection con;
        TConnection dbc;
        String sorteer;
        String selectQuery = "SELECT spelerscode FROM speler";
        if(sort == 1)
                sorteer = " asc";
            else
                sorteer = " desc";
        if(sort > 0) {
            selectQuery += " ORDER BY spelerscode " + sorteer;
        }
        System.out.println(selectQuery);
        con = new Connection();
        if(con.getConnError() != null) {
            return -1;
        }
        dbc = con.getConnection();
        dbc.makeQuery(selectQuery);
        if(dbc.sendQuery() == -1) {
            return -1;
        }
        sortMethode = (sortMethode.equals("asc")? "desc": "asc");
        return getData(dbc, selectQuery);
    }
    
    /**
     * Deze methode haalt alle studenten op uit 
     * de database School op basis van het zoekargument.
     * Hij maakt daarbij gebruik van de methode 
     * <strong>getData(String selectQuery)</strong>.
     * @param zoekArg Gezocht wordt naar een lettercombinatie in
     * achternaam, tussenvoegsels of roepnaam
     * @return 0 als alles goed is gegaan, -1 als
     * er een exceptie is opgetreden
     */
    public int getStudentsSearched(String zoekArg) {
        Connection con;
        TConnection dbc;
        String selectQuery = "SELECT * FROM speler WHERE spelerscode LIKE ? OR "
                + "spelersnr LIKE ? OR roepnaam LIKE ? OR tussenvoegsels LIKE ? OR "
                + "achternaam LIKE ? OR adres LIKE ? OR postcode LIKE ? OR "
                + "woonplaats LIKE ? OR telefoon LIKE ? OR geboortedatum LIKE ?;";
                
        con = new Connection();
        if(con.getConnError() != null) {
            return -1;
        }
        System.out.println(selectQuery);
        
        dbc = con.getConnection();
        dbc.makeQuery(selectQuery);
        
        dbc.insertIntoQuery(1, zoekArg, zoekArg, zoekArg, zoekArg, zoekArg, zoekArg, 
                zoekArg, zoekArg, zoekArg, zoekArg);
        
        if(dbc.sendQuery() == -1) {
            return -1;
        }
        
        return getData(dbc, selectQuery);
    }
    
    /**
     * Deze methode haalt alle studenten op uit 
     * de database School die in een bepaalde groep
     * zitten.
     * Hij maakt daarbij gebruik van de methode 
     * <strong>getData(String selectQuery)</strong>.
     * @param groep Gezocht wordt naar de studenten in
     * een bepaalde groep.
     * @return 0 als alles goed is gegaan, -1 als
     * er een exceptie is opgetreden
     */
    public int getStudentsPerGroup(String groep) {
        Connection con;
        TConnection dbc;
        String selectQuery = "select student.ovnummer from student, studentgroep where " +
                "student.ovnummer = studentgroep.ovnummer and studentgroep.groepscode = ?" +
                " order by achternaam, tussenvoegsels, roepnaam";
        
        con = new Connection();
        if(con.getConnError() != null) {
            return -1;
        }
        dbc = con.getConnection();
        dbc.makeQuery(selectQuery);
        dbc.insertIntoQuery(1, groep);
        if(dbc.sendQuery() == -1) {
            return -1;
        }
        return getData(dbc, selectQuery);
    }

    /**
     * Deze methode wordt aangeroepen door de
     * methodes getStudentsSorted(int sort),
     * getStudentsSearched(String zoekArg) en 
     * getStudentsPerGroup(String groep) en stuurt
     * de query naar de database, haalt de <strong>
     * ResultSet</strong> op uit de database en stelt
     * aan de hand daarvan de lijst met de klassen
     * <strong>Student</strong> samen. 
     * @param selectQuery De query die naar de database
     * wordt gestuurd.
     * @return 0 als alles goed is gegaan, -1 als
     * er een exceptie is opgetreden
     */
    protected int getData(TConnection dbc, String selectQuery) {
        
        ResultSet rs;
        Lid lid;
        
        
        rs = dbc.getResultSet();
        lijst = new ArrayList<Lid>();
        try {
            rs.beforeFirst();
            while(rs.next()) {
                lid = new Lid(rs.getString("spelerscode"));
                lijst.add(lid);
            }
        }
        catch(SQLException se) {
            return -1;
        }
        catch(NullPointerException ne) {
            return -1;
        }
        finally {
            dbc.closeDbConnection(); 
        }
        return 0;
    }
    
    /**
     * Deze methode haalt een van de
     * klassen <strong>Student</strong> op
     * uit de lijst op basis van de index.
     * @param index Een integer die de index
     * is van de klasse <strong>Student</strong>
     * uit de lijst die opgehaald moet worden.
     * @return
     */
    public Lid getLid(int index) {
        return (Lid)lijst.get(index);
    }
    
    /**
     * Deze methode geeft het aantal klassen
     * <strong>Student</strong> die op dat moment
     * in de lijst staan.
     * @return Het aantal klassen <strong>Student
     * </strong> in de lijst.
     */
    public int getAantalLeden() {
        return lijst.size();
    }
    
}