
package Controlador;

import DAO.ProductosDAO;
import Modelos.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


public class ctrlInventario extends HttpServlet {
    private  ProductosDAO pDAO=new ProductosDAO();
 
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
        
        if (request.getParameter("Agregar")!=null) {
            
            int idProdu=Integer.parseInt(request.getParameter("idProducto"));
            int cantidad=Integer.parseInt(request.getParameter("cantidadProducto"));
            
            if (idProdu>0) {
                
                Producto p=pDAO.ObtenerProducto(idProdu);
                int Ncantidad=p.getCantidad()+cantidad;

                if (pDAO.ModificarCantidad(idProdu, Ncantidad)) {
                    response.sendRedirect(request.getContextPath() + "/Admin/Inventario/");
                }
                
            } else {
                response.sendRedirect(request.getContextPath() + "/Admin/Inventario/");
            } 
            
        }
        
        if (request.getParameter("Quitar")!=null) {
            
            int idProdu=Integer.parseInt(request.getParameter("idProducto"));
            int cantidad=Integer.parseInt(request.getParameter("cantidadProducto"));
            
            if (idProdu>0) {
                
                Producto p=pDAO.ObtenerProducto(idProdu);
                int Ncantidad=p.getCantidad()-cantidad;

                if (Ncantidad<=0) {
                    Ncantidad=0;
                }        
                
                if (pDAO.ModificarCantidad(idProdu, Ncantidad)) {
                    response.sendRedirect(request.getContextPath() + "/Admin/Inventario/");
                }
                
            } else {
                response.sendRedirect(request.getContextPath() + "/Admin/Inventario/");
            }
        }
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
