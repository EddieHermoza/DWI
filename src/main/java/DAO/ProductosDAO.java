
package DAO;

import Modelos.Producto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;


public class ProductosDAO extends Conexion{
    
    
    public boolean Insertar(Producto produ){
        PreparedStatement ps = null;
        Connection con = getConnection();
        try{
            ps = con.prepareStatement("INSERT INTO Productos(nombre, descripcion, precio, marca_id,categoria_id,img,cantidad,descuento,estado,especificaciones) VALUES(?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1, produ.getNombre());
            ps.setString(2, produ.getDescripcion());
            ps.setDouble(3, produ.getPrecio());
            ps.setInt(4, produ.getMarca());
            ps.setInt(5, produ.getCategoria());
            ps.setString(6, produ.getImg());
            ps.setInt(7, produ.getCantidad());
            ps.setDouble(8, produ.getDescuento());
            ps.setString(9,produ.getEstado());
            ps.setString(10, produ.getEspecificaciones());
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
    
    
    public boolean Modificar(Producto produ){
        PreparedStatement ps = null;
        Connection con = getConnection();
        try {
            ps = con.prepareStatement("UPDATE Productos SET nombre=?, descripcion=?, precio=?, marca_id=?, categoria_id=?, img=?, cantidad=?, descuento=?, estado=?, especificaciones=? WHERE id=?");
            ps.setString(1, produ.getNombre());
            ps.setString(2, produ.getDescripcion());
            ps.setDouble(3, produ.getPrecio());
            ps.setInt(4, produ.getMarca());
            ps.setInt(5, produ.getCategoria());
            ps.setString(6, produ.getImg());
            ps.setInt(7, produ.getCantidad());
            ps.setDouble(8, produ.getDescuento());
            ps.setString(9, produ.getEstado());
            ps.setString(10, produ.getEspecificaciones());
            ps.setInt(11, produ.getId());
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
            ps = con.prepareStatement("DELETE FROM Productos WHERE id=?");
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
    
    public boolean ModificarCantidad(int id,int cantidad){
        PreparedStatement ps = null;
        Connection con = getConnection();
        try {
            ps = con.prepareStatement("UPDATE Productos SET cantidad=? WHERE id=?");
            ps.setInt(1, cantidad);
            ps.setInt(2, id);
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
    
    public boolean Inhabilitar(int id){
        PreparedStatement ps = null;
        Connection con = getConnection();
        try {
            ps = con.prepareStatement("UPDATE Productos SET estado='inhabilitado' WHERE id=?");
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
    
    public boolean Habilitar(int id){
        PreparedStatement ps = null;
        Connection con = getConnection();
        try {
            ps = con.prepareStatement("UPDATE Productos SET estado='habilitado' WHERE id=?");
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
    
    
    public ArrayList<Producto> Listar() {
        ArrayList<Producto> productos = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
             ps = con.prepareStatement("SELECT * FROM Productos");
             rs = ps.executeQuery();
                while (rs.next()) {
                    Producto producto = new Producto();
                    producto.setId(rs.getInt("id"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setPrecio(rs.getDouble("precio"));
                    producto.setMarca(rs.getInt("marca_id"));
                    producto.setCategoria(rs.getInt("categoria_id"));
                    producto.setImg(rs.getString("img"));
                    producto.setCantidad(rs.getInt("cantidad"));
                    producto.setDescuento(rs.getDouble("descuento"));
                    producto.setEstado(rs.getString("estado"));
                    producto.setEspecificaciones(rs.getString("especificaciones"));
                    productos.add(producto);
                }
             return productos;
             
        } catch (SQLException e) {
            
            Logger.getLogger(ProductosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            return productos;
            
        } finally{     
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProductosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }
    
    public ArrayList<Producto> ListarDisponibles() {
        ArrayList<Producto> productos = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
             ps = con.prepareStatement("SELECT * FROM Productos WHERE estado='habilitado' AND cantidad > 0");
             rs = ps.executeQuery();
                while (rs.next()) {
                    Producto producto = new Producto();
                    producto.setId(rs.getInt("id"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setPrecio(rs.getDouble("precio"));
                    producto.setMarca(rs.getInt("marca_id"));
                    producto.setCategoria(rs.getInt("categoria_id"));
                    producto.setImg(rs.getString("img"));
                    producto.setCantidad(rs.getInt("cantidad"));
                    producto.setDescuento(rs.getDouble("descuento"));
                    producto.setEstado(rs.getString("estado"));
                    producto.setEspecificaciones(rs.getString("especificaciones"));
                    productos.add(producto);
                }
             return productos;
             
        } catch (SQLException e) {
            
            Logger.getLogger(ProductosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            return productos;
            
        } finally{     
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProductosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }
    
    public ArrayList<Producto> ListarPorMarca(int id) {
        ArrayList<Producto> productos = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
             ps = con.prepareStatement("SELECT * FROM Productos WHERE marca_id=? AND estado = 'habilitado' AND cantidad > 0 ");
             ps.setInt(1, id);
             rs = ps.executeQuery();
                while (rs.next()) {
                    Producto producto = new Producto();
                    producto.setId(rs.getInt("id"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setPrecio(rs.getDouble("precio"));
                    producto.setMarca(rs.getInt("marca_id"));
                    producto.setCategoria(rs.getInt("categoria_id"));
                    producto.setImg(rs.getString("img"));
                    producto.setCantidad(rs.getInt("cantidad"));
                    producto.setDescuento(rs.getDouble("descuento"));
                    producto.setEstado(rs.getString("estado"));
                    producto.setEspecificaciones(rs.getString("especificaciones"));
                    productos.add(producto);
                }
             return productos;
             
        } catch (SQLException e) {
            
            Logger.getLogger(ProductosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            return productos;
            
        } finally{     
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProductosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }
    
    public ArrayList<Producto> ListarPorCategoria(int id) {
        ArrayList<Producto> productos = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
             ps = con.prepareStatement("SELECT * FROM Productos WHERE categoria_id=? AND estado = 'habilitado' AND cantidad > 0 ");
             ps.setInt(1, id);
             rs = ps.executeQuery();
                while (rs.next()) {
                    Producto producto = new Producto();
                    producto.setId(rs.getInt("id"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setPrecio(rs.getDouble("precio"));
                    producto.setMarca(rs.getInt("marca_id"));
                    producto.setCategoria(rs.getInt("categoria_id"));
                    producto.setImg(rs.getString("img"));
                    producto.setCantidad(rs.getInt("cantidad"));
                    producto.setDescuento(rs.getDouble("descuento"));
                    producto.setEstado(rs.getString("estado"));
                    producto.setEspecificaciones(rs.getString("especificaciones"));
                    productos.add(producto);
                }
             return productos;
             
        } catch (SQLException e) {
            
            Logger.getLogger(ProductosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            return productos;
            
        } finally{     
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProductosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }
    
    public ArrayList<Producto> ListarPorBusqueda(String str) {
        ArrayList<Producto> productos = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
             ps = con.prepareStatement("SELECT * FROM Productos WHERE nombre LIKE ? AND estado = 'habilitado' AND cantidad > 0 ");
             ps.setString(1, "%" + str + "%");
             rs = ps.executeQuery();
                while (rs.next()) {
                    Producto producto = new Producto();
                    producto.setId(rs.getInt("id"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setPrecio(rs.getDouble("precio"));
                    producto.setMarca(rs.getInt("marca_id"));
                    producto.setCategoria(rs.getInt("categoria_id"));
                    producto.setImg(rs.getString("img"));
                    producto.setCantidad(rs.getInt("cantidad"));
                    producto.setDescuento(rs.getDouble("descuento"));
                    producto.setEstado(rs.getString("estado"));
                    producto.setEspecificaciones(rs.getString("especificaciones"));
                    productos.add(producto);
                }
             return productos;
             
        } catch (SQLException e) {
            
            Logger.getLogger(ProductosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            return productos;
            
        } finally{     
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProductosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }
    
    public Producto ObtenerProducto(int id) {
        Producto producto = new Producto();
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
             ps = con.prepareStatement("SELECT * FROM Productos WHERE id=?");
             ps.setInt(1, id);
             rs = ps.executeQuery();
                while (rs.next()) {
                    producto.setId(rs.getInt("id"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setPrecio(rs.getDouble("precio"));
                    producto.setMarca(rs.getInt("marca_id"));
                    producto.setCategoria(rs.getInt("categoria_id"));
                    producto.setImg(rs.getString("img"));
                    producto.setCantidad(rs.getInt("cantidad"));
                    producto.setDescuento(rs.getDouble("descuento"));
                    producto.setEstado(rs.getString("estado"));
                    producto.setEspecificaciones(rs.getString("especificaciones"));
                }
             return producto;
             
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
    
    public int Cantidad(){
        int cantidad=0;
        PreparedStatement ps=null;
        Connection con=getConnection();
        ResultSet rs=null;
        try {
            ps=con.prepareStatement("SELECT count(*) AS cantidad FROM Productos");
            rs=ps.executeQuery(); 
            if (rs.next()) {
                cantidad=Integer.parseInt(rs.getString("cantidad"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return cantidad;
    }
}
