package modelo.vo;

public class Socio {

    private int id_socio;
    private String nombre_socio;
    private String tasa;
    private String monto_maximo;

    public Socio() {
    }

    public int getId_socio() {
        return id_socio;
    }

    public void setId_socio(int id_socio) {
        this.id_socio = id_socio;
    }

    public String getNombre_socio() {
        return nombre_socio;
    }

    public void setNombre_socio(String nombre_socio) {
        this.nombre_socio = nombre_socio;
    }

    public String getTasa() {
        return tasa;
    }

    public void setTasa(String tasa) {
        this.tasa = tasa;
    }

    public String getMonto_maximo() {
        return monto_maximo;
    }

    public void setMonto_maximo(String monto_maximo) {
        this.monto_maximo = monto_maximo;
    }

    @Override
    public String toString() {
        return "nombre "+nombre_socio+ " tasa "+tasa+" montomaximo "+monto_maximo; 
    }

}
