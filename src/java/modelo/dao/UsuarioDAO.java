package modelo.dao;

import java.sql.*;
import modelo.vo.Usuario;


public class UsuarioDAO {
    
    Connection cnn;

    public UsuarioDAO(Connection cnn) {
        this.cnn = cnn;
    }
    
    public Usuario autenticar(String correo) throws SQLException {
        PreparedStatement sentencia = cnn.prepareStatement("SELECT * FROM usuario WHERE correo=?");
        sentencia.setString(1, correo);
        ResultSet resultado = sentencia.executeQuery();
        if (resultado.next()) {
            return getVo(resultado);
        }
        return null;
    }
    
    public Usuario getVo(ResultSet resultado) throws SQLException {
        Usuario vot = new Usuario();
        vot.setId_usuario(resultado.getInt("id_usuario"));
        vot.setClave(resultado.getString("clave"));
        vot.setCorreo(resultado.getString("correo"));
        vot.setFk_estado(resultado.getInt("fk_estado"));
        return vot;
    }
}
