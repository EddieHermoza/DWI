
package DAO;

import Modelos.Venta;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;


public class VentasDAO extends Conexion{
    
    
    public boolean Insertar(Venta v) {
        Connection con = getConnection();
        PreparedStatement ps = null;

        try {
            ps = con.prepareStatement("INSERT INTO Ventas(transaccion,fecha,hora,monto,descuento_total,cliente_nom,cliente_correo,cliente_telefono,cliente_id,metodo_pago) VALUES(?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1, v.getTransaccion());
            ps.setString(2, v.getFecha());
            ps.setString(3, v.getHora());
            ps.setDouble(4, v.getMonto());
            ps.setDouble(5, v.getDescuento());
            ps.setString(6, v.getNombreCliente());
            ps.setString(7, v.getCorreoCliente());
            ps.setString(8, v.getTelefonoCliente());

            if (v.getIdcliente() > 0) {
                ps.setInt(9, v.getIdcliente());
            } else {
                ps.setNull(9, java.sql.Types.INTEGER);
            }
            ps.setString(10, v.getMetodo());
            System.out.println(ps.toString());
            ps.execute();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(VentasDAO.class.getName()).log(Level.SEVERE, null, "Error: " + e);
            return false;
        } 
    }
    
      
    public boolean Eliminar(int id){
        PreparedStatement ps = null;
        Connection con = getConnection();
        try {
            ps = con.prepareStatement("DELETE FROM Ventas WHERE id=?");
            ps.setInt(1, id);
            ps.execute();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(VentasDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e);
            return false;
            
        }
    }
    
    
    public ArrayList<Venta> Listar() {
        ArrayList<Venta> ventasList = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
             ps = con.prepareStatement("SELECT * FROM Ventas");
             rs = ps.executeQuery();
                while (rs.next()) {
                    Venta v = new Venta();
                    v.setId(rs.getInt("id"));
                    v.setTransaccion(rs.getString("transaccion"));
                    v.setFecha(rs.getString("fecha"));
                    v.setHora(rs.getString("hora"));
                    v.setMonto(rs.getDouble("monto"));
                    v.setDescuento(rs.getDouble("descuento_total"));
                    v.setNombreCliente(rs.getString("cliente_nom"));
                    v.setCorreoCliente(rs.getString("cliente_correo"));
                    v.setTelefonoCliente(rs.getString("cliente_telefono"));
                    v.setIdcliente(rs.getInt("cliente_id"));
                    v.setMetodo(rs.getString("metodo_pago"));
                    ventasList.add(v);
                }
             return ventasList;
             
        } catch (SQLException e) {
            
            Logger.getLogger(VentasDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            return ventasList;
            
        } 
    }
    
    
    public Venta ObtenerVenta(int id) {
        Venta v=new Venta();
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
             ps = con.prepareStatement("SELECT * FROM Ventas WHERE id=?");
             ps.setInt(1, id);
             rs = ps.executeQuery();
                while (rs.next()) {
                    v.setId(rs.getInt("id"));
                    v.setTransaccion(rs.getString("transaccion"));
                    v.setFecha(rs.getString("fecha"));
                    v.setHora(rs.getString("hora"));
                    v.setMonto(rs.getDouble("monto"));
                    v.setDescuento(rs.getDouble("descuento_total"));
                    v.setNombreCliente(rs.getString("cliente_nom"));
                    v.setCorreoCliente(rs.getString("cliente_correo"));
                    v.setTelefonoCliente(rs.getString("cliente_telefono"));
                    v.setIdcliente(rs.getInt("cliente_id"));
                    v.setMetodo(rs.getString("metodo_pago"));
                }
             return v;
             
        } catch (SQLException e) {
            
            Logger.getLogger(VentasDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            return null;
            
        }
    }
    
    public int ObtenerIDgenerado(){
        PreparedStatement ps=null;
        ResultSet rs=null;
        Connection con=getConnection();
        try {
            ps=con.prepareStatement("SELECT MAX(id) AS IDgenerado FROM Ventas");
            rs=ps.executeQuery();
            if (rs.next()) {
                int id=rs.getInt("IDgenerado");
                return  id;    
            }        
        } catch (SQLException e) {
            Logger.getLogger(VentasDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            return 0;
        }
        return 0;
    }
    
    
    public int Cantidad(){
        int cantidad=0;
        PreparedStatement ps=null;
        Connection con=getConnection();
        ResultSet rs=null;
        try {
            ps=con.prepareStatement("SELECT count(*) AS cantidad FROM Ventas");
            rs=ps.executeQuery(); 
            if (rs.next()) {
                cantidad=Integer.parseInt(rs.getString("cantidad"));
            }
        } catch (SQLException e) {
            Logger.getLogger(VentasDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e);
            System.out.println(e);
        }
      return cantidad;
    }
    
    public double GananciaTotal(){
        double monto=0;
        PreparedStatement ps=null;
        Connection con=getConnection();
        ResultSet rs=null;
        try {
            ps=con.prepareStatement("SELECT sum(monto) AS monto FROM Ventas");
            rs=ps.executeQuery(); 
            if (rs.next()) {
                monto=Double.parseDouble(rs.getString("monto"));
            }
            return monto;
        } catch (SQLException e) {
            Logger.getLogger(VentasDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e);
            System.out.println(e);
        }
        return monto;
    }
    
}
