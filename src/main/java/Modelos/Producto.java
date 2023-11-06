
package Modelos;

public class Producto {
    private int id;
    private String nombre;
    private String descripcion;
    private String img;
    private int marca;
    private int categoria;
    private double descuento;
    private double precio;
    private int cantidad;
    private String estado;
    private String Especificaciones;
    
    public Producto(){};

    public Producto(String nombre, String descripcion, String img, int marca, int categoria, double descuento, double precio, int cantidad, String estado, String Especificaciones) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.img = img;
        this.marca = marca;
        this.categoria = categoria;
        this.descuento = descuento;
        this.precio = precio;
        this.cantidad = cantidad;
        this.estado = estado;
        this.Especificaciones = Especificaciones;
    }
    


    public String getEspecificaciones() {
        return Especificaciones;
    }

    public void setEspecificaciones(String Especificaciones) {
        this.Especificaciones = Especificaciones;
    }

    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public int getMarca() {
        return marca;
    }

    public void setMarca(int marca) {
        this.marca = marca;
    }

    public int getCategoria() {
        return categoria;
    }

    public void setCategoria(int categoria) {
        this.categoria = categoria;
    }

    public double getDescuento() {
        return descuento;
    }

    public void setDescuento(double descuento) {
        this.descuento = descuento;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String[] FormatearEspecs() {
        return this.Especificaciones.split("-");
    }
    
    public boolean ConAtributosVacios() {
        return
        (nombre == null || nombre.isBlank()) ||
        (descripcion == null || descripcion.isBlank()) ||
        (img == null || img.isBlank()) ||
        (Especificaciones == null || Especificaciones.isBlank());
    }
    
    public double PrecioConDescuento(){
        return precio - (precio * descuento);
    }
    
    
    public double Ahorro(){
        return precio * descuento;
    }
    
    public String DescuentoPorcentaje() {
        int descuentoPorcentaje = (int) (descuento * 100);
        if (descuentoPorcentaje==0) {
            return "";
        }
        return descuentoPorcentaje + "% de descuento";
    }
}
