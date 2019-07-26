package control;

import Excepciones.AppException;
import java.sql.Connection;
import modelo.dao.UsuarioDAO;
import modelo.vo.Usuario;

public class UsuarioControl {
    
    Connection cnn;
    UsuarioDAO usuDAO;

    public UsuarioControl(Connection cnn) {
        this.cnn = cnn;
        usuDAO = new UsuarioDAO(cnn);
    }    
    
    public Usuario consultarUsuario(String correo, String clave) throws AppException {
        try {
            Usuario vo = usuDAO.autenticar(correo);
            if (vo == null || !vo.getClave().equals(clave)) {
                throw new AppException("Clave o Usuario Incorrecto");
            }else{
            
            }
            return vo;
        } catch (Exception e) {
            throw new AppException(e);
        }
    }
    
}
