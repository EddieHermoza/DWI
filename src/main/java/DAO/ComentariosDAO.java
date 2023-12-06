
package DAO;

import Modelos.Comentario;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;



public class ComentariosDAO extends Conexion{
    
    
    public boolean Insertar(Comentario c){
        PreparedStatement ps = null;
        Connection con = getConnection();
        try{
            ps = con.prepareStatement("INSERT INTO comentarios(producto_id, cliente_id, comentario, calificacion, fecha, estado) VALUES(?,?,?,?,?,?)");
            ps.setInt(1, c.getProducto());
            ps.setInt(2, c.getCliente());
            ps.setString(3, c.getMensaje());
            ps.setInt(4, c.getCalificacion());
            ps.setString(5, c.getFecha());
            ps.setString(6, c.getEstado());
            System.out.println(ps.toString());
            ps.execute();
            return true; 
        } catch (SQLException e) {
            Logger.getLogger(ComentariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e);
            return false;
            
        } finally{
            
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(ComentariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }
    
    public boolean Eliminar(int id){
        PreparedStatement ps = null;
        Connection con = getConnection();
        try {
            ps = con.prepareStatement("DELETE FROM comentarios WHERE id=?");
            ps.setInt(1, id);
            ps.execute();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(ProductosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e);
            return false;
            
        } finally{
            
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProductosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }
    
    public ArrayList<Comentario> ListarComentarios() {
        ArrayList<Comentario> comentarios = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs = null;
        Connection con = getConnection();
        try {
            ps = con.prepareStatement("SELECT c.comentario, c.calificacion, c.fecha, c.estado, p.id AS id_producto, p.img AS imagen_producto, u.nombres AS nombreCliente, u.apellidos AS apellidoCliente, p.nombre AS productoNombre, p.img AS productoURL " +
                                      "FROM comentarios c " +
                                      "JOIN productos p ON c.producto_id = p.id " +
                                      "JOIN clientes cl ON c.cliente_id = cl.usuario_id " +
                                      "JOIN usuarios u ON cl.usuario_id = u.id");
            rs = ps.executeQuery();
            while (rs.next()) {
                Comentario c = new Comentario();
                c.setMensaje(rs.getString("comentario"));
                c.setCalificacion(rs.getInt("calificacion"));
                c.setFecha(rs.getString("fecha"));
                c.setEstado(rs.getString("estado"));
                c.setProducto(rs.getInt("id_producto"));
                c.setProductoURL(rs.getString("imagen_producto"));
                c.setNombreCliente(rs.getString("nombreCliente")+" "+rs.getString("apellidoCliente"));
                c.setProductoNombre(rs.getString("productoNombre"));
                comentarios.add(c);
            }
        return comentarios;
        } catch (SQLException e) {
            System.out.print(e);
            Logger.getLogger(ComentariosDAO.class.getName()).log(Level.SEVERE, null, "Error: " + e);
            return comentarios;
        } 
    }
    
    public int PromedioProducto(int id) {
        int cantidad = 0;
        PreparedStatement ps = null;
        Connection con = getConnection();
        ResultSet rs = null;

        try {
            ps = con.prepareStatement("SELECT CAST(AVG(calificacion) AS UNSIGNED) AS promedio " +
                                      "FROM comentarios " +
                                      "WHERE producto_id = ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                cantidad = rs.getInt("promedio");
            }
        } catch (SQLException e) {
            Logger.getLogger(VentasDAO.class.getName()).log(Level.SEVERE, null, "Error: " + e);
            System.out.println(e);
        } 

        return cantidad;
    }
}
