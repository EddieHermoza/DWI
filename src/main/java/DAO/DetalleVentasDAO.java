
package DAO;

import Modelos.Venta_Detalle;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;


public class DetalleVentasDAO extends Conexion{
    
    public boolean Insertar(Venta_Detalle vd){
        PreparedStatement ps = null;
        Connection con = getConnection();
        try{
            ps = con.prepareStatement("INSERT INTO venta_detalle(venta_id,producto_id,cantidad, monto_unit, desc_aplicado,subtotal) VALUES(?,?,?,?,?,?)");
            ps.setInt(1, vd.getVenta());
            ps.setInt(2, vd.getProducto());
            ps.setInt(3, vd.getCantidad());
            ps.setDouble(4, vd.getMonto_unit());
            ps.setDouble(5, vd.getDesc_aplicado());
            ps.setDouble(6, vd.getSubtotal());
            ps.execute();
            return true; 
        } catch (SQLException e) {
            Logger.getLogger(DetalleVentasDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e);
            return false;
     
        }
    }
    
 
   
    public ArrayList<Venta_Detalle> ListarDetalle(int id) {
        ArrayList<Venta_Detalle> ventasDetalle = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
             ps = con.prepareStatement("SELECT * FROM venta_detalle WHERE venta_id=?");
             ps.setInt(1, id);
             rs = ps.executeQuery();
                while (rs.next()) {
                    Venta_Detalle vd = new Venta_Detalle();
                    vd.setId(rs.getInt("id"));
                    vd.setVenta(rs.getInt("venta_id"));
                    vd.setProducto(rs.getInt("producto_id"));
                    vd.setCantidad(rs.getInt("cantidad"));
                    vd.setMonto_unit(rs.getDouble("monto_unit"));
                    vd.setDesc_aplicado(rs.getDouble("desc_aplicado"));
                    vd.setSubtotal(rs.getDouble("subtotal"));
                    ventasDetalle.add(vd);
                }
             return ventasDetalle;
             
        } catch (SQLException e) {
            
            Logger.getLogger(VentasDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            return ventasDetalle;
            
        } finally{     
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(VentasDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }
    
    public ArrayList<Venta_Detalle> Listar() {
        ArrayList<Venta_Detalle> ventasDetalle = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
             ps = con.prepareStatement("SELECT * FROM venta_detalle");
             rs = ps.executeQuery();
                while (rs.next()) {
                    Venta_Detalle vd = new Venta_Detalle();
                    vd.setId(rs.getInt("id"));
                    vd.setVenta(rs.getInt("venta_id"));
                    vd.setProducto(rs.getInt("producto_id"));
                    vd.setCantidad(rs.getInt("cantidad"));
                    vd.setMonto_unit(rs.getDouble("monto_unit"));
                    vd.setDesc_aplicado(rs.getDouble("desc_aplicado"));
                    vd.setSubtotal(rs.getDouble("subtotal"));
                    ventasDetalle.add(vd);
                }
             return ventasDetalle;
             
        } catch (SQLException e) {
            
            Logger.getLogger(VentasDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            return ventasDetalle;
            
        } finally{     
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(VentasDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }
    
}
