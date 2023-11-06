
package Controlador;

import DAO.UsuariosDAO;
import Modelos.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;



public class ctrlUsuarios extends HttpServlet {
    UsuariosDAO uDAO =new UsuariosDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
        
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
        
        if (request.getParameter("InsertarAdmin")!= null) {
            
            String nombres=request.getParameter("nombresAdmin");
            String apellidos=request.getParameter("apellidosAdmin");
            String correo=request.getParameter("correoAdmin");
            String contraseña=request.getParameter("contraAdmin");
            
            Usuario u=new Usuario(nombres, apellidos, correo, codificarContraseña(contraseña), "administrador");
            
            if (u.ConAtributosVacios()) {
                response.sendRedirect(request.getContextPath() + "/Admin/Administradores/");
            }
            if (uDAO.Insertar(u)) {
                response.sendRedirect(request.getContextPath() + "/Admin/Administradores/");
            }
        }
        
        if (request.getParameter("ModificarAdmin")!=null) {
            
            String nombres=request.getParameter("nombresAdmin");
            String apellidos=request.getParameter("apellidosAdmin");
            String correo=request.getParameter("correoAdmin");
            String contraNueva=request.getParameter("contraAdminNuevo");
            String contraPrev=request.getParameter("contraPrev");
            int id =Integer.parseInt(request.getParameter("idAdmin"));
            
            
            if (contraNueva != "") {
                
                 Usuario u=new Usuario(nombres, apellidos, correo, codificarContraseña(contraNueva), "administrador");
                 u.setId(id);
                 
                if (u.ConAtributosVacios()) {
                    response.sendRedirect(request.getContextPath() + "/Admin/Administradores/");
                }
                if (uDAO.Modificar(u)) {
                    response.sendRedirect(request.getContextPath() + "/Admin/Administradores/");
                }
                
            } else {
                
                Usuario u=new Usuario(nombres, apellidos, correo, contraPrev, "administrador");
                u.setId(id);
                
                if (u.ConAtributosVacios()) {
                    response.sendRedirect(request.getContextPath() + "/Admin/Administradores/");
                }
                if (uDAO.Modificar(u)) {
                    response.sendRedirect(request.getContextPath() + "/Admin/Administradores/");
                }
            }
            
        }
        
        if (request.getParameter("EliminarAdmin")!=null) {
            int id =Integer.parseInt(request.getParameter("idAdmin"));
            if (uDAO.Eliminar(id)) {
                response.sendRedirect(request.getContextPath() + "/Admin/Administradores/");
            }
        }
        
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }
    
    private String codificarContraseña(String contra) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] bytes = md.digest(contra.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : bytes) {
                String hex = Integer.toHexString(0xFF & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            System.out.println("Error en la codificación de la contraseña: " + e);
        }
        return null;
    }

}
