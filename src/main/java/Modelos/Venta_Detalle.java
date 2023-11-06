
package Modelos;

public class Venta_Detalle {
    private int id;
    private int venta;
    private int producto;
    private int cantidad;
    private double monto_unit;
    private double desc_aplicado;
    private double subtotal;

    public Venta_Detalle(int venta, int producto, int cantidad, double monto_unit, double desc_aplicado,double subtotal) {
        this.venta = venta;
        this.producto = producto;
        this.cantidad = cantidad;
        this.monto_unit = monto_unit;
        this.desc_aplicado = desc_aplicado;
        this.subtotal = subtotal;
    }

    public Venta_Detalle() {
        
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getVenta() {
        return venta;
    }

    public void setVenta(int venta) {
        this.venta = venta;
    }

    public int getProducto() {
        return producto;
    }

    public void setProducto(int producto) {
        this.producto = producto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getMonto_unit() {
        return monto_unit;
    }

    public void setMonto_unit(double monto_unit) {
        this.monto_unit = monto_unit;
    }

    public double getDesc_aplicado() {
        return desc_aplicado;
    }

    public void setDesc_aplicado(double desc_aplicado) {
        this.desc_aplicado = desc_aplicado;
    }
    
    public double getSubtotal(){
        return subtotal;
    }
    
    public void setSubtotal(double subtotal){
        this.subtotal=subtotal;
    }
    
    
}
