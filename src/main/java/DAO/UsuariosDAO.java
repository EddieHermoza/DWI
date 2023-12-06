
package DAO;

import Modelos.Cliente;
import Modelos.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;


public class UsuariosDAO extends Conexion{
    
    
    public boolean Insertar(Usuario u){
        PreparedStatement ps = null;
        Connection con = getConnection();
        try{
            ps = con.prepareStatement("INSERT INTO Usuarios(nombres, apellidos, email, contraseña, rol) VALUES(?,?,?,?,?)");
            ps.setString(1, u.getNombres());
            ps.setString(2, u.getApellidos());
            ps.setString(3, u.getCorreo());
            ps.setString(4, u.getContraseña());
            ps.setString(5, u.getRol());
            ps.execute();
            return true; 
        } catch (SQLException e) {
            Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e);
            return false;
            
        } finally{
            
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }
    
    public boolean InsertarCliente(Cliente u,int id){
        PreparedStatement ps = null;
        Connection con = getConnection();
        try{        
            ps=con.prepareStatement("INSERT INTO Clientes(usuario_id,telefono,puntos) VALUES(?,?,?)");
            ps.setInt(1, id);
            ps.setString(2, u.getTelefono());
            ps.setInt(3, u.getPuntos());
            ps.execute();
            return true; 
        } catch (SQLException e) {
            Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e);
            return false;
            
        } 
    }
    
    
    public boolean Modificar(Usuario u){
        PreparedStatement ps = null;
        Connection con = getConnection();
        try {
            ps = con.prepareStatement("UPDATE Usuarios SET nombres=?, apellidos=?, email=?, contraseña=? WHERE id=?");
            ps.setString(1, u.getNombres());
            ps.setString(2, u.getApellidos());
            ps.setString(3, u.getCorreo());
            ps.setString(4, u.getContraseña());
            ps.setInt(5, u.getId());
            ps.execute();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e);
            return false;
            
        } finally{
            
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }
    
    public boolean Eliminar(int id){
        PreparedStatement ps = null;
        Connection con = getConnection();
        try {
            ps = con.prepareStatement("DELETE FROM Usuarios WHERE id=?");
            ps.setInt(1, id);
            ps.execute();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e);
            return false;
            
        } finally{
            
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }       
    
    
    public ArrayList<Usuario> ListarAdministradores() {
        ArrayList<Usuario> usuarios = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
             ps = con.prepareStatement("SELECT * FROM Usuarios WHERE rol='administrador'");
             rs = ps.executeQuery();
                while (rs.next()) {
                    Usuario u = new Usuario();
                    u.setId(rs.getInt("id"));
                    u.setNombres(rs.getString("nombres"));
                    u.setApellidos(rs.getString("apellidos"));
                    u.setCorreo(rs.getString("email"));
                    u.setContraseña(rs.getString("contraseña"));
                    u.setRol(rs.getString("rol"));
                    usuarios.add(u);
                }
             return usuarios;
             
        } catch (SQLException e) {
            
            Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            return usuarios;
            
        } finally{     
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }
    
    
    public ArrayList<Cliente> ListarClientes() {
        ArrayList<Cliente> clientes = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
             ps = con.prepareStatement( "SELECT u.id, u.nombres, u.apellidos, u.email, u.contraseña, c.telefono, c.puntos\n" +
                                        "FROM usuarios u\n" +
                                        "INNER JOIN clientes c ON u.id = c.usuario_id");
             rs = ps.executeQuery();
                while (rs.next()) {
                    Cliente c = new Cliente();
                    c.setId(rs.getInt("id"));
                    c.setNombres(rs.getString("nombres"));
                    c.setApellidos(rs.getString("apellidos"));
                    c.setCorreo(rs.getString("email"));
                    c.setContraseña(rs.getString("contraseña"));
                    c.setTelefono(rs.getString("telefono"));
                    c.setPuntos(rs.getInt("puntos"));
                    clientes.add(c);
                }
             return clientes;
             
        } catch (SQLException e) {
            
            Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            return clientes;
            
        } finally{     
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }
    
    public ArrayList<Usuario> Listar() {
        ArrayList<Usuario> usuarios = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
             ps = con.prepareStatement("SELECT * FROM Usuarios");
             rs = ps.executeQuery();
                while (rs.next()) {
                    Usuario u = new Usuario();
                    u.setId(rs.getInt("id"));
                    u.setNombres(rs.getString("nombres"));
                    u.setApellidos(rs.getString("apellidos"));
                    u.setCorreo(rs.getString("email"));
                    u.setContraseña(rs.getString("contraseña"));
                    u.setRol(rs.getString("rol"));
                    usuarios.add(u);
                }
             return usuarios;
             
        } catch (SQLException e) {
            
            Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            return usuarios;
            
        } finally{     
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }
    
    
    
    public Usuario ValidarUsuario(String correo, String contra){
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
            ps=con.prepareStatement("SELECT * FROM Usuarios WHERE email=? AND contraseña=?");
            ps.setString(1, correo);
            ps.setString(2, contra);
            rs=ps.executeQuery();
            Usuario u=new Usuario();
            while (rs.next()) {                
                u.setNombres(rs.getString("nombres"));
                u.setApellidos(rs.getString("apellidos"));
                u.setCorreo(rs.getString("email"));
                u.setContraseña(rs.getString("contraseña"));
                u.setRol(rs.getString("rol"));
                u.setId(rs.getInt("id"));
                
            }
            return  u;
            
        } catch (SQLException e) {
            
            Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e);
            return null;
            
        } finally {    
            
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
            
        }
    }
    
    public Usuario ObtenerUsuario(int id){
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
            ps=con.prepareStatement("SELECT * FROM Usuarios WHERE id=?");
            ps.setInt(1, id);
            rs=ps.executeQuery();
            Usuario u=new Usuario();
            while (rs.next()) {                
                u.setNombres(rs.getString("nombres"));
                u.setApellidos(rs.getString("apellidos"));
                u.setCorreo(rs.getString("email"));
                u.setContraseña(rs.getString("contraseña"));
                u.setRol(rs.getString("rol"));
                u.setId(rs.getInt("id"));
                
            }
            return  u;
            
        } catch (SQLException e) {
            
            Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e);
            return null;
            
        } finally {    
            
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
            
        }
    }
    
    public Cliente ObtenerCliente(int id) {
        Cliente c = new Cliente();
        PreparedStatement ps = null;
        ResultSet rs=null;
        Connection con = getConnection();
        try {
             ps = con.prepareStatement( "SELECT u.id, u.nombres, u.apellidos, u.email, u.contraseña, c.telefono, c.puntos\n" +
                                        "FROM usuarios u\n" +
                                        "INNER JOIN clientes c ON u.id = c.usuario_id");
             rs = ps.executeQuery();
                while (rs.next()) {
                    c.setId(rs.getInt("id"));
                    c.setNombres(rs.getString("nombres"));
                    c.setApellidos(rs.getString("apellidos"));
                    c.setCorreo(rs.getString("email"));
                    c.setContraseña(rs.getString("contraseña"));
                    c.setTelefono(rs.getString("telefono"));
                    c.setPuntos(rs.getInt("puntos"));
                }
             return c;
             
        } catch (SQLException e) {
            
            Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            return null;
            
        } finally{     
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+ex);
            }
        }
    }
    
    public int ObtenerIDgenerado(){
        PreparedStatement ps=null;
        ResultSet rs=null;
        Connection con=getConnection();
        try {
            ps=con.prepareStatement("SELECT MAX(id) AS IDgenerado FROM Usuarios");
            rs=ps.executeQuery();
            if (rs.next()) {
                int id=rs.getInt("IDgenerado");
                return  id;    
            }        
        } catch (SQLException e) {
            Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            return 0;
        }
        return 0;
    }
    
    public int CantidadClientes(){
        int cantidad=0;
        PreparedStatement ps=null;
        Connection con=getConnection();
        ResultSet rs=null;
        try {
            ps=con.prepareStatement("SELECT count(*) AS cantidad FROM Clientes");
            rs=ps.executeQuery(); 
            if (rs.next()) {
                cantidad=Integer.parseInt(rs.getString("cantidad"));
            }
        } catch (SQLException e) {
           Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: "+e); 
            System.out.println(e);
        }
        return cantidad;
    }
    
    public boolean ModificarCliente(Cliente clie) {
        PreparedStatement ps = null;
        Connection con = getConnection();
        String sql = "UPDATE usuarios " +
                     "JOIN clientes ON usuarios.id = clientes.usuario_id " +
                     "SET usuarios.nombres =?, " +
                     "    usuarios.apellidos =?, " +
                     "    usuarios.email =?, " +
                     "    usuarios.contraseña =?, " +
                     "    clientes.telefono =? " +
                     "WHERE usuarios.id =?";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, clie.getNombres());
            ps.setString(2, clie.getApellidos());
            ps.setString(3, clie.getCorreo());
            ps.setString(4, clie.getContraseña());
            ps.setString(5, clie.getTelefono());
            ps.setInt(6, clie.getId());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(UsuariosDAO.class.getName()).log(Level.SEVERE, null, "Error: " + e); 
            System.out.println(e);
            return false;
        } 
    }
}
