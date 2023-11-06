
package Controlador;

import DAO.UsuariosDAO;
import Modelos.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


public class ctrlLogin extends HttpServlet {
    UsuariosDAO uDAO=new UsuariosDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    
   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
        
        HttpSession session = request.getSession();
        
        String correoUsuario = request.getParameter("correoLogin");
        String contraUsuario = codificarContraseña(request.getParameter("contraLogin"));
    
        Usuario u = uDAO.ValidarUsuario(correoUsuario, contraUsuario);
    
        if (u == null || u.ConAtributosVacios()) {
            session.setAttribute("errorLogin", "El usuario ingresado no existe");
            response.sendRedirect(request.getContextPath() + "/Home/Login.jsp");
            
        } else {
            session.setAttribute("usuario", u);
            session.setAttribute("errorLogin", "");
            
            if ("cliente".equals(u.getRol())) {
                response.sendRedirect(request.getContextPath() + "/Home/index.jsp");
            } else if ("administrador".equals(u.getRol())) {
                response.sendRedirect(request.getContextPath() + "/Admin/index.jsp");
            }
        }
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
