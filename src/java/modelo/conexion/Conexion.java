package modelo.conexion;

import java.sql.*;

public class Conexion {
    
    public  static Connection getConexionDB() throws ClassNotFoundException, SQLException{
        String servidor = "localhost";
        String nombreDB = "prestamos";
        String usuario = "mf_prueba";
        String clave = "prestamos";
        String puerto = "3306";
        
        Class.forName("com.mysql.jdbc.Driver"); 
        
        Connection cnn = DriverManager.getConnection("jdbc:mysql://"+servidor+":"+puerto+"/"+nombreDB, usuario, clave);
        cnn.setAutoCommit(false);
        return cnn;
    }
    
    public static void cerrarConexion(Connection cnn) throws SQLException{
        cnn.commit();
        cnn.close();
    }
    
}
