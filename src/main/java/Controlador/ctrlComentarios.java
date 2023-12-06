
package Controlador;

import DAO.ComentariosDAO;
import Modelos.Comentario;
import Modelos.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;


public class ctrlComentarios extends HttpServlet {
    private SimpleDateFormat formatoFecha = new SimpleDateFormat("dd-MM-yyyy");
    private  ComentariosDAO cdao = new ComentariosDAO();
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
        
        if (request.getParameter("Agregar") !=null) {
            HttpSession session = request.getSession();
            Usuario u=(Usuario) session.getAttribute("usuario");
            String comentario = request.getParameter("comentario");
            String calificacionSTR = request.getParameter("calificacion");
            String idproductoSTR = request.getParameter("idproducto");
            int calificacion = Integer.parseInt(calificacionSTR);
            int idproducto=Integer.parseInt(idproductoSTR);
            Date fechaHoraActual = new Date();
            String fecha = formatoFecha.format(fechaHoraActual);
            Comentario coment=new Comentario();
            coment.setMensaje(comentario);
            coment.setCalificacion(calificacion);
            coment.setProducto(idproducto);
            coment.setCliente(u.getId());
            coment.setFecha(fecha);
            coment.setEstado("habilitado");
            if (cdao.Insertar(coment)) {
                response.sendRedirect(request.getContextPath() + "/Home/Detalle.jsp?id="+idproducto);
            }
        }
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
