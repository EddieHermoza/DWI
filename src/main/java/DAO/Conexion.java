
package DAO;
import java.sql.*;


public class Conexion {
    private final String baselocal="paragondb";
    private final String userlocal="root";
    private final String passwordLocal="";
    private String urlLocal="jdbc:mysql://127.0.0.1:3306/"+baselocal;
    private Connection con=null;
         
    public Connection getConnection() {
             
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(urlLocal, userlocal, passwordLocal);
                  
        } catch (ClassNotFoundException e) {
            System.out.println("Error al cargar el driver de MySQL: " + e.getMessage());
                  
        } catch (SQLException e) {
            System.out.println("Error al establecer la conexión: " + e.getMessage());
                  
        }
          return con;
    }
         
}