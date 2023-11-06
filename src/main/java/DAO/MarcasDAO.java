
package DAO;

import Modelos.Marca;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;


public class MarcasDAO extends Conexion{
    
    public boolean Insertar(Marca marca){
        PreparedStatement ps = null;
        Connection con = getConnection();
        try{
            ps = con.prepareStatement("INSERT INTO Marcas(nombre, descripcion, banner_img) VALUES(?,?,?)");
            ps.setString(1, marca.getNombre());
            ps.setString(2, marca.getDesc());
            ps.setString(3, marca.getBannerRef());
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
    
    
    public boolean Modificar(Marca marca){
        PreparedStatement ps = null;
        Connection con = getConnection();
        try {
            ps = con.prepareStatement("UPDATE Marcas SET nombre=?, descripcion=?, banner_img=? WHERE id=?");
            ps.setString(1, marca.getNombre());
            ps.setString(2, marca.getDesc());
            ps.setString(3, marca.getBannerRef());
            ps.setInt(4, marca.getId());
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
    
    
    public boolean Eliminar(int id){
        PreparedStatement ps = null;
        Connection con = getConnection();
        try {
            ps = con.prepareStatement("DELETE FROM Marcas WHERE id=?");
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
    
    
    public ArrayList<Marca> Listar() {
        ArrayList<Marca> marcas = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
             ps = con.prepareStatement("SELECT * FROM Marcas");
             rs = ps.executeQuery();
                while (rs.next()) {
                    Marca marca = new Marca();
                    marca.setId(rs.getInt("id"));
                    marca.setNombre(rs.getString("nombre"));
                    marca.setDesc(rs.getString("descripcion"));
                    marca.setBannerRef(rs.getString("banner_img"));
                    marcas.add(marca);
                }
             return marcas;
             
        } catch (SQLException e) {
            
            Logger.getLogger(ProductosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            return marcas;
            
        } finally{     
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProductosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }
    
    public Marca ObtenerMarca(int id) {
        Marca m=new Marca();
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
             ps = con.prepareStatement("SELECT * FROM Marcas WHERE id=?");
             ps.setInt(1, id);
             rs = ps.executeQuery();
                while (rs.next()) {
                    m.setId(rs.getInt("id"));
                    m.setNombre(rs.getString("nombre"));
                    m.setDesc(rs.getString("descripcion"));
                    m.setBannerRef(rs.getString("banner_img"));
                }
             return m;
             
        } catch (SQLException e) {
            
            Logger.getLogger(ProductosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            return null;
            
        } finally{     
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProductosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }
}
