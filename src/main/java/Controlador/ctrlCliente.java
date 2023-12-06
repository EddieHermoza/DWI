
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



public class ctrlCliente extends HttpServlet {
        UsuariosDAO uDAO = new UsuariosDAO();
    
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
        HttpSession session = request.getSession();
        Usuario u = (Usuario) session.getAttribute("usuario");
        Cliente c = uDAO.ObtenerCliente(u.getId());
        
        if (request.getParameter("ModificarCliente")!=null) {
            String nombre= request.getParameter("nombresClie");
            String apellidos= request.getParameter("apellidosClie");
            String correo= request.getParameter("correoClie");
            String telefono= request.getParameter("telefonoClie");
            String contraseña= request.getParameter("contraseñaClie");
            
            if (contraseña != "") {
                Cliente clie = new Cliente();
                clie.setId(c.getId());
                clie.setNombres(nombre);
                clie.setApellidos(apellidos);
                clie.setCorreo(correo);
                clie.setTelefono(telefono);
                clie.setContraseña(codificarContraseña(contraseña));
                
                if (clie.ConAtributosVacios()) {
                    String error="Hubo un error al Editar la informacion1";
                    response.sendRedirect(request.getContextPath() + "/Home/Cuenta.jsp?error="+error);
                }
                
                if (uDAO.ModificarCliente(clie)) {
                    response.sendRedirect(request.getContextPath() + "/Home/Cuenta.jsp");
                }else {
                    String error="Hubo un error al Editar la informacion";
                    response.sendRedirect(request.getContextPath() + "/Home/Cuenta.jsp?error="+error);
                }
                
            } else {
                Cliente clie = new Cliente();
                clie.setId(c.getId());
                clie.setNombres(nombre);
                clie.setApellidos(apellidos);
                clie.setCorreo(correo);
                clie.setTelefono(telefono);
                clie.setContraseña(c.getContraseña());
                if (uDAO.ModificarCliente(clie)) {
                    response.sendRedirect(request.getContextPath() + "/Home/Cuenta.jsp");
                }else {
                    String error="Hubo un error al Editar la informacion";
                    response.sendRedirect(request.getContextPath() + "/Home/Cuenta.jsp?error="+error);
                }
            }
            
            
        }
        
        if (request.getParameter("EliminarCliente")!=null) {
            int id =c.getId();
            if (uDAO.Eliminar(id)) {
               HttpSession ses = request.getSession();
               ses.invalidate();
               response.sendRedirect(request.getContextPath() + "/Home/index.jsp");
            }
        }
                
                
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
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

