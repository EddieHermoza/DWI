
package Controlador;

import DAO.UsuariosDAO;
import Modelos.Cliente;
import Modelos.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


public class ctrlRegister extends HttpServlet {
    private UsuariosDAO uDAO=new UsuariosDAO();

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

        String nombres = request.getParameter("nombresRegister");
        String apellidos = request.getParameter("apellidosRegister");
        String correo = request.getParameter("correoRegister");
        String numero = request.getParameter("numeroRegister");
        String contra = codificarContraseña(request.getParameter("contraRegister"));

        Usuario u=new Usuario(nombres, apellidos, correo, contra, "cliente");

        if (u.ConAtributosVacios()) {
            session.setAttribute("errorRegister", "No debe dejar campos vacíos");
            response.sendRedirect(request.getContextPath() + "/Home/Register.jsp");
            
        } else {
            
            for (Usuario usu : uDAO.Listar()) {
                if (usu.getCorreo() != null && usu.getCorreo().equals(correo)) {
                    session.setAttribute("errorRegister", "El correo ingresado ya está registrado");
                    response.sendRedirect(request.getContextPath() + "/Home/Register.jsp");
                    return; 
                }
            }
            
            if (uDAO.Insertar(u)) {
                int id=uDAO.ObtenerIDgenerado();
                if (id>0) {
                    Cliente c=new Cliente(0, numero, nombres, apellidos, correo, contra, "cliente");
                    if (uDAO.InsertarCliente(c, id)) {
                        session.setAttribute("errorRegister", "");
                        response.sendRedirect(request.getContextPath() + "/Home/Login.jsp");
                    } else {
                        session.setAttribute("errorRegister", "Hubo un error en el registro");
                        response.sendRedirect(request.getContextPath() + "/Home/Register.jsp");
                    }
                } else {
                    session.setAttribute("errorRegister", "Hubo un error en el registro");
                    response.sendRedirect(request.getContextPath() + "/Home/Register.jsp");
                }
            } else {
                session.setAttribute("errorRegister", "Hubo un error en el registro");
                response.sendRedirect(request.getContextPath() + "/Home/Register.jsp");
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
