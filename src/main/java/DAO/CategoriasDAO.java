
package DAO;

import Modelos.Categoria;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CategoriasDAO extends Conexion{
    public boolean Insertar(Categoria c){
        PreparedStatement ps = null;
        Connection con = getConnection();
        try{
            ps = con.prepareStatement("INSERT INTO categorias(nombre, descripcion, banner_img, referencia_img) VALUES(?,?,?,?)");
            ps.setString(1, c.getNombre());
            ps.setString(2, c.getDesc());
            ps.setString(3, c.getBannerRef());
            ps.setString(4, c.getImgRef());
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
    
    
    public boolean Modificar(Categoria c){
        PreparedStatement ps = null;
        Connection con = getConnection();
        try {
            ps = con.prepareStatement("UPDATE categorias SET nombre=?, descripcion=?, banner_img=?, referencia_img=? WHERE id=?");
            ps.setString(1, c.getNombre());
            ps.setString(2, c.getDesc());
            ps.setString(3, c.getBannerRef());
            ps.setString(4, c.getImgRef());
            ps.setInt(5, c.getId());
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
            ps = con.prepareStatement("DELETE FROM categorias WHERE id=?");
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
    
    
    public ArrayList<Categoria> Listar() {
        ArrayList<Categoria> categorias = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
             ps = con.prepareStatement("SELECT * FROM categorias");
             rs = ps.executeQuery();
                while (rs.next()) {
                    Categoria c = new Categoria();
                    c.setId(rs.getInt("id"));
                    c.setNombre(rs.getString("nombre"));
                    c.setDesc(rs.getString("descripcion"));
                    c.setBannerRef(rs.getString("banner_img"));
                    c.setImgRef(rs.getString("referencia_img"));
                    categorias.add(c);
                }
             return categorias;
             
        } catch (SQLException e) {
            
            Logger.getLogger(ProductosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            return categorias;
            
        } finally{     
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProductosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }
    
    public Categoria ObtenerCategoria(int id) {
        Categoria c=new Categoria();
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
             ps = con.prepareStatement("SELECT * FROM categorias WHERE id=?");
             ps.setInt(1, id);
             rs = ps.executeQuery();
                while (rs.next()) {
                    c.setId(rs.getInt("id"));
                    c.setNombre(rs.getString("nombre"));
                    c.setDesc(rs.getString("descripcion"));
                    c.setBannerRef(rs.getString("banner_img"));
                    c.setImgRef(rs.getString("referencia_img"));
                }
             return c;
             
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
