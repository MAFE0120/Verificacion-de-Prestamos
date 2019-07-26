package control;

import Excepciones.AppException;
import java.sql.*;
import modelo.dao.SocioDAO;
import modelo.vo.Socio;

public class SocioControl {

    Connection cnn;
    SocioDAO socDAO;

    public SocioControl(Connection cnn) {
        this.cnn = cnn;
        socDAO = new SocioDAO(cnn);
    }

    public Socio socioPrestamista(String monto) throws AppException {
        try {
            Socio socioPrestamo = null;
            String valorTasa = socDAO.obtenerSocios().get(0).getTasa();
 
            for (Socio datos : socDAO.obtenerSocios()) {
                double maximo = Double.parseDouble(datos.getMonto_maximo());
                double montoPedido = Double.parseDouble(monto);
                if (maximo >= montoPedido) {
                    if (Float.parseFloat(datos.getTasa()) <= Float.valueOf(valorTasa)) {
                        socioPrestamo = datos;
                        valorTasa = datos.getTasa();
                    }
                } 
            } 
            return socioPrestamo;
        } catch (Exception e) {            
            throw new AppException(e);
        }
    }
    
}
