
package Modelos;

public class Cliente extends Usuario {
    private int puntos;
    private String telefono;

    public Cliente() {
        
    }

    public Cliente(int puntos, String telefono, String nombres, String apellidos, String correo, String contraseña, String rol) {
        super(nombres, apellidos, correo, contraseña, rol);
        this.puntos = puntos;
        this.telefono = telefono;
    }

    

    public int getPuntos() {
        return puntos;
    }

    public void setPuntos(int puntos) {
        this.puntos = puntos;
    }


    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    
    
    
}
