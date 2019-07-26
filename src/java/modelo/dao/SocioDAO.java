package modelo.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.vo.Socio;

public class SocioDAO {

    Connection cnn;

    public SocioDAO(Connection cnn) {
        this.cnn = cnn;
    }

    public List<Socio> obtenerSocios() {
        List<Socio> listado = new ArrayList<>();
        Connection cnn = null;
        try {
            cnn = (this.cnn != null) ? this.cnn : modelo.conexion.Conexion.getConexionDB();
            PreparedStatement sentencia = cnn.prepareStatement("select * from socio");
            ResultSet resultado = sentencia.executeQuery();
            while (resultado.next()) {
                listado.add(getVO(resultado));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listado;
    }

    public Socio getVO(ResultSet resultado) throws SQLException {
        Socio socio = new Socio();
        socio.setId_socio(resultado.getInt("id_socio"));
        socio.setNombre_socio(resultado.getString("nombre_socio"));
        socio.setTasa(resultado.getString("tasa"));
        socio.setMonto_maximo(resultado.getString("monto_maximo"));
        return socio;
    }
}
