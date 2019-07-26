package Excepciones;


public class AppException extends Exception{
    
    public AppException(String mensaje) {
        super(mensaje);
    }

    public AppException(Exception e) {
        super(e);
    }
    
}
