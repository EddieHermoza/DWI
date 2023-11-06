package Modelos;

import java.util.ArrayList;
import Modelos.Producto;

public class Carro {
   private ArrayList<Producto> listaDeProductos; 

    public Carro() {
        listaDeProductos = new ArrayList<Producto>();
    }

    public ArrayList<Producto> getListaDeProductos() {
        return listaDeProductos;
    }

    public void setListaDeProductos(ArrayList<Producto> listaDeProductos) {
        this.listaDeProductos = listaDeProductos;
    }
    
    public double Monto(){
        double monto=0;
        for (Producto p : listaDeProductos) {
            monto+=p.getPrecio()*p.getCantidad();
        }
        return monto;
    }
    
    public double MontoDescontado(){
        double monto=0;
        for(Producto p:listaDeProductos){
            monto+=p.PrecioConDescuento()*p.getCantidad();           
        }
        return monto;
    }
    
    public double AhorroTotal(){
        double ahorro=0;
        for (Producto p : listaDeProductos) {
            ahorro+=p.Ahorro() * p.getCantidad();
        }
        return ahorro;
    }
}